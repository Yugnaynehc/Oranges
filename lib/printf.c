#include "type.h"
#include "const.h"
#include "protect.h"
#include "proc.h"
#include "console.h"
#include "tty.h"
#include "proto.h"
#include "string.h"
#include "global.h"

PUBLIC int printf(const char *fmt, ...)
{
    int     i;
    char    buf[256];

    va_list arg = (va_list)((char*)(&fmt) + 4); /* the size of fmt in stack */
    i = vsprintf(buf, fmt, arg);
    write(buf, i);

    return i;
}
        
