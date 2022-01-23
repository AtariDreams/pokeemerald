#ifndef GUARD_PALETTE_H
#define GUARD_PALETTE_H

#define gPaletteFade_selectedPalettes (gPaletteFade.multipurpose1) // normal and fast fade
#define gPaletteFade_blendCnt         (gPaletteFade.multipurpose1) // hardware fade
#define gPaletteFade_delay            (gPaletteFade.multipurpose2) // normal and hardware fade
#define gPaletteFade_submode          (gPaletteFade.multipurpose2) // fast fade

#define PLTT_BUFFER_SIZE 0x200
#define PLTT_DECOMP_BUFFER_SIZE (PLTT_BUFFER_SIZE * 2)

#define PALETTE_FADE_STATUS_DELAY 2
#define PALETTE_FADE_STATUS_ACTIVE 1
#define PALETTE_FADE_STATUS_DONE 0
#define PALETTE_FADE_STATUS_LOADING 0xFF

#define PALETTES_BG      0x0000FFFF
#define PALETTES_OBJECTS 0xFFFF0000
#define PALETTES_ALL     (PALETTES_BG | PALETTES_OBJECTS)

#define PAL0		0
#define PAL1		(PAL0+16)
#define PAL2		(PAL1+16)
#define PAL3		(PAL2+16)
#define PAL4		(PAL3+16)
#define PAL5		(PAL4+16)
#define PAL6		(PAL5+16)
#define PAL7		(PAL6+16)
#define PAL8		(PAL7+16)
#define PAL9		(PAL8+16)
#define PAL10		(PAL9+16)
#define PAL11		(PAL10+16)
#define PAL12		(PAL11+16)
#define PAL13		(PAL12+16)
#define PAL14		(PAL13+16)
#define PAL15		(PAL14+16)

#define PA_OBJ0		(PAL15+16)
#define PA_OBJ1		(PA_OBJ0+16)
#define PA_OBJ2		(PA_OBJ1+16)
#define PA_OBJ3		(PA_OBJ2+16)
#define PA_OBJ4		(PA_OBJ3+16)
#define PA_OBJ5		(PA_OBJ4+16)
#define PA_OBJ6		(PA_OBJ5+16)
#define PA_OBJ7		(PA_OBJ6+16)
#define PA_OBJ8		(PA_OBJ7+16)
#define PA_OBJ9		(PA_OBJ8+16)
#define PA_OBJ10	(PA_OBJ9+16)
#define PA_OBJ11	(PA_OBJ10+16)
#define PA_OBJ12	(PA_OBJ11+16)
#define PA_OBJ13	(PA_OBJ12+16)
#define PA_OBJ14	(PA_OBJ13+16)
#define PA_OBJ15	(PA_OBJ14+16)

#define PA_COL0			0
#define PA_COL1			1
#define PA_COL2			2
#define PA_COL3			3
#define PA_COL4			4
#define PA_COL5			5
#define PA_COL6			6
#define PA_COL7			7
#define PA_COL8			8
#define PA_COL9			9
#define PA_COL10		10
#define PA_COL11		11
#define PA_COL12		12
#define PA_COL13		13
#define PA_COL14		14
#define PA_COL15		15

#define PAL_BG0			(0)
#define PAL_BG1			(1)
#define PAL_BG2			(2)
#define PAL_BG3			(3)
#define PAL_BG4			(4)
#define PAL_BG5			(5)
#define PAL_BG6			(6)
#define PAL_BG7			(7)
#define PAL_BG8			(8)
#define PAL_BG9			(9)
#define PAL_BG10		(10)
#define PAL_BG11		(11)
#define PAL_BG12		(12)
#define PAL_BG13		(13)
#define PAL_BG14		(14)
#define PAL_BG15		(15)

#define BGPALNO_TO_PANO(palnum)	    ((palnum) << 4)
#define OBJPALNO_TO_PANO(palnum)	(((palnum) << 4) + PA_OBJ0)

enum
{
    FAST_FADE_IN_FROM_WHITE,
    FAST_FADE_OUT_TO_WHITE,
    FAST_FADE_IN_FROM_BLACK,
    FAST_FADE_OUT_TO_BLACK,
};

struct PaletteFadeControl
{
    u32 multipurpose1;
    u8 delayCounter:6;
    u16 y:5; // blend coefficient
    u16 targetY:5; // target blend coefficient
    u16 blendColor:15;
    bool16 active:1;
    u16 multipurpose2:6;
    bool16 yDec:1; // whether blend coefficient is decreasing
    bool16 bufferTransferDisabled:1;
    u16 mode:2;
    bool16 shouldResetBlendRegisters:1;
    bool16 hardwareFadeFinishing:1;
    u16 softwareFadeFinishingCounter:5;
    bool16 softwareFadeFinishing:1;
    bool16 objPaletteToggle:1;
    u8 deltaY:4; // rate of change of blend coefficient
};

extern struct PaletteFadeControl gPaletteFade;
extern u32 gPlttBufferTransferPending;
extern u8 gPaletteDecompressionBuffer[];
extern u16 gPlttBufferUnfaded[PLTT_BUFFER_SIZE];
extern u16 gPlttBufferFaded[PLTT_BUFFER_SIZE];

void LoadCompressedPalette(const u32 *, u16, u16);
void LoadPalette(const void *, u16, u16);
void FillPalette(u16, u16, u16);
void TransferPlttBuffer(void);
u8 UpdatePaletteFade(void);
void ResetPaletteFade(void);
bool8 BeginNormalPaletteFade(u32, s8, u8, u8, u16);
void PaletteStruct_ResetById(u16);
void ResetPaletteFadeControl(void);
void InvertPlttBuffer(u32);
void TintPlttBuffer(u32, s8, s8, s8);
void UnfadePlttBuffer(u32);
void BeginFastPaletteFade(u8);
void BeginHardwarePaletteFade(u8, u8, u8, u8, u8);
void BlendPalettes(u32 selectedPalettes, u8 coeff, u16 color);
void BlendPalettesUnfaded(u32, u8, u16);
void BlendPalettesGradually(u32 selectedPalettes, s8 delay, u8 coeff, u8 coeffTarget, u16 color, u8 priority, u8 id);
void TintPalette_GrayScale(u16 *palette, u16 count);
void TintPalette_GrayScale2(u16 *palette, u16 count);
void TintPalette_SepiaTone(u16 *palette, u16 count);
void TintPalette_CustomTone(u16 *palette, u16 count, u16 rTone, u16 gTone, u16 bTone);

#endif // GUARD_PALETTE_H
