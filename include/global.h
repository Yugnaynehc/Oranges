






/* EXTERN is defined as extern except in global.c */
//#ifdef  GLOBAL_VARIABLES_HERE
//#undef  EXTERN
//#define EXTERN
//#endif

EXTERN  int         disp_pos;
EXTERN  u8          gdt_ptr[6];  /* 0~15:Limitation 16~47:base */
EXTERN  DESCRIPTOR  gdt[GDT_SIZE];
EXTERN  u8          idt_ptr[6];  /* 0~15:Limitation 16~47:base */
EXTERN  GATE        idt[IDT_SIZE];

EXTERN  int         k_reenter;

EXTERN  TSS         tss;
EXTERN  PROCESS     *p_proc_ready;

EXTERN  PROCESS     proc_table[NR_TASKS+NR_PROCS];
EXTERN  TASK        task_table[NR_TASKS];
EXTERN  TASK        user_proc_table[NR_PROCS];

EXTERN  TTY         tty_table[NR_CONSOLES];
EXTERN  CONSOLE     console_table[NR_CONSOLES];
EXTERN  u8          task_stack[STACK_SIZE_TOTAL];

EXTERN  irq_handler irq_table[NR_IRQ];
EXTERN  system_call sys_call_table[NR_SYS_CALL];
EXTERN  int         ticks;
EXTERN  int         nr_current_console;
