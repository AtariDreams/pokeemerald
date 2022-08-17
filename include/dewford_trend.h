#ifndef GUARD_DEWFORDTREND_H
#define GUARD_DEWFORDTREND_H

void InitDewfordTrend(void);
void UpdateDewfordTrendPerDay(u16 days);
bool8 TrySetTrendyPhrase(u16 *phrase);
#if !MODERN
void ReceiveDewfordTrendData(struct DewfordTrend *linkedTrends, u32 size, u8 unused);
#else
void ReceiveDewfordTrendData(struct DewfordTrend *linkedTrends, u32 size);
#endif


#endif // GUARD_DEWFORDTREND_H
