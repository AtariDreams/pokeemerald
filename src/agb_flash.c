#include "gba/gba.h"
#include "gba/flash_internal.h"

static u8 sTimerNum;
static u16 sTimerCount;
static vu16 *sTimerReg;
static u16 sSavedIme;

u8 gFlashTimeoutFlag;
u8 (*PollFlashStatus)(vu8 *);
u16 (*WaitForFlashWrite)(u8 phase, vu8 *addr, u8 lastData);
u16 (*ProgramFlashSector)(u16 sectorNum, vu8 *src);
const struct FlashType *gFlash;
u16 (*ProgramFlashByte)(u16 sectorNum, u32 offset, u8 data);
u16 gFlashNumRemainingBytes;
u16 (*EraseFlashChip)();
u16 (*EraseFlashSector)(u16 sectorNum);
const u16 (*gFlashMaxTime)[3];

void SetReadFlash1(vu16 *dest);

void SwitchFlashBank(u8 bankNum)
{
    *(vu8 *)COM_ADR1=0xaa;
    *(vu8 *)COM_ADR2=0x55;
    *(vu8 *)COM_ADR1=0xb0;
    *(vu8 *)FLASH_ADR=bankNum;
}

#define DELAY()                  \
do {                             \
    vu32 i;                      \
    for (i = 20000; i != 0; i--) \
        ;                        \
} while (0)

u16 ReadFlashId(void)
{
    vu32 i;
    u16 flashId;
    u16 readFlash1Buffer[0x20];
    u8 (*readFlash1)(vu8 *);

    SetReadFlash1(readFlash1Buffer);
    readFlash1 = (u8 (*)(vu8 *))((u8 *)readFlash1Buffer + 1);

	// read flashID
	*(vu8 *)COM_ADR1=0xaa;
	*(vu8 *)COM_ADR2=0x55;
	*(vu8 *)COM_ADR1=0x90;

    //wait 20ms
    for (i = 20000; i != 0; i--);  

    flashId = (readFlash1((vu8*)DEVICE_ID_ADR) << 8) | readFlash1((vu8*)VENDER_ID_ADR);

	// exit readID-mode(ATMEL)
	*(vu8 *)COM_ADR1=0xaa;
	*(vu8 *)COM_ADR2=0x55;
	*(vu8 *)COM_ADR1=0xf0;

	// reset
	*(vu8 *)COM_ADR1=0xf0;
    
    //wait 20ms
    for (i = 20000; i != 0; i--);  

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
    sTimerReg = (vu16 *)(REG_ADDR_TMCNT_L + (timerNum << 2));
    *intrFunc = FlashTimerIntr;
    return 0;
}

void StartFlashTimer(u8 phase)
{
    const u16 *maxTime = (const u16 *)(gFlashMaxTime + phase);
    sSavedIme = REG_IME;
    REG_IME = 0;
    *(sTimerReg + 1) = 0;
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

u8 ReadFlash1(vu8 *addr)
{
    return *addr;
}

void SetReadFlash1(vu16 *dest)
{
    vu16 *src;
    u32 i;

    PollFlashStatus = (u8 (*)(vu8 *))((u8 *)dest + 1);

    src = (u16 *)((u32)ReadFlash1 & ~1);

    for(i=((u32)SetReadFlash1-(u32)ReadFlash1)>>1; i;i--)
    {
        *dest++ = *src++;
    }
}

// Using volatile here to make sure the flash memory will ONLY be read as bytes, to prevent any compiler optimizations.
void ReadFlash_Core(vu8 *src, vu8 *dest, u32 size)
{
	for (; size; size--)
		*dest++=*src++;
}

void ReadFlash(u16 sectorNum, u32 offset, vu8 *dest, u32 size)
{
    vu8 *src;
    u32 i;
    vu16 readFlash_Core_Buffer[0x40], *funcSrc, *funcDest;
    void (*readFlash_Core)(vu8 *, vu8 *, u32);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum >> 4);
        sectorNum &= 0xf;
    }

    funcSrc = (vu16 *)((u32)ReadFlash_Core & ~1);
    funcDest = readFlash_Core_Buffer;

    for (i = ((u32)ReadFlash - (u32)ReadFlash_Core) >> 1; i; i--)
    {
        *funcDest++ = *funcSrc++;
    }

    readFlash_Core = (void (*)(vu8 *, vu8 *, u32))((u32)readFlash_Core_Buffer + 1);

    src = (vu8*)(FLASH_ADR + (sectorNum << gFlash->sector.shift) + offset);

    readFlash_Core(src, dest, size);
}

u32 VerifyFlashSector_Core(vu8 *src, vu8 *tgt, u32 size)
{
    for (; size; size--)
    {
        if (*tgt++ != *src++)
            return (u32)(tgt - 1);
    }

    return 0;
}

u32 VerifyFlashSector(u16 sectorNum, vu8 *src)
{
    u32 i;
    vu16 verifyFlashSector_Core_Buffer[0x80];
    vu16 *funcSrc;
    vu16 *funcDest;
    vu8 *tgt;
    u16 size;
    u32 (*verifyFlashSector_Core)(vu8 *, vu8 *, u32);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum >> 4);
        sectorNum &= 0xf;
    }

    funcSrc = (vu16 *)((u32)VerifyFlashSector_Core & ~1);
    funcDest = verifyFlashSector_Core_Buffer;

    for(i=((u32)VerifyFlashSector-(u32)VerifyFlashSector_Core)>>1;i;i--)
    {
        *funcDest++ = *funcSrc++;
    }

    verifyFlashSector_Core = (u32 (*)(vu8 *, vu8 *, u32))((u8 *)verifyFlashSector_Core_Buffer + 1);

    tgt = (vu8 *)(FLASH_ADR + (sectorNum << gFlash->sector.shift));
    size = gFlash->sector.size;

    return verifyFlashSector_Core(src, tgt, size);
}

u32 VerifyFlashSectorNBytes(u16 sectorNum, vu8 *src, u32 n)
{
    u32 i;
    vu16 verifyFlashSector_Core_Buffer[0x80];
    vu16 *funcSrc;
    vu16 *funcDest;
    vu8 *tgt;
    u32 (*verifyFlashSector_Core)(vu8 *, vu8 *, u32);

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum >> 4);
        sectorNum &= 0xF;
    }

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    funcSrc = (vu16 *)((u32)VerifyFlashSector_Core & ~1);
    funcDest = verifyFlashSector_Core_Buffer;

    for(i=((u32)VerifyFlashSector-(u32)VerifyFlashSector_Core)>>1;i;i--)
    {
        *funcDest++ = *funcSrc++;
    }

    verifyFlashSector_Core = (u32 (*)(vu8 *, vu8 *, u32))((u8 *)verifyFlashSector_Core_Buffer + 1);

    tgt = (vu8 *)(FLASH_ADR + (sectorNum << gFlash->sector.shift));

    return verifyFlashSector_Core(src, tgt, n);
}

u32 ProgramFlashSectorAndVerify(u16 sectorNum, vu8 *src)
{
    u32 i;
    u32 result;

    for (i = 0; i < 3; i++)
    {
        result = ProgramFlashSector(sectorNum, src);
        if (result == 0)
        {
            result = VerifyFlashSector(sectorNum, src);
            if (result == 0)
                break;
        }
    }

    return result;
}

u32 ProgramFlashSectorAndVerifyNBytes(u16 sectorNum, vu8 *src, u32 n)
{
    u32 i;
    u32 result;

    for (i = 0; i < 3; i++)
    {
        result = ProgramFlashSector(sectorNum, src);
        if (result == 0)
        {
            result = VerifyFlashSectorNBytes(sectorNum, src, n);
            if (result == 0)
                break;
        }
    }

    return result;
}
