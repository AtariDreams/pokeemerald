#include "global.h"
#include "crt0.h"
#include "malloc.h"
#include "link.h"
#include "link_rfu.h"
#include "librfu.h"
#include "m4a.h"
#include "bg.h"
#include "rtc.h"
#include "scanline_effect.h"
#include "overworld.h"
#include "play_time.h"
#include "random.h"
#include "dma3.h"
#include "gba/flash_internal.h"
#include "load_save.h"
#include "gpu_regs.h"
#include "agb_flash.h"
#include "sound.h"
#include "battle.h"
#include "battle_controllers.h"
#include "text.h"
#include "intro.h"
#include "main.h"
#include "trainer_hill.h"
#include "constants/rgb.h"

static void VBlankIntr(void);
static void HBlankIntr(void);
static void VCountIntr(void);
static void SerialIntr(void);
static void IntrDummy(void);

const u8 gGameVersion = GAME_VERSION;

const u8 gGameLanguage = GAME_LANGUAGE; // English

ALIGNED(4) const IntrFunc gIntrTableTemplate[] =
{
    VCountIntr, // V-count interrupt
    SerialIntr, // Serial interrupt
    HBlankIntr, // H-blank interrupt
    VBlankIntr, // V-blank interrupt
    IntrDummy,  // V-count interrupt
    IntrDummy,  // Timer 0 interrupt
    IntrDummy,  // Timer 1 interrupt
    IntrDummy,  // Timer 2 interrupt
    IntrDummy,  // DMA 0 interrupt
    IntrDummy,  // DMA 1 interrupt
    IntrDummy,  // DMA 2 interrupt
    IntrDummy,  // DMA 3 interrupt
    IntrDummy,  // Key interrupt
    IntrDummy,  // Game Pak interrupt
};

#define INTR_COUNT ((sizeof(gIntrTableTemplate)/sizeof(IntrFunc)))

u16 gKeyRepeatStartDelay;
bool8 gLinkTransferringData;
struct Main gMain;
u16 gKeyRepeatContinueDelay;
bool8 gSoftResetDisabled;
ALIGNED(4) IntrFunc gIntrTable[INTR_COUNT];
u8 gLinkVSyncDisabled;
ALIGNED(4) u32 IntrMain_Buffer[0x200];
s8 gPcmDmaCounter;

static EWRAM_DATA u16 sTrainerId = 0;

//EWRAM_DATA void (**gFlashTimerIntrFunc)(void) = NULL;

static void UpdateLinkAndCallCallbacks(void);
//static void InitMainCallbacks(void);
static void CallCallbacks(void);
static void SeedRngWithRtc(void);
static void ReadKeys(void);
void InitIntrHandlers(void);

#define AB_START_SELECT (A_BUTTON| B_BUTTON | START_BUTTON | SELECT_BUTTON)

_Noreturn void AgbMain(void) 
{
    REG_WAITCNT = WAITCNT_PREFETCH_ENABLE | WAITCNT_WS0_S_1 | WAITCNT_WS0_N_3;

    DmaCopy32(1, gIntrTableTemplate, gIntrTable, sizeof(gIntrTableTemplate));
    DmaCopy32(1, IntrMain, IntrMain_Buffer, sizeof(IntrMain_Buffer));

    INTR_VECTOR = IntrMain_Buffer;

    *(vu16 *)BG_PLTT = RGB_WHITE; // Set the backdrop to white on startup
    InitGpuRegManager();

    REG_DISPSTAT = (REG_DISPSTAT & 0xFF) | (150 << 8) | DISPSTAT_VCOUNT_INTR | DISPSTAT_VBLANK_INTR;

    REG_IE_SETS(INTR_FLAG_VCOUNT | INTR_FLAG_VBLANK);

    m4aSoundInit();
    InitKeys();
    RtcInit();
    CheckForFlashMemory();
    // Works because of null initialization
    if (gFlashMemoryPresent)
        gMain.callback2 = CB2_InitCopyrightScreenAfterBootup;

    SeedRngWithRtc(); // see comment at SeedRngWithRtc definition below

    // 0 initialization
    //InitMainCallbacks();
   // InitMapMusic();
    // ClearDma3Requests();
    ResetBgs();
    InitHeap(gHeap, HEAP_SIZE);

    // TODO: redundant?
    // gTrainerHillVBlankCounter = NULL;
    // gSoftResetDisabled = FALSE;
    // gLinkTransferringData = FALSE;

#ifndef NDEBUG
#if (LOG_HANDLER == LOG_HANDLER_MGBA_PRINT)
    (void) MgbaOpen();
#elif (LOG_HANDLER == LOG_HANDLER_AGB_PRINT)
    AGBPrintfInit();
#endif
#endif

    // Loop forever
    for (;;)
    {
        VBlankIntrWait();
        ReadKeys();
        PlayTimeCounter_Update();
        MapMusicMain();
    }
}

static void UpdateLinkAndCallCallbacks(void)
{
    if (!HandleLinkConnection())
        CallCallbacks();
}

// static void InitMainCallbacks(void)
// {
//     gMain.vblankCounter1 = 0;
//     gMain.vblankCounter2 = 0;
//     gMain.callback1 = NULL;
// }

static void CallCallbacks(void)
{
    if (gMain.callback1)
        gMain.callback1();

    if (gMain.callback2)
        gMain.callback2();
}

void SetMainCallback2(MainCallback callback)
{
    gMain.callback2 = callback;
    gMain.state = 0;
}

void StartTimer1(void)
{
    REG_TM1CNT_H = 0x80;
}

void SeedRngAndSetTrainerId(void)
{
    u16 val = REG_TM1CNT_L;
    SeedRng(val);
    REG_TM1CNT_H = 0;
    sTrainerId = val;
}

u16 GetGeneratedTrainerIdLower(void)
{
    return sTrainerId;
}

// FRLG commented this out to remove RTC, however Emerald didn't undo this!
static void SeedRngWithRtc(void)
{
    u32 seed = RtcGetMinuteCount();
    seed = (seed >> 16) ^ (seed & 0xFFFF);
    SeedRng(seed);
}

void InitKeys(void)
{
    gKeyRepeatContinueDelay = 5;
    gKeyRepeatStartDelay = 40;

    // 0 Initialization
    // gMain.heldKeys = 0;
    // gMain.newKeys = 0;
    // gMain.newAndRepeatedKeys = 0;
    // gMain.heldKeysRaw = 0;
    // gMain.newKeysRaw = 0;
}

static void ReadKeys(void)
{
    u16 keyInput = REG_KEYINPUT ^ KEYS_MASK;

    if (__builtin_expect_with_probability(!gSoftResetDisabled, 1, 0.99999999) && __builtin_expect_with_probability((keyInput & AB_START_SELECT) == AB_START_SELECT, 0, 0.99999999))
    {
        DoSoftReset();
    }

    u16 oldKeys = gMain.oldKeys;
    u16 newKeys = keyInput & ~oldKeys;

    gMain.oldKeys = keyInput;
    gMain.heldKeys = oldKeys;
    gMain.newKeys = newKeys;
    gMain.newAndRepeatedKeys = newKeys;

    if (keyInput == 0 || keyInput != oldKeys) {
        gMain.keyRepeatCounter = gKeyRepeatStartDelay;
    }
    else
    {
        if (--gMain.keyRepeatCounter == 0)
        {
            gMain.newAndRepeatedKeys = keyInput;
            gMain.keyRepeatCounter = gKeyRepeatContinueDelay;
        }
    }

    // Remap L to A if the L=A option is enabled.
    if (gSaveBlock2.optionsButtonMode == OPTIONS_BUTTON_MODE_L_EQUALS_A)
    {
        if (JOY_NEW(L_BUTTON))
            gMain.newKeys |= A_BUTTON;
        if (JOY_HELD(L_BUTTON))
            gMain.heldKeys |= A_BUTTON;
        if (JOY_REPEAT(L_BUTTON))
            gMain.newAndRepeatedKeys |= A_BUTTON;
    }

    if (JOY_NEW(gMain.watchedKeysMask))
        gMain.watchedKeysPressed = TRUE;
}

void InitIntrHandlers(void)
{ 
    REG_IE_SETS(INTR_FLAG_VCOUNT | INTR_FLAG_VBLANK);
    SetGpuReg(REG_OFFSET_DISPSTAT, (150 << 8) | DISPSTAT_VCOUNT_INTR | INTR_FLAG_VBLANK);

    EnableInterrupts(INTR_FLAG_VBLANK);
}

void SetVBlankCallback(IntrCallback callback)
{
    gMain.vblankCallback = callback;
}

void SetHBlankCallback(IntrCallback callback)
{
    gMain.hblankCallback = callback;
}

void SetVCountCallback(IntrCallback callback)
{
    gMain.vcountCallback = callback;
}

void RestoreSerialTimer3IntrHandlers(void)
{
    gIntrTable[1] = SerialIntr;
    gIntrTable[2] = Timer3Intr;
}

void SetSerialCallback(IntrCallback callback)
{
    gMain.serialCallback = callback;
}

static void VBlankIntr(void)
{
    if (gWirelessCommType != 0)
        RfuVSync();
    else if (gLinkVSyncDisabled == FALSE)
        LinkVSync();

    gMain.vblankCounter1++;

    if (gTrainerHillVBlankCounter && *gTrainerHillVBlankCounter < 0xFFFFFFFF)
        (*gTrainerHillVBlankCounter)++;

    if (gMain.vblankCallback)
        gMain.vblankCallback();

    gMain.vblankCounter2++;

    CopyBufferedValuesToGpuRegs();
    ProcessDma3Requests();

    gPcmDmaCounter = gSoundInfo.pcmDmaCounter;

    m4aSoundMain();
    TryReceiveLinkBattleData();

    if (!gMain.inBattle || !(gBattleTypeFlags & (BATTLE_TYPE_LINK | BATTLE_TYPE_FRONTIER | BATTLE_TYPE_RECORDED)))
        Random();

    UpdateWirelessStatusIndicatorSprite();

    INTR_CHECK |= INTR_FLAG_VBLANK;
}

void InitFlashTimer(void)
{
    SetFlashTimerIntr(2, gIntrTable + 0x7);
}

static void HBlankIntr(void)
{
    if (gMain.hblankCallback)
        gMain.hblankCallback();

    INTR_CHECK |= INTR_FLAG_HBLANK;
}

static void VCountIntr(void)
{
    if (gMain.vcountCallback)
        gMain.vcountCallback();

    m4aSoundVSync();
    INTR_CHECK |= INTR_FLAG_VCOUNT;
}

static void SerialIntr(void)
{
    if (gMain.serialCallback)
        gMain.serialCallback();

    INTR_CHECK |= INTR_FLAG_SERIAL;
}

static void IntrDummy(void)
{}

void SetTrainerHillVBlankCounter(u32 *counter)
{
    gTrainerHillVBlankCounter = counter;
}

void ClearTrainerHillVBlankCounter(void)
{
    gTrainerHillVBlankCounter = NULL;
}

_Noreturn void DoSoftReset(void)
{
    REG_IME = 0;
    m4aSoundVSyncOff();
    ScanlineEffect_Stop();
    DmaStop(1);
    DmaStop(2);
    DmaStop(3);
    SiiRtcProtect();
    SoftReset(RESET_ALL);
}
