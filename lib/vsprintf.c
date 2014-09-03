#include "type.h"
#include "const.h"
#include "protect.h"
#include "proc.h"
#include "console.h"
#include "tty.h"
#include "proto.h"
#include "string.h"
#include "global.h"

PUBLIC int vsprintf(char *buf, const char *fmt, va_list args)
{
    char    *p;
    char    tmp[256];
    va_list p_next_arg = args;

    for (p=buf; *fmt; fmt++) {
        if (*fmt != '%') {
            *p++ = *fmt;
            continue;
        }
        fmt++;

        switch (*fmt) {
        case 'x':
            itoa(tmp, *((int*)p_next_arg));
            strcpy(p, tmp);
            p_next_arg += 4;
            p += strlen(tmp);
            break;
        case 's':
            break;
        default:
            break;
        }
    }
    return (p - buf);
}
