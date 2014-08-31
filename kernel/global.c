








#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "proc.h"
//#include "global.h"

PUBLIC  int        disp_pos;
PUBLIC  u8         gdt_ptr[6];  /* 0~15:Limitation 16~47:base */
PUBLIC  DESCRIPTOR gdt[GDT_SIZE];
PUBLIC  u8         idt_ptr[6];  /* 0~15:Limitation 16~47:base */
PUBLIC  GATE       idt[IDT_SIZE];

PUBLIC  int        k_reenter;

PUBLIC  TSS        tss;
PUBLIC  PROCESS    *p_proc_ready;

PUBLIC  PROCESS    proc_table[NR_TASKS];
PUBLIC  char       task_stack[STACK_SIZE_TOTAL];
PUBLIC  TASK       task_table[NR_TASKS] = {{TestA, STACK_SIZE_TESTA, "TestA"},
                                           {TestB, STACK_SIZE_TESTB, "TestB"},
                                           {TestC, STACK_SIZE_TESTC, "TestC"}};

PUBLIC irq_handler irq_table[NR_IRQ];
PUBLIC system_call    sys_call_table[NR_SYS_CALL] = { sys_get_ticks };
PUBLIC int         ticks;
