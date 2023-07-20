#include "global.h"
#include "malloc.h"

#define MALLOC_SYSTEM_ID 0xA3A3

typedef long Align; /* for alignment to long boundary */
union header
{ /* block header */
    struct
    {
        union header *ptr; /* next block if on free list */
        u32 size;     /* size of this block */
    } s;
    Align x; /* force alignment of blocks */
};
typedef union header Header;

void *const basep = gHeap;
static Header *freep = NULL; /* start of free list */
/* malloc: general-purpose storage allocator */

void ResetHeap(void)
{
    freep = NULL;
}

void *Alloc(u32 size)
{
  Header *base = basep;
  Header*  p;
  Header*  prevp;
  u32   nunits;

  nunits = (size + sizeof(Header) - 1) / sizeof(Header) + 1;

  prevp = freep;
  if (prevp == NULL)                     /* no free list yet */
  {
    base->s.ptr  = base;
    base->s.size = sizeof(gHeap)-sizeof(Header);
    freep     = base;
    prevp     = base;
  }

  for (p = prevp->s.ptr; ; prevp = p, p = p->s.ptr)
  {
    if (p->s.size >= nunits)             /* big enough */
    {
      if (p->s.size == nunits)           /* exactly */
      {
        prevp->s.ptr = p->s.ptr;
      }
      else                               /* allocate tail end */
      {
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }

      freep = prevp;
      return (p + 1);
    }

    if (p == freep)                      /* wrapped around free list */
    {
        return NULL;                     /* none left */
    }
  } /* for */
}

/* free: put block ap in free list */
void Free(void *ap) {
  Header *bp, *p;
  bp = (Header *)ap - 1; /* point to block header */
  for (p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if (p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break; /* freed block at start or end of arena */
  if (bp + bp->s.size == p->s.ptr) {
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
      bp->s.ptr = p->s.ptr;

  if (p + p->s.size == bp) {
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
}

void *Calloc(u32 size)
{
    void *mem = Alloc(size);

    if (mem != NULL) {
        if (size & 3)
            size = 4 * ((size / 4) + 1);

        CpuFill32(0, mem, size);
    }

    return mem;
}

