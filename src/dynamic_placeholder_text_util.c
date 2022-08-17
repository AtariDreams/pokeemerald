#include "global.h"
#include "text.h"
#include "dynamic_placeholder_text_util.h"
#include "string_util.h"

static EWRAM_DATA const u8 *sStringPointers[8] = {};

void DynamicPlaceholderTextUtil_Reset(void)
{
    int i;
    // why not just memset???
    for (i = 0; i < (int)ARRAY_COUNT(sStringPointers); i++)
    {
        sStringPointers[i] = NULL;
    }
}

void DynamicPlaceholderTextUtil_SetPlaceholderPtr(u8 idx, const u8 *ptr)
{
    // ASSERT (idx < ARRAY_COUNT(sStringPointers))
    // why even keep it then
    if (idx < ARRAY_COUNT(sStringPointers))
    {
        sStringPointers[idx] = ptr;
    }
}

u8 *DynamicPlaceholderTextUtil_ExpandPlaceholders(u8 *dest, const u8 *src)
{
    while (*src != EOS)
    {
        if (*src != CHAR_DYNAMIC)
        {
            *dest++ = *src++;
        }
        else
        {
            src++;
            // ASSERT (idx < ARRAY_COUNT(sStringPointers))
            if (sStringPointers[*src] != NULL)
            {
                dest = StringCopy(dest, sStringPointers[*src]);
            }
            src++;
        }
    }
    *dest = EOS;
    return dest;
}

const u8 *DynamicPlaceholderTextUtil_GetPlaceholderPtr(u8 idx)
{
    // ASSERT (idx < ARRAY_COUNT(sStringPointers))
    return sStringPointers[idx];
}
