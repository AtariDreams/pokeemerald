#include "global.h"
#include "malloc.h"

#define MALLOC_SYSTEM_ID 0xA3A3

struct MemBlock {
    // Whether this block is currently allocated.
    bool16 flag;

    // Magic number used for error checking. Should equal MALLOC_SYSTEM_ID.
    u16 magic;

    // Size of the block (not including this header struct).
    u32 size;

    // Previous block pointer. Equals sHeapStart if this is the first block.
    struct MemBlock *prev;

    // Next block pointer. Equals sHeapStart if this is the last block.
    struct MemBlock *next;

    // Data in the memory block. (Arrays of length 0 are a GNU extension.)
    u8 data[];
};

void InitMemBlock(void *block, struct MemBlock *prev, u32 size)
{
    struct MemBlock *header = (struct MemBlock *)block;
    
    header->flag = FALSE;
    header->magic = MALLOC_SYSTEM_ID;
    header->size = size;
    header->prev = prev;
    header->next = NULL;
}

void ResetHeap(void)
{
    InitMemBlock(gHeap, NULL, sizeof(gHeap) - sizeof(struct MemBlock));
}

void *AllocInternal(void *heapStart, u32 size)
{
    struct MemBlock *pos = (struct MemBlock *)heapStart;

    // Alignment
    if (size & 3)
        size = 4 * ((size / 4) + 1);

    do
    {
        // Loop through the blocks looking for unused block that's big enough.

        if (!pos->flag)
        {
            u32 foundBlockSize = pos->size;

            if (foundBlockSize >= size)
            {

                if (foundBlockSize - size < 2 * sizeof(struct MemBlock))
                {
                    // The block isn't much bigger than the requested size,
                    // so just use it.
                    pos->flag = TRUE;
                }
                else
                {
                    // The block is significantly bigger than the requested
                    // size, so split the rest into a separate block.
                    foundBlockSize -= sizeof(struct MemBlock) + size;

                    void *next = pos->data + size;

                    pos->size = size;

                    InitMemBlock(next, pos, foundBlockSize);
                    
                    pos->next = next;

                    pos->flag = TRUE;
                }

                return pos->data;
            }
        }
        pos = pos->next;
    } while (pos != NULL);
    return NULL;
}

void FreeInternal(void *heapStart, void *pointer)
{
    // Never Free
    if (pointer == NULL)
        return;
    
    struct MemBlock *pos = (struct MemBlock *)pointer;
    struct MemBlock *block = pos->prev;
    block->flag = FALSE;

    // If the freed block isn't the first one, merge with the previous block
    // if it's not in use.
    if (block->prev != NULL)
    {
        if (!block->prev->flag)
        {
            block->prev->next = block->next;

            if (block->next != NULL)
                block->next->prev = block->prev;

            block->magic = 0;
            block->prev->size += sizeof(struct MemBlock) + block->size;
        }
    }

    // If the freed block isn't the last one, merge with the next block
    // if it's not in use.
    if (block->next != NULL)
    {
        if (!block->next->flag)
        {
            block->size += sizeof(struct MemBlock) + block->next->size;
            block->next->magic = 0;
            block->next = block->next->next;
            if (block->next != NULL)
                block->next->prev = block;
        }
    }
}

void *Calloc(u32 size)
{
    void *mem = AllocInternal(gHeap, size);

    if (mem != NULL) {
        if (size & 3)
            size = 4 * ((size / 4) + 1);

        CpuFill32(0, mem, size);
    }

    return mem;
}

void *Alloc(u32 size)
{
    return AllocInternal(gHeap, size);
}

void Free(void *pointer)
{
    FreeInternal(gHeap, pointer);
}
