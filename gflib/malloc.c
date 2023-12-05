#include "global.h"
#include "malloc.h"

EWRAM_DATA ALIGNED(4) u8 gHeap[HEAP_SIZE] = {0};

struct header
{
        struct header *ptr; /* next block if on free list */
        u32 size;           /* size of this block */
        unsigned char d[];
};

typedef struct header Header;
static Header *const base = (void *)gHeap;
static Header *freep = NULL; /* start of free list */

static u32 current_break = 0; // Some global variable for your application.

static Header *incbreak(u32 incr)
{
        if ((current_break + incr) <= (HEAP_SIZE / sizeof(Header)))
        {
                Header *ret = base + current_break;
                current_break += incr;
                return ret;
        }
        return NULL;
}

static Header *morecore(u32 nu)
{
    if (nu < 1024)
        nu = 1024;
    Header *cp, *up;
    cp = incbreak(nu);
    if (cp == NULL)  /* no space at all */
        return NULL;
    up = freep; /* remember the old tail of the free list */
    /* make the new block point to the start of the free list */
    cp->ptr = freep->ptr; 
    cp->size = nu;
    /* make the old tail of the free list point to the new block */
    up->ptr = cp; 
    freep = cp; /* the new block is now the tail of the free list */
    return freep;
}

/* Malloc: general-purpose storage allocator */
void* Alloc (u32 nbytes)
{
  Header*   p, *prevp;
  u32  nunits;

  nunits = (nbytes+sizeof(Header)-1)/sizeof(Header) + 1;

  if ((prevp = freep) == NULL)           /* no free list yet */
  {
    base->ptr = prevp = freep = base;
    base->size = 0;
  }

  for (p = prevp->ptr; ; prevp = p, p = p->ptr)
  {
    if (p->size >= nunits)             /* big enough */
    {
      if (p->size == nunits)           /* exactly */
        prevp->ptr = p->ptr;
      else                               /* allocate tail end */
      {
        p->size -= nunits;
        p += p->size;
        p->size = nunits;
      }

      freep = prevp;
      return (void *)(p->d);
    }

    if (p == freep)                      /* wrapped around free list */
        if ((p = morecore(nunits)) == NULL)
                return NULL;                     /* none left */
  }
}

// {
//     asm_unified("\
//         push    {r4, r5, r6, r7, lr}\n\
//         sub     sp, #4\n\
//         ldr     r1, =freep\n\
//         str     r1, [sp]\n\
//         ldr     r2, [r1]\n\
//         movs    r3, r0\n\
//         subs    r3, #8\n\
//         movs    r1, #1\n\
//         movs    r6, #0\n\
// .LBB1_1:\n\
//         movs    r4, r2\n\
//         ldr     r2, [r2]\n\
//         cmp     r3, r4\n\
//         bls     .LBB1_3\n\
//         cmp     r3, r2\n\
//         blo     .LBB1_9\n\
// .LBB1_3:\n\
//         cmp     r3, r2\n\
//         push    {r1}\n\
//         pop     {r7}\n\
//         bhs     .LBB1_6\n\
//         cmp     r3, r4\n\
//         push    {r1}\n\
//         pop     {r5}\n\
//         bls     .LBB1_7\n\
// .LBB1_5:\n\
//         cmp     r4, r2\n\
//         bhs     .LBB1_8\n\
//         b       .LBB1_1\n\
// .LBB1_6:\n\
//         movs    r7, r6\n\
//         cmp     r3, r4\n\
//         push    {r1}\n\
//         pop     {r5}\n\
//         bhi     .LBB1_5\n\
// .LBB1_7:\n\
//         movs    r5, r6\n\
//         cmp     r4, r2\n\
//         blo     .LBB1_1\n\
// .LBB1_8:\n\
//         orrs    r5, r7\n\
//         beq     .LBB1_1\n\
// .LBB1_9:\n\
//         subs    r1, r0, #4\n\
//         ldr     r0, [r1]\n\
//         lsls    r5, r0, #3\n\
//         adds    r5, r3, r5\n\
//         cmp     r5, r2\n\
//         bne     .LBB1_11\n\
//         ldr     r5, [r2, #4]\n\
//         adds    r0, r5, r0\n\
//         str     r0, [r1]\n\
//         ldr     r2, [r2]\n\
// .LBB1_11:\n\
//         str     r2, [r3]\n\
//         ldr     r1, [r4, #4]\n\
//         lsls    r5, r1, #3\n\
//         adds    r5, r4, r5\n\
//         cmp     r5, r3\n\
//         bne     .LBB1_13\n\
//         adds    r0, r0, r1\n\
//         str     r0, [r4, #4]\n\
//         movs    r3, r2\n\
// .LBB1_13:\n\
//         str     r3, [r4]\n\
//         ldr     r0, [sp]\n\
//         str     r4, [r0]\n\
//         add     sp, #4\n\
//         pop     {r4, r5, r6, r7}\n\
//         pop     {r0}\n\
//         bx      r0\n");
// }
/* free: put block ap in free list */
void Free(void *ap) {
  Header *bp, *p;
  bp = (Header *)ap - 1; /* point to block header */
  for (p = freep; !(bp > p && bp < p->ptr); p = p->ptr)
    if (p >= p->ptr && (bp > p || bp < p->ptr))
      break; /* freed block at start or end of arena */
  if (bp + bp->size == p->ptr) {
    bp->size += p->ptr->size;
    bp->ptr = p->ptr->ptr;
  } else
      bp->ptr = p->ptr;

  if (p + p->size == bp) {
    p->size += bp->size;
    p->ptr = bp->ptr;
  } else
    p->ptr = bp;
  freep = p;
}

void InitHeap(void)
{
    freep = NULL;
    current_break = 0; 
}

void *AllocZeroed(u32 size)
{
    void *mem = Alloc(size);

    if (mem != NULL) {
        memset(mem, 0, size);
    }

    return mem;
}



// NAKED void *AllocZeroed(u32 size)
// {
//     asm_unified("\
//         push    {r4, r5, r6, r7, lr}\n\
//         sub     sp, #4\n\
//         ldr     r2, =freep\n\
//         ldr     r3, [r2]\n\
//         subs    r1, r0, #1\n\
//         lsrs    r1, r1, #3\n\
//         cmp     r3, #0\n\
//         bne     .LBB3_2\n\
//         ldr     r3, =gHeap\n\
//         str     r3, [r2]\n\
//         movs    r4, #7\n\
//         lsls    r4, r4, #11\n\
//         str     r3, [r3]\n\
//         str     r4, [r3, #4]\n\
// .LBB3_2:\n\
//         adds    r5, r1, #2\n\
//         movs    r6, #0\n\
//         movs    r4, r3\n\
// .LBB3_3:                                @ =>This Inner Loop Header: Depth=1\n\
//         ldr     r1, [r4]\n\
//         ldr     r7, [r1, #4]\n\
//         cmp     r7, r5\n\
//         bhs     .LBB3_6\n\
//         cmp     r1, r3\n\
//         push    {r1}\n\
//         pop     {r4}\n\
//         bne     .LBB3_3\n\
//         movs    r1, r6\n\
//         b       .LBB3_10\n\
// .LBB3_6:\n\
//         bne     .LBB3_8\n\
//         ldr     r3, [r1]\n\
//         str     r3, [r4]\n\
//         b       .LBB3_9\n\
// .LBB3_8:\n\
//         subs    r3, r7, r5\n\
//         str     r3, [r1, #4]\n\
//         lsls    r3, r3, #3\n\
//         adds    r1, r1, r3\n\
//         str     r5, [r1, #4]\n\
// .LBB3_9:\n\
//         str     r4, [r2]\n\
//         movs    r2, #0\n\
//         str     r2, [sp]\n\
//         ldr     r2, =67109084 @DMA Setting. Do not mess with this\n\
//         movs    r3, r2\n\
//         subs    r3, #8\n\
//         mov     r4, sp\n\
//         str     r4, [r3]\n\
//         subs    r3, r2, #4\n\
//         adds    r1, #8\n\
//         str     r1, [r3]\n\
//         movs    r3, #133\n\
//         lsls    r3, r3, #24\n\
//         adds    r0, r0, #7\n\
//         lsrs    r0, r0, #3\n\
//         lsls    r0, r0, #1\n\
//         orrs    r0, r3\n\
//         str     r0, [r2]\n\
//         ldr     r0, [r2]\n\
// .LBB3_10:\n\
//         movs    r0, r1\n\
//         add     sp, #4\n\
//         pop     {r4, r5, r6, r7}\n\
//         pop     {r1}\n\
//         bx      r1\n");
// }

/* realloc: resize block of memory */
// void *realloc(void *ptr, size_t new_size) {
//     Header *bp = (Header *)ptr - 1;  /* point to block header */
//     Header *new_bp;
//     void *new_ptr;
//     size_t copy_size;

//     /* Special cases */
//     if (ptr == NULL) {
//         return malloc(new_size);
//     }

//     if (new_size == 0) {
//         free(ptr);
//         return NULL;
//     }

//     /* Check if we can extend the current block */
//     if (bp->s.size >= new_size / sizeof(Header)) {
//         return ptr;
//     }

//     /* Allocate a new block */
//     new_ptr = malloc(new_size);
//     if (new_ptr == NULL) {
//         return NULL;  /* allocation failure */
//     }

//     new_bp = (Header *)new_ptr - 1;
//     copy_size = bp->s.size * sizeof(Header);
    
//     /* Copy data from the old block to the new block */
//     memcpy(new_ptr, ptr, copy_size);

//     /* Free the old block */
//     free(ptr);

//     return new_ptr;
// }