






/* klib.asm */
PUBLIC void out_byte(u16 port, u8 value);
PUBLIC u8   in_byte(u16 port);
PUBLIC void disp_str(char *info);
PUBLIC void	disp_color_str(char *info, int color);

/* protect.c */
PUBLIC void init_prot();
PUBLIC u32  seg2phys(u16 seg);

/* klib.c */
PUBLIC void delay(int time);

/* kernel.asm */
PUBLIC void restart();
PUBLIC void sys_call();

/* main.c */
PUBLIC void TestA();
PUBLIC void TestB();
PUBLIC void TestC();

/* clock.c */
PUBLIC void clock_handler();
PUBLIC void milli_delay(int milli_sec);

/* i8259.c */
PUBLIC void spurious_irq(int irq);
PUBLIC void put_irq_handler(int irq, irq_handler handler);

/* syscall.asm */
PUBLIC int  get_ticks();

/* proc.c */
PUBLIC int  sys_get_ticks();
PUBLIC void schedule();
