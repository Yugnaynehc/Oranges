






/* klib.asm */
PUBLIC void out_byte(u16 port, u8 value);
PUBLIC u8   in_byte(u16 port);
PUBLIC void disp_str(char *info);
PUBLIC void	disp_color_str(char *info, int color);

/* protect.c */
PUBLIC void init_port();
PUBLIC u32  seg2phys(u16 seg);

/* klib.c */
PUBLIC void delay(int time);

/* kernel.asm */
PUBLIC void restart();

/* main.c */
PUBLIC void TestA();
