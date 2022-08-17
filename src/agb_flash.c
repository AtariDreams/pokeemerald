#include "gba/gba.h"
#include "gba/flash_internal.h"

static u8 sTimerNum;
static u16 sTimerCount;
static vu16 *sTimerReg;
static u16 sSavedIme;

u8 gFlashTimeoutFlag;
u8 (*PollFlashStatus)(u8 *);
u16 (*WaitForFlashWrite)(u8 phase, u8 *addr, u8 lastData);
u16 (*ProgramFlashSector)(u16 sectorNum, u8 *src);
const struct FlashType *gFlash;
u16 (*ProgramFlashByte)(u16 sectorNum, u32 offset, u8 data);
u16 gFlashNumRemainingBytes;
u16 (*EraseFlashChip)();
u16 (*EraseFlashSector)(u16 sectorNum);
const u16 (*gFlashMaxTime)[3];

void SetReadFlash1(u16 *dest);

void SwitchFlashBank(u8 bankNum)
{
    FLASH_WRITE(0x5555, 0xAA);
    FLASH_WRITE(0x2AAA, 0x55);
    FLASH_WRITE(0x5555, 0xB0);
    *(vu8*)FLASH_BASE = bankNum;
}

#if !MODERN
#define DELAY()                  \
do {                             \
    vu16 i;                      \
    for (i = 20000; i != 0; i--) \
        ;                        \
} while (0)
#else
#define DELAY() for (i = 20000; i != 0; i--);
#endif
u16 ReadFlashId(void)
{
    #if MODERN
    vu16 i;
    #endif
    u16 flashId;
    u16 readFlash1Buffer[0x20];
    u8 (*readFlash1)(u8 *);

    SetReadFlash1(readFlash1Buffer);
    readFlash1 = (u8 (*)(u8 *))((u8 *)readFlash1Buffer + 1);

    // Enter ID mode.
    FLASH_WRITE(0x5555, 0xAA);
    FLASH_WRITE(0x2AAA, 0x55);
    FLASH_WRITE(0x5555, 0x90);
    DELAY();

    flashId = readFlash1(FLASH_BASE + 1) << 8;
    flashId |= readFlash1(FLASH_BASE);

    // Leave ID mode.
    FLASH_WRITE(0x5555, 0xAA);
    FLASH_WRITE(0x2AAA, 0x55);
    FLASH_WRITE(0x5555, 0xF0);

    // reset?
    // This is writing twice. Is it needed? It's a volatile write...
    FLASH_WRITE(0x5555, 0xF0);

    DELAY();

    return flashId;
}

void FlashTimerIntr(void)
{
    if (sTimerCount != 0 && --sTimerCount == 0)
        gFlashTimeoutFlag = 1;
}

u16 SetFlashTimerIntr(u8 timerNum, void (**intrFunc)(void))
{
    if (timerNum > 3)
        return 1;

    sTimerNum = timerNum;
    sTimerReg = REG_NADDR_TMCNT_L(sTimerNum);
    *intrFunc = FlashTimerIntr;
    return 0;
}

void StartFlashTimer(u8 phase)
{
    const u16 *maxTime = (const u16 *)(gFlashMaxTime + phase);
    sSavedIme = REG_IME;
    REG_IME = 0;
    sTimerReg[1] = 0;
    REG_IE |= (INTR_FLAG_TIMER0 << sTimerNum);
    gFlashTimeoutFlag = 0;
    sTimerCount = *maxTime++;
    *sTimerReg++ = *maxTime++;
    *sTimerReg-- = *maxTime++;
    REG_IF = (INTR_FLAG_TIMER0 << sTimerNum);
    REG_IME = 1;
}

void StopFlashTimer(void)
{
    REG_IME = 0;
    *sTimerReg++ = 0;
    *sTimerReg-- = 0;
    REG_IE &= ~(INTR_FLAG_TIMER0 << sTimerNum);
    REG_IME = sSavedIme;
}

u8 ReadFlash1(u8 *addr)
{
    return *addr;
}

void SetReadFlash1(u16 *dest)
{
    u16 *src;
    m16 i;

    PollFlashStatus = (u8 (*)(u8 *))((u8 *)dest + 1);

    src = (u16 *)ReadFlash1;
    src = (u16 *)((u32)src ^ 1);

    for(i=((u32)SetReadFlash1-(u32)ReadFlash1)>>1;i!=0;i--)
		*dest++=*src++;
}

// Using volatile here to make sure the flash memory will ONLY be read as bytes, to prevent any compiler optimizations.
#if !MODERN
void ReadFlash_Core(u8 *src, u8 *dest, u32 size)
{
    while (size-- != 0)
    {
        *dest++ = *src++;
    }
}
#else
__attribute__((naked))
void ReadFlash_Core(u8 *src, u8 *dest, u32 size)
{
    //hand optimized
    asm("cmp     r2, #0\n\
        beq     .end \n\
.loop: \n\
        ldrb    r3, [r0]\n\
        strb    r3, [r1]\n\
        adds    r0, r0, #1\n\
        adds    r1, r1, #1\n\
        subs    r2, r2, #1\n\
        bne     .loop\n\
.end:\n\
        bx      lr");
}
#endif
void ReadFlash(u16 sectorNum, u32 offset, u8 *dest, u32 size)
{
    u8 *src;
    m16 i;
    u16 readFlash_Core_Buffer[0x40];
    u16 *funcSrc;
    u16 *funcDest;
    void (*readFlash_Core)(u8 *, u8 *, u32);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum / SECTORS_PER_BANK);
        sectorNum %= SECTORS_PER_BANK;
    }

    funcSrc = (u16 *)ReadFlash_Core;
    funcSrc = (u16 *)((u32)funcSrc ^ 1);
    funcDest = readFlash_Core_Buffer;

    for(i=((u32)ReadFlash-(u32)ReadFlash_Core)>>1;i!=0;i--)
    {
        *funcDest++ = *funcSrc++;
    }

    readFlash_Core = (void (*)(u8 *, u8 *, u32))((u8*)readFlash_Core_Buffer + 1);

    src = FLASH_BASE + (sectorNum << gFlash->sector.shift) + offset;

    readFlash_Core(src, dest, size);
}

#if !MODERN
u32 VerifyFlashSector_Core(u8 *src, u8 *tgt, u32 size)
{
    while (size-- != 0)
    {
        if (*tgt++ != *src++)
            return (u32)(tgt - 1);
    }

    return 0;
}
#else
bool32 VerifyFlashSector_Core(u8 *src, u8 *tgt, u32 size)
{
    for (; size; size--)
    {
        if (*tgt != *src)
            return TRUE;
        tgt++, src++;
    }

    return FALSE;
}
#endif

bool32 VerifyFlashSector(u16 sectorNum, u8 *src)
{
    m16 i;
    u16 verifyFlashSector_Core_Buffer[0x80];
    u16 *funcSrc;
    u16 *funcDest;
    u8 *tgt;
    #if !MODERN
    u16 size;
    #endif
    u32 (*verifyFlashSector_Core)(u8 *, u8 *, u32);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum / SECTORS_PER_BANK);
        sectorNum %= SECTORS_PER_BANK;
    }

    funcSrc = (u16 *)VerifyFlashSector_Core;
    funcSrc = (u16 *)((u32)funcSrc ^ 1);
    funcDest = verifyFlashSector_Core_Buffer;

    for(i=((u32)VerifyFlashSector-(u32)VerifyFlashSector_Core)>>1;i>0;i--)
    {
        *funcDest++ = *funcSrc++;
    }

    verifyFlashSector_Core = (u32 (*)(u8 *, u8 *, u32))((u8 *)verifyFlashSector_Core_Buffer + 1);

    tgt = FLASH_BASE + (sectorNum << gFlash->sector.shift);

    #if !MODERN
    size = gFlash->sector.size;

    return verifyFlashSector_Core(src, tgt, size);

    #else
    return verifyFlashSector_Core(src, tgt, gFlash->sector.size);
    #endif
}
#if !MODERN
u32 VerifyFlashSectorNBytes(u16 sectorNum, u8 *src, u32 n)
{
    m16 i;
    u16 verifyFlashSector_Core_Buffer[0x80];
    u16 *funcSrc;
    u16 *funcDest;
    u8 *tgt;
    u32 (*verifyFlashSector_Core)(u8 *, u8 *, u32);

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum / SECTORS_PER_BANK);
        sectorNum %= SECTORS_PER_BANK;
    }

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    funcSrc = (u16 *)VerifyFlashSector_Core;
    funcSrc = (u16 *)((u32)funcSrc ^ 1);
    funcDest = verifyFlashSector_Core_Buffer;

    for(i=((u32)VerifyFlashSector-(u32)VerifyFlashSector_Core)>>1;i!=0;i--)
    {
        *funcDest++ = *funcSrc++;
    }

    verifyFlashSector_Core = (u32 (*)(u8 *, u8 *, u32))((u8 *)verifyFlashSector_Core_Buffer + 1);

    tgt = FLASH_BASE + (sectorNum << gFlash->sector.shift);

    return verifyFlashSector_Core(src, tgt, n);
}
#endif

u32 ProgramFlashSectorAndVerify(u16 sectorNum, u8 *src)
{
    m8 i;
    u32 result;

    for (i = 0; i < 3; i++)
    {
        result = ProgramFlashSector(sectorNum, src);
        if (result != 0)
            continue;

        result = VerifyFlashSector(sectorNum, src);
        if (result == 0)
            break;
    }

    return result;
}

#if !MODERN
u32 ProgramFlashSectorAndVerifyNBytes(u16 sectorNum, u8 *src, u32 n)
{
    m8 i;
    u32 result;

    for (i = 0; i < 3; i++)
    {
        result = ProgramFlashSector(sectorNum, src);
        if (result != 0)
            continue;

        result = VerifyFlashSectorNBytes(sectorNum, src, n);
        if (result == 0)
            break;
    }

    return result;
}
#endif