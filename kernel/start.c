






#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "proc.h"
#include "global.h"





PUBLIC void cstart()
{
    disp_str("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
		 "-----\"cstart\" begins-----\n");

    /* Get GDT from loader, and update it, set new GDT for kernel */
    /* gdt_ptr has 6 bytes: 0~15:limit 16~47:base use gdt_ptr in sgdt/lgdt */
    memcpy(&gdt,                /* new GDT */
           (void*)(*((u32*)(&gdt_ptr[2]))), /* base of old GDT */
           *((u16*)(&gdt_ptr[0])) + 1       /* limitation of old GDT */
        );     
    u16* p_gdt_limit = (u16*)(&gdt_ptr[0]);
    u32* p_gdt_base  = (u32*)(&gdt_ptr[2]);
    *p_gdt_limit     = GDT_SIZE * sizeof(DESCRIPTOR) - 1;
    *p_gdt_base      = (u32)&gdt;
    
    /* idt_ptr has 6 bytes: 0~15:limit 16~47:base use idt_ptr in sidt/lidt */
    u16* p_idt_limit = (u16*)(&idt_ptr[0]);
	u32* p_idt_base  = (u32*)(&idt_ptr[2]);
	*p_idt_limit     = IDT_SIZE * sizeof(GATE) - 1;
	*p_idt_base      = (u32)&idt;

    init_port();

    disp_str("-----\"cstart\" ends-----\n");
}

    
