#include "global.h"
#include "item.h"
#include "berry.h"
#include "string_util.h"
#include "text.h"
#include "event_data.h"
#include "malloc.h"
#include "secret_base.h"
#include "item_menu.h"
#include "strings.h"
#include "load_save.h"
#include "item_use.h"
#include "battle_pyramid.h"
#include "battle_pyramid_bag.h"
#include "constants/items.h"
#include "constants/hold_effects.h"

static bool8 CheckPyramidBagHasItem(u16 itemId, u16 count);
static bool8 CheckPyramidBagHasSpace(u16 itemId, u16 count);


const struct BagPocket gBagPockets[] =
{
    {gSaveBlock1.bagPocket_Items, BAG_ITEMS_COUNT},
    {gSaveBlock1.bagPocket_PokeBalls, BAG_POKEBALLS_COUNT},
    {gSaveBlock1.bagPocket_TMHM, BAG_TMHM_COUNT},
    {gSaveBlock1.bagPocket_Berries, BAG_BERRIES_COUNT},
    {gSaveBlock1.bagPocket_KeyItems, BAG_KEYITEMS_COUNT},
};

#include "data/text/item_descriptions.h"
#include "data/items.h"


void CopyItemName(u16 itemId, u8 *dst)
{
    StringCopy(dst, ItemId_GetName(itemId));
}

void CopyItemNameHandlePlural(u16 itemId, u8 *dst, u32 quantity)
{
    if (itemId == ITEM_POKE_BALL)
    {
        if (quantity < 2)
            StringCopy(dst, ItemId_GetName(ITEM_POKE_BALL));
        else
            StringCopy(dst, gText_PokeBalls);
    }
    else
    {
        if (itemId >= FIRST_BERRY_INDEX && itemId <= LAST_BERRY_INDEX)
            GetBerryCountString(dst, gBerries[itemId - FIRST_BERRY_INDEX].name, quantity);
        else
            StringCopy(dst, ItemId_GetName(itemId));
    }
}

void GetBerryCountString(u8 *dst, const u8 *berryName, u32 quantity)
{
    const u8 *berryString;
    u8 *txtPtr;

    if (quantity < 2)
        berryString = gText_Berry;
    else
        berryString = gText_Berries;

    txtPtr = StringCopy(dst, berryName);
    *txtPtr = CHAR_SPACE;
    StringCopy(txtPtr + 1, berryString);
}

bool8 IsBagPocketNonEmpty(u8 pocket)
{
    u8 i;

    for (i = 0; i < gBagPockets[pocket - 1].capacity; i++)
    {
        if (gBagPockets[pocket - 1].itemSlots[i].itemId != 0)
            return TRUE;
    }
    return FALSE;
}

bool8 CheckBagHasItem(u16 itemId, u16 count)
{
    u8 i;
    u8 pocket;

    if (ItemId_GetPocket(itemId) == 0)
        return FALSE;
    if (InBattlePyramid() || FlagGet(FLAG_STORING_ITEMS_IN_PYRAMID_BAG) == TRUE)
        return CheckPyramidBagHasItem(itemId, count);
    pocket = ItemId_GetPocket(itemId) - 1;
    // Check for item slots that contain the item
    for (i = 0; i < gBagPockets[pocket].capacity; i++)
    {
        if (gBagPockets[pocket].itemSlots[i].itemId == itemId)
        {
            u16 quantity;
            // Does this item slot contain enough of the item?
            quantity = gBagPockets[pocket].itemSlots[i].quantity;
            if (quantity >= count)
                return TRUE;
            count -= quantity;
            // Does this item slot and all previous slots contain enough of the item?
            if (count == 0)
                return TRUE;
        }
    }
    return FALSE;
}

bool8 HasAtLeastOneBerry(void)
{
    u16 i;

    for (i = FIRST_BERRY_INDEX; i < ITEM_BRIGHT_POWDER; i++)
    {
        if (CheckBagHasItem(i, 1) == TRUE)
        {
            gSpecialVar_Result = TRUE;
            return TRUE;
        }
    }
    gSpecialVar_Result = FALSE;
    return FALSE;
}

bool8 CheckBagHasSpace(u16 itemId, u16 count)
{
    u8 i;
    u8 pocket;
    u16 slotCapacity;
    u16 ownedCount;

    if (ItemId_GetPocket(itemId) == POCKET_NONE)
        return FALSE;

    if (InBattlePyramid() || FlagGet(FLAG_STORING_ITEMS_IN_PYRAMID_BAG) == TRUE)
    {
        return CheckPyramidBagHasSpace(itemId, count);
    }

    pocket = ItemId_GetPocket(itemId) - 1;
    if (pocket != BERRIES_POCKET)
        slotCapacity = MAX_BAG_ITEM_CAPACITY;
    else
        slotCapacity = MAX_BERRY_CAPACITY;

    // Check space in any existing item slots that already contain this item
    for (i = 0; i < gBagPockets[pocket].capacity; i++)
    {
        if (gBagPockets[pocket].itemSlots[i].itemId == itemId)
        {
            ownedCount = gBagPockets[pocket].itemSlots[i].quantity;
            if (ownedCount + count <= slotCapacity)
                return TRUE;
            if (pocket == TMHM_POCKET || pocket == BERRIES_POCKET)
                return FALSE;
            count -= (slotCapacity - ownedCount);
            if (count == 0)
                return TRUE;
        }
    }

    // Check space in empty item slots
    if (count > 0)
    {
        for (i = 0; i < gBagPockets[pocket].capacity; i++)
        {
            if (gBagPockets[pocket].itemSlots[i].itemId == 0)
            {
                if (count > slotCapacity)
                {
                    if (pocket == TMHM_POCKET || pocket == BERRIES_POCKET)
                        return FALSE;
                    count -= slotCapacity;
                }
                else
                {
                    count = 0; //should be return TRUE, but that doesn't match
                    break;
                }
            }
        }
        if (count > 0)
            return FALSE; // No more item slots. The bag is full
    }

    return TRUE;
}

bool8 AddBagItem(u16 itemId, u16 count)
{
    u8 i;

    if (ItemId_GetPocket(itemId) == POCKET_NONE)
        return FALSE;

    // check Battle Pyramid Bag
    if (InBattlePyramid() || FlagGet(FLAG_STORING_ITEMS_IN_PYRAMID_BAG) == TRUE)
    {
        return AddPyramidBagItem(itemId, count);
    }
    else
    {
        const struct BagPocket *itemPocket;
        struct ItemSlot *newItems;
        u16 slotCapacity;
        u16 ownedCount;
        u8 pocket = ItemId_GetPocket(itemId) - 1;

        itemPocket = &gBagPockets[pocket];
        newItems = Alloc(itemPocket->capacity * sizeof(struct ItemSlot));
        memcpy(newItems, itemPocket->itemSlots, itemPocket->capacity * sizeof(struct ItemSlot));

        if (pocket != BERRIES_POCKET)
            slotCapacity = MAX_BAG_ITEM_CAPACITY;
        else
            slotCapacity = MAX_BERRY_CAPACITY;

        for (i = 0; i < itemPocket->capacity; i++)
        {
            if (newItems[i].itemId == itemId)
            {
                ownedCount = newItems[i].quantity;
                // check if won't exceed max slot capacity
                if (ownedCount + count <= slotCapacity)
                {
                    // successfully added to already existing item's count
                    newItems[i].quantity = ownedCount + count;
                    memcpy(itemPocket->itemSlots, newItems, itemPocket->capacity * sizeof(struct ItemSlot));
                    Free(newItems);
                    return TRUE;
                }
                else
                {
                    // try creating another instance of the item if possible
                    if (pocket == TMHM_POCKET || pocket == BERRIES_POCKET)
                    {
                        Free(newItems);
                        return FALSE;
                    }
                    else
                    {
                        count -= slotCapacity - ownedCount;
                        newItems[i].quantity = slotCapacity;
                        // don't create another instance of the item if it's at max slot capacity and count is equal to 0
                        if (count == 0)
                        {
                            break;
                        }
                    }
                }
            }
        }

        // we're done if quantity is equal to 0
        if (count > 0)
        {
            // either no existing item was found or we have to create another instance, because the capacity was exceeded
            for (i = 0; i < itemPocket->capacity; i++)
            {
                if (newItems[i].itemId == ITEM_NONE)
                {
                    newItems[i].itemId = itemId;
                    if (count > slotCapacity)
                    {
                        // try creating a new slot with max capacity if duplicates are possible
                        if (pocket == TMHM_POCKET || pocket == BERRIES_POCKET)
                        {
                            Free(newItems);
                            return FALSE;
                        }
                        count -= slotCapacity;
                        newItems[i].quantity = slotCapacity;
                    }
                    else
                    {
                        // created a new slot and added quantity
                        newItems[i].quantity = count;
                        count = 0;
                        break;
                    }
                }
            }

            if (count > 0)
            {
                Free(newItems);
                return FALSE;
            }
        }
        memcpy(itemPocket->itemSlots, newItems, itemPocket->capacity * sizeof(struct ItemSlot));
        Free(newItems);
        return TRUE;
    }
}

bool8 RemoveBagItem(u16 itemId, u16 count)
{
    u8 i;
    u16 totalQuantity = 0;

    if (ItemId_GetPocket(itemId) == POCKET_NONE || itemId == ITEM_NONE)
        return FALSE;

    // check Battle Pyramid Bag
    if (InBattlePyramid() || FlagGet(FLAG_STORING_ITEMS_IN_PYRAMID_BAG) == TRUE)
    {
        return RemovePyramidBagItem(itemId, count);
    }
    else
    {
        u8 pocket;
        u8 var;
        u16 ownedCount;
        const struct BagPocket *itemPocket;

        pocket = ItemId_GetPocket(itemId) - 1;
        itemPocket = &gBagPockets[pocket];

        for (i = 0; i < itemPocket->capacity; i++)
        {
            if (itemPocket->itemSlots[i].itemId == itemId)
                totalQuantity += itemPocket->itemSlots[i].quantity;
        }

        if (totalQuantity < count)
            return FALSE;   // We don't have enough of the item

        if (CurMapIsSecretBase() == TRUE)
        {
            VarSet(VAR_SECRET_BASE_LOW_TV_FLAGS, VarGet(VAR_SECRET_BASE_LOW_TV_FLAGS) | SECRET_BASE_USED_BAG);
            VarSet(VAR_SECRET_BASE_LAST_ITEM_USED, itemId);
        }

        var = GetItemListPosition(pocket);
        if (itemPocket->capacity > var
         && itemPocket->itemSlots[var].itemId == itemId)
        {
            ownedCount = itemPocket->itemSlots[var].quantity;
            if (ownedCount >= count)
            {
                itemPocket->itemSlots[var].quantity = ownedCount - count;
                count = 0;
            }
            else
            {
                count -= ownedCount;
                itemPocket->itemSlots[var].quantity = 0;
            }

            if (itemPocket->itemSlots[var].quantity == 0)
                itemPocket->itemSlots[var].itemId = ITEM_NONE;

            if (count == 0)
                return TRUE;
        }

        for (i = 0; i < itemPocket->capacity; i++)
        {
            if (itemPocket->itemSlots[i].itemId == itemId)
            {
                ownedCount = itemPocket->itemSlots[i].quantity;
                if (ownedCount >= count)
                {
                    itemPocket->itemSlots[i].quantity = ownedCount - count;
                    count = 0;
                }
                else
                {
                    count -= ownedCount;
                    itemPocket->itemSlots[i].quantity = 0;
                }

                if (itemPocket->itemSlots[i].quantity == 0)
                    itemPocket->itemSlots[i].itemId = ITEM_NONE;

                if (count == 0)
                    return TRUE;
            }
        }
        return TRUE;
    }
}

u8 GetPocketByItemId(u16 itemId)
{
    return ItemId_GetPocket(itemId);
}

void ClearItemSlots(struct ItemSlot *itemSlots, u8 itemCount)
{
    u16 i;

    for (i = 0; i < itemCount; i++)
    {
        itemSlots[i].itemId = ITEM_NONE;
        itemSlots[i].quantity = 0;
    }
}

static s32 FindFreePCItemSlot(void)
{
    s8 i;

    for (i = 0; i < PC_ITEMS_COUNT; i++)
    {
        if (gSaveBlock1.pcItems[i].itemId == ITEM_NONE)
            return i;
    }
    return -1;
}

u8 CountUsedPCItemSlots(void)
{
    u8 usedSlots = 0;
    u8 i;

    for (i = 0; i < PC_ITEMS_COUNT; i++)
    {
        if (gSaveBlock1.pcItems[i].itemId != ITEM_NONE)
            usedSlots++;
    }
    return usedSlots;
}

bool8 CheckPCHasItem(u16 itemId, u16 count)
{
    u8 i;

    for (i = 0; i < PC_ITEMS_COUNT; i++)
    {
        if (gSaveBlock1.pcItems[i].itemId == itemId && gSaveBlock1.pcItems[i].quantity >= count)
            return TRUE;
    }
    return FALSE;
}

bool8 AddPCItem(u16 itemId, u16 count)
{
    u8 i;
    s8 freeSlot;
    u16 ownedCount;
    struct ItemSlot *newItems;

    // Copy PC items
    newItems = Alloc(sizeof(gSaveBlock1.pcItems));
    memcpy(newItems, gSaveBlock1.pcItems, sizeof(gSaveBlock1.pcItems));

    // Use any item slots that already contain this item
    for (i = 0; i < PC_ITEMS_COUNT; i++)
    {
        if (newItems[i].itemId == itemId)
        {
            ownedCount = newItems[i].quantity;
            if (ownedCount + count <= MAX_PC_ITEM_CAPACITY)
            {
                newItems[i].quantity = ownedCount + count;
                memcpy(gSaveBlock1.pcItems, newItems, sizeof(gSaveBlock1.pcItems));
                Free(newItems);
                return TRUE;
            }
            count += ownedCount - MAX_PC_ITEM_CAPACITY;
            newItems[i].quantity = MAX_PC_ITEM_CAPACITY;
            if (count == 0)
            {
                memcpy(gSaveBlock1.pcItems, newItems, sizeof(gSaveBlock1.pcItems));
                Free(newItems);
                return TRUE;
            }
        }
    }

    // Put any remaining items into a new item slot.
    if (count > 0)
    {
        freeSlot = FindFreePCItemSlot();
        if (freeSlot == -1)
        {
            Free(newItems);
            return FALSE;
        }
        else
        {
            newItems[freeSlot].itemId = itemId;
            newItems[freeSlot].quantity = count;
        }
    }

    // Copy items back to the PC
    memcpy(gSaveBlock1.pcItems, newItems, sizeof(gSaveBlock1.pcItems));
    Free(newItems);
    return TRUE;
}

void RemovePCItem(u8 index, u16 count)
{
    gSaveBlock1.pcItems[index].quantity -= count;
    if (gSaveBlock1.pcItems[index].quantity == 0)
    {
        gSaveBlock1.pcItems[index].itemId = ITEM_NONE;
        CompactPCItems();
    }
}

void CompactPCItems(void)
{
    u16 i;
    u16 j;

    for (i = 0; i < PC_ITEMS_COUNT - 1; i++)
    {
        for (j = i + 1; j < PC_ITEMS_COUNT; j++)
        {
            if (gSaveBlock1.pcItems[i].itemId == 0)
            {
                struct ItemSlot temp = gSaveBlock1.pcItems[i];
                gSaveBlock1.pcItems[i] = gSaveBlock1.pcItems[j];
                gSaveBlock1.pcItems[j] = temp;
            }
        }
    }
}

void SwapRegisteredBike(void)
{
    switch (gSaveBlock1.registeredItem)
    {
    case ITEM_MACH_BIKE:
        gSaveBlock1.registeredItem = ITEM_ACRO_BIKE;
        break;
    case ITEM_ACRO_BIKE:
        gSaveBlock1.registeredItem = ITEM_MACH_BIKE;
        break;
    }
}

u16 BagGetItemIdByPocketPosition(u8 pocketId, u16 pocketPos)
{
    return gBagPockets[pocketId - 1].itemSlots[pocketPos].itemId;
}

u16 BagGetQuantityByPocketPosition(u8 pocketId, u16 pocketPos)
{
    return gBagPockets[pocketId - 1].itemSlots[pocketPos].quantity;
}

static void SwapItemSlots(struct ItemSlot *a, struct ItemSlot *b)
{
    struct ItemSlot temp;
    SWAP(*a, *b, temp);
}

void CompactItemsInBagPocket(const struct BagPocket *bagPocket)
{
    u16 i, j;

    for (i = 0; i < bagPocket->capacity - 1; i++)
    {
        for (j = i + 1; j < bagPocket->capacity; j++)
        {
            if (bagPocket->itemSlots[i].quantity == 0)
                SwapItemSlots(&bagPocket->itemSlots[i], &bagPocket->itemSlots[j]);
        }
    }
}

void SortBerriesOrTMHMs(const struct BagPocket *bagPocket)
{
    u16 i, j;

    for (i = 0; i < bagPocket->capacity - 1; i++)
    {
        for (j = i + 1; j < bagPocket->capacity; j++)
        {
            if (bagPocket->itemSlots[i].quantity != 0)
            {
                if (bagPocket->itemSlots[j].quantity == 0)
                    continue;
                if (bagPocket->itemSlots[i].itemId <= bagPocket->itemSlots[j].itemId)
                    continue;
            }
            SwapItemSlots(&bagPocket->itemSlots[i], &bagPocket->itemSlots[j]);
        }
    }
}

void MoveItemSlotInList(struct ItemSlot* itemSlots_, u32 from, u32 to)
{
    // dumb assignments needed to match

    if (from != to)
    {
        struct ItemSlot firstSlot = itemSlots_[from];
        u32 size = (to > from) ? to - from : from - to;
        memmove(&itemSlots_[to], &itemSlots_[from], size * sizeof(struct ItemSlot));

        itemSlots_[to] = firstSlot;
    }
}

void ClearBag(void)
{
    u32 i;

    for (i = 0; i < POCKETS_COUNT; i++)
    {
        ClearItemSlots(gBagPockets[i].itemSlots, gBagPockets[i].capacity);
    }
}

u16 CountTotalItemQuantityInBag(u16 itemId)
{
    u16 i;
    u16 ownedCount = 0;
    const struct BagPocket *bagPocket = &gBagPockets[ItemId_GetPocket(itemId) - 1];

    for (i = 0; i < bagPocket->capacity; i++)
    {
        if (bagPocket->itemSlots[i].itemId == itemId)
            ownedCount += bagPocket->itemSlots[i].quantity;
    }

    return ownedCount;
}

static bool8 CheckPyramidBagHasItem(u16 itemId, u16 count)
{
    u8 i;
    u16 *items = gSaveBlock2.frontier.pyramidBag.itemId[gSaveBlock2.frontier.lvlMode];
    u8 *quantities = gSaveBlock2.frontier.pyramidBag.quantity[gSaveBlock2.frontier.lvlMode];

    for (i = 0; i < PYRAMID_BAG_ITEMS_COUNT; i++)
    {
        if (items[i] == itemId)
        {
            if (quantities[i] >= count)
                return TRUE;

            count -= quantities[i];
            if (count == 0)
                return TRUE;
        }
    }

    return FALSE;
}

static bool8 CheckPyramidBagHasSpace(u16 itemId, u16 count)
{
    u8 i;
    u16 *items = gSaveBlock2.frontier.pyramidBag.itemId[gSaveBlock2.frontier.lvlMode];
    u8 *quantities = gSaveBlock2.frontier.pyramidBag.quantity[gSaveBlock2.frontier.lvlMode];

    for (i = 0; i < PYRAMID_BAG_ITEMS_COUNT; i++)
    {
        if (items[i] == itemId || items[i] == ITEM_NONE)
        {
            if (quantities[i] + count <= MAX_BAG_ITEM_CAPACITY)
                return TRUE;

            count = (quantities[i] + count) - MAX_BAG_ITEM_CAPACITY;
            if (count == 0)
                return TRUE;
        }
    }

    return FALSE;
}

bool8 AddPyramidBagItem(u16 itemId, u16 count)
{
    u16 i;

    u16 *items = gSaveBlock2.frontier.pyramidBag.itemId[gSaveBlock2.frontier.lvlMode];
    u8 *quantities = gSaveBlock2.frontier.pyramidBag.quantity[gSaveBlock2.frontier.lvlMode];

    u16 *newItems = Alloc(PYRAMID_BAG_ITEMS_COUNT * sizeof(*newItems));
    u8 *newQuantities = Alloc(PYRAMID_BAG_ITEMS_COUNT * sizeof(*newQuantities));

    memcpy(newItems, items, PYRAMID_BAG_ITEMS_COUNT * sizeof(*newItems));
    memcpy(newQuantities, quantities, PYRAMID_BAG_ITEMS_COUNT * sizeof(*newQuantities));

    for (i = 0; i < PYRAMID_BAG_ITEMS_COUNT; i++)
    {
        if (newItems[i] == itemId && newQuantities[i] < MAX_BAG_ITEM_CAPACITY)
        {
            newQuantities[i] += count;
            if (newQuantities[i] > MAX_BAG_ITEM_CAPACITY)
            {
                count = newQuantities[i] - MAX_BAG_ITEM_CAPACITY;
                newQuantities[i] = MAX_BAG_ITEM_CAPACITY;
            }
            else
            {
                count = 0;
            }

            if (count == 0)
                break;
        }
    }

    if (count > 0)
    {
        for (i = 0; i < PYRAMID_BAG_ITEMS_COUNT; i++)
        {
            if (newItems[i] == ITEM_NONE)
            {
                newItems[i] = itemId;
                newQuantities[i] = count;
                if (newQuantities[i] > MAX_BAG_ITEM_CAPACITY)
                {
                    count = newQuantities[i] - MAX_BAG_ITEM_CAPACITY;
                    newQuantities[i] = MAX_BAG_ITEM_CAPACITY;
                }
                else
                {
                    count = 0;
                }

                if (count == 0)
                    break;
            }
        }
    }

    if (count == 0)
    {
        memcpy(items, newItems, PYRAMID_BAG_ITEMS_COUNT * sizeof(*items));
        memcpy(quantities, newQuantities, PYRAMID_BAG_ITEMS_COUNT * sizeof(*quantities));
        Free(newItems);
        Free(newQuantities);
        return TRUE;
    }
    else
    {
        Free(newItems);
        Free(newQuantities);
        return FALSE;
    }
}

bool8 RemovePyramidBagItem(u16 itemId, u16 count)
{
    u16 i;

    u16 *items = gSaveBlock2.frontier.pyramidBag.itemId[gSaveBlock2.frontier.lvlMode];
    u8 *quantities = gSaveBlock2.frontier.pyramidBag.quantity[gSaveBlock2.frontier.lvlMode];

    i = gPyramidBagMenuState.cursorPosition + gPyramidBagMenuState.scrollPosition;
    if (items[i] == itemId && quantities[i] >= count)
    {
        quantities[i] -= count;
        if (quantities[i] == 0)
            items[i] = ITEM_NONE;
        return TRUE;
    }
    else
    {
        u16 *newItems = Alloc(PYRAMID_BAG_ITEMS_COUNT * sizeof(*newItems));
        u8 *newQuantities = Alloc(PYRAMID_BAG_ITEMS_COUNT * sizeof(*newQuantities));

        memcpy(newItems, items, PYRAMID_BAG_ITEMS_COUNT * sizeof(*newItems));
        memcpy(newQuantities, quantities, PYRAMID_BAG_ITEMS_COUNT * sizeof(*newQuantities));

        for (i = 0; i < PYRAMID_BAG_ITEMS_COUNT; i++)
        {
            if (newItems[i] == itemId)
            {
                if (newQuantities[i] >= count)
                {
                    newQuantities[i] -= count;
                    count = 0;
                    if (newQuantities[i] == 0)
                        newItems[i] = ITEM_NONE;
                }
                else
                {
                    count -= newQuantities[i];
                    newQuantities[i] = 0;
                    newItems[i] = ITEM_NONE;
                }

                if (count == 0)
                    break;
            }
        }

        if (count == 0)
        {
            memcpy(items, newItems, PYRAMID_BAG_ITEMS_COUNT * sizeof(*items));
            memcpy(quantities, newQuantities, PYRAMID_BAG_ITEMS_COUNT * sizeof(*quantities));
            Free(newItems);
            Free(newQuantities);
            return TRUE;
        }
        else
        {
            Free(newItems);
            Free(newQuantities);
            return FALSE;
        }
    }
}

static u16 SanitizeItemId(u16 itemId)
{
    if (itemId >= ITEMS_COUNT)
        return ITEM_NONE;
    else
        return itemId;
}

const u8 *ItemId_GetName(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].name;
}

// Unused
u16 ItemId_GetId(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].itemId;
}

u16 ItemId_GetPrice(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].price;
}

u8 ItemId_GetHoldEffect(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].holdEffect;
}

u8 ItemId_GetHoldEffectParam(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].holdEffectParam;
}

const u8 *ItemId_GetDescription(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].description;
}

u8 ItemId_GetImportance(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].importance;
}

// Unused
u8 ItemId_GetRegistrability(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].registrability;
}

u8 ItemId_GetPocket(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].pocket;
}

u8 ItemId_GetType(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].type;
}

ItemUseFunc ItemId_GetFieldFunc(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].fieldUseFunc;
}

u8 ItemId_GetBattleUsage(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].battleUsage;
}

ItemUseFunc ItemId_GetBattleFunc(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].battleUseFunc;
}

u8 ItemId_GetSecondaryId(u16 itemId)
{
    return gItems[SanitizeItemId(itemId)].secondaryId;
}
