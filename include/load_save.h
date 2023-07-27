#ifndef GUARD_LOAD_SAVE_H
#define GUARD_LOAD_SAVE_H

#include "pokemon_storage_system.h"

#define SAVEBLOCK_MOVE_RANGE    128

/**
 * These structs are to prevent them from being reordered on newer or modern
 * toolchains. If this is not done, the ClearSav functions will end up erasing
 * the wrong memory leading to various glitches.
 */

extern EWRAM_DATA struct SaveBlock1 gSaveBlock1;
extern EWRAM_DATA struct SaveBlock2 gSaveBlock2;
extern EWRAM_DATA struct PokemonStorage gPokemonStorage;

extern bool32 gFlashMemoryPresent;

void CheckForFlashMemory(void);
void ClearSav2(void);
void ClearSav1(void);
void SetSaveBlocksPointers(u16 offset);
void MoveSaveBlocks_ResetHeap(void);
u32 UseContinueGameWarp(void);
void ClearContinueGameWarpStatus(void);
void SetContinueGameWarpStatus(void);
void SetContinueGameWarpStatusToDynamicWarp(void);
void ClearContinueGameWarpStatus2(void);
void SavePlayerParty(void);
void LoadPlayerParty(void);
void SaveObjectEvents(void);
void LoadObjectEvents(void);
void CopyPartyAndObjectsToSave(void);
void CopyPartyAndObjectsFromSave(void);
void LoadPlayerBag(void);
void SavePlayerBag(void);
void ApplyNewEncryptionKeyToHword(u16 *hWord, u32 newKey);
void ApplyNewEncryptionKeyToWord(u32 *word, u32 newKey);

#endif // GUARD_LOAD_SAVE_H
