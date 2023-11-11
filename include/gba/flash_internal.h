#ifndef GUARD_GBA_FLASH_INTERNAL_H
#define GUARD_GBA_FLASH_INTERNAL_H


#define FLASH_ADR         0xE000000
#define PHASE_VERIFY			0x0000
#define	PHASE_PROGRAM			0x0001
#define PHASE_SECTOR_ERASE		0x0002
#define PHASE_CHIP_ERASE		0x0003
#define	PHASE_VERIFY_ERASE		0x0004
#define	PHASE_PARAMETER_CHECK	0x00ff

#define	RESULT_OK				0x0000
#define	RESULT_ERROR			0x8000
#define	RESULT_TIMEOUT			0x4000
#define RESULT_Q5TIMEOUT		0x2000


#define	VENDER_ID_ADR		(FLASH_ADR+0x00000000)
#define	DEVICE_ID_ADR		(FLASH_ADR+0x00000001)
#define	COM_ADR1			(FLASH_ADR+0x00005555)
#define COM_ADR2			(FLASH_ADR+0x00002aaa)

#define	MEGA_512K_ID		0x1cc2
#define	MEGA_1M_ID			0x09c2


#define FLASH_BASE         (vu8*)0xE000000


#define FLASH_WRITE(addr, data) ((*(vu8 *)(FLASH_ADR + (addr))) = (data))

#define FLASH_ROM_SIZE_1M 131072 // 1 megabit ROM

#define SECTORS_PER_BANK 16

struct FlashSector
{
    u32 size;
    u8 shift;
    u16 count;
    u16 top;
};

struct FlashType {
    u32 romSize;
    struct FlashSector sector;
    u16 wait[2]; // game pak bus read/write wait

    // TODO: add support for anonymous unions/structs if possible
    union {
        struct {
        u8 makerId;
        u8 deviceId;
        } separate;
        u16 joined;
    } ids;
};

struct FlashSetupInfo
{
    u16 (*programFlashByte)(u16, u32, u8);
    u16 (*programFlashSector)(u16, vu8 *);
    u16 (*eraseFlashChip)(void);
    u16 (*eraseFlashSector)(u16);
    u16 (*WaitForFlashWrite)(u8, vu8 *, u8);
    const u16 (*maxTime)[3];
    struct FlashType type;
};

extern u16 gFlashNumRemainingBytes;

extern u16 (*ProgramFlashByte)(u16, u32, u8);
extern u16 (*ProgramFlashSector)(u16, vu8 *);
extern u16 (*EraseFlashChip)(void);
extern u16 (*EraseFlashSector)(u16);
extern u16 (*WaitForFlashWrite)(u8, vu8 *, u8);
extern const u16 (*gFlashMaxTime)[3];
extern const struct FlashType *gFlash;

extern u8 (*PollFlashStatus)(vu8 *);
extern u8 gFlashTimeoutFlag;

extern const struct FlashSetupInfo MX29L010;
extern const struct FlashSetupInfo LE26FV10N1TS;
extern const struct FlashSetupInfo DefaultFlash;

void SwitchFlashBank(u8 bankNum);
u16 ReadFlashId(void);
void StartFlashTimer(u8 phase);
void SetReadFlash1(u32 *dest);
void StopFlashTimer(void);
void ReadFlash(u16 sectorNum, u32 offset, volatile void *dest, u32 size);

u16 WaitForFlashWrite_Common(u8 phase, vu8 *addr, u8 lastData);

u16 EraseFlashChip_MX(void);
u16 EraseFlashSector_MX(u16 sectorNum);
u16 ProgramFlashByte_MX(u16 sectorNum, u32 offset, u8 data);
u16 ProgramFlashSector_MX(u16 sectorNum, vu8 *src);

#endif // GUARD_GBA_FLASH_INTERNAL_H
