#include "global.h"
#include "malloc.h"
#include "berry_powder.h"
#include "item.h"
#include "load_save.h"
#include "main.h"
#include "overworld.h"
#include "pokemon.h"
#include "pokemon_storage_system.h"
#include "random.h"
#include "save_location.h"
#include "trainer_hill.h"
#include "gba/flash_internal.h"
#include "decoration_inventory.h"
#include "agb_flash.h"

#define SAVEBLOCK_MOVE_RANGE    128

struct LoadedSaveData
{
 /*0x0000*/ struct ItemSlot items[BAG_ITEMS_COUNT];
 /*0x0078*/ struct ItemSlot keyItems[BAG_KEYITEMS_COUNT];
 /*0x00F0*/ struct ItemSlot pokeBalls[BAG_POKEBALLS_COUNT];
 /*0x0130*/ struct ItemSlot TMsHMs[BAG_TMHM_COUNT];
 /*0x0230*/ struct ItemSlot berries[BAG_BERRIES_COUNT];
 /*0x02E8*/ struct Mail mail[MAIL_COUNT];
};

// EWRAM DATA

EWRAM_DATA struct SaveBlock1 gSaveBlock1;
EWRAM_DATA struct SaveBlock2 gSaveBlock2;
EWRAM_DATA struct PokemonStorage gPokemonStorage;

EWRAM_DATA struct LoadedSaveData gLoadedSaveData = {0};

// IWRAM common
bool32 gFlashMemoryPresent;

// code
void CheckForFlashMemory(void)
{
    if (!IdentifyFlash())
    {
        gFlashMemoryPresent = TRUE;
        InitFlashTimer();
    }
    else
    {
        gFlashMemoryPresent = FALSE;
    }
}

void ClearSav2(void)
{
    CpuFill16(0, &gSaveBlock2, sizeof(struct SaveBlock2));
}

void ClearSav1(void)
{
    CpuFill16(0, &gSaveBlock1, sizeof(struct SaveBlock1));
}

// Offset is the sum of the trainer id bytes

u32 UseContinueGameWarp(void)
{
    return gSaveBlock2.specialSaveWarpFlags & CONTINUE_GAME_WARP;
}

void ClearContinueGameWarpStatus(void)
{
    gSaveBlock2.specialSaveWarpFlags &= ~CONTINUE_GAME_WARP;
}

void SetContinueGameWarpStatus(void)
{
    gSaveBlock2.specialSaveWarpFlags |= CONTINUE_GAME_WARP;
}

void SetContinueGameWarpStatusToDynamicWarp(void)
{
    SetContinueGameWarpToDynamicWarp(0);
    gSaveBlock2.specialSaveWarpFlags |= CONTINUE_GAME_WARP;
}

void ClearContinueGameWarpStatus2(void)
{
    gSaveBlock2.specialSaveWarpFlags &= ~CONTINUE_GAME_WARP;
}

void SavePlayerParty(void)
{
    unsigned int i;

    gSaveBlock1.playerPartyCount = gPlayerPartyCount;

    for (i = 0; i < PARTY_SIZE; i++)
        gSaveBlock1.playerParty[i] = gPlayerParty[i];
}

void LoadPlayerParty(void)
{
    unsigned int i;

    gPlayerPartyCount = gSaveBlock1.playerPartyCount;

    for (i = 0; i < PARTY_SIZE; i++)
        gPlayerParty[i] = gSaveBlock1.playerParty[i];
}

void SaveObjectEvents(void)
{
    unsigned int i;

    for (i = 0; i < OBJECT_EVENTS_COUNT; i++)
        gSaveBlock1.objectEvents[i] = gObjectEvents[i];
}

void LoadObjectEvents(void)
{
    unsigned int i;

    for (i = 0; i < OBJECT_EVENTS_COUNT; i++)
        gObjectEvents[i] = gSaveBlock1.objectEvents[i];
}

void CopyPartyAndObjectsToSave(void)
{
    SavePlayerParty();
    SaveObjectEvents();
}

void CopyPartyAndObjectsFromSave(void)
{
    LoadPlayerParty();
    LoadObjectEvents();
}

void LoadPlayerBag(void)
{
    unsigned int i;

    // load player items.
    for (i = 0; i < BAG_ITEMS_COUNT; i++)
        gLoadedSaveData.items[i] = gSaveBlock1.bagPocket_Items[i];

    // load player key items.
    for (i = 0; i < BAG_KEYITEMS_COUNT; i++)
        gLoadedSaveData.keyItems[i] = gSaveBlock1.bagPocket_KeyItems[i];

    // load player pokeballs.
    for (i = 0; i < BAG_POKEBALLS_COUNT; i++)
        gLoadedSaveData.pokeBalls[i] = gSaveBlock1.bagPocket_PokeBalls[i];

    // load player TMs and HMs.
    for (i = 0; i < BAG_TMHM_COUNT; i++)
        gLoadedSaveData.TMsHMs[i] = gSaveBlock1.bagPocket_TMHM[i];

    // load player berries.
    for (i = 0; i < BAG_BERRIES_COUNT; i++)
        gLoadedSaveData.berries[i] = gSaveBlock1.bagPocket_Berries[i];

    // load mail.
    for (i = 0; i < MAIL_COUNT; i++)
        gLoadedSaveData.mail[i] = gSaveBlock1.mail[i];
}

void SavePlayerBag(void)
{
    unsigned int i;
    // save player items.
    for (i = 0; i < BAG_ITEMS_COUNT; i++)
        gSaveBlock1.bagPocket_Items[i] = gLoadedSaveData.items[i];

    // save player key items.
    for (i = 0; i < BAG_KEYITEMS_COUNT; i++)
        gSaveBlock1.bagPocket_KeyItems[i] = gLoadedSaveData.keyItems[i];

    // save player pokeballs.
    for (i = 0; i < BAG_POKEBALLS_COUNT; i++)
        gSaveBlock1.bagPocket_PokeBalls[i] = gLoadedSaveData.pokeBalls[i];

    // save player TMs and HMs.
    for (i = 0; i < BAG_TMHM_COUNT; i++)
        gSaveBlock1.bagPocket_TMHM[i] = gLoadedSaveData.TMsHMs[i];

    // save player berries.
    for (i = 0; i < BAG_BERRIES_COUNT; i++)
        gSaveBlock1.bagPocket_Berries[i] = gLoadedSaveData.berries[i];

    // save mail.
    for (i = 0; i < MAIL_COUNT; i++)
        gSaveBlock1.mail[i] = gLoadedSaveData.mail[i];
}