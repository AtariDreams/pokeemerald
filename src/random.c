#include "global.h"
#include "random.h"

// IWRAM common
COMMON_DATA u32 gRngValue = 0;
COMMON_DATA u32 gRng2Value = 0;

u16 Random(void)
{
    gRngValue = ISO_RANDOMIZE1(gRngValue);
    return gRngValue >> 16;
}

void SeedRng(u32 seed)
{
    gRngValue = seed;
}

void SeedRng2(u32 seed)
{
    gRng2Value = seed;
}

u16 Random2(void)
{
    gRng2Value = ISO_RANDOMIZE1(gRng2Value);
    return gRng2Value >> 16;
}
