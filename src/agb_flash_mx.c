#include "gba/gba.h"
#include "gba/flash_internal.h"

static const u16 mxMaxTime[][3] =
{
      {10, 65469, TIMER_ENABLE | TIMER_INTR_ENABLE | TIMER_256CLK},
      {10, 65469, TIMER_ENABLE | TIMER_INTR_ENABLE | TIMER_256CLK},
    {2000, 65469, TIMER_ENABLE | TIMER_INTR_ENABLE | TIMER_256CLK},
    {2000, 65469, TIMER_ENABLE | TIMER_INTR_ENABLE | TIMER_256CLK},
};

const struct FlashSetupInfo MX29L010 =
{
    ProgramFlashByte_MX,
    ProgramFlashSector_MX,
    EraseFlashChip_MX,
    EraseFlashSector_MX,
    WaitForFlashWrite_Common,
    mxMaxTime,
    {
        131072, // ROM size
        {
            4096, // sector size
              12, // bit shift to multiply by sector size (4096 == 1 << 12)
              32, // number of sectors
               0  // appears to be unused
        },
        { 3, 1 }, // wait state setup data
        { { 0xC2, 0x09 } } // ID
    }
};

const struct FlashSetupInfo DefaultFlash =
{
    ProgramFlashByte_MX,
    ProgramFlashSector_MX,
    EraseFlashChip_MX,
    EraseFlashSector_MX,
    WaitForFlashWrite_Common,
    mxMaxTime,
    {
        131072, // ROM size
        {
            4096, // sector size
              12, // bit shift to multiply by sector size (4096 == 1 << 12)
              32, // number of sectors
               0  // appears to be unused
        },
        { 3, 1 }, // wait state setup data
        { { 0x00, 0x00 } } // ID of 0
    }
};

u16 EraseFlashChip_MX(void)
{
    u16 result;
    u32 readFlash1Buffer[4];

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | gFlash->wait[0];

	*(vu8 *)COM_ADR1=0xaa;
	*(vu8 *)COM_ADR2=0x55;
	*(vu8 *)COM_ADR1=0x80;
	*(vu8 *)COM_ADR1=0xaa;
	*(vu8 *)COM_ADR2=0x55;
	*(vu8 *)COM_ADR1=0x10;

    SetReadFlash1(readFlash1Buffer);

    result = WaitForFlashWrite(3, (vu8*)FLASH_ADR, 0xFF);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    return result;
}

u16 EraseFlashSector_MX(u16 sectorNum)
{
    vu8 *addr;
    u32 readFlash1Buffer[4], result;

    if (sectorNum >= gFlash->sector.count)
        return RESULT_ERROR | PHASE_PARAMETER_CHECK;

    SwitchFlashBank(sectorNum >> 4);
    sectorNum &= 0xf;

    for (u32 numTries = 0; numTries <= 3; numTries++)
    {
        REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | gFlash->wait[0];

        addr = (vu8 *)(FLASH_ADR + (sectorNum << gFlash->sector.shift));

        *(vu8 *)COM_ADR1 = 0xaa;
        *(vu8 *)COM_ADR2 = 0x55;
        *(vu8 *)COM_ADR1 = 0x80;
        *(vu8 *)COM_ADR1 = 0xaa;
        *(vu8 *)COM_ADR2 = 0x55;
        *addr = 0x30;

        SetReadFlash1(readFlash1Buffer);

        result = WaitForFlashWrite(2, addr, 0xFF);
        if ((result & (RESULT_ERROR | RESULT_Q5TIMEOUT)) == 0)
            break;
    }

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | WAITCNT_SRAM_8;

    return result;
}

u16 ProgramFlashByte_MX(u16 sectorNum, u32 offset, u8 data)
{
    vu8 *addr;
    u32 readFlash1Buffer[2];

    if (offset >= gFlash->sector.size)
        return RESULT_ERROR|PHASE_PARAMETER_CHECK;

    SwitchFlashBank(sectorNum >> 4);
    sectorNum &= 0xF;

    addr = (vu8*)(FLASH_ADR + (sectorNum << gFlash->sector.shift) + offset);

    SetReadFlash1(readFlash1Buffer);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | gFlash->wait[0];

    *(vu8 *)COM_ADR1 = 0xaa;
    *(vu8 *)COM_ADR2 = 0x55;
    *(vu8 *)COM_ADR1 = 0xa0;
    *addr = data;

    return WaitForFlashWrite(1, addr, data);
}

static u16 ProgramByte(vu8 *src, vu8 *dest)
{
	*(vu8 *)COM_ADR1=0xaa;
	*(vu8 *)COM_ADR2=0x55;
	*(vu8 *)COM_ADR1=0xa0;
    *dest = *src;

    return WaitForFlashWrite(1, dest, *src);
}

u16 ProgramFlashSector_MX(u16 sectorNum, vu8 *src)
{
    vu8 *dest;
    u16 result;
    u32 readFlash1Buffer[4];

    if (sectorNum >= gFlash->sector.count)
        return RESULT_ERROR|PHASE_PARAMETER_CHECK;

	if((result=EraseFlashSector_MX(sectorNum)))
		return result;

    SwitchFlashBank(sectorNum >> 4);
    sectorNum &= 0xF;

    SetReadFlash1(readFlash1Buffer);

    REG_WAITCNT = (REG_WAITCNT & ~WAITCNT_SRAM_MASK) | gFlash->wait[0];

    gFlashNumRemainingBytes = gFlash->sector.size;
    dest = (vu8*)(FLASH_ADR + (sectorNum << gFlash->sector.shift));

    while (gFlashNumRemainingBytes)
    {
        result = ProgramByte(src, dest);

        if (result != 0)
            break;

        gFlashNumRemainingBytes--;
        src++;
        dest++;
    }

    return result;
}
