#include "global.h"
#include "battle_anim.h"
#include "contest.h"
#include "gpu_regs.h"
#include "graphics.h"
#include "malloc.h"
#include "palette.h"
#include "random.h"
#include "sound.h"
#include "sprite.h"
#include "task.h"
#include "trig.h"
#include "util.h"
#include "constants/rgb.h"
#include "constants/songs.h"

static void AnimConfusionDuck(struct Sprite *);
static void AnimSimplePaletteBlend(struct Sprite *);
static void AnimSimplePaletteBlend_Step(struct Sprite *);
static void AnimComplexPaletteBlend(struct Sprite *);
static void AnimComplexPaletteBlend_Step1(struct Sprite *);
static void AnimComplexPaletteBlend_Step2(struct Sprite *);
static void AnimCirclingSparkle(struct Sprite *);
static void AnimShakeMonOrBattleTerrain(struct Sprite *);
static void AnimShakeMonOrBattleTerrain_Step(struct Sprite *);
static void AnimShakeMonOrBattleTerrain_UpdateCoordOffsetEnabled(void);
static void AnimHitSplatBasic(struct Sprite *);
static void AnimHitSplatPersistent(struct Sprite *);
static void AnimHitSplatHandleInvert(struct Sprite *);
static void AnimHitSplatRandom(struct Sprite *);
static void AnimHitSplatOnMonEdge(struct Sprite *);
static void AnimCrossImpact(struct Sprite *);
static void AnimFlashingHitSplat(struct Sprite *);
static void AnimFlashingHitSplat_Step(struct Sprite *);
static void AnimConfusionDuck_Step(struct Sprite *);
static void BlendColorCycle(u8, u8, u8);
static void AnimTask_BlendColorCycleLoop(u8);
static void BlendColorCycleExclude(u8, u8, u8);
static void AnimTask_BlendColorCycleExcludeLoop(u8);
static void BlendColorCycleByTag(u8, u8, u8);
static void AnimTask_BlendColorCycleByTagLoop(u8);
static void AnimTask_FlashAnimTagWithColor_Step1(u8);
static void AnimTask_FlashAnimTagWithColor_Step2(u8);
static void AnimTask_ShakeBattleTerrain_Step(u8);
static void StartBlendAnimSpriteColor(u8, u32);
static void AnimTask_BlendSpriteColor_Step2(u8);
static void AnimTask_HardwarePaletteFade_Step(u8);
static void AnimTask_TraceMonBlended_Step(u8);
static void AnimMonTrace(struct Sprite*);
static void AnimTask_DrawFallingWhiteLinesOnAttacker_Step(u8);
static void StatsChangeAnimation_Step1(u8);
static void StatsChangeAnimation_Step2(u8);
static void StatsChangeAnimation_Step3(u8);
static void AnimTask_Flash_Step(u8);
static void SetPalettesToColor(u32, u16);
static void AnimTask_UpdateSlidingBg(u8);
static void UpdateMonScrollingBgMask(u8);
static void AnimTask_WaitAndRestoreVisibility(u8);

struct AnimStatsChangeData
{
    u8 battler1;
    u8 battler2;
    u8 higherPriority;
    //u8 dummy; //TODO: keep or can we safely remove?
    s16 data[8];
    u16 species;
};

static const union AnimCmd sAnim_ConfusionDuck_0[] =
{
    ANIMCMD_FRAME(0, 8),
    ANIMCMD_FRAME(4, 8),
    ANIMCMD_FRAME(0, 8, .hFlip = TRUE),
    ANIMCMD_FRAME(8, 8),
    ANIMCMD_JUMP(0),
};

static const union AnimCmd sAnim_ConfusionDuck_1[] =
{
    ANIMCMD_FRAME(0, 8, .hFlip = TRUE),
    ANIMCMD_FRAME(4, 8),
    ANIMCMD_FRAME(0, 8),
    ANIMCMD_FRAME(8, 8),
    ANIMCMD_JUMP(0),
};

static const union AnimCmd *const sAnims_ConfusionDuck[] =
{
    sAnim_ConfusionDuck_0,
    sAnim_ConfusionDuck_1,
};

const struct SpriteTemplate gConfusionDuckSpriteTemplate =
{
    .tileTag = ANIM_TAG_DUCK,
    .paletteTag = ANIM_TAG_DUCK,
    .oam = &gOamData_AffineOff_ObjNormal_16x16,
    .anims = sAnims_ConfusionDuck,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = AnimConfusionDuck,
};

const struct SpriteTemplate gSimplePaletteBlendSpriteTemplate =
{
    .tileTag = 0,
    .paletteTag = 0,
    .oam = &gDummyOamData,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = AnimSimplePaletteBlend,
};

const struct SpriteTemplate gComplexPaletteBlendSpriteTemplate =
{
    .tileTag = 0,
    .paletteTag = 0,
    .oam = &gDummyOamData,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = AnimComplexPaletteBlend,
};

static const union AnimCmd sAnim_CirclingSparkle[] =
{
    ANIMCMD_FRAME(0, 3),
    ANIMCMD_FRAME(16, 3),
    ANIMCMD_FRAME(32, 3),
    ANIMCMD_FRAME(48, 3),
    ANIMCMD_FRAME(64, 3),
    ANIMCMD_JUMP(0),
};

static const union AnimCmd *const sAnims_CirclingSparkle[] =
{
    sAnim_CirclingSparkle,
};

// Unused
static const struct SpriteTemplate sCirclingSparkleSpriteTemplate =
{
    .tileTag = ANIM_TAG_SPARKLE_4,
    .paletteTag = ANIM_TAG_SPARKLE_4,
    .oam = &gOamData_AffineOff_ObjNormal_32x32,
    .anims = sAnims_CirclingSparkle,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = AnimCirclingSparkle,
};

const struct SpriteTemplate gShakeMonOrTerrainSpriteTemplate =
{
    .tileTag = 0,
    .paletteTag = 0,
    .oam = &gDummyOamData,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = AnimShakeMonOrBattleTerrain,
};

static const union AffineAnimCmd sAffineAnim_HitSplat_0[] =
{
    AFFINEANIMCMD_FRAME(0x0, 0x0, 0, 8),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd sAffineAnim_HitSplat_1[] =
{
    AFFINEANIMCMD_FRAME(0xD8, 0xD8, 0, 0),
    AFFINEANIMCMD_FRAME(0x0, 0x0, 0, 8),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd sAffineAnim_HitSplat_2[] =
{
    AFFINEANIMCMD_FRAME(0xB0, 0xB0, 0, 0),
    AFFINEANIMCMD_FRAME(0x0, 0x0, 0, 8),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd sAffineAnim_HitSplat_3[] =
{
    AFFINEANIMCMD_FRAME(0x80, 0x80, 0, 0),
    AFFINEANIMCMD_FRAME(0x0, 0x0, 0, 8),
    AFFINEANIMCMD_END,
};

static const union AffineAnimCmd *const sAffineAnims_HitSplat[] =
{
    sAffineAnim_HitSplat_0,
    sAffineAnim_HitSplat_1,
    sAffineAnim_HitSplat_2,
    sAffineAnim_HitSplat_3,
};

const struct SpriteTemplate gBasicHitSplatSpriteTemplate =
{
    .tileTag = ANIM_TAG_IMPACT,
    .paletteTag = ANIM_TAG_IMPACT,
    .oam = &gOamData_AffineNormal_ObjBlend_32x32,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = sAffineAnims_HitSplat,
    .callback = AnimHitSplatBasic,
};

const struct SpriteTemplate gHandleInvertHitSplatSpriteTemplate =
{
    .tileTag = ANIM_TAG_IMPACT,
    .paletteTag = ANIM_TAG_IMPACT,
    .oam = &gOamData_AffineNormal_ObjBlend_32x32,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = sAffineAnims_HitSplat,
    .callback = AnimHitSplatHandleInvert,
};

const struct SpriteTemplate gWaterHitSplatSpriteTemplate =
{
    .tileTag = ANIM_TAG_WATER_IMPACT,
    .paletteTag = ANIM_TAG_WATER_IMPACT,
    .oam = &gOamData_AffineNormal_ObjBlend_32x32,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = sAffineAnims_HitSplat,
    .callback = AnimHitSplatBasic,
};

const struct SpriteTemplate gRandomPosHitSplatSpriteTemplate =
{
    .tileTag = ANIM_TAG_IMPACT,
    .paletteTag = ANIM_TAG_IMPACT,
    .oam = &gOamData_AffineNormal_ObjBlend_32x32,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = sAffineAnims_HitSplat,
    .callback = AnimHitSplatRandom,
};

const struct SpriteTemplate gMonEdgeHitSplatSpriteTemplate =
{
    .tileTag = ANIM_TAG_IMPACT,
    .paletteTag = ANIM_TAG_IMPACT,
    .oam = &gOamData_AffineNormal_ObjBlend_32x32,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = sAffineAnims_HitSplat,
    .callback = AnimHitSplatOnMonEdge,
};

const struct SpriteTemplate gCrossImpactSpriteTemplate =
{
    .tileTag = ANIM_TAG_CROSS_IMPACT,
    .paletteTag = ANIM_TAG_CROSS_IMPACT,
    .oam = &gOamData_AffineOff_ObjBlend_32x32,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = AnimCrossImpact,
};

const struct SpriteTemplate gFlashingHitSplatSpriteTemplate =
{
    .tileTag = ANIM_TAG_IMPACT,
    .paletteTag = ANIM_TAG_IMPACT,
    .oam = &gOamData_AffineNormal_ObjNormal_32x32,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = sAffineAnims_HitSplat,
    .callback = AnimFlashingHitSplat,
};

const struct SpriteTemplate gPersistHitSplatSpriteTemplate =
{
    .tileTag = ANIM_TAG_IMPACT,
    .paletteTag = ANIM_TAG_IMPACT,
    .oam = &gOamData_AffineNormal_ObjBlend_32x32,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = sAffineAnims_HitSplat,
    .callback = AnimHitSplatPersistent,
};


// Moves a spinning duck around the mon's head.
// arg 0: initial x pixel offset
// arg 1: initial y pixel offset
// arg 2: initial wave offset
// arg 3: wave period (higher means faster wave)
// arg 4: duration
static void AnimConfusionDuck(struct Sprite *sprite)
{
    sprite->x += gBattleAnimArgs[0];
    sprite->y += gBattleAnimArgs[1];
    sprite->data[0] = gBattleAnimArgs[2];
    if (GetBattlerSide(gBattleAnimAttacker) != B_SIDE_PLAYER)
    {
        sprite->data[1] = -gBattleAnimArgs[3];
        sprite->data[4] = 1;
    }
    else
    {
        sprite->data[1] = gBattleAnimArgs[3];
        sprite->data[4] = 0;
        StartSpriteAnim(sprite, 1);
    }

    sprite->data[3] = gBattleAnimArgs[4];
    sprite->callback = AnimConfusionDuck_Step;
    sprite->callback(sprite);
}

static void AnimConfusionDuck_Step(struct Sprite *sprite)
{
    sprite->x2 = Cos(sprite->data[0], 30);
    sprite->y2 = Sin(sprite->data[0], 10);

    if (sprite->data[0] >= 0 && sprite->data[0] < 128)
        sprite->oam.priority = 1;
    else
        sprite->oam.priority = 3;

    sprite->data[0] = (sprite->data[0] + sprite->data[1]) & 0xFF;
    if (++sprite->data[2] == sprite->data[3])
        DestroyAnimSprite(sprite);
}

// Performs a simple color blend on a specified sprite.
// arg 0: palette selector
// arg 1: delay
// arg 2: start blend amount
// arg 3: end blend amount
// arg 4: blend color
static void AnimSimplePaletteBlend(struct Sprite *sprite)
{
    u32 selectedPalettes = UnpackSelectedBattlePalettes(gBattleAnimArgs[0]);
    BeginNormalPaletteFade(selectedPalettes, gBattleAnimArgs[1], gBattleAnimArgs[2], gBattleAnimArgs[3], gBattleAnimArgs[4]);
    sprite->invisible = TRUE;
    sprite->callback = AnimSimplePaletteBlend_Step;
}

// Unpacks a bitfield and returns a bitmask of its selected palettes.
// Bits 0-6 of the selector parameter result in the following palettes being selected:
//   0: F_PAL_BG, battle background palettes (BG palettes 1, 2, and 3)
//   1: F_PAL_ATTACKER, gBattleAnimAttacker OBJ palette
//   2: F_PAL_TARGET, gBattleAnimTarget OBJ palette
//   3: F_PAL_ATK_PARTNER, gBattleAnimAttacker partner OBJ palette
//   4: F_PAL_DEF_PARTNER, gBattleAnimTarget partner OBJ palette
//   5: F_PAL_ANIM_1, BG palette 8 (or 14, if in Contest)
//   6: F_PAL_ANIM_2, BG palette 9
u32 UnpackSelectedBattlePalettes(s16 selector)
{
    bool8 battleBackground = selector & 1;
    bool8 attacker = (selector >> 1) & 1;
    bool8 target = (selector >> 2) & 1;
    bool8 attackerPartner = (selector >> 3) & 1;
    bool8 targetPartner = (selector >> 4) & 1;
    bool8 anim1 = (selector >> 5) & 1;
    bool8 anim2 = (selector >> 6) & 1;
    return GetBattlePalettesMask(battleBackground, attacker, target, attackerPartner, targetPartner, anim1, anim2);
}

static void AnimSimplePaletteBlend_Step(struct Sprite *sprite)
{
    if (!gPaletteFade.active)
        DestroyAnimSprite(sprite);
}

static void AnimComplexPaletteBlend(struct Sprite *sprite)
{
    u32 selectedPalettes;

    sprite->data[0] = gBattleAnimArgs[1];
    sprite->data[1] = gBattleAnimArgs[1];
    sprite->data[2] = gBattleAnimArgs[2];
    sprite->data[3] = gBattleAnimArgs[3];
    sprite->data[4] = gBattleAnimArgs[4];
    sprite->data[5] = gBattleAnimArgs[5];
    sprite->data[6] = gBattleAnimArgs[6];
    sprite->data[7] = gBattleAnimArgs[0];

    selectedPalettes = UnpackSelectedBattlePalettes(sprite->data[7]);
    BlendPalettes(selectedPalettes, gBattleAnimArgs[4], gBattleAnimArgs[3]);
    sprite->invisible = TRUE;
    sprite->callback = AnimComplexPaletteBlend_Step1;
}

static void AnimComplexPaletteBlend_Step1(struct Sprite *sprite)
{
    u32 selectedPalettes;

    if (sprite->data[0] > 0)
    {
        sprite->data[0]--;
        return;
    }

    if (gPaletteFade.active)
        return;

    if (sprite->data[2] == 0)
    {
        sprite->callback = AnimComplexPaletteBlend_Step2;
        return;
    }

    selectedPalettes = UnpackSelectedBattlePalettes(sprite->data[7]);
    if (sprite->data[1] & 0x100)
        BlendPalettes(selectedPalettes, sprite->data[4], sprite->data[3]);
    else
        BlendPalettes(selectedPalettes, sprite->data[6], sprite->data[5]);

    sprite->data[1] ^= 0x100;
    sprite->data[0] = sprite->data[1] & 0xFF;
    sprite->data[2]--;
}

static void AnimComplexPaletteBlend_Step2(struct Sprite *sprite)
{
    if (!gPaletteFade.active)
    {
        u32 selectedPalettes = UnpackSelectedBattlePalettes(sprite->data[7]);
        BlendPalettes(selectedPalettes, 0, 0);
        DestroyAnimSprite(sprite);
    }
}

static void AnimCirclingSparkle(struct Sprite *sprite)
{
    sprite->x += gBattleAnimArgs[0];
    sprite->y += gBattleAnimArgs[1];
    sprite->data[0] = 0;
    sprite->data[1] = 10;
    sprite->data[2] = 8;
    sprite->data[3] = 40;
    sprite->data[4] = 112;
    sprite->data[5] = 0;
    StoreSpriteCallbackInData6(sprite, DestroySpriteAndMatrix);
    sprite->callback = TranslateSpriteInGrowingCircle;
    TranslateSpriteInGrowingCircle(sprite);
}

// Task data for AnimTask_BlendColorCycle, AnimTask_BlendColorCycleExclude, and AnimTask_BlendColorCycleByTag
#define tPalSelector   data[0]  // AnimTask_BlendColorCycle
#define tPalTag        data[0]  // AnimTask_BlendColorCycleByTag
#define tDelay         data[1]
#define tNumBlends     data[2]
#define tInitialBlendY data[3]
#define tTargetBlendY  data[4]
#define tBlendColor    data[5]
#define tRestoreBlend  data[8]
#define tPalSelectorHi data[9]
#define tPalSelectorLo data[10]

// Blends mon/screen to designated color or back alternately tNumBlends times
// Many uses of this task only set a tNumBlends of 2, which has the effect of blending to a color and back once
void AnimTask_BlendColorCycle(u8 taskId)
{
    gTasks[taskId].tPalSelector = gBattleAnimArgs[0];
    gTasks[taskId].tDelay = gBattleAnimArgs[1];
    gTasks[taskId].tNumBlends = gBattleAnimArgs[2];
    gTasks[taskId].tInitialBlendY = gBattleAnimArgs[3];
    gTasks[taskId].tTargetBlendY = gBattleAnimArgs[4];
    gTasks[taskId].tBlendColor = gBattleAnimArgs[5];
    gTasks[taskId].tRestoreBlend = FALSE;
    BlendColorCycle(taskId, 0, gTasks[taskId].tTargetBlendY);
    gTasks[taskId].func = AnimTask_BlendColorCycleLoop;
}

static void BlendColorCycle(u8 taskId, u8 startBlendAmount, u8 targetBlendAmount)
{
    u32 selectedPalettes = UnpackSelectedBattlePalettes(gTasks[taskId].tPalSelector);
    BeginNormalPaletteFade(
        selectedPalettes,
        gTasks[taskId].tDelay,
        startBlendAmount,
        targetBlendAmount,
        gTasks[taskId].tBlendColor);

    gTasks[taskId].tNumBlends--;
    gTasks[taskId].tRestoreBlend ^= 1;
}

static void AnimTask_BlendColorCycleLoop(u8 taskId)
{
    u8 startBlendAmount, targetBlendAmount;
    if (!gPaletteFade.active)
    {
        if (gTasks[taskId].tNumBlends > 0)
        {
            if (!gTasks[taskId].tRestoreBlend)
            {
                // Blend to designated color
                startBlendAmount = gTasks[taskId].tInitialBlendY;
                targetBlendAmount = gTasks[taskId].tTargetBlendY;
            }
            else
            {
                // Blend back to original color
                startBlendAmount = gTasks[taskId].tTargetBlendY;
                targetBlendAmount = gTasks[taskId].tInitialBlendY;
            }

            if (gTasks[taskId].tNumBlends == 1)
                targetBlendAmount = 0;

            BlendColorCycle(taskId, startBlendAmount, targetBlendAmount);
        }
        else
        {
            DestroyAnimVisualTask(taskId);
        }
    }
}

// See AnimTask_BlendColorCycle. Same, but excludes Attacker and Target
void AnimTask_BlendColorCycleExclude(u8 taskId)
{
    m32 battler;
    u32 selectedPalettes = 0;

    gTasks[taskId].data[0] = gBattleAnimArgs[0];
    gTasks[taskId].tDelay = gBattleAnimArgs[1];
    gTasks[taskId].tNumBlends = gBattleAnimArgs[2];
    gTasks[taskId].tInitialBlendY = gBattleAnimArgs[3];
    gTasks[taskId].tTargetBlendY = gBattleAnimArgs[4];
    gTasks[taskId].tBlendColor = gBattleAnimArgs[5];
    gTasks[taskId].tRestoreBlend = 0;

    for (battler = 0; battler < gBattlersCount; battler++)
    {
        if (battler != gBattleAnimAttacker && battler != gBattleAnimTarget)
            selectedPalettes |= 1 << (battler + 16);
    }

    if (gBattleAnimArgs[0] == 1)
        selectedPalettes |= 0xE;

    gTasks[taskId].tPalSelectorHi = selectedPalettes >> 16;
    gTasks[taskId].tPalSelectorLo = selectedPalettes & 0xFF;
    BlendColorCycleExclude(taskId, 0, gTasks[taskId].tTargetBlendY);
    gTasks[taskId].func = AnimTask_BlendColorCycleExcludeLoop;
}

static void BlendColorCycleExclude(u8 taskId, u8 startBlendAmount, u8 targetBlendAmount)
{
    u32 selectedPalettes = ((u16)gTasks[taskId].tPalSelectorHi << 16) | ((u16)gTasks[taskId].tPalSelectorLo & 0xFFFF);
    BeginNormalPaletteFade(
        selectedPalettes,
        gTasks[taskId].tDelay,
        startBlendAmount,
        targetBlendAmount,
        gTasks[taskId].tBlendColor);

    gTasks[taskId].tNumBlends--;
    gTasks[taskId].tRestoreBlend ^= 1;
}

static void AnimTask_BlendColorCycleExcludeLoop(u8 taskId)
{
    u8 startBlendAmount, targetBlendAmount;
    if (!gPaletteFade.active)
    {
        if (gTasks[taskId].tNumBlends > 0)
        {
            if (!gTasks[taskId].tRestoreBlend)
            {
                // Blend to designated color
                startBlendAmount = gTasks[taskId].tInitialBlendY;
                targetBlendAmount = gTasks[taskId].tTargetBlendY;
            }
            else
            {
                // Blend back to original color
                startBlendAmount = gTasks[taskId].tTargetBlendY;
                targetBlendAmount = gTasks[taskId].tInitialBlendY;
            }

            if (gTasks[taskId].tNumBlends == 1)
                targetBlendAmount = 0;

            BlendColorCycleExclude(taskId, startBlendAmount, targetBlendAmount);
        }
        else
        {
            DestroyAnimVisualTask(taskId);
        }
    }
}

// See AnimTask_BlendColorCycle. Same, but selects palette by ANIM_TAG_*
void AnimTask_BlendColorCycleByTag(u8 taskId)
{
    gTasks[taskId].tPalTag = gBattleAnimArgs[0];
    gTasks[taskId].tDelay = gBattleAnimArgs[1];
    gTasks[taskId].tNumBlends = gBattleAnimArgs[2];
    gTasks[taskId].tInitialBlendY = gBattleAnimArgs[3];
    gTasks[taskId].tTargetBlendY = gBattleAnimArgs[4];
    gTasks[taskId].tBlendColor = gBattleAnimArgs[5];
    gTasks[taskId].tRestoreBlend = FALSE;

    BlendColorCycleByTag(taskId, 0, gTasks[taskId].tTargetBlendY);
    gTasks[taskId].func = AnimTask_BlendColorCycleByTagLoop;
}

static void BlendColorCycleByTag(u8 taskId, u8 startBlendAmount, u8 targetBlendAmount)
{
    u8 paletteIndex = IndexOfSpritePaletteTag(gTasks[taskId].tPalTag);
    BeginNormalPaletteFade(
        1 << (paletteIndex + 16),
        gTasks[taskId].tDelay,
        startBlendAmount,
        targetBlendAmount,
        gTasks[taskId].tBlendColor);

    gTasks[taskId].tNumBlends--;
    gTasks[taskId].tRestoreBlend ^= 1;
}

static void AnimTask_BlendColorCycleByTagLoop(u8 taskId)
{
    u8 startBlendAmount, targetBlendAmount;
    if (!gPaletteFade.active)
    {
        if (gTasks[taskId].tNumBlends > 0)
        {
            if (!gTasks[taskId].tRestoreBlend)
            {
                // Blend to designated color
                startBlendAmount = gTasks[taskId].tInitialBlendY;
                targetBlendAmount = gTasks[taskId].tTargetBlendY;
            }
            else
            {
                // Blend back to original color
                startBlendAmount = gTasks[taskId].tTargetBlendY;
                targetBlendAmount = gTasks[taskId].tInitialBlendY;
            }

            if (gTasks[taskId].tNumBlends == 1)
                targetBlendAmount = 0;

            BlendColorCycleByTag(taskId, startBlendAmount, targetBlendAmount);
        }
        else
        {
            DestroyAnimVisualTask(taskId);
        }
    }
}

#undef tPalSelector
#undef tPalTag
#undef tDelay
#undef tNumBlends
#undef tInitialBlendY
#undef tTargetBlendY
#undef tBlendColor
#undef tRestoreBlend
#undef tPalSelectorHi
#undef tPalSelectorLo

// Flashes the specified anim tag with given color. Used e.g. to flash the particles red in Hyper Beam
void AnimTask_FlashAnimTagWithColor(u8 taskId)
{
    u8 paletteIndex;

    gTasks[taskId].data[0] = gBattleAnimArgs[1];
    gTasks[taskId].data[1] = gBattleAnimArgs[1];
    gTasks[taskId].data[2] = gBattleAnimArgs[2];
    gTasks[taskId].data[3] = gBattleAnimArgs[3];
    gTasks[taskId].data[4] = gBattleAnimArgs[4];
    gTasks[taskId].data[5] = gBattleAnimArgs[5];
    gTasks[taskId].data[6] = gBattleAnimArgs[6];
    gTasks[taskId].data[7] = gBattleAnimArgs[0];

    paletteIndex = IndexOfSpritePaletteTag(gBattleAnimArgs[0]);
    BeginNormalPaletteFade(
        1 << (paletteIndex + 16),
        0,
        gBattleAnimArgs[4],
        gBattleAnimArgs[4],
        gBattleAnimArgs[3]);

    gTasks[taskId].func = AnimTask_FlashAnimTagWithColor_Step1;
}

static void AnimTask_FlashAnimTagWithColor_Step1(u8 taskId)
{
    u32 selectedPalettes;

    if (gTasks[taskId].data[0] > 0)
    {
        gTasks[taskId].data[0]--;
        return;
    }

    if (gPaletteFade.active)
        return;

    if (gTasks[taskId].data[2] == 0)
    {
        gTasks[taskId].func = AnimTask_FlashAnimTagWithColor_Step2;
        return;
    }

    selectedPalettes = 1 << (IndexOfSpritePaletteTag(gTasks[taskId].data[7]) + 16);
    if (gTasks[taskId].data[1] & 0x100)
    {
        BeginNormalPaletteFade(
            selectedPalettes,
            0,
            gTasks[taskId].data[4],
            gTasks[taskId].data[4],
            gTasks[taskId].data[3]);
    }
    else
    {
        BeginNormalPaletteFade(
            selectedPalettes,
            0,
            gTasks[taskId].data[6],
            gTasks[taskId].data[6],
            gTasks[taskId].data[5]);
    }

    gTasks[taskId].data[1] ^= 0x100;
    gTasks[taskId].data[0] = gTasks[taskId].data[1] & 0xFF;
    gTasks[taskId].data[2]--;
}

static void AnimTask_FlashAnimTagWithColor_Step2(u8 taskId)
{
    if (!gPaletteFade.active)
    {
        u32 selectedPalettes = 1 << (IndexOfSpritePaletteTag(gTasks[taskId].data[7]) + 16);
        BeginNormalPaletteFade(selectedPalettes, 0, 0, 0, RGB(0, 0, 0));
        DestroyAnimVisualTask(taskId);
    }
}

void AnimTask_InvertScreenColor(u8 taskId)
{
    u32 selectedPalettes = 0;
    u8 attackerBattler = gBattleAnimAttacker;
    u8 targetBattler = gBattleAnimTarget;

    if (gBattleAnimArgs[0] & 0x100)
        selectedPalettes = GetBattlePalettesMask(TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE);

    if (gBattleAnimArgs[1] & 0x100)
        selectedPalettes |= (0x10000 << attackerBattler);

    if (gBattleAnimArgs[2] & 0x100)
        selectedPalettes |= (0x10000 << targetBattler);

    InvertPlttBuffer(selectedPalettes);
    DestroyAnimVisualTask(taskId);
}

// Unused
#define tTimer         data[0]
#define tLength        data[1]
#define tFlagsScenery  data[2]
#define tFlagsAttacker data[3]
#define tFlagsTarget   data[4]
#define tColorR        data[5]
#define tColorG        data[6]
#define tColorB        data[7]
void AnimTask_TintPalettes(u8 taskId)
{
    u8 attackerBattler;
    u8 targetBattler;
    u8 paletteIndex;
    u32 selectedPalettes = 0;

    if (gTasks[taskId].tTimer == 0)
    {
        gTasks[taskId].tFlagsScenery = gBattleAnimArgs[0];
        gTasks[taskId].tFlagsAttacker = gBattleAnimArgs[1];
        gTasks[taskId].tFlagsTarget = gBattleAnimArgs[2];
        gTasks[taskId].tLength = gBattleAnimArgs[3];
        gTasks[taskId].tColorR = gBattleAnimArgs[4];
        gTasks[taskId].tColorG = gBattleAnimArgs[5];
        gTasks[taskId].tColorB = gBattleAnimArgs[6];
    }

    gTasks[taskId].tTimer++;
    attackerBattler = gBattleAnimAttacker;
    targetBattler = gBattleAnimTarget;

    if (gTasks[taskId].tFlagsScenery & (1 << 8))
        selectedPalettes = PALETTES_BG;

    if (gTasks[taskId].tFlagsScenery & 1)
    {
        paletteIndex = IndexOfSpritePaletteTag(gSprites[gHealthboxSpriteIds[attackerBattler]].template->paletteTag);
        selectedPalettes |= (1 << paletteIndex) << 16;
    }

    if (gTasks[taskId].tFlagsAttacker & (1 << 8))
        selectedPalettes |= (1 << attackerBattler) << 16;

    if (gTasks[taskId].tFlagsTarget & (1 << 8))
        selectedPalettes |= (1 << targetBattler) << 16;

    TintPlttBuffer(selectedPalettes, gTasks[taskId].tColorR, gTasks[taskId].tColorG, gTasks[taskId].tColorB);
    if (gTasks[taskId].tTimer == gTasks[taskId].tLength)
    {
        UnfadePlttBuffer(selectedPalettes);
        DestroyAnimVisualTask(taskId);
    }
}
#undef tTimer
#undef tLength
#undef tFlagsScenery
#undef tFlagsAttacker
#undef tFlagsTarget
#undef tColorR
#undef tColorG
#undef tColorB

static void AnimShakeMonOrBattleTerrain(struct Sprite *sprite)
{
    u16 var0;

    sprite->invisible = TRUE;
    sprite->data[0] = -gBattleAnimArgs[0];
    sprite->data[1] = gBattleAnimArgs[1];
    sprite->data[2] = gBattleAnimArgs[1];
    sprite->data[3] = gBattleAnimArgs[2];

    switch (gBattleAnimArgs[3])
    {
    case 0:
        StoreSpriteCallbackInData6(sprite, (void *)&gBattle_BG3_X);
        break;
    case 1:
        StoreSpriteCallbackInData6(sprite, (void *)&gBattle_BG3_Y);
        break;
    case 2:
        StoreSpriteCallbackInData6(sprite, (void *)&gSpriteCoordOffsetX);
        break;
    case 3:
    default:
        StoreSpriteCallbackInData6(sprite, (void *)&gSpriteCoordOffsetY);
        break;
    }
    #if !MODERN
    sprite->data[4] = *(u16 *)((u32)sprite->data[6] | ((u32)sprite->data[7] << 16));
    #else
    sprite->data[4] = *(s16 *)((u32)sprite->data[6] | ((u32)sprite->data[7] << 16));
    #endif
    sprite->data[5] = gBattleAnimArgs[3];

    if (gBattleAnimArgs[3] == 2 || gBattleAnimArgs[3] == 3)
        AnimShakeMonOrBattleTerrain_UpdateCoordOffsetEnabled();

    sprite->callback = AnimShakeMonOrBattleTerrain_Step;
}

static void AnimShakeMonOrBattleTerrain_Step(struct Sprite *sprite)
{
    m8 i;

    if (sprite->data[3] > 0)
    {
        sprite->data[3]--;
        if (sprite->data[1] > 0)
        {
            sprite->data[1]--;
        }
        else
        {
            sprite->data[1] = sprite->data[2];
            // TODO: should this be an s16 or u16?
            *(s16 *)((u32)sprite->data[6] | ((u32)sprite->data[7] << 16)) += sprite->data[0];
            sprite->data[0] = -sprite->data[0];
        }
    }
    else
    {
        
        *(s16 *)((u32)sprite->data[6] | ((u32)sprite->data[7] << 16)) = sprite->data[4];

        if (sprite->data[5] == 2 || sprite->data[5] == 3)
        {
            for (i = 0; i < gBattlersCount; i++)
                gSprites[gBattlerSpriteIds[i]].coordOffsetEnabled = FALSE;
        }

        DestroyAnimSprite(sprite);
    }
}

static void AnimShakeMonOrBattleTerrain_UpdateCoordOffsetEnabled(void)
{
    gSprites[gBattlerSpriteIds[gBattleAnimAttacker]].coordOffsetEnabled = FALSE;
    gSprites[gBattlerSpriteIds[gBattleAnimTarget]].coordOffsetEnabled = FALSE;

    if (gBattleAnimArgs[4] == 2)
    {
        gSprites[gBattlerSpriteIds[gBattleAnimAttacker]].coordOffsetEnabled = TRUE;
        gSprites[gBattlerSpriteIds[gBattleAnimTarget]].coordOffsetEnabled = TRUE;
        return;
    }

    if (gBattleAnimArgs[4] == 0)
        gSprites[gBattlerSpriteIds[gBattleAnimAttacker]].coordOffsetEnabled = TRUE;
    else
        gSprites[gBattlerSpriteIds[gBattleAnimTarget]].coordOffsetEnabled = TRUE;
}

// Task data for AnimTask_ShakeBattleTerrain
#define tXOffset     data[0]
#define tYOffset     data[1]
#define tNumShakes   data[2]
#define tTimer       data[3]
#define tShakeDelay  data[8]

// Can shake battle terrain back and forth on the X or down and back to original pos on Y (cant shake up from orig pos)
// arg0: x offset of shake
// arg1: y offset of shake
// arg2: number of shakes
// arg3: time between shakes
void AnimTask_ShakeBattleTerrain(u8 taskId)
{
    gTasks[taskId].tXOffset = gBattleAnimArgs[0];
    gTasks[taskId].tYOffset = gBattleAnimArgs[1];
    gTasks[taskId].tNumShakes = gBattleAnimArgs[2];
    gTasks[taskId].tTimer = gBattleAnimArgs[3];
    gTasks[taskId].tShakeDelay = gBattleAnimArgs[3];
    gBattle_BG3_X = gBattleAnimArgs[0];
    gBattle_BG3_Y = gBattleAnimArgs[1];
    gTasks[taskId].func = AnimTask_ShakeBattleTerrain_Step;
    gTasks[taskId].func(taskId);
}

static void AnimTask_ShakeBattleTerrain_Step(u8 taskId)
{
    if (gTasks[taskId].tTimer == 0)
    {
        if (gBattle_BG3_X == gTasks[taskId].tXOffset)
            gBattle_BG3_X = -gTasks[taskId].tXOffset;
        else
            gBattle_BG3_X = gTasks[taskId].tXOffset;

        if (gBattle_BG3_Y == -gTasks[taskId].tYOffset)
            gBattle_BG3_Y = 0;
        else
            gBattle_BG3_Y = -gTasks[taskId].tYOffset;

        gTasks[taskId].tTimer = gTasks[taskId].tShakeDelay;
        if (--gTasks[taskId].tNumShakes == 0)
        {
            gBattle_BG3_X = 0;
            gBattle_BG3_Y = 0;
            DestroyAnimVisualTask(taskId);
        }
    }
    else
    {
        gTasks[taskId].tTimer--;
    }
}

#undef tXOffset
#undef tYOffset
#undef tNumShakes
#undef tTimer
#undef tShakeDelay

static void AnimHitSplatBasic(struct Sprite *sprite)
{
    StartSpriteAffineAnim(sprite, gBattleAnimArgs[3]);
    if (gBattleAnimArgs[2] == ANIM_ATTACKER)
        InitSpritePosToAnimAttacker(sprite, TRUE);
    else
        InitSpritePosToAnimTarget(sprite, TRUE);

    sprite->callback = RunStoredCallbackWhenAffineAnimEnds;
    StoreSpriteCallbackInData6(sprite, DestroyAnimSprite);
}

// Same as basic hit splat but takes a length of time to persist for (arg4)
static void AnimHitSplatPersistent(struct Sprite *sprite)
{
    StartSpriteAffineAnim(sprite, gBattleAnimArgs[3]);
    if (gBattleAnimArgs[2] == ANIM_ATTACKER)
        InitSpritePosToAnimAttacker(sprite, TRUE);
    else
        InitSpritePosToAnimTarget(sprite, TRUE);

    sprite->data[0] = gBattleAnimArgs[4];
    sprite->callback = RunStoredCallbackWhenAffineAnimEnds;
    StoreSpriteCallbackInData6(sprite, DestroyAnimSpriteAfterTimer);
}

// For paired hit splats whose position is inverted when used by the opponent on the player.
// Used by Twineedle and Spike Cannon
static void AnimHitSplatHandleInvert(struct Sprite *sprite)
{
    if (GetBattlerSide(gBattleAnimAttacker) != B_SIDE_PLAYER && !IsContest())
        gBattleAnimArgs[1] = -gBattleAnimArgs[1];

    AnimHitSplatBasic(sprite);
}

static void AnimHitSplatRandom(struct Sprite *sprite)
{
    if (gBattleAnimArgs[1] == -1)
        gBattleAnimArgs[1] = Random2() & 3;

    StartSpriteAffineAnim(sprite, gBattleAnimArgs[1]);
    if (gBattleAnimArgs[0] == ANIM_ATTACKER)
        InitSpritePosToAnimAttacker(sprite, FALSE);
    else
        InitSpritePosToAnimTarget(sprite, FALSE);

    sprite->x2 += (Random2() % 48) - 24;
    sprite->y2 += (Random2() % 24) - 12;

    StoreSpriteCallbackInData6(sprite, DestroySpriteAndMatrix);
    sprite->callback = RunStoredCallbackWhenAffineAnimEnds;
}

static void AnimHitSplatOnMonEdge(struct Sprite *sprite)
{
    sprite->data[0] = GetAnimBattlerSpriteId(gBattleAnimArgs[0]);
    sprite->x = gSprites[sprite->data[0]].x + gSprites[sprite->data[0]].x2;
    sprite->y = gSprites[sprite->data[0]].y + gSprites[sprite->data[0]].y2;
    sprite->x2 = gBattleAnimArgs[1];
    sprite->y2 = gBattleAnimArgs[2];
    StartSpriteAffineAnim(sprite, gBattleAnimArgs[3]);
    StoreSpriteCallbackInData6(sprite, DestroySpriteAndMatrix);
    sprite->callback = RunStoredCallbackWhenAffineAnimEnds;
}

static void AnimCrossImpact(struct Sprite *sprite)
{
    if (gBattleAnimArgs[2] == ANIM_ATTACKER)
        InitSpritePosToAnimAttacker(sprite, TRUE);
    else
        InitSpritePosToAnimTarget(sprite, TRUE);

    sprite->data[0] = gBattleAnimArgs[3];
    StoreSpriteCallbackInData6(sprite, DestroyAnimSprite);
    sprite->callback = WaitAnimForDuration;
}

static void AnimFlashingHitSplat(struct Sprite *sprite)
{
    StartSpriteAffineAnim(sprite, gBattleAnimArgs[3]);
    if (gBattleAnimArgs[2] == ANIM_ATTACKER)
        InitSpritePosToAnimAttacker(sprite, TRUE);
    else
        InitSpritePosToAnimTarget(sprite, TRUE);

    sprite->callback = AnimFlashingHitSplat_Step;
}

static void AnimFlashingHitSplat_Step(struct Sprite *sprite)
{
    sprite->invisible ^= 1;
    if (sprite->data[0]++ > 12)
        DestroyAnimSprite(sprite);
}

// START

void AnimTask_BlendBattleAnimPal(u8 taskId)
{
    u32 selectedPalettes = UnpackSelectedBattlePalettes(gBattleAnimArgs[0]);
    selectedPalettes |= GetBattleMonSpritePalettesMask((gBattleAnimArgs[0] >>  7) & 1,
                                    (gBattleAnimArgs[0] >>  8) & 1,
                                    (gBattleAnimArgs[0] >>  9) & 1,
                                    (gBattleAnimArgs[0] >> 10) & 1);
    StartBlendAnimSpriteColor(taskId, selectedPalettes);
}

void AnimTask_BlendBattleAnimPalExclude(u8 taskId)
{
    u8 battler;
    u32 selectedPalettes;
    u8 animBattlers[2];

    animBattlers[1] = 0xFF;
    selectedPalettes = UnpackSelectedBattlePalettes(1);
    switch (gBattleAnimArgs[0])
    {
    case 2:
        selectedPalettes = 0;
        // fall through
    case ANIM_ATTACKER:
        animBattlers[0] = gBattleAnimAttacker;
        break;
    case 3:
        selectedPalettes = 0;
        // fall through
    case ANIM_TARGET:
        animBattlers[0] = gBattleAnimTarget;
        break;
    case 4:
        animBattlers[0] = gBattleAnimAttacker;
        animBattlers[1] = gBattleAnimTarget;
        break;
    case 5:
        animBattlers[0] = 0xFF;
        break;
    case 6:
        selectedPalettes = 0;
        animBattlers[0] = BATTLE_PARTNER(gBattleAnimAttacker);
        break;
    case 7:
        selectedPalettes = 0;
        animBattlers[0] = BATTLE_PARTNER(gBattleAnimTarget);
        break;
    }

    for (battler = 0; battler < MAX_BATTLERS_COUNT; battler++)
    {
        if (battler != animBattlers[0] && battler != animBattlers[1] && IsBattlerSpriteVisible(battler))
            selectedPalettes |= 0x10000 << GetSpritePalIdxByBattler(battler);
    }

    StartBlendAnimSpriteColor(taskId, selectedPalettes);
}

void AnimTask_SetCamouflageBlend(u8 taskId)
{
    u32 selectedPalettes = UnpackSelectedBattlePalettes(gBattleAnimArgs[0]);
    switch (gBattleTerrain)
    {
    case BATTLE_TERRAIN_GRASS:
        gBattleAnimArgs[4] = RGB(12, 24, 2);
        break;
    case BATTLE_TERRAIN_LONG_GRASS:
        gBattleAnimArgs[4] = RGB(0, 15, 2);
        break;
    case BATTLE_TERRAIN_SAND:
        gBattleAnimArgs[4] = RGB(30, 24, 11);
        break;
    case BATTLE_TERRAIN_UNDERWATER:
        gBattleAnimArgs[4] = RGB(0, 0, 18);
        break;
    case BATTLE_TERRAIN_WATER:
        gBattleAnimArgs[4] = RGB(11, 22, 31);
        break;
    case BATTLE_TERRAIN_POND:
        gBattleAnimArgs[4] = RGB(11, 22, 31);
        break;
    case BATTLE_TERRAIN_MOUNTAIN:
        gBattleAnimArgs[4] = RGB(22, 16, 10);
        break;
    case BATTLE_TERRAIN_CAVE:
        gBattleAnimArgs[4] = RGB(14, 9, 3);
        break;
    case BATTLE_TERRAIN_BUILDING:
        gBattleAnimArgs[4] = RGB(31, 31, 31);
        break;
    case BATTLE_TERRAIN_PLAIN:
        gBattleAnimArgs[4] = RGB(31, 31, 31);
        break;
    }

    StartBlendAnimSpriteColor(taskId, selectedPalettes);
}

void AnimTask_BlendParticle(u8 taskId)
{
    u8 paletteIndex = IndexOfSpritePaletteTag(gBattleAnimArgs[0]);
    u32 selectedPalettes = 1 << (paletteIndex + 16);
    StartBlendAnimSpriteColor(taskId, selectedPalettes);
}

void StartBlendAnimSpriteColor(u8 taskId, u32 selectedPalettes)
{
    gTasks[taskId].data[0] = selectedPalettes & 0xFFFF;
    gTasks[taskId].data[1] = selectedPalettes >> 16;
    gTasks[taskId].data[2] = gBattleAnimArgs[1];
    gTasks[taskId].data[3] = gBattleAnimArgs[2];
    gTasks[taskId].data[4] = gBattleAnimArgs[3];
    gTasks[taskId].data[5] = gBattleAnimArgs[4];
    gTasks[taskId].data[10] = gBattleAnimArgs[2];
    gTasks[taskId].func = AnimTask_BlendSpriteColor_Step2;
    gTasks[taskId].func(taskId);
}

static void AnimTask_BlendSpriteColor_Step2(u8 taskId)
{
    u32 selectedPalettes;
    u16 singlePaletteMask = 0;

    if (gTasks[taskId].data[9] == gTasks[taskId].data[2])
    {
        gTasks[taskId].data[9] = 0;
        selectedPalettes = gTasks[taskId].data[0] | (gTasks[taskId].data[1] << 16);
        while (selectedPalettes != 0)
        {
            if (selectedPalettes & 1)
                BlendPalette(singlePaletteMask, 16, gTasks[taskId].data[10], gTasks[taskId].data[5]);
            singlePaletteMask += 0x10;
            selectedPalettes >>= 1;
        }

        if (gTasks[taskId].data[10] < gTasks[taskId].data[4])
            gTasks[taskId].data[10]++;
        else if (gTasks[taskId].data[10] > gTasks[taskId].data[4])
            gTasks[taskId].data[10]--;
        else
            DestroyAnimVisualTask(taskId);
    }
    else
    {
        gTasks[taskId].data[9]++;
    }
}

void AnimTask_HardwarePaletteFade(u8 taskId)
{
    BeginHardwarePaletteFade(
        gBattleAnimArgs[0],
        gBattleAnimArgs[1],
        gBattleAnimArgs[2],
        gBattleAnimArgs[3],
        gBattleAnimArgs[4]);

    gTasks[taskId].func = AnimTask_HardwarePaletteFade_Step;
}

static void AnimTask_HardwarePaletteFade_Step(u8 taskId)
{
    if (!gPaletteFade.active)
        DestroyAnimVisualTask(taskId);
}

// Used to leave blended traces of a mon, usually to imply speed as in Agility or Aerial Ace
void AnimTask_TraceMonBlended(u8 taskId)
{
    struct Task *task = &gTasks[taskId];

    task->data[0] = gBattleAnimArgs[0];
    task->data[1] = 0;
    task->data[2] = gBattleAnimArgs[1];
    task->data[3] = gBattleAnimArgs[2];
    task->data[4] = gBattleAnimArgs[3];
    task->data[5] = 0;
    task->func = AnimTask_TraceMonBlended_Step;
}

static void AnimTask_TraceMonBlended_Step(u8 taskId)
{
    struct Task *task = &gTasks[taskId];

    if (task->data[4])
    {
        if (task->data[1])
        {
            task->data[1]--;
        }
        else
        {
            task->data[6] = CloneBattlerSpriteWithBlend(task->data[0]);
            if (task->data[6] >= 0)
            {
                gSprites[task->data[6]].oam.priority = task->data[0] ? 1 : 2;
                gSprites[task->data[6]].data[0] = task->data[3];
                gSprites[task->data[6]].data[1] = taskId;
                gSprites[task->data[6]].data[2] = 5;
                gSprites[task->data[6]].callback = AnimMonTrace;
                task->data[5]++;
            }

            task->data[4]--;
            task->data[1] = task->data[2];
        }
    }
    else if (task->data[5] == 0)
    {
        DestroyAnimVisualTask(taskId);
    }
}

static void AnimMonTrace(struct Sprite *sprite)
{
    if (sprite->data[0])
    {
        sprite->data[0]--;
    }
    else
    {
        gTasks[sprite->data[1]].data[sprite->data[2]]--;
        DestroySpriteWithActiveSheet(sprite);
    }
}

const u16 sCurseLinesPalette = RGB_WHITE;
// Only used by Curse for non-Ghost mons
void AnimTask_DrawFallingWhiteLinesOnAttacker(u8 taskId)
{
    u16 species;
    u8 spriteId, newSpriteId;
    s16 var0 = FALSE;
    u16 bg1Cnt;
    struct BattleAnimBgData animBgData;

    gBattle_WIN0H = 0;
    gBattle_WIN0V = 0;
    SetGpuReg(REG_OFFSET_WININ, WININ_WIN0_BG_ALL | WININ_WIN0_OBJ | WININ_WIN0_CLR
                              | WININ_WIN1_BG_ALL | WININ_WIN1_OBJ | WININ_WIN1_CLR);
    SetGpuReg(REG_OFFSET_WINOUT, WINOUT_WIN01_BG0 | WINOUT_WIN01_BG2 | WINOUT_WIN01_BG3 | WINOUT_WIN01_OBJ | WINOUT_WIN01_CLR
                               | WINOUT_WINOBJ_BG_ALL | WINOUT_WINOBJ_OBJ | WINOUT_WINOBJ_CLR);
    SetGpuRegBits(REG_OFFSET_DISPCNT, DISPCNT_OBJWIN_ON);
    SetGpuReg(REG_OFFSET_BLDCNT, BLDCNT_TGT1_BG1 | BLDCNT_TGT2_ALL | BLDCNT_EFFECT_BLEND);
    SetGpuReg(REG_OFFSET_BLDALPHA, BLDALPHA_BLEND(8, 12));
    bg1Cnt = GetGpuReg(REG_OFFSET_BG1CNT);
    // TODO: SHOULD THESE BE VOLATILE?!
    ((vBgCnt*)&bg1Cnt)->priority = 0;
    ((vBgCnt*)&bg1Cnt)->screenSize = 0;
    SetGpuReg(REG_OFFSET_BG1CNT, bg1Cnt);

    if (!IsContest())
    {
        ((vBgCnt*)&bg1Cnt)->charBaseBlock = 1;
        SetGpuReg(REG_OFFSET_BG1CNT, bg1Cnt);
    }

    if (IsDoubleBattle() && !IsContest())
    {
        if (GetBattlerPosition(gBattleAnimAttacker) == B_POSITION_OPPONENT_RIGHT
         || GetBattlerPosition(gBattleAnimAttacker) == B_POSITION_PLAYER_LEFT)
        {
            if (IsBattlerSpriteVisible(BATTLE_PARTNER(gBattleAnimAttacker)) == TRUE)
            {
                gSprites[gBattlerSpriteIds[BATTLE_PARTNER(gBattleAnimAttacker)]].oam.priority -= 1;
                ((vBgCnt*)&bg1Cnt)->priority = 1;
                SetGpuReg(REG_OFFSET_BG1CNT, bg1Cnt);
                var0 = TRUE;
            }
        }
    }

    if (IsContest())
        species = gContestResources->moveAnim->species;
    else if (GetBattlerSide(gBattleAnimAttacker) != B_SIDE_PLAYER)
        species = GetMonData(&gEnemyParty[gBattlerPartyIndexes[gBattleAnimAttacker]], MON_DATA_SPECIES);
    else
        species = GetMonData(&gPlayerParty[gBattlerPartyIndexes[gBattleAnimAttacker]], MON_DATA_SPECIES);

    spriteId = GetAnimBattlerSpriteId(ANIM_ATTACKER);
    newSpriteId = CreateInvisibleSpriteCopy(gBattleAnimAttacker, spriteId, species);
    GetBattleAnimBg1Data(&animBgData);
    // TODO: apparently this is a debug function
    AnimLoadCompressedBgTilemapHandleContest(&animBgData, gBattleAnimMaskTilemap_Curse, FALSE);
    AnimLoadCompressedBgGfx(animBgData.bgId, gBattleAnimMaskImage_Curse, animBgData.tilesOffset);
    LoadPalette(&sCurseLinesPalette, animBgData.paletteId * 16 + 1, 2);

    gBattle_BG1_X = -gSprites[spriteId].x + 32;
    gBattle_BG1_Y = -gSprites[spriteId].y + 32;
    gTasks[taskId].data[0] = newSpriteId;
    gTasks[taskId].data[6] = var0;
    gTasks[taskId].func = AnimTask_DrawFallingWhiteLinesOnAttacker_Step;
}

static void AnimTask_DrawFallingWhiteLinesOnAttacker_Step(u8 taskId)
{
    struct BattleAnimBgData animBgData;
    struct Sprite *sprite;
    u16 bg1Cnt;

    gTasks[taskId].data[10] += 4;
    gBattle_BG1_Y -= 4;
    if (gTasks[taskId].data[10] == 64)
    {
        gTasks[taskId].data[10] = 0;
        gBattle_BG1_Y += 64;
        if (++gTasks[taskId].data[11] == 4)
        {
            ResetBattleAnimBg(0);
            gBattle_WIN0H = 0;
            gBattle_WIN0V = 0;
            SetGpuReg(REG_OFFSET_WININ, WININ_WIN0_BG_ALL | WININ_WIN0_OBJ | WININ_WIN0_CLR
                                      | WININ_WIN1_BG_ALL | WININ_WIN1_OBJ | WININ_WIN1_CLR);
            SetGpuReg(REG_OFFSET_WINOUT, WINOUT_WIN01_BG_ALL  | WINOUT_WIN01_OBJ  | WINOUT_WIN01_CLR
                                       | WINOUT_WINOBJ_BG_ALL | WINOUT_WINOBJ_OBJ | WINOUT_WINOBJ_CLR);
            if (!IsContest())
            {
                bg1Cnt = GetGpuReg(REG_OFFSET_BG1CNT);
                ((vBgCnt*)&bg1Cnt)->charBaseBlock = 0;
                SetGpuReg(REG_OFFSET_BG1CNT, bg1Cnt);
            }

            SetGpuReg(REG_OFFSET_DISPCNT, GetGpuReg(REG_OFFSET_DISPCNT) ^ DISPCNT_OBJWIN_ON);
            SetGpuReg(REG_OFFSET_BLDCNT, 0);
            SetGpuReg(REG_OFFSET_BLDALPHA, 0);
            #if !MODERN
            sprite = &gSprites[GetAnimBattlerSpriteId(0)]; // unused
            sprite = &gSprites[gTasks[taskId].data[0]];
            DestroySprite(sprite);
            #else
            DestroySprite(&gSprites[gTasks[taskId].data[0]);
            #endif

            GetBattleAnimBg1Data(&animBgData);
            ClearBattleAnimBg(animBgData.bgId);
            if (gTasks[taskId].data[6] == 1)
                gSprites[gBattlerSpriteIds[BATTLE_PARTNER(gBattleAnimAttacker)]].oam.priority++;

            gBattle_BG1_Y = 0;
            DestroyAnimVisualTask(taskId);
        }
    }
}

static EWRAM_DATA struct AnimStatsChangeData *sAnimStatsChangeData = NULL;
void InitStatsChangeAnimation(u8 taskId)
{
    m8 i;

    sAnimStatsChangeData = AllocZeroed(sizeof(struct AnimStatsChangeData));
    for (i = 0; i < 8; i++)
        sAnimStatsChangeData->data[i] = gBattleAnimArgs[i];

    gTasks[taskId].func = StatsChangeAnimation_Step1;
}

static void StatsChangeAnimation_Step1(u8 taskId)
{
    if (sAnimStatsChangeData->data[2] == 0)
        sAnimStatsChangeData->battler1 = gBattleAnimAttacker;
    else
        sAnimStatsChangeData->battler1 = gBattleAnimTarget;

    sAnimStatsChangeData->battler2 = BATTLE_PARTNER(sAnimStatsChangeData->battler1);
    if (IsContest() || (sAnimStatsChangeData->data[3] && !IsBattlerSpriteVisible(sAnimStatsChangeData->battler2)))
        sAnimStatsChangeData->data[3] = 0;

    gBattle_WIN0H = 0;
    gBattle_WIN0V = 0;
    SetGpuReg(REG_OFFSET_WININ, WININ_WIN0_BG_ALL | WININ_WIN0_OBJ | WININ_WIN0_CLR
                              | WININ_WIN1_BG_ALL | WININ_WIN1_OBJ | WININ_WIN1_CLR);
    SetGpuReg(REG_OFFSET_WINOUT, WINOUT_WIN01_BG0 | WINOUT_WIN01_BG2 | WINOUT_WIN01_BG3 | WINOUT_WIN01_OBJ  | WINOUT_WIN01_CLR
                               | WINOUT_WINOBJ_BG_ALL | WINOUT_WINOBJ_OBJ | WINOUT_WINOBJ_CLR);
    SetGpuRegBits(REG_OFFSET_DISPCNT, DISPCNT_OBJWIN_ON);
    SetGpuReg(REG_OFFSET_BLDCNT, BLDCNT_TGT1_BG1 | BLDCNT_TGT2_ALL | BLDCNT_EFFECT_BLEND);
    SetGpuReg(REG_OFFSET_BLDALPHA, BLDALPHA_BLEND(0, 16));
    SetAnimBgAttribute(1, BG_ANIM_PRIORITY, 0);
    SetAnimBgAttribute(1, BG_ANIM_SCREEN_SIZE, 0);
    if (!IsContest())
        SetAnimBgAttribute(1, BG_ANIM_CHAR_BASE_BLOCK, 1);

    if (IsDoubleBattle() && sAnimStatsChangeData->data[3] == 0)
    {
        if (GetBattlerPosition(sAnimStatsChangeData->battler1) == B_POSITION_OPPONENT_RIGHT
         || GetBattlerPosition(sAnimStatsChangeData->battler1) == B_POSITION_PLAYER_LEFT)
        {
            if (IsBattlerSpriteVisible(sAnimStatsChangeData->battler2) == TRUE)
            {
                gSprites[gBattlerSpriteIds[sAnimStatsChangeData->battler2]].oam.priority -= 1;
                SetAnimBgAttribute(1, BG_ANIM_PRIORITY, 1);
                sAnimStatsChangeData->higherPriority = 1;
            }
        }
    }

    if (IsContest())
    {
        sAnimStatsChangeData->species = gContestResources->moveAnim->species;
    }
    else
    {
        if (GetBattlerSide(sAnimStatsChangeData->battler1) != B_SIDE_PLAYER)
            sAnimStatsChangeData->species = GetMonData(&gEnemyParty[gBattlerPartyIndexes[sAnimStatsChangeData->battler1]], MON_DATA_SPECIES);
        else
            sAnimStatsChangeData->species = GetMonData(&gPlayerParty[gBattlerPartyIndexes[sAnimStatsChangeData->battler1]], MON_DATA_SPECIES);
    }

    gTasks[taskId].func = StatsChangeAnimation_Step2;
}

static void StatsChangeAnimation_Step2(u8 taskId)
{
    struct BattleAnimBgData animBgData;
    u8 spriteId, spriteId2;
    u8 battlerSpriteId;

    spriteId2 = 0;
    battlerSpriteId = gBattlerSpriteIds[sAnimStatsChangeData->battler1];
    spriteId = CreateInvisibleSpriteCopy(sAnimStatsChangeData->battler1, battlerSpriteId, sAnimStatsChangeData->species);
    if (sAnimStatsChangeData->data[3])
    {
        battlerSpriteId = gBattlerSpriteIds[sAnimStatsChangeData->battler2];
        spriteId2 = CreateInvisibleSpriteCopy(sAnimStatsChangeData->battler2, battlerSpriteId, sAnimStatsChangeData->species);
    }

    GetBattleAnimBg1Data(&animBgData);
    // TODO: these are debug functions
    if (sAnimStatsChangeData->data[0] == 0)
        AnimLoadCompressedBgTilemapHandleContest(&animBgData, gBattleStatMask1_Tilemap, FALSE);
    else
        AnimLoadCompressedBgTilemapHandleContest(&animBgData, gBattleStatMask2_Tilemap, FALSE);

    AnimLoadCompressedBgGfx(animBgData.bgId, gBattleStatMask_Gfx, animBgData.tilesOffset);
    switch (sAnimStatsChangeData->data[1])
    {
    case 0:
        LoadCompressedPalette(gBattleStatMask2_Pal, animBgData.paletteId * 16, 32);
        break;
    case 1:
        LoadCompressedPalette(gBattleStatMask1_Pal, animBgData.paletteId * 16, 32);
        break;
    case 2:
        LoadCompressedPalette(gBattleStatMask3_Pal, animBgData.paletteId * 16, 32);
        break;
    case 3:
        LoadCompressedPalette(gBattleStatMask4_Pal, animBgData.paletteId * 16, 32);
        break;
    case 4:
        LoadCompressedPalette(gBattleStatMask6_Pal, animBgData.paletteId * 16, 32);
        break;
    case 5:
        LoadCompressedPalette(gBattleStatMask7_Pal, animBgData.paletteId * 16, 32);
        break;
    case 6:
        LoadCompressedPalette(gBattleStatMask8_Pal, animBgData.paletteId * 16, 32);
        break;
    default:
        LoadCompressedPalette(gBattleStatMask5_Pal, animBgData.paletteId * 16, 32);
        break;
    }

    gBattle_BG1_X = 0;
    gBattle_BG1_Y = 0;

     if (sAnimStatsChangeData->data[0] == 1)
    {
        gBattle_BG1_X = 64;
        gTasks[taskId].data[1] = -3;
    }
    else
    {
        gTasks[taskId].data[1] = 3;
    }

    if (sAnimStatsChangeData->data[4] == 0)
    {
        gTasks[taskId].data[4] = 10;
        gTasks[taskId].data[5] = 20;
    }
    else
    {
        gTasks[taskId].data[4] = 13;
        gTasks[taskId].data[5] = 30;
    }

    gTasks[taskId].data[0] = spriteId;
    gTasks[taskId].data[2] = sAnimStatsChangeData->data[3];
    gTasks[taskId].data[3] = spriteId2;
    gTasks[taskId].data[6] = sAnimStatsChangeData->higherPriority;
    gTasks[taskId].data[7] = gBattlerSpriteIds[sAnimStatsChangeData->battler2];
    gTasks[taskId].func = StatsChangeAnimation_Step3;

    if (sAnimStatsChangeData->data[0] == 0)
        PlaySE12WithPanning(SE_M_STAT_INCREASE, BattleAnimAdjustPanning2(-64));
    else
        PlaySE12WithPanning(SE_M_STAT_DECREASE, BattleAnimAdjustPanning2(-64));
}

static void StatsChangeAnimation_Step3(u8 taskId)
{
    gBattle_BG1_Y += gTasks[taskId].data[1];

    switch (gTasks[taskId].data[15])
    {
    case 0:
    #if !MODERN
        if (gTasks[taskId].data[11]++ > 0)
        {
            gTasks[taskId].data[11] = 0;
            gTasks[taskId].data[12]++;
            SetGpuReg(REG_OFFSET_BLDALPHA, BLDALPHA_BLEND(gTasks[taskId].data[12], 16 - gTasks[taskId].data[12]));
            if (gTasks[taskId].data[12] == gTasks[taskId].data[4])
                gTasks[taskId].data[15]++;
        }
        #else
        if (gTasks[taskId].data[11] > 0)
        {
            gTasks[taskId].data[11] = 0;
            gTasks[taskId].data[12]++;
            SetGpuReg(REG_OFFSET_BLDALPHA, BLDALPHA_BLEND(gTasks[taskId].data[12], 16 - gTasks[taskId].data[12]));
            if (gTasks[taskId].data[12] == gTasks[taskId].data[4])
                gTasks[taskId].data[15]++;
        }
        else
            gTasks[taskId].data[11]++;
        #endif
        break;
    case 1:
        if (++gTasks[taskId].data[10] == gTasks[taskId].data[5])
            gTasks[taskId].data[15]++;
        break;
    case 2:
    #if !MODERN
        if (gTasks[taskId].data[11]++ > 0)
    #else
        if (gTasks[taskId].data[11] > 0)
    #endif
        {
            gTasks[taskId].data[11] = 0;
            gTasks[taskId].data[12]--;
            SetGpuReg(REG_OFFSET_BLDALPHA, BLDALPHA_BLEND(gTasks[taskId].data[12], 16 - gTasks[taskId].data[12]));
            if (gTasks[taskId].data[12] == 0)
            {
                ResetBattleAnimBg(0);
                gTasks[taskId].data[15]++;
            }
        }
        #if MODERN
        else gTasks[taskId].data[11]++;
        #endif
        break;
    case 3:
        gBattle_WIN0H = 0;
        gBattle_WIN0V = 0;
        SetGpuReg(REG_OFFSET_WININ, WININ_WIN0_BG_ALL | WININ_WIN0_OBJ | WININ_WIN0_CLR
                                  | WININ_WIN1_BG_ALL | WININ_WIN1_OBJ | WININ_WIN1_CLR);
        SetGpuReg(REG_OFFSET_WINOUT, WINOUT_WIN01_BG_ALL  | WINOUT_WIN01_OBJ  | WINOUT_WIN01_CLR
                                   | WINOUT_WINOBJ_BG_ALL | WINOUT_WINOBJ_OBJ | WINOUT_WINOBJ_CLR);

        if (!IsContest())
            SetAnimBgAttribute(1, BG_ANIM_CHAR_BASE_BLOCK, 0);

        SetGpuReg(REG_OFFSET_DISPCNT, GetGpuReg(REG_OFFSET_DISPCNT) ^ DISPCNT_OBJWIN_ON);
        SetGpuReg(REG_OFFSET_BLDCNT, 0);
        SetGpuReg(REG_OFFSET_BLDALPHA, 0);
        DestroySprite(&gSprites[gTasks[taskId].data[0]]);
        if (gTasks[taskId].data[2])
            DestroySprite(&gSprites[gTasks[taskId].data[3]]);

        if (gTasks[taskId].data[6] == 1)
            gSprites[gTasks[taskId].data[7]].oam.priority++;

        FREE_AND_SET_NULL(sAnimStatsChangeData);
        DestroyAnimVisualTask(taskId);
        break;
    }
}

void AnimTask_Flash(u8 taskId)
{
    u32 selectedPalettes = GetBattleMonSpritePalettesMask(1, 1, 1, 1);
    SetPalettesToColor(selectedPalettes, RGB_BLACK);
    gTasks[taskId].data[14] = selectedPalettes >> 16;

    // TODO: assign to a different var?
    selectedPalettes = GetBattlePalettesMask(1, 0, 0, 0, 0, 0, 0) & 0xFFFF;
    SetPalettesToColor(selectedPalettes, RGB_WHITEALPHA);
    gTasks[taskId].data[15] = selectedPalettes;

    gTasks[taskId].data[0] = 0;
    gTasks[taskId].data[1] = 0;
    gTasks[taskId].func = AnimTask_Flash_Step;
}

static void AnimTask_Flash_Step(u8 taskId)
{
    u16 i;
    struct Task *task = &gTasks[taskId];

    switch (task->data[0])
    {
    case 0:
        if (++task->data[1] > 6)
        {
            task->data[1] = 0;
            task->data[2] = 16;
            task->data[0]++;
        }
        break;
    case 1:
        if (++task->data[1] > 1)
        {
            task->data[1] = 0;
            task->data[2]--;

            for (i = 0; i < 16; i++)
            {
                if (task->data[15] & (1 << i))
                {
                    BlendPalette(i * 16, 16, task->data[2], 0xFFFF);
                }

                if (task->data[14] & (1 << i))
                {
                    BlendPalette(i * 16 + 0x100, 16, task->data[2], 0);
                }
            }

            if (task->data[2] == 0)
                task->data[0]++;
        }
        break;
    case 2:
        DestroyAnimVisualTask(taskId);
        break;
    }
}

static void SetPalettesToColor(u32 selectedPalettes, u16 color)
{
    u16 i, curOffset, paletteOffset;

    for (i = 0; i < 32; i++)
    {
        if (selectedPalettes & 1)
        {
            curOffset = i * 16;
            for (paletteOffset = curOffset; paletteOffset < curOffset + 16; paletteOffset++)
            {
                gPlttBufferFaded[paletteOffset] = color;
            }
        }

        selectedPalettes >>= 1;
    }
}

void AnimTask_BlendNonAttackerPalettes(u8 taskId)
{
    u32 j;
    u32 selectedPalettes = 0;

    for (j = 0; j < MAX_BATTLERS_COUNT; j++)
    {
        if (gBattleAnimAttacker != j)
            selectedPalettes |= 1 << (j + 16);
    }

    for (j = 5; j != 0; j--)
        gBattleAnimArgs[j] = gBattleAnimArgs[j - 1];

    StartBlendAnimSpriteColor(taskId, selectedPalettes);
}

void AnimTask_StartSlidingBg(u8 taskId)
{
    u8 newTaskId;

    UpdateAnimBg3ScreenSize(FALSE);
    newTaskId = CreateTask(AnimTask_UpdateSlidingBg, 5);
    if (gBattleAnimArgs[2] && GetBattlerSide(gBattleAnimAttacker) != B_SIDE_PLAYER)
    {
        gBattleAnimArgs[0] = -gBattleAnimArgs[0];
        gBattleAnimArgs[1] = -gBattleAnimArgs[1];
    }

    gTasks[newTaskId].data[1] = gBattleAnimArgs[0];
    gTasks[newTaskId].data[2] = gBattleAnimArgs[1];
    gTasks[newTaskId].data[3] = gBattleAnimArgs[3];
    gTasks[newTaskId].data[0]++;
    DestroyAnimVisualTask(taskId);
}

static void AnimTask_UpdateSlidingBg(u8 taskId)
{
    gTasks[taskId].data[10] += gTasks[taskId].data[1];
    gTasks[taskId].data[11] += gTasks[taskId].data[2];
    gBattle_BG3_X += gTasks[taskId].data[10] >> 8;
    gBattle_BG3_Y += gTasks[taskId].data[11] >> 8;
    gTasks[taskId].data[10] &= 0xFF;
    gTasks[taskId].data[11] &= 0xFF;

    if (gBattleAnimArgs[7] == gTasks[taskId].data[3])
    {
        gBattle_BG3_X = 0;
        gBattle_BG3_Y = 0;
        UpdateAnimBg3ScreenSize(TRUE);
        DestroyTask(taskId);
    }
}

void AnimTask_GetAttackerSide(u8 taskId)
{
    gBattleAnimArgs[ARG_RET_ID] = GetBattlerSide(gBattleAnimAttacker);
    DestroyAnimVisualTask(taskId);
}

void AnimTask_GetTargetSide(u8 taskId)
{
    gBattleAnimArgs[ARG_RET_ID] = GetBattlerSide(gBattleAnimTarget);
    DestroyAnimVisualTask(taskId);
}

void AnimTask_GetTargetIsAttackerPartner(u8 taskId)
{
    gBattleAnimArgs[ARG_RET_ID] = BATTLE_PARTNER(gBattleAnimAttacker) == gBattleAnimTarget;
    DestroyAnimVisualTask(taskId);
}

// For hiding or subsequently revealing all other battlers
void AnimTask_SetAllNonAttackersInvisiblity(u8 taskId)
{
    u16 battler;

    for (battler = 0; battler < MAX_BATTLERS_COUNT; battler++)
    {
        if (battler != gBattleAnimAttacker && IsBattlerSpriteVisible(battler))
            gSprites[gBattlerSpriteIds[battler]].invisible = gBattleAnimArgs[0];
    }

    DestroyAnimVisualTask(taskId);
}

//TODO: can we inline this?
#if !MODERN
void StartMonScrollingBgMask(u8 taskId, s16 unused, s16 scrollSpeed, u8 battler, bool8 includePartner, u8 numFadeSteps, u8 fadeStepDelay, u8 duration, const u32 *gfx, const u32 *tilemap, const u32 *palette)
#else
void StartMonScrollingBgMask(u8 taskId, s16 scrollSpeed, u8 battler, bool8 includePartner, u8 numFadeSteps, u8 fadeStepDelay, u8 duration, const u32 *gfx, const u32 *tilemap, const u32 *palette)
#endif
{
    u16 species;
    u8 spriteId, spriteId2;
    u16 bg1Cnt;
    struct BattleAnimBgData animBgData;
    u8 battler2;

    spriteId2 = 0;
    battler2 = BATTLE_PARTNER(battler);

    if (IsContest() || (includePartner && !IsBattlerSpriteVisible(battler2)))
        includePartner = FALSE;

    gBattle_WIN0H = 0;
    gBattle_WIN0V = 0;
    SetGpuReg(REG_OFFSET_WININ, WININ_WIN0_BG_ALL | WININ_WIN0_OBJ | WININ_WIN0_CLR
                              | WININ_WIN1_BG_ALL | WININ_WIN1_OBJ | WININ_WIN1_CLR);
    SetGpuReg(REG_OFFSET_WINOUT, WINOUT_WIN01_BG0 | WINOUT_WIN01_BG2 | WINOUT_WIN01_BG3 | WINOUT_WIN01_OBJ  | WINOUT_WIN01_CLR
                               | WINOUT_WINOBJ_BG_ALL | WINOUT_WINOBJ_OBJ | WINOUT_WINOBJ_CLR);
    SetGpuRegBits(REG_OFFSET_DISPCNT, DISPCNT_OBJWIN_ON);
    SetGpuReg(REG_OFFSET_BLDCNT, BLDCNT_TGT1_BG1 | BLDCNT_TGT2_ALL | BLDCNT_EFFECT_BLEND);
    SetGpuReg(REG_OFFSET_BLDALPHA, BLDALPHA_BLEND(0, 16));
    bg1Cnt = GetGpuReg(REG_OFFSET_BG1CNT);
    ((vBgCnt *)&bg1Cnt)->priority = 0;
    ((vBgCnt *)&bg1Cnt)->screenSize = 0;
    ((vBgCnt *)&bg1Cnt)->areaOverflowMode = 1;
    if (!IsContest())
    {
        ((vBgCnt *)&bg1Cnt)->charBaseBlock = 1;
    }

    SetGpuReg(REG_OFFSET_BG1CNT, bg1Cnt);

    if (IsContest())
    {
        species = gContestResources->moveAnim->species;
    }
    else if (GetBattlerSide(battler) != B_SIDE_PLAYER)
        species = GetMonData(&gEnemyParty[gBattlerPartyIndexes[battler]], MON_DATA_SPECIES);
    else
        species = GetMonData(&gPlayerParty[gBattlerPartyIndexes[battler]], MON_DATA_SPECIES);

    spriteId = CreateInvisibleSpriteCopy(battler, gBattlerSpriteIds[battler], species);
    if (includePartner)
        spriteId2 = CreateInvisibleSpriteCopy(battler2, gBattlerSpriteIds[battler2], species);

    GetBattleAnimBg1Data(&animBgData);
    // TODO: this is debug again
    AnimLoadCompressedBgTilemapHandleContest(&animBgData, tilemap, FALSE);
    AnimLoadCompressedBgGfx(animBgData.bgId, gfx, animBgData.tilesOffset);
    LoadCompressedPalette(palette, animBgData.paletteId * 16, 32);

    gBattle_BG1_X = 0;
    gBattle_BG1_Y = 0;
    gTasks[taskId].data[1] = scrollSpeed;
    gTasks[taskId].data[4] = numFadeSteps;
    gTasks[taskId].data[5] = duration;
    gTasks[taskId].data[6] = fadeStepDelay;
    gTasks[taskId].data[0] = spriteId;
    gTasks[taskId].data[2] = includePartner;
    gTasks[taskId].data[3] = spriteId2;
    gTasks[taskId].func = UpdateMonScrollingBgMask;
}

static void UpdateMonScrollingBgMask(u8 taskId)
{
    gTasks[taskId].data[13] += abs(gTasks[taskId].data[1]);
    if (gTasks[taskId].data[1] < 0)
        gBattle_BG1_Y -= gTasks[taskId].data[13] >> 8;
    else
        gBattle_BG1_Y += gTasks[taskId].data[13] >> 8;

    gTasks[taskId].data[13] &= 0xFF;
    switch (gTasks[taskId].data[15])
    {
    case 0:
#if !MODERN
        if (gTasks[taskId].data[11]++ < gTasks[taskId].data[6])
            break;
#else
        if (gTasks[taskId].data[11] < gTasks[taskId].data[6])
        {
            gTasks[taskId].data[11]++;
            break;
        }
#endif

        gTasks[taskId].data[11] = 0;
        gTasks[taskId].data[12]++;
        SetGpuReg(REG_OFFSET_BLDALPHA, BLDALPHA_BLEND(gTasks[taskId].data[12], 16 - gTasks[taskId].data[12]));
        if (gTasks[taskId].data[12] == gTasks[taskId].data[4])
            gTasks[taskId].data[15]++;
        break;
    case 1:
        if (++gTasks[taskId].data[10] == gTasks[taskId].data[5])
            gTasks[taskId].data[15]++;
        break;
    case 2:
        #if !MODERN
        if (gTasks[taskId].data[11]++ < gTasks[taskId].data[6])
            break;
#else
        if (gTasks[taskId].data[11] < gTasks[taskId].data[6])
        {
            gTasks[taskId].data[11]++;
            break;
        }
#endif
        gTasks[taskId].data[11] = 0;
        gTasks[taskId].data[12]--;
        SetGpuReg(REG_OFFSET_BLDALPHA, BLDALPHA_BLEND(gTasks[taskId].data[12], 16 - gTasks[taskId].data[12]));
        if (gTasks[taskId].data[12] == 0)
        {
            ResetBattleAnimBg(0);
            gBattle_WIN0H = 0;
            gBattle_WIN0V = 0;
            SetGpuReg(REG_OFFSET_WININ, WININ_WIN0_BG_ALL | WININ_WIN0_OBJ | WININ_WIN0_CLR | WININ_WIN1_BG_ALL | WININ_WIN1_OBJ | WININ_WIN1_CLR);
            SetGpuReg(REG_OFFSET_WINOUT, WINOUT_WIN01_BG_ALL | WINOUT_WIN01_OBJ | WINOUT_WIN01_CLR | WINOUT_WINOBJ_BG_ALL | WINOUT_WINOBJ_OBJ | WINOUT_WINOBJ_CLR);
            if (!IsContest())
            {
                u16 bg1Cnt = GetGpuReg(REG_OFFSET_BG1CNT);
                ((vBgCnt *)&bg1Cnt)->charBaseBlock = 0;
                SetGpuReg(REG_OFFSET_BG1CNT, bg1Cnt);
            }

            SetGpuReg(REG_OFFSET_DISPCNT, GetGpuReg(REG_OFFSET_DISPCNT) ^ DISPCNT_OBJWIN_ON);
            SetGpuReg(REG_OFFSET_BLDCNT, 0);
            SetGpuReg(REG_OFFSET_BLDALPHA, 0);
            DestroySprite(&gSprites[gTasks[taskId].data[0]]);
            if (gTasks[taskId].data[2])
                DestroySprite(&gSprites[gTasks[taskId].data[3]]);

            DestroyAnimVisualTask(taskId);
        }
        break;
    }
}

void AnimTask_GetBattleTerrain(u8 taskId)
{
    gBattleAnimArgs[0] = gBattleTerrain;
    DestroyAnimVisualTask(taskId);
}

void AnimTask_AllocBackupPalBuffer(u8 taskId)
{
    gMonSpritesGfxPtr->buffer = AllocZeroed(0x2000);
    DestroyAnimVisualTask(taskId);
}

void AnimTask_FreeBackupPalBuffer(u8 taskId)
{
    FREE_AND_SET_NULL(gMonSpritesGfxPtr->buffer);
    DestroyAnimVisualTask(taskId);
}

void AnimTask_CopyPalUnfadedToBackup(u8 taskId)
{
    u32 selectedPalettes;
    u32 paletteIndex = 0;

    if (gBattleAnimArgs[0] == 0)
    {
        selectedPalettes = GetBattlePalettesMask(1, 0, 0, 0, 0, 0, 0);
        while ((selectedPalettes & 1) == 0)
        {
            selectedPalettes >>= 1;
            paletteIndex++;
        }
    }
    else if (gBattleAnimArgs[0] == 1)
    {
        paletteIndex = gBattleAnimAttacker + 16;
    }
    else if (gBattleAnimArgs[0] == 2)
    {
        paletteIndex = gBattleAnimTarget + 16;
    }

    memcpy(&gMonSpritesGfxPtr->buffer[gBattleAnimArgs[1] * 16], &gPlttBufferUnfaded[paletteIndex * 16], 32);
    DestroyAnimVisualTask(taskId);
}

void AnimTask_CopyPalUnfadedFromBackup(u8 taskId)
{
    u32 selectedPalettes;
    u32 paletteIndex = 0;

    if (gBattleAnimArgs[0] == 0)
    {
        selectedPalettes = GetBattlePalettesMask(1, 0, 0, 0, 0, 0, 0);
        while ((selectedPalettes & 1) == 0)
        {
            selectedPalettes >>= 1;
            paletteIndex++;
        }
    }
    else if (gBattleAnimArgs[0] == 1)
    {
        paletteIndex = gBattleAnimAttacker + 16;
    }
    else if (gBattleAnimArgs[0] == 2)
    {
        paletteIndex = gBattleAnimTarget + 16;
    }

    memcpy(&gPlttBufferUnfaded[paletteIndex * 16], &gMonSpritesGfxPtr->buffer[gBattleAnimArgs[1] * 16], 32);
    DestroyAnimVisualTask(taskId);
}

void AnimTask_CopyPalFadedToUnfaded(u8 taskId)
{
    u32 selectedPalettes;
    u32 paletteIndex = 0;

    if (gBattleAnimArgs[0] == 0)
    {
        selectedPalettes = GetBattlePalettesMask(1, 0, 0, 0, 0, 0, 0);
        while ((selectedPalettes & 1) == 0)
        {
            selectedPalettes >>= 1;
            paletteIndex++;
        }
    }
    else if (gBattleAnimArgs[0] == 1)
    {
        paletteIndex = gBattleAnimAttacker + 16;
    }
    else if (gBattleAnimArgs[0] == 2)
    {
        paletteIndex = gBattleAnimTarget + 16;
    }

    memcpy(&gPlttBufferUnfaded[paletteIndex * 16], &gPlttBufferFaded[paletteIndex * 16], 32);
    DestroyAnimVisualTask(taskId);
}

void AnimTask_IsContest(u8 taskId)
{
    if (IsContest())
        gBattleAnimArgs[ARG_RET_ID] = TRUE;
    else
        gBattleAnimArgs[ARG_RET_ID] = FALSE;

    DestroyAnimVisualTask(taskId);
}

void AnimTask_SetAnimAttackerAndTargetForEffectTgt(u8 taskId)
{
    gBattleAnimAttacker = gBattlerTarget;
    gBattleAnimTarget = gEffectBattler;
    DestroyAnimVisualTask(taskId);
}

void AnimTask_IsTargetSameSide(u8 taskId)
{
    if (GetBattlerSide(gBattleAnimAttacker) == GetBattlerSide(gBattleAnimTarget))
        gBattleAnimArgs[ARG_RET_ID] = TRUE;
    else
        gBattleAnimArgs[ARG_RET_ID] = FALSE;

    DestroyAnimVisualTask(taskId);
}

void AnimTask_SetAnimTargetToBattlerTarget(u8 taskId)
{
    gBattleAnimTarget = gBattlerTarget;
    DestroyAnimVisualTask(taskId);
}

void AnimTask_SetAnimAttackerAndTargetForEffectAtk(u8 taskId)
{
    gBattleAnimAttacker = gBattlerAttacker;
    gBattleAnimTarget = gEffectBattler;
    DestroyAnimVisualTask(taskId);
}

void AnimTask_SetAttackerInvisibleWaitForSignal(u8 taskId)
{
    if (IsContest())
    {
        DestroyAnimVisualTask(taskId);
        return;
    }

    gTasks[taskId].data[0] = gBattleSpritesDataPtr->battlerData[gBattleAnimAttacker].invisible;
    gBattleSpritesDataPtr->battlerData[gBattleAnimAttacker].invisible = TRUE;
    gTasks[taskId].func = AnimTask_WaitAndRestoreVisibility;
    gAnimVisualTaskCount--;
}

static void AnimTask_WaitAndRestoreVisibility(u8 taskId)
{
    if (gBattleAnimArgs[7] == 0x1000)
    {
        gBattleSpritesDataPtr->battlerData[gBattleAnimAttacker].invisible = (u8)gTasks[taskId].data[0] & 1;
        DestroyTask(taskId);
    }
}
static const u8 gBattleAnimBgCntSet[] = {REG_OFFSET_BG0CNT, REG_OFFSET_BG1CNT, REG_OFFSET_BG2CNT, REG_OFFSET_BG3CNT};
// literally just a copy
#if !MODERN
static const u8 gBattleAnimBgCntGet[] = {REG_OFFSET_BG0CNT, REG_OFFSET_BG1CNT, REG_OFFSET_BG2CNT, REG_OFFSET_BG3CNT};
#else
#define gBattleAnimBgCntGet gBattleAnimBgCntSet
#endif

void SetAnimBgAttribute(u8 bgId, u8 attributeId, u8 value)
{
    // TODO: should this REALLY be static?
    // Does it make a difference??? it's not like it is used anywhere but here
    #if !MODERN
    static EWRAM_DATA u16 sBgCnt = 0;
    #else
    u16 sBgCnt;
    #endif
    if (bgId < 4)
    {
        sBgCnt = GetGpuReg(gBattleAnimBgCntSet[bgId]);
        switch (attributeId)
        {
        case BG_ANIM_SCREEN_SIZE:
            ((vBgCnt*)&sBgCnt)->screenSize = value;
            break;
        case BG_ANIM_AREA_OVERFLOW_MODE:
            ((vBgCnt*)&sBgCnt)->areaOverflowMode = value;
            break;
        case BG_ANIM_MOSAIC:
            ((vBgCnt*)&sBgCnt)->mosaic = value;
            break;
        case BG_ANIM_CHAR_BASE_BLOCK:
            ((vBgCnt*)&sBgCnt)->charBaseBlock = value;
            break;
        case BG_ANIM_PRIORITY:
            ((vBgCnt*)&sBgCnt)->priority = value;
            break;
        case BG_ANIM_PALETTES_MODE:
            ((vBgCnt*)&sBgCnt)->palettes = value;
            break;
        case BG_ANIM_SCREEN_BASE_BLOCK:
            ((vBgCnt*)&sBgCnt)->screenBaseBlock = value;
            break;
        }

        SetGpuReg(gBattleAnimBgCntSet[bgId], sBgCnt);
    }
}

// Should be u16? but the only known caller of this returns a u8. Both match
u8 GetAnimBgAttribute(u8 bgId, u8 attributeId)
{
    u16 bgCnt;

    if (bgId < 4)
    {
        bgCnt = GetGpuReg(gBattleAnimBgCntGet[bgId]);
        switch (attributeId)
        {
        case BG_ANIM_SCREEN_SIZE:
            return ((vBgCnt*)&bgCnt)->screenSize;
        case BG_ANIM_AREA_OVERFLOW_MODE:
            return ((vBgCnt*)&bgCnt)->areaOverflowMode;
        case BG_ANIM_MOSAIC:
            return ((vBgCnt*)&bgCnt)->mosaic;
        case BG_ANIM_CHAR_BASE_BLOCK:
            return ((vBgCnt*)&bgCnt)->charBaseBlock;
        case BG_ANIM_PRIORITY:
            return ((vBgCnt*)&bgCnt)->priority;
        case BG_ANIM_PALETTES_MODE:
            return ((vBgCnt*)&bgCnt)->palettes;
        case BG_ANIM_SCREEN_BASE_BLOCK:
            return ((vBgCnt*)&bgCnt)->screenBaseBlock;
        }
    }

    return 0;
}