#include "global.h"

s16 MathUtil_Mul16(s16 x, s16 y)
{
    s32 tmp = (s32)x * y;
    tmp /= 0x100;
    return (s16)tmp;
}

s16 MathUtil_Mul16Shift(u8 s, s16 x, s16 y)
{
    s32 tmp = (s32)x * y;
    tmp /= (0x00000001 << s);
    return (s16)tmp;
}

s32 MathUtil_Mul32(s32 x, s32 y)
{
    s64 result = (s64)x * y;
    result /= 256;
    return (s32)result;
}

s16 MathUtil_Div16(s16 x, s16 y)
{
    if (y == 0)
    {
        return 0;
    }
    s32 tmp = (s32)x * 256 / y;
    return (s16)tmp;
}

s16 MathUtil_Div16Shift(u8 s, s16 x, s16 y)
{
    if (y == 0)
    {
        return 0;
    }
    s32 tmp = ((s32)x << s) / y;
    return (s16)tmp;
}

s32 MathUtil_Div32(s32 x, s32 y)
{
    if (y == 0)
    {
        return 0;
    }
    s64 tmp = (s64)x * 0x100 / (s64)y;
    return (s32)tmp;
}

s16 MathUtil_Inv16(s16 y)
{
    if (y == 0)
    {
        // Handle division by zero appropriately
        return 0;
    }
    s32 tmp = 0x10000 / y;
    return (s16)tmp;
}

s16 MathUtil_Inv16Shift(u8 s, s16 y)
{
    if (y == 0)
    {
        // Handle division by zero appropriately
        return 0;
    }
    s32 x = (0x100 << s) / y;
    return (s16)x;
}

s32 MathUtil_Inv32(s32 y)
{
    if (y == 0)
    {
        // Handle division by zero appropriately
        return 0;
    }
    s64 tmp = 0x10000 / (s64)y;
    return (s32)tmp;
}
