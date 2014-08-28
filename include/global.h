






/* EXTERN is defined as extern except in global.c */
#ifdef  GLOBAL_VARIABLES_HERE
#undef  EXTERN
#define EXTERN
#endif

EXTERN  int        disp_pos;
EXTERN  u8         gdt_ptr[6];  /* 0~15:Limitation 16~47:base */
EXTERN  DESCRIPTOR gdt[GDT_SIZE];
EXTERN  u8         idt_ptr[6];  /* 0~15:Limitation 16~47:base */
EXTERN  GATE       idt[IDT_SIZE];
