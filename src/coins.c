#include "global.h"
#include "coins.h"
#include "text.h"
#include "window.h"
#include "strings.h"
#include "string_util.h"
#include "menu.h"
#include "international_string_util.h"
#include "constants/coins.h"

static EWRAM_DATA u8 sCoinsWindowId = 0;

void PrintCoinsString(u32 coinAmount)
{
    u32 xAlign;

    ConvertIntToDecimalStringN(gStringVar1, coinAmount, STR_CONV_MODE_RIGHT_ALIGN, MAX_COIN_DIGITS);
    StringExpandPlaceholders(gStringVar4, gText_Coins);

    xAlign = GetStringRightAlignXOffset(FONT_NORMAL, gStringVar4, 0x40);
    AddTextPrinterParameterized(sCoinsWindowId, FONT_NORMAL, gStringVar4, xAlign, 1, 0, NULL);
}

void ShowCoinsWindow(u32 coinAmount, u8 x, u8 y)
{
    struct WindowTemplate template;
    SetWindowTemplateFields(&template, 0, x, y, 8, 2, 0xF, 0x141);
    sCoinsWindowId = AddWindow(&template);
    FillWindowPixelBuffer(sCoinsWindowId, PIXEL_FILL(0));
    PutWindowTilemap(sCoinsWindowId);
    DrawStdFrameWithCustomTileAndPalette(sCoinsWindowId, FALSE, 0x214, 0xE);
    PrintCoinsString(coinAmount);
}

void HideCoinsWindow(void)
{
    ClearStdWindowAndFrame(sCoinsWindowId, TRUE);
    RemoveWindow(sCoinsWindowId);
}

bool8 AddCoins(u16 toAdd)
{
    u16 ownedCoins = gSaveBlock1.coins;
    if (ownedCoins >= MAX_COINS)
        return FALSE;
    // check overflow, can't have less coins than previously
    if (ownedCoins > ownedCoins + toAdd)
    {
        ownedCoins = MAX_COINS;
    }
    else
    {
        ownedCoins += toAdd;
        if (ownedCoins > MAX_COINS)
            ownedCoins = MAX_COINS;
    }
    gSaveBlock1.coins = ownedCoins;
    return TRUE;
}

bool8 RemoveCoins(u16 toSub)
{
    if (gSaveBlock1.coins < toSub)
    {
        gSaveBlock1.coins = 0;
        return FALSE;
    }
    // TODO: What does the result of this do, and do we need it, if not can we optimize this by taking care of equals and removing return?

    gSaveBlock1.coins -= toSub;
    return TRUE;
}
