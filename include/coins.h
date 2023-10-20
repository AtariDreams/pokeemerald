#ifndef GUARD_COINS_H
#define GUARD_COINS_H

void PrintCoinsString(u32 coinAmount);
void ShowCoinsWindow(u32 coinAmount, u8 x, u8 y);
void HideCoinsWindow(void);

bool16 AddCoins(u16 toAdd);
bool16 RemoveCoins(u16 toSub);

#endif // GUARD_COINS_H
