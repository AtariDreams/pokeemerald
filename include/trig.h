#ifndef GUARD_TRIG_H
#define GUARD_TRIG_H

extern const s16 gSineTable[];

s16 Sin(s16 index, s16 amplitude)  __attribute__ ((const));
s16 Cos(s16 index, s16 amplitude)  __attribute__ ((const));
s16 Sin2(u16 angle)  __attribute__ ((const));
s16 Cos2(u16 angle)  __attribute__ ((const));;

#endif // GUARD_TRIG_H
