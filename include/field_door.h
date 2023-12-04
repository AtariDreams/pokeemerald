#ifndef GUARD_FIELD_DOOR_H
#define GUARD_FIELD_DOOR_H

void FieldSetDoorOpened(int, int);
void FieldSetDoorClosed(int, int);
s8 FieldAnimateDoorClose(int, int);
s8 FieldAnimateDoorOpen(int, int);
bool8 FieldIsDoorAnimationRunning(void);
u16 GetDoorSoundEffect(int x, int y);

#endif //GUARD_FIELD_DOOR_H
