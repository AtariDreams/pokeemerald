#ifndef GUARD_DMA3_H
#define GUARD_DMA3_H

#define Dma3CopyLarge_(src, dest, size, blocksize, bit)               \
{                                                          \
    const void *_src = src;                                \
    void *_dest = dest;                                    \
    u32 _size = size;                                      \
    while (1)                                              \
    {                                                      \
        if (_size <= blocksize)                   \
        {                                                  \
            DmaCopy##bit(3, _src, _dest, _size);           \
            break;                                         \
        }                                                  \
        DmaCopy##bit(3, _src, _dest, blocksize);  \
        _src += blocksize;                        \
        _dest += blocksize;                       \
        _size -= blocksize;                       \
    }                                                      \
}

#define Dma3CopyLarge16_(src, dest, size) Dma3CopyLarge_(src, dest, size, 0x20000, 16)
#define Dma3CopyLarge32_(src, dest, size) Dma3CopyLarge_(src, dest, size, 0x40000, 32)

#define Dma3FillLarge_(value, dest, size, blocksize, bit)             \
{                                                          \
    void *_dest = dest;                                    \
    u32 _size = size;                                      \
    while (1)                                              \
    {                                                      \
        if (_size <= blocksize)                            \
        {                                                  \
            DmaFill##bit(3, value, _dest, _size);          \
            break;                                         \
        }                                                  \
        DmaFill##bit(3, value, _dest, blocksize); \
        _dest += blocksize;                       \
        _size -= blocksize;                       \
    }                                                      \
}

#define Dma3FillLarge16_(value, dest, size) Dma3FillLarge_(value, dest, size, 0x20000, 16)
#define Dma3FillLarge32_(value, dest, size) Dma3FillLarge_(value, dest, size, 0x40000, 32)

void ClearDma3Requests(void);
void ProcessDma3Requests(void);
s16 RequestDma3Copy(const void *src, void *dest, u16 size, u8 mode);
s16 RequestDma3Fill(u32 value, void *dest, u16 size, u8 mode);
s16 CheckForSpaceForDma3Request(s16 index);

#endif // GUARD_DMA3_H
