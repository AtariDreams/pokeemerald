#include "global.h"
#include "money.h"
#include "graphics.h"
#include "event_data.h"
#include "string_util.h"
#include "text.h"
#include "menu.h"
#include "window.h"
#include "sprite.h"
#include "strings.h"
#include "decompress.h"

#define MAX_MONEY 999999

EWRAM_DATA static u8 sMoneyBoxWindowId = 0;
EWRAM_DATA static u8 sMoneyLabelSpriteId = 0;

#define MONEY_LABEL_TAG 0x2722

static const struct OamData sOamData_MoneyLabel =
{
    .y = 0,
    .affineMode = ST_OAM_AFFINE_OFF,
    .objMode = ST_OAM_OBJ_NORMAL,
    .mosaic = FALSE,
    .bpp = ST_OAM_4BPP,
    .shape = SPRITE_SHAPE(32x16),
    .x = 0,
    .matrixNum = 0,
    .size = SPRITE_SIZE(32x16),
    .tileNum = 0,
    .priority = 0,
    .paletteNum = 0,
    .affineParam = 0,
};

static const union AnimCmd sSpriteAnim_MoneyLabel[] =
{
    ANIMCMD_FRAME(0, 0),
    ANIMCMD_END
};

static const union AnimCmd *const sSpriteAnimTable_MoneyLabel[] =
{
    sSpriteAnim_MoneyLabel,
};

static const struct SpriteTemplate sSpriteTemplate_MoneyLabel =
{
    .tileTag = MONEY_LABEL_TAG,
    .paletteTag = MONEY_LABEL_TAG,
    .oam = &sOamData_MoneyLabel,
    .anims = sSpriteAnimTable_MoneyLabel,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = SpriteCallbackDummy
};

static const struct SpriteSheet sSpriteSheet_MoneyLabel =
{
    .data = gShopMenuMoney_Gfx,
    .size = 256,
    .tag = MONEY_LABEL_TAG,
};

static const struct CompressedSpritePalette sSpritePalette_MoneyLabel =
{
    .data = gShopMenu_Pal,
    .tag = MONEY_LABEL_TAG
};

void AddMoney(u32 toAdd)
{
    u32 overflowCheck = gSaveBlock1.money + toAdd;

    if (overflowCheck > MAX_MONEY)
    {
        gSaveBlock1.money = MAX_MONEY;
        return;
    }

    gSaveBlock1.money = overflowCheck;
}

void RemoveMoney(u32 toSub)
{
    // can't subtract more than you already have
    if (gSaveBlock1.money < toSub)
        gSaveBlock1.money = 0;
    else
        gSaveBlock1.money -= toSub;
}

bool8 IsEnoughForCostInVar0x8005(void)
{
    if (gSaveBlock1.money < gSpecialVar_0x8005)
        return FALSE;
    return TRUE;
}

void SubtractMoneyFromVar0x8005(void)
{
    RemoveMoney(gSpecialVar_0x8005);
}

void PrintMoneyAmountInMoneyBox(u8 windowId, u8 speed)
{
    PrintMoneyAmount(windowId, 38, 1, gSaveBlock1.money, speed);
}

void PrintMoneyAmount(u8 windowId, u8 x, u8 y, u32 amount, u8 speed)
{
    u8 *txtPtr;
    s32 strLength;

    ConvertIntToDecimalStringN(gStringVar1, amount, STR_CONV_MODE_LEFT_ALIGN, 6);

    strLength = 6 - StringLength(gStringVar1);
    txtPtr = gStringVar4;

    while (strLength-- > 0)
        *txtPtr++ = CHAR_SPACER;

    StringExpandPlaceholders(txtPtr, gText_PokedollarVar1);
    AddTextPrinterParameterized(windowId, FONT_NORMAL, gStringVar4, x, y, speed, NULL);
}

void PrintMoneyAmountInMoneyBoxWithBorder(u8 windowId, u16 tileStart, u8 pallete)
{
    DrawStdFrameWithCustomTileAndPalette(windowId, FALSE, tileStart, pallete);
    PrintMoneyAmountInMoneyBox(windowId, 0);
}

void ChangeAmountInMoneyBox(void)
{
    PrintMoneyAmountInMoneyBox(sMoneyBoxWindowId, 0);
}

void DrawMoneyBox(u8 x, u8 y)
{
    struct WindowTemplate template;

    SetWindowTemplateFields(&template, 0, x + 1, y + 1, 10, 2, 15, 8);
    sMoneyBoxWindowId = AddWindow(&template);
    FillWindowPixelBuffer(sMoneyBoxWindowId, PIXEL_FILL(0));
    PutWindowTilemap(sMoneyBoxWindowId);
    CopyWindowToVram(sMoneyBoxWindowId, COPYWIN_MAP);
    PrintMoneyAmountInMoneyBoxWithBorder(sMoneyBoxWindowId, 0x214, 14);
    AddMoneyLabelObject(x * 8 + 19, y * 8 + 11);
}

void HideMoneyBox(void)
{
    RemoveMoneyLabelObject();
    ClearStdWindowAndFrameToTransparent(sMoneyBoxWindowId, FALSE);
    CopyWindowToVram(sMoneyBoxWindowId, COPYWIN_GFX);
    RemoveWindow(sMoneyBoxWindowId);
}

void AddMoneyLabelObject(u16 x, u16 y)
{
    LoadCompressedSpriteSheet(&sSpriteSheet_MoneyLabel);
    LoadCompressedSpritePalette(&sSpritePalette_MoneyLabel);
    sMoneyLabelSpriteId = CreateSprite(&sSpriteTemplate_MoneyLabel, x, y, 0);
}

void RemoveMoneyLabelObject(void)
{
    DestroySpriteAndFreeResources(&gSprites[sMoneyLabelSpriteId]);
}
