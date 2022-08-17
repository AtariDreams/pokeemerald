#ifndef GUARD_FIELDMAP_H
#define GUARD_FIELDMAP_H

#define NUM_TILES_IN_PRIMARY 512
#define NUM_TILES_TOTAL 1024
#define NUM_METATILES_IN_PRIMARY 512
#define NUM_METATILES_TOTAL 1024
#define NUM_PALS_IN_PRIMARY 6
#define NUM_PALS_TOTAL 13
#define MAX_MAP_DATA_SIZE 10240

// Map coordinates are offset by 7 when using the map
// buffer because it needs to load sufficient border
// metatiles to fill the player's view (the player has
// 7 metatiles of view horizontally in either direction).
#define MAP_OFFSET 7
#define MAP_OFFSET_W (MAP_OFFSET * 2 + 1)
#define MAP_OFFSET_H (MAP_OFFSET * 2)

#include "main.h"

extern struct BackupMapLayout gBackupMapLayout;

#if MODERN
u16 MapGridGetMetatileIdAt(int, int);
u16 MapGridGetMetatileBehaviorAt(int, int);
#else
int MapGridGetMetatileIdAt(int, int);
int MapGridGetMetatileBehaviorAt(int, int);
#endif
void MapGridSetMetatileIdAt(int, int, u16);
void MapGridSetMetatileEntryAt(int, int, u16);

#if !MODERN
void GetCameraCoords(s16*, s16*);
#endif

u8 MapGridIsImpassableAt(int, int);
int GetMapBorderIdAt(int x, int y);
bool32 CanCameraMoveInDirection(int direction);
u16 GetMetatileAttributesById(u16 metatileId);
void GetCameraFocusCoords(s16 *x, s16 *y);
u8 MapGridGetMetatileLayerTypeAt(int x, int y);
u8 MapGridGetElevationAt(int x, int y);
bool8 CameraMove(int deltaX, int deltaY);
void SaveMapView(void);
#if MODERN
void SetCameraFocusCoords(s16 x, s16 y);
#else
void SetCameraFocusCoords(u16 x, u16 y);
#endif
void InitMap(void);
void InitMapFromSavedGame(void);
void InitTrainerHillMap(void);
void InitBattlePyramidMap(bool8 setPlayerPosition);
void CopyMapTilesetsToVram(struct MapLayout const *mapLayout);
void LoadMapTilesetPalettes(struct MapLayout const *mapLayout);
void LoadSecondaryTilesetPalette(struct MapLayout const *mapLayout);
void CopySecondaryTilesetToVramUsingHeap(struct MapLayout const *mapLayout);
void CopyPrimaryTilesetToVram(const struct MapLayout *);
void CopySecondaryTilesetToVram(const struct MapLayout *);
const struct MapHeader *const GetMapHeaderFromConnection(struct MapConnection *connection);
struct MapConnection *GetConnectionAtCoords(s16 x, s16 y);
void MapGridSetMetatileImpassabilityAt(int x, int y, bool32 impassable);

// field_region_map.c
void FieldInitRegionMap(MainCallback callback);

#endif //GUARD_FIELDMAP_H
