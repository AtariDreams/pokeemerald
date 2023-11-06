#include "global.h"
#include "gpu_regs.h"

#define GPU_REG_BUF_SIZE 0x60

#define GPU_REG_BUF(offset) (*(u16 *)(&sGpuRegBuffer[offset]))
#define GPU_REG(offset) (*(vu16 *)(REG_BASE + offset))

#define EMPTY_SLOT 0xFF

static ALIGNED(4) u8 sGpuRegBuffer[GPU_REG_BUF_SIZE];
static ALIGNED(4) u8 sGpuRegWaitingList[GPU_REG_BUF_SIZE];
static volatile int sGpuRegBufferLocked;

static void CopyBufferedValueToGpuReg(u8 regOffset);
static void SyncRegIE(void);
static void UpdateRegDispstatIntrBits(u16 regIE);

void InitGpuRegManager(void)
{
    DmaFill32(3, 0xFFFFFFFF, sGpuRegWaitingList, GPU_REG_BUF_SIZE);

    // Memory already set to 0
    // for (i = 0; i < GPU_REG_BUF_SIZE; i++)
    // {
    //     // todo: all set to 0?
    //    //  sGpuRegBuffer[i] = 0;
    //     sGpuRegWaitingList[i] = EMPTY_SLOT;
    // }

    // sGpuRegBufferLocked = FALSE;
    // sShouldSyncRegIE = FALSE;
    // sRegIE = 0;
}

static void CopyBufferedValueToGpuReg(u8 regOffset)
{
    if (regOffset == REG_OFFSET_DISPSTAT)
    {
        REG_DISPSTAT &= ~(DISPSTAT_HBLANK_INTR | DISPSTAT_VBLANK_INTR);
        REG_DISPSTAT |= GPU_REG_BUF(REG_OFFSET_DISPSTAT);
    }
    else
    {
        GPU_REG(regOffset) = GPU_REG_BUF(regOffset);
    }
}

void CopyBufferedValuesToGpuRegs(void)
{
    unsigned int i;
    if (sGpuRegBufferLocked)
        return;

    for (i = 0; i < GPU_REG_BUF_SIZE; i++)
    {
        u8 regOffset = sGpuRegWaitingList[i];
        if (regOffset == EMPTY_SLOT)
            return;
        CopyBufferedValueToGpuReg(regOffset);
        sGpuRegWaitingList[i] = EMPTY_SLOT;
    }
}

void SetGpuReg(u8 regOffset, u16 value)
{
    if (sGpuRegBufferLocked)
        return;
    if (regOffset < GPU_REG_BUF_SIZE)
    {
        u8 vcount;

        GPU_REG_BUF(regOffset) = value;
        vcount = REG_VCOUNT;

        if ((vcount > 160 && vcount < 226) || (REG_DISPCNT & DISPCNT_FORCED_BLANK))
        {
            CopyBufferedValueToGpuReg(regOffset);
            return;
        }
        else
        {
            unsigned int i;

            sGpuRegBufferLocked = TRUE;
            asm volatile ("" : : : "memory");
            for (i = 0; i < GPU_REG_BUF_SIZE && sGpuRegWaitingList[i] != EMPTY_SLOT; i++)
            {
                if (sGpuRegWaitingList[i] == regOffset)
                {
                   goto end;
                }
            }

           sGpuRegWaitingList[i] = regOffset;

           asm volatile ("" : : : "memory");
end:
           sGpuRegBufferLocked = FALSE;
        }
    }
}

void SetGpuReg_ForcedBlank(u8 regOffset, u16 value)
{
    if (sGpuRegBufferLocked)
        return;
    if (regOffset < GPU_REG_BUF_SIZE)
    {
        GPU_REG_BUF(regOffset) = value;

        if (REG_DISPCNT & DISPCNT_FORCED_BLANK)
        {
            CopyBufferedValueToGpuReg(regOffset);
            return;
        }
        else
        {
            unsigned int i;

            sGpuRegBufferLocked = TRUE;
            asm volatile ("" : : : "memory");

            for (i = 0; i < GPU_REG_BUF_SIZE && sGpuRegWaitingList[i] != EMPTY_SLOT; i++)
            {
                if (sGpuRegWaitingList[i] == regOffset)
                {
                   goto end;
                }
            }

            sGpuRegWaitingList[i] = regOffset;
            asm volatile ("" : : : "memory");
end:
            sGpuRegBufferLocked = FALSE;
        }
    }
}

u16 GetGpuReg(u8 regOffset)
{
    return GPU_REG_BUF(regOffset);
}

void SetGpuRegBits(u8 regOffset, u16 mask)
{
    u16 regValue = GPU_REG_BUF(regOffset) | mask;
    SetGpuReg(regOffset, regValue);
}

void ClearGpuRegBits(u8 regOffset, u16 mask)
{
    u16 regValue = GPU_REG_BUF(regOffset) & ~mask;
    SetGpuReg(regOffset, regValue);
}
void EnableInterrupts(u16 mask)
{
    REG_IE_SET(mask);
    UpdateRegDispstatIntrBits(REG_IE);
}

void DisableInterrupts(u16 mask)
{
    REG_IE_RESET(mask);
    UpdateRegDispstatIntrBits(REG_IE);
}

static void UpdateRegDispstatIntrBits(u16 regIE)
{
    u16 oldValue = REG_DISPSTAT & (DISPSTAT_HBLANK_INTR | DISPSTAT_VBLANK_INTR);
    u16 newValue = 0;

    if (regIE & INTR_FLAG_VBLANK)
        newValue |= DISPSTAT_VBLANK_INTR;

    if (regIE & INTR_FLAG_HBLANK)
        newValue |= DISPSTAT_HBLANK_INTR;

    if (oldValue != newValue)
        SetGpuReg(REG_OFFSET_DISPSTAT, newValue);
}
