#include "gba/gba.h"
#include "gba/flash_internal.h"

static const char AgbLibFlashVersion[] = "FLASH1M_V103";

static const struct FlashSetupInfo * const sSetupInfos[] =
{
    &MX29L010,
    &LE26FV10N1TS,
    &DefaultFlash
};

u16 IdentifyFlash(void)
{
    u16 result, flashId;
    const struct FlashSetupInfo * const *setupInfo;

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    flashId = ReadFlashId();

    setupInfo = sSetupInfos;
    result = 1;

    while((*setupInfo)->type.ids.separate.makerId)
    {
        if (flashId == (*setupInfo)->type.ids.joined)
        {
            result = 0;
            break;
        }

        setupInfo++;
    }

    ProgramFlashByte = (*setupInfo)->programFlashByte;
    ProgramFlashSector = (*setupInfo)->programFlashSector;
    EraseFlashChip = (*setupInfo)->eraseFlashChip;
    EraseFlashSector = (*setupInfo)->eraseFlashSector;
    WaitForFlashWrite = (*setupInfo)->WaitForFlashWrite;
    gFlashMaxTime = (*setupInfo)->maxTime;
    gFlash = &(*setupInfo)->type;

    return result;
}

u16 WaitForFlashWrite_Common(u8 phase, vu8 *addr, u8 lastData)
{
    u16 result = 0;
    u8 status;

    StartFlashTimer(phase);

    for (;;)
    {
        status = PollFlashStatus(addr);
        if (status == lastData)
            break;
        if (status & 0x20)
        {
            // The write operation exceeded the flash chip's time limit.
            if (PollFlashStatus(addr) == lastData)
                break;

            *(vu8 *)COM_ADR1=0xf0; // command reset
            result=RESULT_ERROR|RESULT_Q5TIMEOUT|phase;
            break;
        }

        if (gFlashTimeoutFlag)
        {
            if (PollFlashStatus(addr) == lastData)
                break;

            *(vu8 *)COM_ADR1=0xf0; // command reset
            result=RESULT_ERROR|RESULT_TIMEOUT|phase;
            break;
        }
    }

    StopFlashTimer();

    return result;
}
