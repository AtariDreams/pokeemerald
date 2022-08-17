#include "global.h"
#include "window.h"
#include "malloc.h"
#include "bg.h"
#include "blit.h"

// This global is set to 0 and never changed.
#if !MODERN
u32 gUnusedWindowVar1;
u32 gUnusedWindowVar2;
u8 gTransparentTileNumber;
u32 gUnusedWindowVar3;
#endif
void *gWindowBgTilemapBuffers[NUM_BACKGROUNDS];
#if !MODERN
extern u32 gWindowTileAutoAllocEnabled;
#endif
#define WINDOWS_MAX  32

EWRAM_DATA struct Window gWindows[WINDOWS_MAX] = {0};
EWRAM_DATA static struct Window* sWindowPtr = NULL;
EWRAM_DATA static u16 sWindowSize = 0;

static u8 GetNumActiveWindowsOnBg(u8 bgId);
static u8 GetNumActiveWindowsOnBg8Bit(u8 bgId);

static const struct WindowTemplate sDummyWindowTemplate = DUMMY_WIN_TEMPLATE;

//Reserve a screen buffer on another system???
static void DummyWindowBgTilemap(void)
{

}

bool16 InitWindows(const struct WindowTemplate *templates)
{
    m32 i, j;
    u8 bgLayer;
    u16 attrib;
    u8* allocatedTilemapBuffer;
    #if !MODERN
    int allocatedBaseBlock;
    #endif

    for (i = 0; i < NUM_BACKGROUNDS; ++i)
    {
        if (GetBgTilemapBuffer(i) != NULL)
            gWindowBgTilemapBuffers[i] = DummyWindowBgTilemap;
        else
            gWindowBgTilemapBuffers[i] = NULL;
    }


    for (i = 0; i < WINDOWS_MAX; ++i)
    {
        gWindows[i].window = sDummyWindowTemplate;
        gWindows[i].tileData = NULL;
    }
    #if !MODERN
    i = 0;
    allocatedBaseBlock = 0;
    #endif

    #if !MODERN
    while (((bgLayer = templates[i].bg) != 0xFF) && i < WINDOWS_MAX)
    #else
    for (i = 0; i < WINDOWS_MAX; i++)
    #endif
    {
        #if !MODERN
        if (gWindowTileAutoAllocEnabled == TRUE)
        {
            allocatedBaseBlock = BgTileAllocOp(bgLayer, 0, templates[i].width * templates[i].height, 0);
            if (allocatedBaseBlock == -1)
                return FALSE;
        }
        #else
        if ((bgLayer = templates[i].bg) == 0xFF)
            break;
        #endif

        if (gWindowBgTilemapBuffers[bgLayer] == NULL)
        {
            attrib = GetBgAttribute(bgLayer, BG_ATTR_METRIC);

            if (attrib != 0xFFFF)
            {
                allocatedTilemapBuffer = AllocZeroed(attrib);

                if (allocatedTilemapBuffer == NULL)
                {
                    FreeAllWindowBuffers();
                    return FALSE;
                }

                for (j = 0; j < attrib; ++j)
                    allocatedTilemapBuffer[j] = 0;

                gWindowBgTilemapBuffers[bgLayer] = allocatedTilemapBuffer;
                SetBgTilemapBuffer(bgLayer, allocatedTilemapBuffer);
            }
        }
        //todo: is the u16 cast needed? yes it is to match but is it needed?
        allocatedTilemapBuffer = AllocZeroed((u16)(32 * (templates[i].width * templates[i].height)));

        if (allocatedTilemapBuffer == NULL)
        {
            if ((GetNumActiveWindowsOnBg(bgLayer) == 0) && (gWindowBgTilemapBuffers[bgLayer] != DummyWindowBgTilemap))
            {
                Free(gWindowBgTilemapBuffers[bgLayer]);
                gWindowBgTilemapBuffers[bgLayer] = NULL;
            }

            return FALSE;
        }

        gWindows[i].tileData = allocatedTilemapBuffer;
        gWindows[i].window = templates[i];
        
        #if !MODERN
        if (gWindowTileAutoAllocEnabled == TRUE)
        {
            gWindows[i].window.baseBlock = allocatedBaseBlock;
            BgTileAllocOp(bgLayer, allocatedBaseBlock, templates[i].width * templates[i].height, 1);
        }
        #endif

    #if !MODERN
        ++i;
    #endif
    }

    #if !MODERN
    gTransparentTileNumber = 0;
    #endif
    return TRUE;
}

u16 AddWindow(const struct WindowTemplate *template)
{
    m16 win;
    u8 bgLayer;
    
    #if !MODERN
    int allocatedBaseBlock;
    #endif
    u16 attrib;
    u8 *allocatedTilemapBuffer;
    m32 i;

    for (win = 0; win < WINDOWS_MAX; ++win)
    {
        #if !MODERN
        if ((bgLayer = gWindows[win].window.bg) == WINDOW_NONE)
            break;
        #else
        if (gWindows[win].window.bg == WINDOW_NONE)
            break;
        #endif
    }

    if (win == WINDOWS_MAX)
        return WINDOW_NONE;

    bgLayer = template->bg;
    #if !MODERN
    allocatedBaseBlock = 0;

    if (gWindowTileAutoAllocEnabled == TRUE)
    {
        allocatedBaseBlock = BgTileAllocOp(bgLayer, 0, template->width * template->height, 0);

        if (allocatedBaseBlock == -1)
            return WINDOW_NONE;
    }
    #endif

    if (gWindowBgTilemapBuffers[bgLayer] == NULL)
    {
        attrib = GetBgAttribute(bgLayer, BG_ATTR_METRIC);

        if (attrib != 0xFFFF)
        {
            allocatedTilemapBuffer = AllocZeroed(attrib);

            if (allocatedTilemapBuffer == NULL)
                return WINDOW_NONE;

            for (i = 0; i < attrib; ++i)
                allocatedTilemapBuffer[i] = 0;

            gWindowBgTilemapBuffers[bgLayer] = allocatedTilemapBuffer;
            SetBgTilemapBuffer(bgLayer, allocatedTilemapBuffer);
        }
    }
    // TODO: is the u16 cast needed?
    // Keep it for now just in case
    allocatedTilemapBuffer = AllocZeroed((u16)(32 * (template->width * template->height)));

    if (allocatedTilemapBuffer == NULL)
    {
        if ((GetNumActiveWindowsOnBg(bgLayer) == 0) && (gWindowBgTilemapBuffers[bgLayer] != DummyWindowBgTilemap))
        {
            Free(gWindowBgTilemapBuffers[bgLayer]);
            gWindowBgTilemapBuffers[bgLayer] = NULL;
        }
        return WINDOW_NONE;
    }

    gWindows[win].tileData = allocatedTilemapBuffer;
    gWindows[win].window = *template;

    #if !MODERN
    if (gWindowTileAutoAllocEnabled == TRUE)
    {
        gWindows[win].window.baseBlock = allocatedBaseBlock;
        BgTileAllocOp(bgLayer, allocatedBaseBlock, gWindows[win].window.width * gWindows[win].window.height, 1);
    }
    #endif

    return win;
}

u16 AddWindowWithoutTileMap(const struct WindowTemplate *template)
{
    m16 win;
    #if !MODERN
    u8 bgLayer;
    int allocatedBaseBlock;

    for (win = 0; win < WINDOWS_MAX; ++win)
    {
        if ((bgLayer = gWindows[win].window.bg) == 0xFF)
            break;
    }
    #else
    for (win = 0; win < WINDOWS_MAX; ++win)
    {
        if (gWindows[win].window.bg == 0xFF)
            break;
    }
    #endif

    if (win == WINDOWS_MAX)
        return WINDOW_NONE;

    #if !MODERN
    bgLayer = template->bg;

    allocatedBaseBlock = 0;

    if (gWindowTileAutoAllocEnabled == TRUE)
    {
        allocatedBaseBlock = BgTileAllocOp(bgLayer, 0, template->width * template->height, 0);

        if (allocatedBaseBlock == -1)
            return WINDOW_NONE;
    }
    #endif

    gWindows[win].window = *template; // storage of usage data?

    #if !MODERN
    if (gWindowTileAutoAllocEnabled == TRUE)
    {
        gWindows[win].window.baseBlock = allocatedBaseBlock;
        BgTileAllocOp(bgLayer, allocatedBaseBlock, gWindows[win].window.width * gWindows[win].window.height, 1);
    }
    #endif

    return win;
}

void RemoveWindow(u8 windowId)
{
    u8 bgLayer = gWindows[windowId].window.bg;

    #if !MODERN
    if (gWindowTileAutoAllocEnabled == TRUE)
        BgTileAllocOp(bgLayer, gWindows[windowId].window.baseBlock, gWindows[windowId].window.width * gWindows[windowId].window.height, 2);
    #endif

    gWindows[windowId].window = sDummyWindowTemplate;

    if (GetNumActiveWindowsOnBg(bgLayer) == 0)
    {
        if (gWindowBgTilemapBuffers[bgLayer] != DummyWindowBgTilemap)
        {
            Free(gWindowBgTilemapBuffers[bgLayer]);
            gWindowBgTilemapBuffers[bgLayer] = NULL;
        }
    }

    if (gWindows[windowId].tileData != NULL)
    {
        Free(gWindows[windowId].tileData);
        gWindows[windowId].tileData = NULL;
    }
}

void FreeAllWindowBuffers(void)
{
    m32 i;

    for (i = 0; i < NUM_BACKGROUNDS; ++i)
    {
        if (gWindowBgTilemapBuffers[i] != NULL && gWindowBgTilemapBuffers[i] != DummyWindowBgTilemap)
        {
            Free(gWindowBgTilemapBuffers[i]);
            gWindowBgTilemapBuffers[i] = NULL;
        }
    }

    for (i = 0; i < WINDOWS_MAX; ++i)
    {
        if (gWindows[i].tileData != NULL)
        {
            Free(gWindows[i].tileData);
            gWindows[i].tileData = NULL;
        }
    }
}

void CopyWindowToVram(u8 windowId, u8 mode)
{
    struct Window windowLocal = gWindows[windowId];
    u16 windowSize = 32 * (windowLocal.window.width * windowLocal.window.height);

    switch (mode)
    {
    case COPYWIN_MAP:
        CopyBgTilemapBufferToVram(windowLocal.window.bg);
        break;
    case COPYWIN_GFX:
        LoadBgTiles(windowLocal.window.bg, windowLocal.tileData, windowSize, windowLocal.window.baseBlock);
        break;
    case COPYWIN_FULL:
        LoadBgTiles(windowLocal.window.bg, windowLocal.tileData, windowSize, windowLocal.window.baseBlock);
        CopyBgTilemapBufferToVram(windowLocal.window.bg);
        break;
    }
}

void CopyWindowRectToVram(u32 windowId, u32 mode, u32 x, u32 y, u32 w, u32 h)
{
    struct Window windowLocal;
    u32 rectSize;
    u32 rectPos;

    if (w == 0 || h == 0)
        return;

    windowLocal = gWindows[windowId];

    rectSize = ((h - 1) * windowLocal.window.width);
    rectSize += (windowLocal.window.width - x);
    rectSize -= (windowLocal.window.width - (x + w));
    rectSize *= 32;

    rectPos = (y * windowLocal.window.width) + x;

    switch (mode)
    {
    case COPYWIN_MAP:
        CopyBgTilemapBufferToVram(windowLocal.window.bg);
        break;
    case COPYWIN_GFX:
        LoadBgTiles(windowLocal.window.bg, windowLocal.tileData + (rectPos * 32), rectSize, windowLocal.window.baseBlock + rectPos);
        break;
    case COPYWIN_FULL:
        LoadBgTiles(windowLocal.window.bg, windowLocal.tileData + (rectPos * 32), rectSize, windowLocal.window.baseBlock + rectPos);
        CopyBgTilemapBufferToVram(windowLocal.window.bg);
        break;
    }
}

void PutWindowTilemap(u8 windowId)
{
    struct Window windowLocal = gWindows[windowId];

    WriteSequenceToBgTilemapBuffer(
        windowLocal.window.bg,
        GetBgAttribute(windowLocal.window.bg, BG_ATTR_BASETILE) + windowLocal.window.baseBlock,
        windowLocal.window.tilemapLeft,
        windowLocal.window.tilemapTop,
        windowLocal.window.width,
        windowLocal.window.height,
        windowLocal.window.paletteNum,
        1);
}

void PutWindowRectTilemapOverridePalette(u8 windowId, u8 x, u8 y, u8 width, u8 height, u8 palette)
{
    struct Window windowLocal = gWindows[windowId];
    u16 currentRow = windowLocal.window.baseBlock + (y * windowLocal.window.width) + x + GetBgAttribute(windowLocal.window.bg, BG_ATTR_BASETILE);
    m32 i;

    for (i = 0; i < height; ++i)
    {
        WriteSequenceToBgTilemapBuffer(
            windowLocal.window.bg,
            currentRow,
            windowLocal.window.tilemapLeft + x,
            windowLocal.window.tilemapTop + y + i,
            width,
            1,
            palette,
            1);

        currentRow += windowLocal.window.width;
    }
}

// Fills a window with transparent tiles.
void ClearWindowTilemap(u8 windowId)
{
    struct Window windowLocal = gWindows[windowId];

    FillBgTilemapBufferRect(
        windowLocal.window.bg,
        #if !MODERN
        gTransparentTileNumber,
        #else
        0,
        #endif
        windowLocal.window.tilemapLeft,
        windowLocal.window.tilemapTop,
        windowLocal.window.width,
        windowLocal.window.height,
        windowLocal.window.paletteNum);
}

void PutWindowRectTilemap(u8 windowId, u8 x, u8 y, u8 width, u8 height)
{
    struct Window windowLocal = gWindows[windowId];
    u16 currentRow = windowLocal.window.baseBlock + (y * windowLocal.window.width) + x + GetBgAttribute(windowLocal.window.bg, BG_ATTR_BASETILE);
    m32 i;

    for (i = 0; i < height; ++i)
    {
        WriteSequenceToBgTilemapBuffer(
            windowLocal.window.bg,
            currentRow,
            windowLocal.window.tilemapLeft + x,
            windowLocal.window.tilemapTop + y + i,
            width,
            1,
            windowLocal.window.paletteNum,
            1);

        currentRow += windowLocal.window.width;
    }
}

void BlitBitmapToWindow(u8 windowId, const u8 *pixels, u16 x, u16 y, u16 width, u16 height)
{
    BlitBitmapRectToWindow(windowId, pixels, 0, 0, width, height, x, y, width, height);
}

void BlitBitmapRectToWindow(u8 windowId, const u8 *pixels, u16 srcX, u16 srcY, u16 srcWidth, u16 srcHeight, u16 destX, u16 destY, u16 rectWidth, u16 rectHeight)
{
    struct Bitmap sourceRect;
    struct Bitmap destRect;

    sourceRect.pixels = (u8 *)pixels;
    sourceRect.width = srcWidth;
    sourceRect.height = srcHeight;

    destRect.pixels = gWindows[windowId].tileData;
    destRect.width = 8 * gWindows[windowId].window.width;
    destRect.height = 8 * gWindows[windowId].window.height;

    BlitBitmapRect4Bit(&sourceRect, &destRect, srcX, srcY, destX, destY, rectWidth, rectHeight, 0);
}

static void BlitBitmapRectToWindowWithColorKey(u8 windowId, const u8 *pixels, u16 srcX, u16 srcY, u16 srcWidth, u16 srcHeight, u16 destX, u16 destY, u16 rectWidth, u16 rectHeight, u8 colorKey)
{
    struct Bitmap sourceRect;
    struct Bitmap destRect;

    sourceRect.pixels = (u8 *)pixels;
    sourceRect.width = srcWidth;
    sourceRect.height = srcHeight;

    destRect.pixels = gWindows[windowId].tileData;
    destRect.width = 8 * gWindows[windowId].window.width;
    destRect.height = 8 * gWindows[windowId].window.height;

    BlitBitmapRect4Bit(&sourceRect, &destRect, srcX, srcY, destX, destY, rectWidth, rectHeight, colorKey);
}

void FillWindowPixelRect(u8 windowId, u8 fillValue, u16 x, u16 y, u16 width, u16 height)
{
    struct Bitmap pixelRect;

    pixelRect.pixels = gWindows[windowId].tileData;
    pixelRect.width = 8 * gWindows[windowId].window.width;
    pixelRect.height = 8 * gWindows[windowId].window.height;

    FillBitmapRect4Bit(&pixelRect, x, y, width, height, fillValue);
}

void CopyToWindowPixelBuffer(u8 windowId, const void *src, u16 size, u16 tileOffset)
{
    if (size != 0)
        CpuCopy16(src, gWindows[windowId].tileData + (32 * tileOffset), size);
    else
        LZ77UnCompWram(src, gWindows[windowId].tileData + (32 * tileOffset));
}

// Sets all pixels within the window to the fillValue color.
void FillWindowPixelBuffer(u8 windowId, u8 fillValue)
{
    u32 fillSize = gWindows[windowId].window.width * gWindows[windowId].window.height;
    CpuFastFill8(fillValue, gWindows[windowId].tileData, 32 * fillSize);
}

#define MOVE_TILES_DOWN(a)                                                      \
{                                                                               \
    destOffset = i + (a);                                                       \
    srcOffset = i + (((width * (distanceLoop & ~7)) | (distanceLoop & 7)) << 2);\
    if (srcOffset < size)                                                       \
        *(u32 *)(tileData + destOffset) = *(u32 *)(tileData + srcOffset);         \
    else                                                                        \
        *(u32 *)(tileData + destOffset) = fillValue32;                           \
    distanceLoop++;                                                             \
}

#define MOVE_TILES_UP(a)                                                        \
{                                                                               \
    destOffset = i + (a);                                                       \
    srcOffset = i + (((width * (distanceLoop & ~7)) | (distanceLoop & 7)) << 2);\
    if (srcOffset < size)                                                       \
        *(u32 *)(tileData - destOffset) = *(u32 *)(tileData - srcOffset);         \
    else                                                                        \
        *(u32 *)(tileData - destOffset) = fillValue32;                           \
    distanceLoop++;                                                             \
}

void ScrollWindow(u8 windowId, u8 direction, u8 distance, u8 fillValue)
{
    struct WindowTemplate window = gWindows[windowId].window;
    u8 *tileData = gWindows[windowId].tileData;
    u32 fillValue32 = (fillValue << 24) | (fillValue << 16) | (fillValue << 8) | fillValue;

    // Keep them ints justin case, for now
    s32 size = window.height * window.width * 32;
    s32 width = window.width;
    s32 i;
    s32 srcOffset, destOffset;
    s32 distanceLoop;

    switch (direction)
    {
    case 0:
        for (i = 0; i < size; i += 32)
        {
            distanceLoop = distance;
            MOVE_TILES_DOWN(0)
            MOVE_TILES_DOWN(4)
            MOVE_TILES_DOWN(8)
            MOVE_TILES_DOWN(12)
            MOVE_TILES_DOWN(16)
            MOVE_TILES_DOWN(20)
            MOVE_TILES_DOWN(24)
            MOVE_TILES_DOWN(28)
        }
        break;
    case 1:
        tileData += size - 4;
        for (i = 0; i < size; i += 32)
        {
            distanceLoop = distance;
            MOVE_TILES_UP(0)
            MOVE_TILES_UP(4)
            MOVE_TILES_UP(8)
            MOVE_TILES_UP(12)
            MOVE_TILES_UP(16)
            MOVE_TILES_UP(20)
            MOVE_TILES_UP(24)
            MOVE_TILES_UP(28)
        }
        break;
    case 2:
        break;
    }
}

void CallWindowFunction(u8 windowId, void ( *func)(u8, u8, u8, u8, u8, u8))
{
    struct WindowTemplate window = gWindows[windowId].window;
    func(window.bg, window.tilemapLeft, window.tilemapTop, window.width, window.height, window.paletteNum);
}

bool32 SetWindowAttribute(u8 windowId, u8 attributeId, u32 value)
{
    switch (attributeId)
    {
    case WINDOW_TILEMAP_LEFT:
        gWindows[windowId].window.tilemapLeft = value;
        return FALSE;
    case WINDOW_TILEMAP_TOP:
        gWindows[windowId].window.tilemapTop = value;
        return FALSE;
    case WINDOW_PALETTE_NUM:
        gWindows[windowId].window.paletteNum = value;
        return FALSE;
    case WINDOW_BASE_BLOCK:
        gWindows[windowId].window.baseBlock = value;
        return FALSE;
    case WINDOW_TILE_DATA:
        gWindows[windowId].tileData = (u8 *)(value);
        return TRUE;
    case WINDOW_BG:
    case WINDOW_WIDTH:
    case WINDOW_HEIGHT:
    default:
        return TRUE;
    }
}

u32 GetWindowAttribute(u8 windowId, u8 attributeId)
{
    switch (attributeId)
    {
    case WINDOW_BG:
        return gWindows[windowId].window.bg;
    case WINDOW_TILEMAP_LEFT:
        return gWindows[windowId].window.tilemapLeft;
    case WINDOW_TILEMAP_TOP:
        return gWindows[windowId].window.tilemapTop;
    case WINDOW_WIDTH:
        return gWindows[windowId].window.width;
    case WINDOW_HEIGHT:
        return gWindows[windowId].window.height;
    case WINDOW_PALETTE_NUM:
        return gWindows[windowId].window.paletteNum;
    case WINDOW_BASE_BLOCK:
        return gWindows[windowId].window.baseBlock;
    case WINDOW_TILE_DATA:
        return (u32)(gWindows[windowId].tileData);
    default:
        return 0;
    }
}

static u8 GetNumActiveWindowsOnBg(u8 bgId)
{
    u8 windowsNum = 0;
    m32 i;
    for (i = 0; i < WINDOWS_MAX; i++)
    {
        if (gWindows[i].window.bg == bgId)
            windowsNum++;
    }
    return windowsNum;
}

static void DummyWindowBgTilemap8Bit(void)
{

}

u16 AddWindow8Bit(const struct WindowTemplate *template)
{
    u16 windowId;
    u8 *memAddress;
    u8 bgLayer;

    for (windowId = 0; windowId < WINDOWS_MAX; windowId++)
    {
        if (gWindows[windowId].window.bg == 0xFF)
            break;
    }
    if (windowId == WINDOWS_MAX)
        return WINDOW_NONE;
    bgLayer = template->bg;
    if (gWindowBgTilemapBuffers[bgLayer] == NULL)
    {
        u16 attribute = GetBgAttribute(bgLayer, BG_ATTR_METRIC);
        if (attribute != 0xFFFF)
        {
            // TODO: See if alloc zeroed is more performant
            // Maybe inline if needed
            #if !MODERN
            s32 i;
            memAddress = Alloc(attribute);
            if (memAddress == NULL)
                return WINDOW_NONE;
            for (i = 0; i < attribute; i++) // if we're going to zero out the memory anyway, why not call AllocZeroed?
                memAddress[i] = 0;
            #else
            memAddress = AllocZeroed(attribute);
            if (memAddress == NULL)
                return WINDOW_NONE;
            #endif
            gWindowBgTilemapBuffers[bgLayer] = memAddress;
            SetBgTilemapBuffer(bgLayer, memAddress);
        }
    }
    memAddress = Alloc((u16)(64 * (template->width * template->height)));
    if (memAddress == NULL)
    {
        if (GetNumActiveWindowsOnBg8Bit(bgLayer) == 0 && gWindowBgTilemapBuffers[bgLayer] != DummyWindowBgTilemap8Bit)
        {
            Free(gWindowBgTilemapBuffers[bgLayer]);
            gWindowBgTilemapBuffers[bgLayer] = NULL;
        }
        return WINDOW_NONE;
    }
    else
    {
        gWindows[windowId].tileData = memAddress;
        gWindows[windowId].window = *template;
        return windowId;
    }
}

void FillWindowPixelBuffer8Bit(u8 windowId, u8 fillValue)
{
    m32 i;
    u16 size;

    size = 64 * (gWindows[windowId].window.width * gWindows[windowId].window.height);
    for (i = 0; i < size; i++)
        gWindows[windowId].tileData[i] = fillValue;
}

void FillWindowPixelRect8Bit(u8 windowId, u8 fillValue, u16 x, u16 y, u16 width, u16 height)
{
    struct Bitmap pixelRect;

    pixelRect.pixels = gWindows[windowId].tileData;
    pixelRect.width = 8 * gWindows[windowId].window.width;
    pixelRect.height = 8 * gWindows[windowId].window.height;

    FillBitmapRect8Bit(&pixelRect, x, y, width, height, fillValue);
}

void BlitBitmapRectToWindow4BitTo8Bit(u8 windowId, const u8 *pixels, u16 srcX, u16 srcY, u16 srcWidth, u16 srcHeight, u16 destX, u16 destY, u16 rectWidth, u16 rectHeight, u8 paletteNum)
{
    struct Bitmap sourceRect;
    struct Bitmap destRect;

    sourceRect.pixels = (u8 *) pixels;
    sourceRect.width = srcWidth;
    sourceRect.height = srcHeight;

    destRect.pixels = gWindows[windowId].tileData;
    destRect.width = 8 * gWindows[windowId].window.width;
    destRect.height = 8 * gWindows[windowId].window.height;

    BlitBitmapRect4BitTo8Bit(&sourceRect, &destRect, srcX, srcY, destX, destY, rectWidth, rectHeight, 0, paletteNum);
}

void CopyWindowToVram8Bit(u8 windowId, u8 mode)
{
    sWindowPtr = &gWindows[windowId];
    sWindowSize = 64 * (sWindowPtr->window.width * sWindowPtr->window.height);

    switch (mode)
    {
    case COPYWIN_MAP:
        CopyBgTilemapBufferToVram(sWindowPtr->window.bg);
        break;
    case COPYWIN_GFX:
        LoadBgTiles(sWindowPtr->window.bg, sWindowPtr->tileData, sWindowSize, sWindowPtr->window.baseBlock);
        break;
    case COPYWIN_FULL:
        LoadBgTiles(sWindowPtr->window.bg, sWindowPtr->tileData, sWindowSize, sWindowPtr->window.baseBlock);
        CopyBgTilemapBufferToVram(sWindowPtr->window.bg);
        break;
    }
}

static u8 GetNumActiveWindowsOnBg8Bit(u8 bgId)
{
    u8 windowsNum = 0;
    m32 i;
    for (i = 0; i < WINDOWS_MAX; i++)
    {
        if (gWindows[i].window.bg == bgId)
            windowsNum++;
    }
    return windowsNum;
}
