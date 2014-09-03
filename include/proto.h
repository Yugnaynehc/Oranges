






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
PUBLIC void init_clock();
PUBLIC void milli_delay(int milli_sec);

/* i8259.c */
PUBLIC void spurious_irq(int irq);
PUBLIC void put_irq_handler(int irq, irq_handler handler);

/* syscall.asm */
PUBLIC int  get_ticks();

/* proc.c */
PUBLIC int  sys_get_ticks();
PUBLIC void schedule();

/* keyboard.c */
PUBLIC void keyboard_handler();
PUBLIC void init_keyboard();
PUBLIC void keyboard_read();

/* tty.c */
PUBLIC void task_tty();
PUBLIC void in_process(TTY *p_tty, u32 key);

/* console.c */
PUBLIC BOOL is_current_console(CONSOLE *p_con);
PUBLIC void out_char(CONSOLE *p_conm, char ch);
PUBLIC void select_console(int nr_console);
PUBLIC void scroll_screen(CONSOLE *p_con, int direction);
