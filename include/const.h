






#ifndef _ORANGES_CONST_H_
#define _ORANGES_CONST_H_


/* EXTERN is defined as extern except in global.c */
#define EXTERN extern

/* funtion type */
#define PUBLIC                  /* all functions in c is public defalut */
#define PRIVATE static          /* use 'static' keyword to limit scope */

/* Boolean value */
#define TRUE    1
#define FALSE   0

/* the number of selectors of GDT and IDT */
#define GDT_SIZE    128
#define IDT_SIZE    256

/* privilege */
#define PRIVILEGE_KRNL    0
#define PRIVILEGE_TASK    1
#define PRIVILEGE_USER    3
/* RPL */
#define RPL_KRNL          SA_RPL0
#define RPL_TASK          SA_RPL1
#define RPL_USER          SA_RPL3

/* 8259A interrupt controller ports */
#define INT_M_CTL        0x20       /* I/O port for interrupt controller                <Master> */
#define INT_M_CTLMASK    0x21       /* setting bits in this port disalbles ints         <Master> */
#define INT_S_CTL        0xA0       /* I/O port for the second interrupt controller     <Slave>  */
#define INT_S_CTLMASK    0xA1       /* setting bits in this port disalbles ints         <Slave>  */

/* 8253/8254 PIT(Programmable Interbal Timer) */
#define TIMER0           0x40   /* I/O port for timer channel 0 */
#define TIMER_MODE       0x43   /* I/O port for timer mode control */
#define RATE_GERERATOR   0x34   /* 00-11-010-0
                                   Counter0 - LSB then MSB - rate generator - binary
                                */
#define TIMER_FREQ       1193182L /* clock frequency for timer in PC and AT */
#define HZ               100      /* clock freq(sofrware settable on IBM-PC) */

/* Hardware interrupts */
#define NR_IRQ           16     /* number of IRQs */
#define CLOCK_IRQ        0
#define KEYBOADR_IRQ     1
#define CASCADE_IRQ      2
#define ETHER_IRQ        3
#define SECONDARE_IRQ    3
#define RS232_IRQ        4
#define XT_WINI_IRQ      5
#define FLOPPY_IRQ       6
#define PRINTER_IRQ      7
#define AT_WINI_IRQ      14

/* system call */
#define NR_SYS_CALL      1

#endif /* _ORANGES_CONST_H_ */
