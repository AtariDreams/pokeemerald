#include "global.h"

s16 MathUtil_Mul16(s16 x, s16 y)
{
    s32 tmp;
    tmp = x;
    tmp *= y;
    tmp /= 0x100;
    return (s16)tmp;
}

s16 MathUtil_Mul16Shift(u8 s, s16 x, s16 y)
{
    s32 tmp;
    tmp = x;
    tmp *= y;
    tmp /= (0x00000001<<s);
    return (s16)tmp;
}

s32 MathUtil_Mul32(s32 x, s32 y)
{
    s64 result;

    result = (s64)x;
    result *= (s64)y;
    result /= 256;
    return (s32)result;
}

s16 MathUtil_Div16(s16 x, s16 y)
{
    s32 tmp;
    if (y == 0)
    {
        return 0;
    }
    tmp = x;
    tmp *= 256;
    tmp /= y;
    return (s16)tmp;
}

s16 MathUtil_Div16Shift(u8 s, s16 x, s16 y)
{
    s32 tmp;
	if(y == 0){
		return 0;
	}
    tmp = x;
    tmp <<= s;
    tmp /= y;
    return (s16)tmp;
}

s32 MathUtil_Div32(s32 x, s32 y)
{
    s64 tmp;
	if(y == 0){
		return 0;
	}
    tmp = (s64)x;
    tmp *= 0x100;
    tmp /= (s64)y;
    return (s32)tmp;
}

s16 MathUtil_Inv16(s16 y)
{
    s32 tmp;
    tmp = 0x10000;
    tmp /= y;
    return (s16)tmp;
}

s16 MathUtil_Inv16Shift(u8 s, s16 y)
{
    s32 x;

    x = 0x100 << s;
    x /= y;
    return (s16)x;
}

s32 MathUtil_Inv32(s32 y)
{
    s64 tmp;
    tmp = (s64)0x10000;
    tmp /= (s64)y;
    return (s32)tmp;
}
