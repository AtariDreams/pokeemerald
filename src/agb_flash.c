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

void SetReadFlash1(u32 *dest);

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
    u32 readFlash1Buffer[4];
    u8 (*readFlash1)(vu8 *);

    SetReadFlash1(readFlash1Buffer);
    readFlash1 = (u8 (*)(vu8 *))((u8 *)readFlash1Buffer);

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

#define asm_unified(x) asm(".syntax unified\n" x "\n.syntax divided")
#define NAKED __attribute__((naked))

__attribute__((target("arm")))
NAKED u8 ReadFlash1(vu8 *addr)
{
    asm_unified("\
        ldrb    r0, [r0]\n\
        bx      lr\n");
}

void SetReadFlash1(u32 *dest)
{
    PollFlashStatus = (u8 (*)(vu8 *))((u8 *)dest);

    CpuCopy32(&ReadFlash1, PollFlashStatus, 8); 
}

// Using volatile here to make sure the flash memory will ONLY be read as bytes, to prevent any compiler optimizations.



__attribute__((target("arm")))
NAKED void ReadFlash_Core(vu8 *dest, vu8 *src, u32 size)
{
    asm_unified("\
        cmp     r2, #0\n\
        bxeq    lr\n\
.LBB0_1:\n\
        ldrb    r3, [r1], #1\n\
        subs    r2, r2, #1\n\
        strb    r3, [r0], #1\n\
        bne     .LBB0_1\n\
        bx      lr\n");
}

void ReadFlash(u16 sectorNum, u32 offset, volatile void *dest, u32 size)
{
    vu8 *src;
    u32 i;
    u32 readFlash_Core_Buffer[8];
    void (*readFlash_Core)(vu8 *, vu8 *, u32);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum >> 4);
        sectorNum &= 0xf;
    }

    CpuFastCopy((void *)((u32)ReadFlash_Core), readFlash_Core_Buffer, sizeof(readFlash_Core_Buffer));

    readFlash_Core = (void (*)(vu8 *, vu8 *, u32))((u32)readFlash_Core_Buffer);

    src = (vu8*)(FLASH_ADR + (sectorNum << gFlash->sector.shift) + offset);

    readFlash_Core(dest, src, size);
}

__attribute__((target("arm")))
NAKED u32 VerifyFlashSector_Core(vu8 *dest, vu8 *src, u32 size)
{
    asm_unified("\
        push    {r4, lr}\n\
        cmp     r2, #0\n\
        beq     .Ld\n\
        adds    r2, r0, r2\n\
        b       .Lb\n\
.La:\n\
        adds    r0, r0, #1\n\
        adds    r1, r1, #1\n\
        cmp     r0, r2\n\
        beq     .Ld\n\
.Lb:\n\
        ldrb    r4, [r0]\n\
        ldrb    r3, [r1]\n\
        cmp     r4, r3\n\
        beq     .La\n\
.Lc:\n\
        pop     {r4}\n\
        pop     {r1}\n\
        bx      r1\n\
.Ld:\n\
        movs    r0, #0\n\
        b       .Lc\n");
}

u32 VerifyFlashSector(u16 sectorNum, vu8 *src)
{
    u32 verifyFlashSector_Core_Buffer[0x18];
    vu8 *tgt;
    u32 (*verifyFlashSector_Core)(vu8 *, vu8 *, u32);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum >> 4);
        sectorNum &= 0xf;
    }

    CpuFastCopy((void *)((u32)VerifyFlashSector_Core), verifyFlashSector_Core_Buffer, sizeof(verifyFlashSector_Core_Buffer));
    verifyFlashSector_Core = (u32 (*)(vu8 *, vu8 *, u32))((u8 *)verifyFlashSector_Core_Buffer);

    tgt = (vu8 *)(FLASH_ADR + (sectorNum << gFlash->sector.shift));

    return verifyFlashSector_Core(tgt, src, gFlash->sector.size);
}

u32 VerifyFlashSectorNBytes(u16 sectorNum, vu8 *src, u32 n)
{
    u32 i;
    u32 verifyFlashSector_Core_Buffer[0x18];
    vu8 *tgt;
    u32 (*verifyFlashSector_Core)(vu8 *, vu8 *, u32);

    if (gFlash->romSize == FLASH_ROM_SIZE_1M)
    {
        SwitchFlashBank(sectorNum >> 4);
        sectorNum &= 0xF;
    }

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    CpuFastCopy((void *)((u32)VerifyFlashSector_Core), verifyFlashSector_Core_Buffer, sizeof(verifyFlashSector_Core_Buffer));
    verifyFlashSector_Core = (u32 (*)(vu8 *, vu8 *, u32))(verifyFlashSector_Core_Buffer);

    tgt = (vu8 *)(FLASH_ADR + (sectorNum << gFlash->sector.shift));

    return verifyFlashSector_Core(tgt, src, n);
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
