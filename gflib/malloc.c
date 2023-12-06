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
    Header *cp;
    cp = incbreak(nu);
    if (cp == NULL)  /* no space at all */
        return NULL;
    /* make the new block point to the start of the free list */
    cp->ptr = freep->ptr; 
    cp->size = nu;
    /* make the old tail of the free list point to the new block */
    freep->ptr = cp; 
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
    base->size = current_break = 0;
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
}

void *AllocZeroed(u32 size)
{
    void *mem = Alloc(size);

    if (mem != NULL) {
        size = (size + 3) & ~3;
        DmaClear32(3, mem, size);
    }

    return mem;
}

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