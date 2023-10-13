#include "global.h"
#include "event_object_movement.h"
#include "fieldmap.h"
#include "malloc.h"
#include "rotating_tile_puzzle.h"
#include "script_movement.h"
#include "constants/event_object_movement.h"
#include "constants/event_objects.h"
#include "constants/metatile_labels.h"

#define ROTATE_COUNTERCLOCKWISE 0
#define ROTATE_CLOCKWISE        1
#define ROTATE_NONE             2

struct RotatingTileObject
{
    u8 prevPuzzleTileNum;
    u8 eventTemplateId;
};

struct RotatingTilePuzzle
{
    struct RotatingTileObject objects[OBJECT_EVENTS_COUNT];
    u8 numObjects;
    bool8 isTrickHouse;
};

static const u8 sMovement_ShiftRight[] =
{
    MOVEMENT_ACTION_LOCK_ANIM,
    MOVEMENT_ACTION_WALK_NORMAL_RIGHT,
    MOVEMENT_ACTION_UNLOCK_ANIM,
    MOVEMENT_ACTION_STEP_END
};

static const u8 sMovement_ShiftDown[] =
{
    MOVEMENT_ACTION_LOCK_ANIM,
    MOVEMENT_ACTION_WALK_NORMAL_DOWN,
    MOVEMENT_ACTION_UNLOCK_ANIM,
    MOVEMENT_ACTION_STEP_END
};

static const u8 sMovement_ShiftLeft[] =
{
    MOVEMENT_ACTION_LOCK_ANIM,
    MOVEMENT_ACTION_WALK_NORMAL_LEFT,
    MOVEMENT_ACTION_UNLOCK_ANIM,
    MOVEMENT_ACTION_STEP_END
};

static const u8 sMovement_ShiftUp[] =
{
    MOVEMENT_ACTION_LOCK_ANIM,
    MOVEMENT_ACTION_WALK_NORMAL_UP,
    MOVEMENT_ACTION_UNLOCK_ANIM,
    MOVEMENT_ACTION_STEP_END
};

static const u8 sMovement_FaceRight[] =
{
    MOVEMENT_ACTION_FACE_RIGHT,
    MOVEMENT_ACTION_STEP_END
};

static const u8 sMovement_FaceDown[] =
{
    MOVEMENT_ACTION_FACE_DOWN,
    MOVEMENT_ACTION_STEP_END
};

static const u8 sMovement_FaceLeft[] =
{
    MOVEMENT_ACTION_FACE_LEFT,
    MOVEMENT_ACTION_STEP_END
};

static const u8 sMovement_FaceUp[] =
{
    MOVEMENT_ACTION_FACE_UP,
    MOVEMENT_ACTION_STEP_END
};

static void SaveRotatingTileObject(u8, u8);
static void TurnUnsavedRotatingTileObject(u8, u8);

EWRAM_DATA static struct RotatingTilePuzzle *sRotatingTilePuzzle = NULL;

void InitRotatingTilePuzzle(bool8 isTrickHouse)
{
    if (sRotatingTilePuzzle == NULL)
        sRotatingTilePuzzle = AllocZeroed(sizeof(*sRotatingTilePuzzle));

    sRotatingTilePuzzle->isTrickHouse = isTrickHouse;
}

void FreeRotatingTilePuzzle(void)
{
    u32 id;

    TRY_FREE_AND_SET_NULL(sRotatingTilePuzzle);

    id = GetObjectEventIdByLocalIdAndMap(OBJ_EVENT_ID_PLAYER, 0, 0);
    ObjectEventClearHeldMovementIfFinished(&gObjectEvents[id]);
    ScriptMovement_UnfreezeObjectEvents();
}

u16 MoveRotatingTileObjects(u8 puzzleNumber)
{
    u8 i;
    struct ObjectEventTemplate *objectEvents = gSaveBlock1.objectEventTemplates;
    u16 localId = 0;
    u16 puzzleTileStart;
    u32 switch_num;

    for (i = 0; i < OBJECT_EVENT_TEMPLATES_COUNT; i++)
    {
        u8 puzzleTileNum;
        s16 x = objectEvents[i].x + MAP_OFFSET;
        s16 y = objectEvents[i].y + MAP_OFFSET;
        u16 metatile = MapGridGetMetatileIdAt(x, y);

        if (!sRotatingTilePuzzle->isTrickHouse)
            puzzleTileStart = METATILE_MossdeepGym_YellowArrow_Right;
        else
            puzzleTileStart = METATILE_TrickHousePuzzle_Arrow_YellowOnWhite_Right;

        // Object is on a metatile before the puzzle tile section
        // UB: Because this is not if (metatile < puzzleTileStart), for the trick house (metatile - puzzleTileStart) below can result in casting a negative value to u8
        if (metatile < puzzleTileStart)
            continue;

        switch_num = metatile - puzzleTileStart / METATILE_ROW_WIDTH;

        // Object is on a metatile after the puzzle tile section (never occurs, in both cases the puzzle tiles are last)
        if (switch_num >= 5)
            continue;

        // Object is on a metatile in puzzle tile section, but not one of the currently rotating color
        if (switch_num != puzzleNumber)
            continue;

        puzzleTileNum = (metatile - puzzleTileStart) % METATILE_ROW_WIDTH;

        // First 4 puzzle tiles are the colored arrows

        if (puzzleTileNum > 3)
            continue;

        s8 x2 = 0;
        s8 y2 = 0;
        const u8 *movementScript;

        switch (puzzleTileNum)
        {
        case 0: // Right Arrow
            movementScript = sMovement_ShiftRight;
            x2 = 1;
            break;
        case 1: // Down Arrow
            movementScript = sMovement_ShiftDown;
            y2 = 1;
            break;
        case 2: // Left Arrow
            movementScript = sMovement_ShiftLeft;
            x2 = -1;
            break;
        case 3: // Up Arrow
            movementScript = sMovement_ShiftUp;
            y2 = -1;
            break;
        default:
            continue;
        }

        objectEvents[i].x += x2;
        objectEvents[i].y += y2;
        SaveRotatingTileObject(i, puzzleTileNum);
        localId = objectEvents[i].localId;
        ScriptMovement_StartObjectMovementScript(localId, gSaveBlock1.location.mapNum, gSaveBlock1.location.mapGroup, movementScript);
    }

    return localId;
}

void TurnRotatingTileObjects(void)
{
    u32 i;
    u16 puzzleTileStart;
    struct ObjectEventTemplate *objectEvents;

    if (sRotatingTilePuzzle == NULL)
        return;

    if (!sRotatingTilePuzzle->isTrickHouse)
        puzzleTileStart = METATILE_MossdeepGym_YellowArrow_Right;
    else
        puzzleTileStart = METATILE_TrickHousePuzzle_Arrow_YellowOnWhite_Right;

    objectEvents = gSaveBlock1.objectEventTemplates;
    for (i = 0; i < sRotatingTilePuzzle->numObjects; i++)
    {
        u32 objectEventId;
        objectEventId = GetObjectEventIdByLocalIdAndMap(objectEvents[sRotatingTilePuzzle->objects[i].eventTemplateId].localId, gSaveBlock1.location.mapNum, gSaveBlock1.location.mapGroup);
        if (objectEventId != OBJECT_EVENTS_COUNT)
        {
            const u8 *movementScript;
            u8 direction = gObjectEvents[objectEventId].facingDirection;
            switch (direction)
            {
            case DIR_EAST:
                movementScript = sMovement_FaceUp;
                objectEvents[sRotatingTilePuzzle->objects[i].eventTemplateId].movementType = MOVEMENT_TYPE_FACE_UP;
                break;
            case DIR_SOUTH:
                movementScript = sMovement_FaceRight;
                objectEvents[sRotatingTilePuzzle->objects[i].eventTemplateId].movementType = MOVEMENT_TYPE_FACE_RIGHT;
                break;
            case DIR_WEST:
                movementScript = sMovement_FaceDown;
                objectEvents[sRotatingTilePuzzle->objects[i].eventTemplateId].movementType = MOVEMENT_TYPE_FACE_DOWN;
                break;
            case DIR_NORTH:
                movementScript = sMovement_FaceLeft;
                objectEvents[sRotatingTilePuzzle->objects[i].eventTemplateId].movementType = MOVEMENT_TYPE_FACE_LEFT;
                break;
            default:
                continue;
            }
            ScriptMovement_StartObjectMovementScript(objectEvents[sRotatingTilePuzzle->objects[i].eventTemplateId].localId,
                                                     gSaveBlock1.location.mapNum,
                                                     gSaveBlock1.location.mapGroup,
                                                     movementScript);
        }
    }
}

static void SaveRotatingTileObject(u8 eventTemplateId, u8 puzzleTileNum)
{
    sRotatingTilePuzzle->objects[sRotatingTilePuzzle->numObjects].eventTemplateId = eventTemplateId;
    sRotatingTilePuzzle->objects[sRotatingTilePuzzle->numObjects].prevPuzzleTileNum = puzzleTileNum;
    sRotatingTilePuzzle->numObjects++;
}
