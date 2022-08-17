#ifndef GUARD_UTIL_H
#define GUARD_UTIL_H

#include "sprite.h"

extern const u8 gMiscBlank_Gfx[]; // unused in Emerald
extern const u32 gBitTable[];

u8 CreateInvisibleSpriteWithCallback(void (*)(struct Sprite *));
void StoreWordInTwoHalfwords(s16 *, u32);
void LoadWordFromTwoHalfwords(s16 *, u32 *);
u8 CountTrailingZeroBits(u32 value);
#if !MODERN
u16 CalcCRC16(const u8 *data, s32 length);
#else
u16 CalcCRC16(const u8 *data, u32 length);
#endif
u16 CalcCRC16WithTable(const u8 *data, u32 length);
#if !MODERN
u32 CalcByteArraySum(const u8* data, u32 length);
#else
u32 CalcByteArraySum(const void* data, u32 length);
#endif
void BlendPalette(u16 palOffset, u16 numEntries, u8 coeff, u16 blendColor);
void DoBgAffineSet(struct BgAffineDstData *dest, s32 texX, s32 texY, s16 scrX, s16 scrY, s16 sx, s16 sy, u16 alpha);
void CopySpriteTiles(u8 shape, u8 size, u8 *tiles, u16 *tilemap, u8 *output);


#endif // GUARD_UTIL_H
