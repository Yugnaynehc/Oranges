






#ifndef _ORANGES_TYPE_H
#define _ORANGES_TYPE_H


typedef unsigned int       u32;
typedef unsigned short     u16;
typedef unsigned char      u8;

typedef void (*int_handler)();
typedef void (*task_f)();
typedef void (*irq_handler)(int irq);

#endif  /* _ORANGES_TYPE_H */
