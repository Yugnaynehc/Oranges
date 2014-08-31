;;; kernel.asm







%include "sconst.inc"

;;; import functions
extern  cstart
extern  kernel_main
extern  exception_handler
extern  spurious_irq
extern  disp_str
extern  delay
extern  clock_handler
extern  irq_table

;;; import global variables
extern  gdt_ptr
extern  idt_ptr
extern  p_proc_ready
extern  tss
extern  disp_pos
extern  k_reenter

bits 32

[SECTION  .data]
clock_int_msg   db      '^', 0

[SECTION  .bss]
StackSpace      resb    2 * 1024
StackTop:   

[SECTION  .text]
;;; export symbols
global  _start

global  restart

global  divide_error
global  single_step_exception
global  nmi
global  breakpoint_exception
global  overflow
global  bounds_check
global  inval_opcode
global  copr_not_available
global  double_fault
global  copr_seg_overrun
global  inval_tss
global  segment_not_present
global  stack_exception
global  general_protection
global  page_fault
global  copr_error
global  hwint00
global  hwint01
global  hwint02
global  hwint03
global  hwint04
global  hwint05
global  hwint06
global  hwint07
global  hwint08
global  hwint09
global  hwint10
global  hwint11
global  hwint12
global  hwint13
global  hwint14
global  hwint15


_start: 
	; 此时内存看上去是这样的（更详细的内存情况在 LOADER.ASM 中有说明）：
	;              ┃                                    ┃
	;              ┃                 ...                ┃
	;              ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■■■Page  Tables■■■■■■┃
	;              ┃■■■■■(大小由LOADER决定)■■■■┃ PageTblBase
	;    00101000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■Page Directory Table■■■■┃ PageDirBase = 1M
	;    00100000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃□□□□ Hardware  Reserved □□□□┃ B8000h ← gs
	;       9FC00h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■■■■LOADER.BIN■■■■■■┃ somewhere in LOADER ← esp
	;       90000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■■■■KERNEL.BIN■■■■■■┃
	;       80000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃■■■■■■■■KERNEL■■■■■■■┃ 30400h ← KERNEL 入口 (KernelEntryPointPhyAddr)
	;       30000h ┣━━━━━━━━━━━━━━━━━━┫
	;              ┋                 ...                ┋
	;              ┋                                    ┋
	;           0h ┗━━━━━━━━━━━━━━━━━━┛ ← cs, ds, es, fs, ss
	;
	;
	; GDT 以及相应的描述符是这样的：
	;
	;		              Descriptors               Selectors
	;              ┏━━━━━━━━━━━━━━━━━━┓
	;              ┃         Dummy Descriptor           ┃
	;              ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃         DESC_FLAT_C    (0～4G)     ┃   8h = cs
	;              ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃         DESC_FLAT_RW   (0～4G)     ┃  10h = ds, es, fs, ss
	;              ┣━━━━━━━━━━━━━━━━━━┫
	;              ┃         DESC_VIDEO                 ┃  1Bh = gs
	;              ┗━━━━━━━━━━━━━━━━━━┛
	;
	; 注意! 在使用 C 代码的时候一定要保证 ds, es, ss 这几个段寄存器的值是一样的
	; 因为编译器有可能编译出使用它们的代码, 而编译器默认它们是一样的. 比如串拷贝操作会用到 ds 和 es.
	;
	;


    ;; switch esp from LOADER to KERNEL
    mov  esp, StackTop

    mov  dword [disp_pos], 0

    sgdt [gdt_ptr]              ; gdt_ptr will be used in cstart()
    call cstart                 ; update gdt_ptr, makes it points to new GDT
    lgdt [gdt_ptr]              ; use new GDT

    lidt [idt_ptr]

    jmp  SELECTOR_KERNEL_CS:csinit
csinit:





    xor  eax, eax
    mov  ax, SELECTOR_TSS
    ltr  ax

    ;; sti
    jmp  kernel_main

    ;; hlt



;;; Interrupt and exception: the hardware interrupt
%macro  hwint_master    1
    call save
    in   al, INT_M_CTLMASK
    or   al, (1 << %1)
    out  INT_M_CTLMASK, al      ; block current interrupt
    mov  al, EOI                
    out  INT_M_CTL, al          ; reset EOI
    sti                         ; CPU will block all interrupt automatically,
    push %1                     ; so use sti to reopen interrupt.
    call [irq_table + 4 * %1]   ; Call interrupt routine
    pop  ecx
    cli
    in   al, INT_M_CTLMASK
    and  al, ~(1 << %1)
    out  INT_M_CTLMASK, al      ; reopen current interrupt
    ret
%endmacro


ALIGN  16
hwint00:                        ; Interrupt routine for irq 0 (the clock)
    hwint_master    0

ALIGN  16
hwint01:                        ; Interrupt routine for irq 1 (keyboard)
    hwint_master    1

ALIGN  16
hwint02:                        ; Interrupt routine for irq 2 (cascade!)
    hwint_master    2

ALIGN  16
hwint03:                        ; Interrupt routine for irq 3 (second serial)
    hwint_master    3

ALIGN  16
hwint04:                        ; Interrupt routine for irq 4 (first serial)
    hwint_master    4

ALIGN  16
hwint05:                        ; Interrupt routine for irq 5 (XT winchester)
    hwint_master    5

ALIGN  16
hwint06:                        ; Interrupt routine for irq 6 (floppy)
    hwint_master    6

ALIGN  16
hwint07:                        ; Interrupt routine for irq 7 (printer)
    hwint_master    7


%macro  hwint_slave     1
    push %1
    call spurious_irq
    add  esp, 4
    hlt
%endmacro


ALIGN  16
hwint08:                        ; Interrupt routine for irq 8 (realtime clock)
    hwint_slave    8

ALIGN  16
hwint09:                        ; Interrupt routine for irq 9 (irq 2 redirected)
    hwint_slave    9

ALIGN  16
hwint10:                        ; Interrupt routine for irq 10 (
    hwint_slave    10

ALIGN  16
hwint11:                        ; Interrupt routine for irq 11 (
    hwint_slave    11

ALIGN  16
hwint12:                        ; Interrupt routine for irq 12 (
    hwint_slave    12

ALIGN  16
hwint13:                        ; Interrupt routine for irq 13 (FPU exception)
    hwint_slave    13

ALIGN  16
hwint14:                        ; Interrupt routine for irq 14 (AT winchester)
    hwint_slave    14

ALIGN  16
hwint15:                        ; Interrupt routine for irq 15
    hwint_slave    15



;;; Interrupt and exception: the exception part
divide_error:   
    push 0xFFFFFFFF             ; no error code
    push 0                      ; vector_no = 0
    jmp  exception
single_step_exception:  
    push 0xFFFFFFFF             ; no error code
    push 1                      ; vector_no = 1
    jmp  exception
nmi:
	push 0xFFFFFFFF	            ; no error code   
	push 2  		            ; vector_no	= 2
	jmp	 exception
breakpoint_exception:   
    push 0xFFFFFFFF             ; no error code
    push 3                      ; vector_no = 3
    jmp  exception
overflow:
    push 0xFFFFFFFF             ; no error code
    push 4                      ; vector_no = 4
    jmp  exception
bounds_check:
    push 0xFFFFFFFF             ; no error code
    push 5                      ; vector_no = 5
    jmp  exception
inval_opcode:
    push 0xFFFFFFFF             ; no error code
    push 6                      ; vector_no = 6
    jmp  exception
copr_not_available:
    push 0xFFFFFFFF             ; no error code
    push 7                      ; vector_no = 7
    jmp  exception
double_fault:
    push 8                      ; vector_no = 8
    jmp  exception
copr_seg_overrun:
    push 0xFFFFFFFF             ; no error code
    push 9
    jmp  exception
inval_tss:
    push 10                     ; vector_no = 10
    jmp  exception
segment_not_present:
    push 11                     ; vector_no	= B
    jmp  exception
stack_exception:
    push 12                 	; vector_no	= C
    jmp exception
general_protection:
    push 13                     ; vector_no = D
    jmp  exception
page_fault:
    push 14                     ; vector_no = E
    jmp  exception
copr_error:
    push 0xFFFFFFFF             ; no error code
    push 16                     ; vector_no = 10h
    jmp  exception

exception:  
    call exception_handler
    add  esp, 4 * 2             ; make stack top pointer point to eip
    hlt                         ; there are eip, cs, eflages in stack from top to bottom




save:   
    pushad                      ; save registers
    push ds
    push es
    push fs
    push gs
    mov  dx, ss
    mov  ds, dx
    mov  es, dx

    mov  eax, esp               ; eax = the begin address of PCB

    inc  dword [k_reenter]      ; k_reenter++
    cmp  dword [k_reenter], 0   ; if k_reenter == 0
    jne  .1
    mov  esp, StackTop          ; switch to kernel stack
    push restart
    jmp  [eax + RETADR - P_STACKBASE]
.1:
    push restart_reenter
    jmp  [eax + RETADR - P_STACKBASE]



    

restart:    
    mov  esp, [p_proc_ready]
    lldt [esp + P_LDT_SEL]
    lea  eax, [esp + P_STACKTOP]
    mov  dword [tss + TSS3_S_SP0], eax
restart_reenter:    
    dec  dword [k_reenter]
    pop  gs
    pop  fs
    pop  es
    pop  ds
    popad
    add esp, 4
    iretd
