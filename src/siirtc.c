// Ruby/Sapphire/Emerald cartridges contain a Seiko Instruments Inc. (SII)
// S-3511A real-time clock (RTC). This library ("SIIRTC_V001") is for
// communicating with the RTC.

#include "gba/gba.h"
#include "siirtc.h"
#include "config.h"

#define STATUS_INTFE  0x02 // frequency interrupt enable
#define STATUS_INTME  0x08 // per-minute interrupt enable
#define STATUS_INTAE  0x20 // alarm interrupt enable
#define STATUS_24HOUR 0x40 // 0: 12-hour mode, 1: 24-hour mode
#define STATUS_POWER  0x80 // power on or power failure occurred

#define	RTC_POWER_FLAG		0x80
#define	RTC_BKUP_FLAG		0x40
#define	RTC_FLAGS			0xC0

#define TEST_MODE 0x80 // flag in the "second" byte

#define ALARM_AM 0x00
#define ALARM_PM 0x80

#define OFFSET_YEAR         offsetof(struct SiiRtcInfo, year)
#define OFFSET_MONTH        offsetof(struct SiiRtcInfo, month)
#define OFFSET_DAY          offsetof(struct SiiRtcInfo, day)
#define OFFSET_DAY_OF_WEEK  offsetof(struct SiiRtcInfo, dayOfWeek)
#define OFFSET_HOUR         offsetof(struct SiiRtcInfo, hour)
#define OFFSET_MINUTE       offsetof(struct SiiRtcInfo, minute)
#define OFFSET_SECOND       offsetof(struct SiiRtcInfo, second)
#define OFFSET_STATUS       offsetof(struct SiiRtcInfo, status)
#define OFFSET_ALARM_HOUR   offsetof(struct SiiRtcInfo, alarmHour)
#define OFFSET_ALARM_MINUTE offsetof(struct SiiRtcInfo, alarmMinute)

#define INFO_BUF(info, index) ((u8 *)(info))[index]

#define DATETIME_BUF(info, index) INFO_BUF(info, OFFSET_YEAR + index)
#define DATETIME_BUF_LEN (OFFSET_SECOND - OFFSET_YEAR + 1)

#define TIME_BUF(info, index) INFO_BUF(info, OFFSET_HOUR + index)
#define TIME_BUF_LEN (OFFSET_SECOND - OFFSET_HOUR + 1)

#define WR 0 // command for writing data
#define RD 1 // command for reading data

#define	RTC_COM_RESET		0x60	//リセット
#define	RTC_COM_READ_STAT	0x63	//ステータスレジスタ
#define	RTC_COM_WRITE_STAT	0x62
#define	RTC_COM_READ_DATE	0x65	//年～秒データレジスタ
#define	RTC_COM_WRITE_DATE	0x64
#define	RTC_COM_READ_TIME	0x67	//時～秒データレジスタ
#define	RTC_COM_WRITE_TIME	0x66
#define	RTC_COM_READ_ALARM	0x69	//アラームデータレジスタ
#define	RTC_COM_WRITE_ALARM	0x68

#define CMD(n) (0x60 | (n << 1))

#define CMD_RESET    CMD(0)
#define CMD_STATUS   CMD(1)
#define CMD_DATETIME CMD(2)
#define CMD_TIME     CMD(3)
#define CMD_ALARM    CMD(4)

#define SIO_LO      0
#define SCK_LO      0
#define CS_LO       0
#define SCK_HI      1
#define SIO_HI      2
#define CS_HI       4


#define DIR_0_IN    0
#define DIR_0_OUT   1
#define DIR_1_IN    0
#define DIR_1_OUT   2
#define DIR_2_IN    0
#define DIR_2_OUT   4
#define DIR_3_IN    0
#define DIR_ALL_IN  (DIR_0_IN | DIR_1_IN | DIR_2_IN)
#define DIR_ALL_OUT (DIR_0_OUT | DIR_1_OUT | DIR_2_OUT)

#define GPIO_PORT_DATA        (*(vu16 *)0x80000C4)
#define GPIO_PORT_DIRECTION   (*(vu16 *)0x80000C6)
#define GPIO_PORT_READ_ENABLE (*(vu16 *)0x80000C8)

#define	GPIO_P3_IN			0
#define	GPIO_P2_IN			0
#define	GPIO_P1_IN			0
#define	GPIO_P0_IN			0

#define	GPIO_P3_SHIFT		3
#define	GPIO_P3_OUT			(1 << GPIO_P3_SHIFT)
#define	GPIO_P2_SHIFT		2
#define	GPIO_P2_OUT			(1 << GPIO_P2_SHIFT)
#define	GPIO_P1_SHIFT		1
#define	GPIO_P1_OUT			(1 << GPIO_P1_SHIFT)
#define	GPIO_P0_SHIFT		0
#define	GPIO_P0_OUT			(1 << GPIO_P0_SHIFT)

#define	GPIO_P3_DATA_SHIFT	3
#define	GPIO_P3_DATA_MASK	0x0008
#define	GPIO_P2_DATA_SHIFT	2
#define	GPIO_P2_DATA_MASK	0x0004
#define	GPIO_P1_DATA_SHIFT	1
#define	GPIO_P1_DATA_MASK	0x0002
#define	GPIO_P0_DATA_SHIFT	0
#define	GPIO_P0_DATA_MASK	0x0001

#define rtc_write_enable_macro() {						\
	GPIO_PORT_DIRECTION = GPIO_P3_IN | GPIO_P2_OUT |	\
						  GPIO_P1_OUT | GPIO_P0_OUT;	\
}

#define rtc_read_enable_macro() {						\
	GPIO_PORT_DIRECTION = GPIO_P3_IN | GPIO_P2_OUT |	\
						  GPIO_P1_IN | GPIO_P0_OUT;	\
}

static vbool8 sLocked;

#define rtc_lock_macro()                 \
    {                                    \
        if (sLocked)                     \
        {                                \
            return FALSE;                \
        }                                \
                                         \
        sLocked = TRUE;                  \
        asm volatile("" : : : "memory"); \
    }

#define rtc_unlock_macro()               \
    {                                    \
        asm volatile("" : : : "memory"); \
        sLocked = FALSE;                 \
    }

#define rtc_access_header_macro()        \
    {                                    \
        GPIO_PORT_DATA = CS_LO | SCK_HI; \
        GPIO_PORT_DATA = CS_HI | SCK_HI; \
    }
#define rtc_access_footer_macro()        \
    {                                    \
        GPIO_PORT_DATA = CS_LO | SCK_HI; \
        GPIO_PORT_DATA = CS_LO | SCK_HI; \
    }

static void EnableGpioPortRead(void);
static void DisableGpioPortRead(void);

static void WriteCommand(u8 value);
static void WriteData(u8 value);
static u8 ReadData(void);

static const char AgbLibRtcVersion[] = "SIIRTC_V001";

void SiiRtcUnprotect(void)
{
    EnableGpioPortRead();
    sLocked = FALSE;
}

void SiiRtcProtect(void)
{
    DisableGpioPortRead();
    sLocked = TRUE;
}

u8 SiiRtcProbe(void)
{
    u8 errorCode;
    struct SiiRtcInfo rtc;

    if (SiiRtcGetStatus(&rtc) == 0) {
        return 0;
    }

    errorCode = 0;

#ifdef BUGFIX
    if (!(rtc.status & SIIRTCINFO_24HOUR) || (rtc.status & SIIRTCINFO_POWER))
#else
    if (((rtc.status & RTC_FLAGS) == SIIRTCINFO_POWER) ||
        ((rtc.status & RTC_FLAGS) == 0))
#endif
    {
        // The RTC is in 12-hour mode. Reset it and switch to 24-hour mode.

        // Note that the conditions are redundant and equivalent to simply
        // "(rtc.status & SIIRTCINFO_24HOUR) == 0". It's possible that this
        // was also intended to handle resetting the clock after power failure
        // but a mistake was made.

        if (SiiRtcReset() == 0) {
            return 0;
        }
        errorCode++;
    }

    SiiRtcGetTime(&rtc);
    if ((rtc.second & TEST_MODE) == TEST_MODE) {
        // The RTC is in test mode. Reset it to leave test mode.
        if (SiiRtcReset() == 0) {
            return ((errorCode << 4) & 0xF0);
        }
        errorCode++;
    }

    return ((errorCode << 4) | 0x01);
}

bool8 SiiRtcReset(void)
{
    bool8 result;

    struct SiiRtcInfo rtc;

	rtc_lock_macro();
	rtc_access_header_macro();
	
	rtc_write_enable_macro();			//GPIO入出力切換
    WriteCommand(RTC_COM_RESET);

	rtc_access_footer_macro();
	rtc_unlock_macro();

    rtc.status = RTC_BKUP_FLAG;
    result = SiiRtcSetStatus(&rtc);

    return result;
}

bool8 SiiRtcGetStatus(struct SiiRtcInfo *rtc)
{
    u8 statusData;

	rtc_lock_macro();
	rtc_access_header_macro();

	rtc_write_enable_macro();			//GPIO入出力切換
    WriteCommand(RTC_COM_READ_STAT);
    rtc_read_enable_macro();
    statusData = ReadData();

    rtc->status = (statusData & RTC_FLAGS) | ((statusData & STATUS_INTAE) >> 3) |
                   ((statusData & STATUS_INTME) >> 2) | ((statusData & STATUS_INTFE) >> 1);

	rtc_access_footer_macro();
	rtc_unlock_macro();
    return TRUE;
}

bool8 SiiRtcSetStatus(struct SiiRtcInfo *rtc)
{
    u8 statusData;

	rtc_lock_macro();
	rtc_access_header_macro();

    statusData = STATUS_24HOUR | (((rtc->status) & SIIRTCINFO_INTAE) << 3) |
               (((rtc->status) & SIIRTCINFO_INTME) << 2) | (((rtc->status) & SIIRTCINFO_INTFE) << 1);

    rtc_write_enable_macro();	
    WriteCommand(RTC_COM_WRITE_STAT);
    WriteData(statusData);

	rtc_access_footer_macro();
	rtc_unlock_macro();

    return TRUE;
}

bool8 SiiRtcGetDateTime(struct SiiRtcInfo *rtc)
{
    u32 i;

	rtc_lock_macro();
	rtc_access_header_macro();

	rtc_write_enable_macro();	
    WriteCommand(RTC_COM_READ_DATE);
    rtc_read_enable_macro();

    for (i = 0; i < DATETIME_BUF_LEN; i++)
        DATETIME_BUF(rtc, i) = ReadData();

    INFO_BUF(rtc, OFFSET_HOUR) &= 0x7F;

	rtc_access_footer_macro();
	rtc_unlock_macro();
    return TRUE;
}

bool8 SiiRtcSetDateTime(struct SiiRtcInfo *rtc)
{
    u32 i;

	rtc_lock_macro();
	rtc_access_header_macro();

	rtc_write_enable_macro();	
    WriteCommand(RTC_COM_WRITE_DATE);
    for (i = 0; i < DATETIME_BUF_LEN; i++)
        WriteData(DATETIME_BUF(rtc, i));

	rtc_access_footer_macro();
	rtc_unlock_macro();
    return TRUE;
}

bool8 SiiRtcGetTime(struct SiiRtcInfo *rtc)
{
    u32 i;

	rtc_lock_macro();
	rtc_access_header_macro();
	
	rtc_write_enable_macro();	
    WriteCommand(RTC_COM_READ_TIME);
    rtc_read_enable_macro();

    for (i = 0; i < TIME_BUF_LEN; i++)
        TIME_BUF(rtc, i) = ReadData();
    INFO_BUF(rtc, OFFSET_HOUR) &= 0x7F;

	rtc_access_footer_macro();
	rtc_unlock_macro();
    return TRUE;
}

bool8 SiiRtcSetTime(struct SiiRtcInfo *rtc)
{
    u32 i;

    rtc_lock_macro();
    rtc_access_header_macro();

    rtc_write_enable_macro();
    WriteCommand(RTC_COM_WRITE_TIME);
    for (i = 0; i < TIME_BUF_LEN; i++)
        WriteData(TIME_BUF(rtc, i));

    rtc_access_footer_macro();
    rtc_unlock_macro();
    return TRUE;
}

static vu16 * const GPIOPortDirection = &GPIO_PORT_DATA;

bool8 SiiRtcSetAlarm(struct SiiRtcInfo *rtc)
{
    u8 alarmData[2];

    rtc_lock_macro();
    // Decode BCD.
    alarmData[0] = (rtc->alarmHour & 0xF) +
                   (((rtc->alarmHour >> 4) & 0xF) * 10);

    // The AM/PM flag must be set correctly even in 24-hour mode.

    if (alarmData[0] < 12)
    {   alarmData[0] = rtc->alarmHour;}
    else
    {   alarmData[0] = ALARM_PM | rtc->alarmHour;}
    alarmData[1] = rtc->alarmMinute;

	rtc_access_header_macro();

	rtc_write_enable_macro();	
    WriteCommand(RTC_COM_WRITE_ALARM);

    WriteData(alarmData[0]);
    WriteData(alarmData[1]);

	rtc_access_footer_macro();
	rtc_unlock_macro();
    return TRUE;
}

static void WriteCommand(u8 value)
{
    u32 i;
    u8 temp;

    for (i = 0; i < 8; i++) {
        temp = (value>>(7-i))&1;

        GPIO_PORT_DATA = CS_HI | (temp << 1) |
                         SCK_LO;
        GPIO_PORT_DATA = CS_HI | (temp << 1) |
                         SCK_LO;
        GPIO_PORT_DATA = CS_HI | (temp << 1) |
                         SCK_LO;
        GPIO_PORT_DATA = CS_HI | (temp << 1) |
                         SCK_HI;
    }
}

static void WriteData(u8 value)
{
    u32 i;
    u8 temp;

    for (i = 0; i < 8; i++) {
        temp = (value >> i) & 1;

        GPIO_PORT_DATA = CS_HI | (temp << 1) |
                         SCK_LO;
        GPIO_PORT_DATA = CS_HI | (temp << 1) |
                         SCK_LO;
        GPIO_PORT_DATA = CS_HI | (temp << 1) |
                         SCK_LO;
        GPIO_PORT_DATA = CS_HI | (temp << 1) |
                         SCK_HI;
    }
}

static u8 ReadData(void)
{
    u32 i;
    u8 temp, value = 0;

    for (i = 0; i < 8; i++) {
        GPIO_PORT_DATA = CS_HI| SCK_LO;
        GPIO_PORT_DATA = CS_HI| SCK_LO;
        GPIO_PORT_DATA = CS_HI| SCK_LO;
        GPIO_PORT_DATA = CS_HI| SCK_LO;
        GPIO_PORT_DATA = CS_HI| SCK_LO;

        GPIO_PORT_DATA = CS_HI| SCK_HI;
        temp =  ((GPIO_PORT_DATA >> 1) & 1);
        value = (value >> 1) | (temp << 7);
    }
    return value;
}

static void EnableGpioPortRead(void)
{
    GPIO_PORT_READ_ENABLE = TRUE;
}

static void DisableGpioPortRead(void)
{
    GPIO_PORT_READ_ENABLE = FALSE;
}