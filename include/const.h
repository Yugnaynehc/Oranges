






#ifndef _ORANGES_CONST_H_
#define _ORANGES_CONST_H_


/* EXTERN is defined as extern except in global.c */
#define EXTERN extern

/* funtion type */
#define PUBLIC                  /* all functions in c is public defalut */
#define PRIVATE static          /* use 'static' keyword to limit scope */

/* the number of selectors of GDT and IDT */
#define GDT_SIZE    128
#define IDT_SIZE    256

/* privilege */
#define PRIVILEGE_KRNL    0
#define PRIVILEGE_TASK    1
#define PRIVILEGE_USER    3

/* 8259A interrupt controller ports */
#define INT_M_CTL        0x20       /* I/O port for interrupt controller                <Master> */
#define INT_M_CTLMASK    0x21       /* setting bits in this port disalbles ints         <Master> */
#define INT_S_CTL        0xA0       /* I/O port for the second interrupt controller     <Slave>  */
#define INT_S_CTLMASK    0xA1       /* setting bits in this port disalbles ints         <Slave>  */


#endif /* _ORANGES_CONST_H_ */
