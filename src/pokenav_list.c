#include "global.h"
#include "pokenav.h"
#include "window.h"
#include "strings.h"
#include "text.h"
#include "bg.h"
#include "menu.h"
#include "decompress.h"
#include "international_string_util.h"

#define GFXTAG_ARROW 10
#define PALTAG_ARROW 20

struct PokenavListWindowState {
    // The index of the element at the top of the window.
    u16 windowTopIndex;
    u16 listLength;
    u16 entriesOffscreen;
    // The index of the cursor, relative to the top of the window.
    u16 selectedIndexOffset;
    u16 entriesOnscreen;
    u32 listItemSize;
    void * listPtr;
};

struct PokenavListMenuWindow
{
    u8 bg;
    u8 fillValue;
    u8 x;
    u8 y;
    u8 width;
    u8 fontId;
    u16 tileOffset;
    u16 windowId;
    u16 unkA;
    u16 numPrinted;
    u16 numToPrint;

    u32 printStart;
    u32 printIndex;
    u32 itemSize;
    void * listPtr;
    s32 startBgY;
    s32 endBgY;
    u32 loopedTaskId;
    s32 moveDelta;
    u32 bgMoveType;
    PokenavListBufferItemFunc bufferItemFunc;
    void (*iconDrawFunc)(u8, u32, u32);
    struct Sprite *rightArrow;
    struct Sprite *upArrow;
    struct Sprite *downArrow;
    u8 itemTextBuffer[64];
    u8 tilemapBuffer[BG_SCREEN_SIZE];
};

struct PokenavList
{
    struct PokenavListMenuWindow window;

    struct PokenavListWindowState windowState;
    s32 eraseIndex;
    u32 loopedTaskId;
};

static void InitPokenavListBg(struct PokenavList *);
static bool32 CopyPokenavListMenuTemplate(struct PokenavListMenuWindow *, const struct BgTemplate *, struct PokenavListTemplate *, u32);
static void InitPokenavListWindowState(struct PokenavListWindowState *, struct PokenavListTemplate *);
static void SpriteCB_UpArrow(struct Sprite *);
static void SpriteCB_DownArrow(struct Sprite *);
static void SpriteCB_RightArrow(struct Sprite *);
static void ToggleListArrows(struct PokenavListMenuWindow *, bool32);
static void DestroyListArrows(struct PokenavListMenuWindow *);
static void CreateListArrowSprites(struct PokenavListWindowState *, struct PokenavListMenuWindow *);
static void LoadListArrowGfx(void);
static void PrintMatchCallFlavorText(struct PokenavListWindowState *, struct PokenavListMenuWindow *, u32);
static void PrintMatchCallFieldNames(struct PokenavListMenuWindow *, u32);
static void PrintMatchCallListTrainerName(struct PokenavListWindowState *, struct PokenavListMenuWindow *);
static void PrintCheckPageTrainerName(struct PokenavListWindowState *, struct PokenavListMenuWindow *);
static void EraseListEntry(struct PokenavListMenuWindow *, s32, s32);
static void CreateMoveListWindowTask(s32, struct PokenavListMenuWindow *);
static void PrintListItems(void *, u32, u32, u32, u32, struct PokenavListMenuWindow *);
static void InitListItems(struct PokenavListWindowState *, struct PokenavListMenuWindow *);
static void InitPokenavListWindow(struct PokenavListMenuWindow *);
static u32 LoopedTask_CreatePokenavList(s32);
static bool32 IsPrintListItemsTaskActive(void);
static u32 LoopedTask_PrintListItems(s32);
static u32 LoopedTask_MoveListWindow(s32);
static u32 LoopedTask_EraseListForCheckPage(s32);
static u32 LoopedTask_ReshowListFromCheckPage(s32);
static u32 LoopedTask_PrintCheckPageInfo(s32);

static const u16 sListArrow_Pal[] = INCBIN_U16("graphics/pokenav/list_arrows.gbapal");
static const u32 sListArrow_Gfx[] = INCBIN_U32("graphics/pokenav/list_arrows.4bpp.lz");

bool32 CreatePokenavList(const struct BgTemplate *bgTemplate, struct PokenavListTemplate *listTemplate, u32 tileOffset)
{
    struct PokenavList *list = AllocSubstruct(POKENAV_SUBSTRUCT_LIST, sizeof(struct PokenavList));
    if (list == NULL)
        return FALSE;

    InitPokenavListWindowState(&list->windowState, listTemplate);
    if (!CopyPokenavListMenuTemplate(&list->window, bgTemplate, listTemplate, tileOffset))
        return FALSE;

    CreateLoopedTask(LoopedTask_CreatePokenavList, 6);
    return TRUE;
}

bool32 IsCreatePokenavListTaskActive(void)
{
    return FuncIsActiveLoopedTask(LoopedTask_CreatePokenavList);
}

void DestroyPokenavList(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    DestroyListArrows(&list->window);
    RemoveWindow(list->window.windowId);
    FreePokenavSubstruct(POKENAV_SUBSTRUCT_LIST);
}

static u32 LoopedTask_CreatePokenavList(s32 state)
{
    struct PokenavList *list;

    if (IsDma3ManagerBusyWithBgCopy())
        return LT_PAUSE;

    list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);

    switch (state)
    {
    case 0:
        InitPokenavListBg(list);
        return LT_INC_AND_PAUSE;
    case 1:
        InitPokenavListWindow(&list->window);
        return LT_INC_AND_PAUSE;
    case 2:
        InitListItems(&list->windowState, &list->window);
        return LT_INC_AND_PAUSE;
    case 3:
        if (IsPrintListItemsTaskActive())
        {
            return LT_PAUSE;
        }
        else
        {
            LoadListArrowGfx();
            return LT_INC_AND_CONTINUE;
        }
    case 4:
        CreateListArrowSprites(&list->windowState, &list->window);
        break;
    }
    return LT_FINISH;
}

static void InitPokenavListBg(struct PokenavList *list)
{
    u16 tileNum = (list->window.fillValue << 12) | list->window.tileOffset;
    BgDmaFill(list->window.bg, PIXEL_FILL(1), list->window.tileOffset, 1);
    BgDmaFill(list->window.bg, PIXEL_FILL(4), list->window.tileOffset + 1, 1);
    SetBgTilemapBuffer(list->window.bg, list->window.tilemapBuffer);
    FillBgTilemapBufferRect_Palette0(list->window.bg, tileNum, 0, 0, 32, 32);
    ChangeBgY(list->window.bg, 0, BG_COORD_SET);
    ChangeBgX(list->window.bg, 0, BG_COORD_SET);
    ChangeBgY(list->window.bg, list->window.y << 11, BG_COORD_SUB);
    CopyBgTilemapBufferToVram(list->window.bg);
}

static void InitPokenavListWindow(struct PokenavListMenuWindow *listWindow)
{
    FillWindowPixelBuffer(listWindow->windowId, PIXEL_FILL(1));
    PutWindowTilemap(listWindow->windowId);
    CopyWindowToVram(listWindow->windowId, COPYWIN_MAP);
}

static void InitListItems(struct PokenavListWindowState *windowState, struct PokenavListMenuWindow *window)
{
    s32 numToPrint = windowState->listLength - windowState->windowTopIndex;
    if (numToPrint > windowState->entriesOnscreen)
        numToPrint = windowState->entriesOnscreen;

    PrintListItems(windowState->listPtr, windowState->windowTopIndex, numToPrint, windowState->listItemSize, 0, window);
}

static void PrintListItems(void * listPtr, u32 topIndex, u32 numItems, u32 itemSize, u32 printStart, struct PokenavListMenuWindow *list)
{
    if (numItems == 0)
        return;

    list->listPtr = listPtr + topIndex * itemSize;
    list->itemSize = itemSize;
    list->numPrinted = 0;
    list->numToPrint = numItems;
    list->printIndex = topIndex;
    list->printStart = printStart;
    CreateLoopedTask(LoopedTask_PrintListItems, 5);
}

static bool32 IsPrintListItemsTaskActive(void)
{
    return FuncIsActiveLoopedTask(LoopedTask_PrintListItems);
}

static u32 LoopedTask_PrintListItems(s32 state)
{
    u32 row;
    struct PokenavListMenuWindow *listSub = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);

    switch (state)
    {
    case 0:
        row = (listSub->unkA + listSub->numPrinted + listSub->printStart) & 0xF;
        listSub->bufferItemFunc(listSub->listPtr, listSub->itemTextBuffer);
        if (listSub->iconDrawFunc != NULL)
            listSub->iconDrawFunc(listSub->windowId, listSub->printIndex, row);

        AddTextPrinterParameterized(listSub->windowId, listSub->fontId, listSub->itemTextBuffer, 8, (row << 4) + 1, TEXT_SKIP_DRAW, NULL);
        if (++listSub->numPrinted >= listSub->numToPrint)
        {
            // Finished printing items. If icons were being drawn, draw the
            // window tilemap and graphics. Otherwise just do the graphics
            if (listSub->iconDrawFunc != NULL)
                CopyWindowToVram(listSub->windowId, COPYWIN_FULL);
            else
                CopyWindowToVram(listSub->windowId, COPYWIN_GFX);
            return LT_INC_AND_PAUSE;
        }
        else
        {
            listSub->listPtr += listSub->itemSize;
            listSub->printIndex++;
            return LT_CONTINUE;
        }
    case 1:
        if (IsDma3ManagerBusyWithBgCopy())
            return LT_PAUSE;
        return LT_FINISH;
    }
    return LT_FINISH;
}

static bool32 ShouldShowUpArrow(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);

    return (list->windowState.windowTopIndex != 0);
}

static bool32 ShouldShowDownArrow(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    struct PokenavListWindowState *windowState = &list->windowState;

    return (windowState->windowTopIndex + windowState->entriesOnscreen < windowState->listLength);
}

static void MoveListWindow(s32 delta, bool32 printItems)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    struct PokenavListWindowState *windowState = &list->windowState;

    if (delta < 0)
    {
        if (windowState->windowTopIndex + delta < 0)
            delta = -1 * windowState->windowTopIndex;
        if (printItems)
            PrintListItems(windowState->listPtr, windowState->windowTopIndex + delta, delta * -1, windowState->listItemSize, delta, &list->window);
    }
    else if (printItems)
    {
        s32 index = windowState->windowTopIndex + windowState->entriesOnscreen;
        if (index + delta >= windowState->listLength)
            delta = windowState->listLength - index;

        PrintListItems(windowState->listPtr, index, delta, windowState->listItemSize, windowState->entriesOnscreen, &list->window);
    }

    CreateMoveListWindowTask(delta, &list->window);
    windowState->windowTopIndex += delta;
}

static void CreateMoveListWindowTask(s32 delta, struct PokenavListMenuWindow *list)
{
    list->startBgY = GetBgY(list->bg);
    list->endBgY = list->startBgY + (delta * (16 << 8));
    if (delta > 0)
        list->bgMoveType = BG_COORD_ADD;
    else
        list->bgMoveType = BG_COORD_SUB;
    list->moveDelta = delta;
    list->loopedTaskId = CreateLoopedTask(LoopedTask_MoveListWindow, 6);
}

static u32 LoopedTask_MoveListWindow(s32 state)
{
    s32 oldY, newY;
    bool32 finished;
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    struct PokenavListMenuWindow *window = &list->window;
    switch (state)
    {
    case 0:
        if (!IsPrintListItemsTaskActive())
            return LT_INC_AND_CONTINUE;
        return LT_PAUSE;
    case 1:
        finished = FALSE;
        oldY = GetBgY(window->bg);
        newY = ChangeBgY(window->bg, 0x1000, window->bgMoveType);
        if (window->bgMoveType == BG_COORD_SUB)
        {
            if ((oldY > window->endBgY || oldY <= window->startBgY) && newY <= window->endBgY)
                finished = TRUE;
        }
        else // BG_COORD_ADD
        {
            if ((oldY < window->endBgY || oldY >= window->startBgY) && newY >= window->endBgY)
                finished = TRUE;
        }

        if (finished)
        {
            window->unkA += window->moveDelta;
            window->unkA &= 0xF;
            ChangeBgY(window->bg, window->endBgY, BG_COORD_SET);
            return LT_FINISH;
        }
        return LT_PAUSE;
    }
    return LT_FINISH;
}

bool32 PokenavList_IsMoveWindowTaskActive(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    return IsLoopedTaskActive(list->window.loopedTaskId);
}

static struct PokenavListWindowState *GetPokenavListWindowState(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    return &list->windowState;
}

int PokenavList_MoveCursorUp(void)
{
    struct PokenavListWindowState *windowState = GetPokenavListWindowState();

    if (windowState->selectedIndexOffset != 0)
    {
        windowState->selectedIndexOffset--;
        return 1;
    }
    if (ShouldShowUpArrow())
    {
        MoveListWindow(-1, TRUE);
        return 2;
    }
    return 0;
}

int PokenavList_MoveCursorDown(void)
{
    struct PokenavListWindowState *windowState = GetPokenavListWindowState();

    if (windowState->windowTopIndex + windowState->selectedIndexOffset >= windowState->listLength - 1)
        return 0;
    if (windowState->selectedIndexOffset < windowState->entriesOnscreen - 1)
    {
        windowState->selectedIndexOffset++;
        return 1;
    }
    if (ShouldShowDownArrow())
    {
        MoveListWindow(1, TRUE);
        return 2;
    }
    return 0;
}

int PokenavList_PageUp(void)
{
    s32 scroll;
    struct PokenavListWindowState *windowState = GetPokenavListWindowState();

    if (ShouldShowUpArrow())
    {
        if (windowState->windowTopIndex >= windowState->entriesOnscreen)
            scroll = -windowState->entriesOnscreen;
        else
            scroll = -windowState->windowTopIndex;
        MoveListWindow(scroll, TRUE);
        return 2;
    }
    
    if (windowState->selectedIndexOffset != 0)
    {
        windowState->selectedIndexOffset = 0;
        return 1;
    }
    return 0;
}

int PokenavList_PageDown(void)
{
    struct PokenavListWindowState *windowState = GetPokenavListWindowState();

    if (ShouldShowDownArrow())
    {
        s32 scroll;
        if (windowState->windowTopIndex + windowState->entriesOnscreen <= windowState->entriesOffscreen)
            scroll = windowState->entriesOnscreen = windowState->windowTopIndex;
        else
            scroll = windowState->entriesOffscreen - windowState->windowTopIndex;
        MoveListWindow(scroll, TRUE);
        return 2;
    }

    if (windowState->listLength >= windowState->entriesOnscreen)
    {
        if (windowState->selectedIndexOffset < windowState->entriesOnscreen - 1)
        {
            windowState->listLength = windowState->entriesOnscreen - 1;
            return 1;
        }
    }
    else
    {
        if (windowState->selectedIndexOffset < windowState->listLength - 1)
        {
            windowState->listLength = windowState->listLength - 1;
            return 1;
        }
    }
    return 0;
}

u32 PokenavList_GetSelectedIndex(void)
{
    struct PokenavListWindowState *windowState = GetPokenavListWindowState();

    return windowState->windowTopIndex + windowState->selectedIndexOffset;
}

u32 PokenavList_GetTopIndex(void)
{
    struct PokenavListWindowState *windowState = GetPokenavListWindowState();

    return windowState->windowTopIndex;
}

void PokenavList_EraseListForCheckPage(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    list->eraseIndex = 0;
    list->loopedTaskId = CreateLoopedTask(LoopedTask_EraseListForCheckPage, 6);
}

void PrintCheckPageInfo(s16 delta)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    list->windowState.windowTopIndex += delta;
    list->eraseIndex = 0;
    list->loopedTaskId = CreateLoopedTask(LoopedTask_PrintCheckPageInfo, 6);
}

void PokenavList_ReshowListFromCheckPage(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    list->eraseIndex = 0;
    list->loopedTaskId = CreateLoopedTask(LoopedTask_ReshowListFromCheckPage, 6);
}

bool32 PokenavList_IsTaskActive(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    return IsLoopedTaskActive(list->loopedTaskId);
}

void PokenavList_DrawCurrentItemIcon(void)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    struct PokenavListWindowState *windowState = &list->windowState;
    struct PokenavListMenuWindow *window = &list->window;
    window->iconDrawFunc(window->windowId, windowState->windowTopIndex + windowState->selectedIndexOffset, (window->unkA + windowState->selectedIndexOffset) & 0xF);
    CopyWindowToVram(window->windowId, COPYWIN_MAP);
}

static u32 LoopedTask_EraseListForCheckPage(s32 state)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);

    switch (state)
    {
    case 0:
        ToggleListArrows(&list->window, TRUE);
        // fall-through
    case 1:
        if (list->eraseIndex != list->windowState.selectedIndexOffset)
            EraseListEntry(&list->window, list->eraseIndex, 1);

        list->eraseIndex++;
        return LT_INC_AND_PAUSE;
    case 2:
        if (!IsDma3ManagerBusyWithBgCopy())
        {
            if (list->eraseIndex != list->windowState.entriesOnscreen)
                return LT_SET_STATE(1);
            if (list->windowState.selectedIndexOffset != 0)
                EraseListEntry(&list->window, list->eraseIndex, list->windowState.selectedIndexOffset);

            return LT_INC_AND_PAUSE;
        }
        return LT_PAUSE;
    case 3:
        if (!IsDma3ManagerBusyWithBgCopy())
        {
            if (list->windowState.selectedIndexOffset != 0)
            {
                MoveListWindow(list->windowState.selectedIndexOffset, FALSE);
                return LT_INC_AND_PAUSE;
            }
            return LT_FINISH;
        }
        return LT_PAUSE;
    case 4:
         if (PokenavList_IsMoveWindowTaskActive())
            return LT_PAUSE;

        list->windowState.selectedIndexOffset = 0;
        break;
    }
    return LT_FINISH;
}

static u32 LoopedTask_PrintCheckPageInfo(s32 state)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    if (IsDma3ManagerBusyWithBgCopy())
        return LT_PAUSE;

    switch (state)
    {
    case 0:
        PrintCheckPageTrainerName(&list->windowState, &list->window);
        break;
    case 1:
        PrintMatchCallFieldNames(&list->window, 0);
        break;
    case 2:
        PrintMatchCallFlavorText(&list->windowState, &list->window, CHECK_PAGE_STRATEGY);
        break;
    case 3:
        PrintMatchCallFieldNames(&list->window, 1);
        break;
    case 4:
        PrintMatchCallFlavorText(&list->windowState, &list->window, CHECK_PAGE_POKEMON);
        break;
    case 5:
        PrintMatchCallFieldNames(&list->window, 2);
        break;
    case 6:
        PrintMatchCallFlavorText(&list->windowState, &list->window, CHECK_PAGE_INTRO_1);
        break;
    case 7:
        PrintMatchCallFlavorText(&list->windowState, &list->window, CHECK_PAGE_INTRO_2);
        break;
    default:
        return LT_FINISH;
    }
    return LT_INC_AND_PAUSE;
}

static u32 LoopedTask_ReshowListFromCheckPage(s32 state)
{
    struct PokenavList *list;
    struct PokenavListWindowState *windowState;
    struct PokenavListMenuWindow *window;

    if (IsDma3ManagerBusyWithBgCopy())
        return LT_PAUSE;

    list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    windowState = &list->windowState;
    window = &list->window;

    switch (state)
    {
    case 0:
        // Rewrite the name of the trainer whose check page was just being viewed.
        // This is done to erase the red background it had.
        PrintMatchCallListTrainerName(windowState, window);
        return LT_INC_AND_PAUSE;
    case 1:
        list->eraseIndex++;
        if (list->eraseIndex < list->windowState.entriesOnscreen)
        {
            EraseListEntry(window, list->eraseIndex, 1);
            return LT_PAUSE;
        }

        list->eraseIndex = 0;
        if (windowState->listLength <= windowState->entriesOnscreen)
        {
            if (windowState->windowTopIndex != 0)
            {
                s32 r4 = windowState->windowTopIndex;
                EraseListEntry(window, -r4, r4);
                windowState->selectedIndexOffset = r4;
                list->eraseIndex = -r4;
                return LT_INC_AND_PAUSE;
            }
        }
        else
        {
            if (windowState->windowTopIndex + windowState->entriesOnscreen > windowState->listLength)
            {
                s32 r4 = windowState->windowTopIndex + windowState->entriesOnscreen - windowState->listLength;
                EraseListEntry(window, -r4, r4);
                windowState->selectedIndexOffset = r4;
                list->eraseIndex = -r4;
                return LT_INC_AND_PAUSE;
            }
        }
        return LT_SET_STATE(4);
    case 2:
        MoveListWindow(list->eraseIndex, FALSE);
        return LT_INC_AND_PAUSE;
    case 3:
        if (!PokenavList_IsMoveWindowTaskActive())
        {
            list->eraseIndex = 0;
            return LT_INC_AND_CONTINUE;
        }
        return LT_PAUSE;
    case 4:
        PrintListItems(windowState->listPtr, windowState->windowTopIndex + list->eraseIndex, 1, windowState->listItemSize, list->eraseIndex, &list->window);
        return LT_INC_AND_PAUSE;
    case 5:
        if (IsPrintListItemsTaskActive())
            return LT_PAUSE;
        list->eraseIndex++;
        if (list->eraseIndex >= windowState->listLength || list->eraseIndex >= windowState->entriesOnscreen)
            return LT_INC_AND_CONTINUE;
        return LT_SET_STATE(4);
    case 6:
        ToggleListArrows(window, FALSE);
        return LT_FINISH;
    }

    return LT_FINISH;
}

static void EraseListEntry(struct PokenavListMenuWindow *listWindow, s32 offset, s32 entries)
{
    u8 *tileData = (u8 *)GetWindowAttribute(listWindow->windowId, WINDOW_TILE_DATA);
    u32 width = listWindow->width * 64;

    offset = (listWindow->unkA + offset) & 0xF;
    if (offset + entries <= 16)
    {
        CpuFastFill8(PIXEL_FILL(1), tileData + offset * width, entries * width);
        CopyWindowToVram(listWindow->windowId, COPYWIN_GFX);
    }
    else
    {
        int v3 = 16 - offset;
        int v4 = entries - v3;

        CpuFastFill8(PIXEL_FILL(1), tileData + offset * width, v3 * width);
        CpuFastFill8(PIXEL_FILL(1), tileData, v4 * width);
        CopyWindowToVram(listWindow->windowId, COPYWIN_GFX);
    }

    for (; entries > 0; entries--)
    {
        ClearRematchPokeballIcon(listWindow->windowId, offset);
        offset = (offset + 1) & 0xF;
    }

    CopyWindowToVram(listWindow->windowId, COPYWIN_MAP);
}

// Pointless
static void SetListMarginTile(struct PokenavListMenuWindow *listWindow, bool32 draw)
{
    u16 var;
    u16 *tilemapBuffer = (u16 *)GetBgTilemapBuffer(GetWindowAttribute(listWindow->windowId, WINDOW_BG));
    tilemapBuffer += (listWindow->unkA * 64) + listWindow->x - 1;

    if (draw)
        var = (listWindow->fillValue << 12) | (listWindow->tileOffset + 1);
    else
        var = (listWindow->fillValue << 12) | (listWindow->tileOffset);

    tilemapBuffer[0] = var;
    tilemapBuffer[0x20] = var;
}

// Print the trainer's name and title at the top of their check page
static void PrintCheckPageTrainerName(struct PokenavListWindowState *state, struct PokenavListMenuWindow *list)
{
    const u8 colors[3] = {TEXT_COLOR_TRANSPARENT, TEXT_COLOR_DARK_GRAY, TEXT_COLOR_LIGHT_RED};

    list->bufferItemFunc(state->listPtr + state->listItemSize * state->windowTopIndex, list->itemTextBuffer);
    list->iconDrawFunc(list->windowId, state->windowTopIndex, list->unkA);
    FillWindowPixelRect(list->windowId, PIXEL_FILL(4), 0, list->unkA * 16, list->width * 8, 16);
    AddTextPrinterParameterized3(list->windowId, list->fontId, 8, (list->unkA * 16) + 1, colors, TEXT_SKIP_DRAW, list->itemTextBuffer);
    SetListMarginTile(list, TRUE);
    CopyWindowRectToVram(list->windowId, COPYWIN_FULL, 0, list->unkA * 2, list->width, 2);
}

// Print the trainer's name and title for the list (to replace the check page name and title, which has a red background)
static void PrintMatchCallListTrainerName(struct PokenavListWindowState *state, struct PokenavListMenuWindow *list)
{
    list->bufferItemFunc(state->listPtr + state->listItemSize * state->windowTopIndex, list->itemTextBuffer);
    FillWindowPixelRect(list->windowId, PIXEL_FILL(1), 0, list->unkA * 16, list->width * 8, 16);
    AddTextPrinterParameterized(list->windowId, list->fontId, list->itemTextBuffer, 8, list->unkA * 16 + 1, TEXT_SKIP_DRAW, NULL);
    SetListMarginTile(list, FALSE);
    CopyWindowToVram(list->windowId, COPYWIN_FULL);
}

static void PrintMatchCallFieldNames(struct PokenavListMenuWindow *list, u32 fieldId)
{
    const u8 *fieldNames[] = {
        gText_PokenavMatchCall_Strategy,
        gText_PokenavMatchCall_TrainerPokemon,
        gText_PokenavMatchCall_SelfIntroduction
    };
    u8 colors[3] = {TEXT_COLOR_WHITE, TEXT_COLOR_RED, TEXT_COLOR_LIGHT_RED};
    u32 top = (list->unkA + 1 + (fieldId * 2)) & 0xF;

    FillWindowPixelRect(list->windowId, PIXEL_FILL(1), 0, top * 16, list->width, 16);
    AddTextPrinterParameterized3(list->windowId, FONT_NARROW, 2, top * 16 + 1, colors, TEXT_SKIP_DRAW, fieldNames[fieldId]);
    CopyWindowRectToVram(list->windowId, COPYWIN_GFX, 0, top * 2, list->width, 2);
}

static void PrintMatchCallFlavorText(struct PokenavListWindowState *windowState, struct PokenavListMenuWindow *list, u32 checkPageEntry)
{
    // lines 1, 3, and 5 are the field names printed by PrintMatchCallFieldNames
    static const u8 lineOffsets[CHECK_PAGE_ENTRY_COUNT] = {
        [CHECK_PAGE_STRATEGY] = 2,
        [CHECK_PAGE_POKEMON]  = 4,
        [CHECK_PAGE_INTRO_1]  = 6,
        [CHECK_PAGE_INTRO_2]  = 7
    };

    u32 r6 = (list->unkA + lineOffsets[checkPageEntry]) & 0xF;
    const u8 *str = GetMatchCallFlavorText(windowState->windowTopIndex, checkPageEntry);

    if (str != NULL)
    {
        FillWindowTilesByRow(list->windowId, 1, r6 * 2, list->width - 1, 2);
        AddTextPrinterParameterized(list->windowId, FONT_NARROW, str, 2, r6 * 16 + 1, TEXT_SKIP_DRAW, NULL);
        CopyWindowRectToVram(list->windowId, COPYWIN_GFX, 0, r6 * 2, list->width, 2);
    }
}

static const struct SpriteSheet sListArrowSpriteSheets[] =
{
    {
        .data = sListArrow_Gfx,
        .size = 0xC0,
        .tag = GFXTAG_ARROW
    }
};

static const struct SpritePalette sListArrowPalettes[] =
{
    {
        .data = sListArrow_Pal,
        .tag = PALTAG_ARROW
    },
    {}
};

static const struct OamData sOamData_RightArrow =
{
    .y = 0,
    .affineMode = ST_OAM_AFFINE_OFF,
    .objMode = ST_OAM_OBJ_NORMAL,
    .bpp = ST_OAM_4BPP,
    .shape = SPRITE_SHAPE(8x16),
    .x = 0,
    .size = SPRITE_SIZE(8x16),
    .tileNum = 0,
    .priority = 2,
    .paletteNum = 0
};

static const struct SpriteTemplate sSpriteTemplate_RightArrow =
{
    .tileTag = GFXTAG_ARROW,
    .paletteTag = PALTAG_ARROW,
    .oam = &sOamData_RightArrow,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = SpriteCB_RightArrow
};

static const struct OamData sOamData_UpDownArrow =
{
    .y = 0,
    .affineMode = ST_OAM_AFFINE_OFF,
    .objMode = ST_OAM_OBJ_NORMAL,
    .bpp = ST_OAM_4BPP,
    .shape = SPRITE_SHAPE(16x8),
    .x = 0,
    .size = SPRITE_SIZE(16x8),
    .tileNum = 0,
    .priority = 2,
    .paletteNum = 0
};

static const struct SpriteTemplate sSpriteTemplate_UpDownArrow =
{
    .tileTag = GFXTAG_ARROW,
    .paletteTag = PALTAG_ARROW,
    .oam = &sOamData_UpDownArrow,
    .anims = gDummySpriteAnimTable,
    .images = NULL,
    .affineAnims = gDummySpriteAffineAnimTable,
    .callback = SpriteCallbackDummy
};

static void LoadListArrowGfx(void)
{
    u32 i;

    for (i = 0; i < ARRAY_COUNT(sListArrowSpriteSheets); i++)
        LoadCompressedSpriteSheet(sListArrowSpriteSheets + i);

    Pokenav_AllocAndLoadPalettes(sListArrowPalettes);
}

static void CreateListArrowSprites(struct PokenavListWindowState *windowState, struct PokenavListMenuWindow *list)
{
    u32 spriteId;
    s16 x;

    spriteId = CreateSprite(&sSpriteTemplate_RightArrow, list->x * 8 + 3, (list->y + 1) * 8, 7);
    list->rightArrow = &gSprites[spriteId];

    x = list->x * 8 + (list->width - 1) * 4;
    spriteId = CreateSprite(&sSpriteTemplate_UpDownArrow, x, list->y * 8 + windowState->entriesOnscreen * 16, 7);
    list->downArrow = &gSprites[spriteId];
    list->downArrow->oam.tileNum += 2;
    list->downArrow->callback = SpriteCB_DownArrow;

    spriteId = CreateSprite(&sSpriteTemplate_UpDownArrow, x, list->y * 8, 7);
    list->upArrow = &gSprites[spriteId];
    list->upArrow->oam.tileNum += 4;
    list->upArrow->callback = SpriteCB_UpArrow;
}

static void DestroyListArrows(struct PokenavListMenuWindow *list)
{
    DestroySprite(list->rightArrow);
    DestroySprite(list->upArrow);
    DestroySprite(list->downArrow);
    FreeSpriteTilesByTag(GFXTAG_ARROW);
    FreeSpritePaletteByTag(PALTAG_ARROW);
}

static void ToggleListArrows(struct PokenavListMenuWindow *list, bool32 invisible)
{
    if (invisible)
    {
        list->rightArrow->callback = SpriteCallbackDummy;
        list->upArrow->callback = SpriteCallbackDummy;
        list->downArrow->callback = SpriteCallbackDummy;
    }
    else
    {
        list->rightArrow->callback = SpriteCB_RightArrow;
        list->upArrow->callback = SpriteCB_UpArrow;
        list->downArrow->callback = SpriteCB_DownArrow;
    }
    list->rightArrow->invisible = invisible;
    list->upArrow->invisible = invisible;
    list->downArrow->invisible = invisible;
}

static void SpriteCB_RightArrow(struct Sprite *sprite)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    sprite->y2 = list->windowState.selectedIndexOffset << 4;
}

#define sTimer data[0]
#define sOffset data[1]
#define sInvisible data[7]

static void SpriteCB_DownArrow(struct Sprite *sprite)
{
    if (!sprite->sInvisible && ShouldShowDownArrow())
        sprite->invisible = FALSE;
    else
        sprite->invisible = TRUE;

    if (++sprite->sTimer > 3)
    {
        sprite->sTimer = 0;
        sprite->sOffset++;
        sprite->sOffset &= 7;
        sprite->y2 = sprite->sOffset;
    }
}

static void SpriteCB_UpArrow(struct Sprite *sprite)
{
    if (!sprite->sInvisible && ShouldShowUpArrow())
        sprite->invisible = FALSE;
    else
        sprite->invisible = TRUE;

    if (++sprite->sTimer > 3)
    {
        sprite->sTimer = 0;
        sprite->sOffset++;
        sprite->sOffset &= 7;
        sprite->y2 = -sprite->sOffset;
    }
}

void PokenavList_ToggleVerticalArrows(bool32 invisible)
{
    struct PokenavList *list = GetSubstructPtr(POKENAV_SUBSTRUCT_LIST);
    list->window.upArrow->sInvisible = invisible;
    list->window.downArrow->sInvisible = invisible;
}

#undef sTimer
#undef sOffset
#undef sInvisible

static void InitPokenavListWindowState(struct PokenavListWindowState *dst, struct PokenavListTemplate *template)
{
    dst->listPtr = template->list;
    dst->windowTopIndex = template->startIndex;
    dst->listLength = template->count;
    dst->listItemSize = template->itemSize;
    dst->entriesOnscreen = template->maxShowed;
    if (dst->entriesOnscreen >= dst->listLength)
    {
        dst->windowTopIndex = 0;
        dst->entriesOffscreen = 0;
        dst->selectedIndexOffset = template->startIndex;
    }
    else
    {
        dst->entriesOffscreen = dst->listLength - dst->entriesOnscreen;
        if (dst->windowTopIndex + dst->entriesOnscreen > dst->listLength)
        {
            dst->selectedIndexOffset = dst->windowTopIndex + dst->entriesOnscreen - dst->listLength;
            dst->windowTopIndex = template->startIndex - dst->selectedIndexOffset;
        }
        else
        {
            dst->selectedIndexOffset = 0;
        }
    }
}

static bool32 CopyPokenavListMenuTemplate(struct PokenavListMenuWindow *dest, const struct BgTemplate *bgTemplate, struct PokenavListTemplate *template, u32 tileOffset)
{
    struct WindowTemplate window;

    dest->bg = bgTemplate->bg;
    dest->tileOffset = tileOffset;
    dest->bufferItemFunc = template->bufferItemFunc;
    dest->iconDrawFunc = template->iconDrawFunc;
    dest->fillValue = template->fillValue;
    dest->x = template->item_X;
    dest->y = template->listTop;
    dest->width = template->windowWidth;
    dest->fontId = template->fontId;

    window.bg = bgTemplate->bg;
    window.tilemapLeft = template->item_X;
    window.tilemapTop = 0;
    window.width = template->windowWidth;
    window.height = 32;
    window.paletteNum = template->fillValue;
    window.baseBlock = tileOffset + 2;

    dest->windowId = AddWindow(&window);
    if (dest->windowId == WINDOW_NONE)
        return FALSE;

    dest->unkA = 0;
    dest->rightArrow = NULL;
    dest->upArrow = NULL;
    dest->downArrow = NULL;
    return 1;
}
