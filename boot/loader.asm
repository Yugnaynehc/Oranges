;;; loader.asm
;;; Try to find kernel and put it to memory. After that, load the kernel to
;;; the right place in memory and exectute the kernel.
;;;                                                    Rewrite by Tim Chen, 2014




org 0100h

    jmp  LABEL_START
;;; Head file aoubt FAT12 disk head information, some load information
;;; and some symbol protect mode will used
%include    "fat12hdr.inc"
%include    "load.inc"
%include    "pm.inc"


;;; GDT begin
;;; GDT items                           BaseAddress Limitation  Attributions
LABEL_GDT:              Descriptor      0,          0,          0
LABEL_DESC_FLAT_C:      Descriptor      0,          0FFFFFh,    DA_CR  | DA_32 | DA_LIMIT_4K
LABEL_DESC_FLAT_RW:     Descriptor      0,          0FFFFFh,    DA_DRW | DA_32 | DA_LIMIT_4K
LABEL_DESC_VIDEO:       Descriptor      0B8000h,    0FFFFh,     DA_DRW | DA_DPL3
;;; GTD end

GdtLen      equ     $ - LABEL_GDT
GdtPtr      dw      GdtLen - 1  ; Limitation of GDT
            dd      BaseOfLoaderPhyAddr + LABEL_GDT ; Base address of GDT

;;; GDT selectors
SelectorFlatC       equ     LABEL_DESC_FLAT_C   - LABEL_GDT
SelectorFlatRW      equ     LABEL_DESC_FLAT_RW  - LABEL_GDT
SelectorVideo       equ     LABEL_DESC_VIDEO    - LABEL_GDT + SA_RPL3



BaseOfStack         equ     0100h

;;; Start form here
LABEL_START:
    mov  ax, cs
    mov  ds, ax
    mov  es, ax
    mov  ss, ax
    mov  sp, BaseOfStack

    mov  dh, 0                  ; Points to the first string in string table
    call DispStrRealMode        ; Display 'Loading  '

    ;; Get memory size
    mov  ebx, 0
    mov  di, _MemChkBuf         ; es:di points to an ARDS(Address Range Descriptor Structure)
.MemChkLoop:
    mov  eax, 0E820h
    mov  ecx, 20                ; ecx = the size of an ARDS
    mov  edx, 0534D4150h        ; edx = 'SMAP'
    int  15h
    jc   .MemChkFail
    add  di, 20
    inc  dword [_dwMCRNumber]   ; dwMCRNumber = the number of ARDS
    cmp  ebx, 0
    jne  .MemChkLoop
    jmp  .MemChkOK
.MemChkFail:
    mov  dword [_dwMCRNumber], 0
.MemChkOK:

    ;; Search KERNEL.BIN in root directory of A:
    mov  word [wSectorNo], SectorNoOfRootDirectory
    xor  ah, ah
    xor  dl, dl                 ; Reset floppy driver
    int  13h
LABEL_SEARCH_IN_ROOT_DIR_BEGIN:
    cmp  word [wRootDirSizeForLoop], 0 ; Whether all files in root directory is searched?
    jz   LABEL_NO_KERNELBIN           ; If yes, KERNEL.BIN is not found
    dec  word [wRootDirSizeForLoop]
    mov  ax, BaseOfKernelFile
    mov  es, ax                 ; es = BaseOfKernelFile
    mov  bx, OffsetOfKernelFile ; es:bx = BaseOfKernelFile:OffsetOfKernelFile
    mov  ax, [wSectorNo]        ; ax = the order number of current sector in root directory
    mov  cl, 1
    call ReadSector

    mov  si, KernelFileName     ; ds:si = the address of first byte in string 'KERNEL  BIN'
    mov  di, OffsetOfKernelFile ; es:di = the address that kernel file will be load
    cld
    mov  dx, 10h
LABEL_SEARCH_FOR_KERNELBIN:
    cmp  dx, 0
    jz   LABEL_GOTO_NEXT_SECTOR_IN_ROOT_DIR ; Control the loop times. If finish reading a sector, jump to next one.
    dec  dx
    mov  cx, 11
LABEL_CMP_FILENAME:
    cmp  cx, 0                  ; If all 11 characters are equal, "KERNEL  BIN" is found.
    jz   LABEL_FILENAME_FOUND
    dec  cx
    lodsb                      ; al = ds:si
    cmp  al, byte [es:di]       ; if al == es:di
    jz   LABEL_GO_ON            ; continue to compare next character
    jmp  LABEL_DIFFERENT        ; else, this file is not we want to find
LABEL_GO_ON:
    inc  di                     ; points to next character
    jmp  LABEL_CMP_FILENAME

LABEL_DIFFERENT:
    and  di, 0FFE0h             ; reset pointer, make it points to the begin of a directory entry
    add  di, 20h                ; update pointer, make it points to the next directory entry
    mov  si, KernelFileName     ; reset source pointer and make it points to the begin of 'KERNEL   BIN'
    jmp  LABEL_SEARCH_FOR_KERNELBIN

LABEL_GOTO_NEXT_SECTOR_IN_ROOT_DIR:
    add  word [wSectorNo], 1
    jmp  LABEL_SEARCH_IN_ROOT_DIR_BEGIN

LABEL_NO_KERNELBIN:
    mov  dh, 2                  ; select the third string in string table
    call DispStrRealMode        ; display 'NO KERNEL.'
    jmp  $                      ; Nothing we can do if we could not find kernel.

LABEL_FILENAME_FOUND:           ; if kernel is found
    mov  ax, RootDirSectors    ; ax = RootDirSectors
    and  di, 0FFF0h            ; reset di = the head of current directory entry which is kernel located in

    push eax
    mov  eax, [es:di + 01Ch]
    mov  dword [dwKernelSize], eax ; save the size of kernel file
    pop  eax

    add  di, 01Ah
    mov  cx, word [es:di]       ; es:di = the first cluster's order number of this file
    push cx                     ; save the first cluster's order number of this file
    add  cx, ax
    add  cx, DeltaSectorNo      ; RootDirSectors + DeltaSectorNo + the first cluster's order number = the first sector's order number of this file
    mov  ax, BaseOfKernelFile
    mov  es, ax
    mov  bx, OffsetOfKernelFile
    mov  ax, cx

LABEL_GOON_LOADING_FILE:
    push ax                     ; save the first sector's order number of this file
    push bx                     ; save the offset which we want to put kernel file in
    mov  ah, 0Eh
    mov  al, '.'
    mov  bl, 0Fh
    int  10h                    ; display 'Loading ...'
    pop  bx
    pop  ax

    mov  cl, 1
    call ReadSector
    pop  ax                     ; ax = the cluster's order number of this file which we are going to read
    call GetFATEntry            ; read the next sector of this file, and find the next cluster's order number of this file, save it to ax
    cmp  ax, 0FFFh              ; if ax = 0FFFh, all cluster have been read
    jz   LABEL_FILE_LOADED
    push ax                     ; save the next cluser's order number of this file
    mov  dx, RootDirSectors
    add  ax, dx
    add  ax, DeltaSectorNo      ; ax = the next sector's order number of this file
    add  bx, [BPB_BytesPerSec]   ; update destination pointer
    jmp  LABEL_GOON_LOADING_FILE
LABEL_FILE_LOADED:

    call KillMotor              ; kill floppy drive's motor

    mov  dh, 1                  ; select the second string in string table
    call DispStrRealMode        ; display 'Ready.'

;;; Prepate to eneter protect mode

    ;; load GDTR
    lgdt [GdtPtr]


    cli

    ;; open A20
    in   al, 92h
    or   al, 00000010b
    out  92h, al

    ;; update cr0, set PE = 1
    mov  eax, cr0
    or   eax, 1
    mov  cr0, eax

    ;; enter protect mode
    jmp  dword SelectorFlatC:(BaseOfLoaderPhyAddr+LABEL_PM_START)



;;; some variables

wRootDirSizeForLoop     dw      RootDirSectors ; the number of root directory's sectors
wSectorNo               dw      0              ; the order number of sector which we want to read
bOdd                    db      0              ; an odd/even flag
dwKernelSize            dd      0              ; the size of kernel file


;;; some strings

KernelFileName          db      "KERNEL  BIN", 0
MessageLength           equ     9
LoadMessage:            db      "Loading  "
Message1:               db      "Ready.   "
Message2:               db      "No KERNEL"






;;; Display a string in real mode
;;; the order number of string in string table is saved in ah(0-based)


DispStrRealMode:
    mov  ax, MessageLength
    mul  dh
    add  ax, LoadMessage
    mov  bp, ax
    mov  ax, ds
    mov  es, ax
    mov  cx, MessageLength
    mov  ax, 01301h
    mov  bx, 0007h
    mov  dl, 0
    add  dh, 3
    int  10h
    ret


;;; Read sectors
;;; the begin sector's order number is saved in ax, the number of sectors will be read is saved in cl
;;; write them to es:bx
ReadSector:
; -----------------------------------------------------------------------
    ; 怎样由扇区号求扇区在磁盘中的位置 (扇区号 -> 柱面号, 起始扇区, 磁头号)
    ; -----------------------------------------------------------------------
    ; 设扇区号为 x
    ;                           ┌ 柱面号 = y >> 1
    ;       x           ┌ 商 y ┤
    ; -------------- => ┤      └ 磁头号 = y & 1
    ;  每磁道扇区数     │
    ;                   └ 余 z => 起始扇区号 = z + 1
    push bp
    mov  bp, sp
    sub  esp, 2                 ; creat 2 bytes space in stack to save the number of sectors will be read

    mov  byte [bp-2], cl
    push bx
    mov  bl, [BPB_SecPerTrk]
    div  bl
    inc  ah
    mov  cl, ah
    mov  dh, al
    shr  al, 1
    mov  ch, al
    and  dh, 1
    pop  bx

    mov  dl, [BS_DrvNum]
.GoOnReading:
    mov  ah, 2
    mov  al, byte [bp-2]
    int  13h
    jc   .GoOnReading

    add  esp, 2
    pop  bp

    ret



;;; Get the FAT entry
;;; accoring the cluster order number to find the sector's FAT entry
;;; the cluster order number is saved in ax
;;; write the result to es:bx
GetFATEntry:
    push es
    push bx
    push ax
    mov  ax, BaseOfKernelFile
    sub  ax, 0100h
    mov  es, ax
    pop  ax
    mov  byte [bOdd], 0
    mov  bx, 3
    mul  bx
    mov  bx, 2
    div  bx
    cmp  dx, 0
    jz   LABEL_EVEN
    mov  byte [bOdd], 1
LABEL_EVEN:
    xor  dx, dx
    mov  bx, [BPB_BytesPerSec]
    div  bx

    push dx
    mov  bx, 0
    add  ax, SectorNoOfFAT1
    mov  cl, 2
    call ReadSector
    pop  dx
    add  bx, dx
    mov  ax, [es:bx]
    cmp  byte [bOdd], 1
    jnz  LABEL_EVEN_2
    shr  ax, 4
LABEL_EVEN_2:
    and  ax, 0FFFh

LABEL_GET_FAT_ENTRY_OK:

    pop  bx
    pop  es
    ret





;;; Kill the floppy's motor


KillMotor:
    push dx
    mov  dx, 03F2h
    mov  al, 0
    out  dx, al
    pop  dx
    ret



;;; This code is running in protected mode

[SECTION .s32]

ALIGN   32

[BITS   32]

LABEL_PM_START:
    mov  ax, SelectorVideo
    mov  gs, ax
    mov  ax, SelectorFlatRW
    mov  ds, ax
    mov  es, ax
    mov  fs, ax
    mov  ss, ax
    mov  esp, TopOfStack

    push szMemChkTitle
    call DispStr
    add  esp, 4

    call DispMemInfo
    call SetupPaging



	
    ;; load kernel to correct place
    call InitKernel


	
    ;; ;; jump to kernel
    jmp  SelectorFlatC:KernelEntryPointPhyAddr
    ;***************************************************************
    ; 内存看上去是这样的：
    ;              ┃                                    ┃
    ;              ┃                 .                  ┃
    ;              ┃                 .                  ┃
    ;              ┃                 .                  ┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃■■■■■■■■■■■■■■■■■■┃
    ;              ┃■■■■■■Page  Tables■■■■■■┃
    ;              ┃■■■■■(大小由LOADER决定)■■■■┃
    ;    00101000h ┃■■■■■■■■■■■■■■■■■■┃ PageTblBase
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃■■■■■■■■■■■■■■■■■■┃
    ;    00100000h ┃■■■■Page Directory Table■■■■┃ PageDirBase  <- 1M
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃□□□□□□□□□□□□□□□□□□┃
    ;       F0000h ┃□□□□□□□System ROM□□□□□□┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃□□□□□□□□□□□□□□□□□□┃
    ;       E0000h ┃□□□□Expansion of system ROM □□┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃□□□□□□□□□□□□□□□□□□┃
    ;       C0000h ┃□□□Reserved for ROM expansion□□┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃□□□□□□□□□□□□□□□□□□┃ B8000h ← gs
    ;       A0000h ┃□□□Display adapter reserved□□□┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃□□□□□□□□□□□□□□□□□□┃
    ;       9FC00h ┃□□extended BIOS data area (EBDA)□┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃■■■■■■■■■■■■■■■■■■┃
    ;       90000h ┃■■■■■■■LOADER.BIN■■■■■■┃ somewhere in LOADER ← esp
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃■■■■■■■■■■■■■■■■■■┃
    ;       80000h ┃■■■■■■■KERNEL.BIN■■■■■■┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃■■■■■■■■■■■■■■■■■■┃
    ;       30000h ┃■■■■■■■■KERNEL■■■■■■■┃ 30400h ← KERNEL 入口 (KernelEntryPointPhyAddr)
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃                                    ┃
    ;        7E00h ┃              F  R  E  E            ┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃■■■■■■■■■■■■■■■■■■┃
    ;        7C00h ┃■■■■■■BOOT  SECTOR■■■■■■┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃                                    ┃
    ;         500h ┃              F  R  E  E            ┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃□□□□□□□□□□□□□□□□□□┃
    ;         400h ┃□□□□ROM BIOS parameter area □□┃
    ;              ┣━━━━━━━━━━━━━━━━━━┫
    ;              ┃◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇◇┃
    ;           0h ┃◇◇◇◇◇◇Int  Vectors◇◇◇◇◇◇┃
    ;              ┗━━━━━━━━━━━━━━━━━━┛ ← cs, ds, es, fs, ss
    ;
    ;
    ;		┏━━━┓		┏━━━┓
    ;		┃■■■┃ 我们使用     ┃□□□┃ 不能使用的内存
    ;		┗━━━┛		┗━━━┛
    ;		┏━━━┓		┏━━━┓
    ;		┃      ┃ 未使用空间	┃◇◇◇┃ 可以覆盖的内存
    ;		┗━━━┛		┗━━━┛
    ;
    ; 注：KERNEL 的位置实际上是很灵活的，可以通过同时改变 LOAD.INC 中的 KernelEntryPointPhyAddr 和 MAKEFILE 中参数 -Ttext 的值来改变。
    ;     比如，如果把 KernelEntryPointPhyAddr 和 -Ttext 的值都改为 0x400400，则 KERNEL 就会被加载到内存 0x400000(4M) 处，入口在 0x400400。
    ;




;;; Display number which saved in al


DispAL:
    push ecx
    push edx
    push edi

    mov  edi, [dwDispPos]

    mov  ah, 0Fh                ; 0000b->black background,  1111b->white foreground
    mov  dl, al
    shr  al, 4
    mov  ecx, 2
.begin:
    and  al, 01111b
    cmp  al, 9
    ja   .1
    add  al, '0'
    jmp  .2
.1:
    sub  al, 0Ah
    add  al, 'A'
.2:
    mov  [gs:edi], ax
    add  edi, 2

    mov  al, dl
    loop .begin


    mov  [dwDispPos], edi

    pop  edi
    pop  edx
    pop  ecx

    ret




;;; Display an integer

DispInt:
    mov  eax, [esp+4]
    shr  eax, 24
    call DispAL

    mov  eax, [esp+4]
    shr  eax, 16
    call DispAL

    mov  eax, [esp+4]
    shr  eax, 8
    call DispAL

    mov  eax, [esp+4]
    call DispAL

    mov  ah, 07h
    mov  al, 'h'
    push edi
    mov  edi, [dwDispPos]
    mov  [gs:edi], ax
    add  edi, 4
    mov  [dwDispPos], edi
    pop  edi

    ret



;;; Display a string

DispStr:
    push ebp
    mov  ebp, esp
    push ebx
    push esi
    push edi

    mov  esi, [ebp + 8]
    mov  edi, [dwDispPos]
    mov  ah, 0Fh
.1:
    lodsb
    test al, al
    jz   .2
    cmp  al, 0Ah                ; Is there an ENTER?
    jnz  .3
    push eax
    mov  eax, edi
    mov  bl, 160
    div  bl
    and  eax, 0FFh
    inc  eax
    mov  bl, 160
    mul  bl
    mov  edi, eax
    pop  eax
    jmp  .1
.3:
    mov  [gs:edi], ax
    add  edi, 2
    jmp  .1

.2:
    mov  [dwDispPos], edi

    pop edi
    pop esi
    pop ebx
    pop ebp
    ret



;;; Display a newline

DispReturn:
    push szReturn
    call DispStr
    add  esp, 4

    ret





;;; Memory copy, just like memcpy in C
;;; void* MemCpy(void* es:pDest, void* ds:pSrc, int iSieze);

MemCpy:
    push ebp
    mov  ebp, esp

    push esi
    push edi
    push ecx

    mov  edi, [ebp+8]           ; Destination
    mov  esi, [ebp+12]          ; Source
    mov  ecx, [ebp+16]          ; Counter
.1:
    cmp  ecx, 0
    jz   .2

    mov  al, [ds:esi]
    inc  esi

    mov  byte [es:edi], al
    inc  edi

    dec  ecx
    jmp  .1
.2:
    mov  eax, [ebp+8]

    pop  ecx
    pop  edi
    pop  esi
    mov  esp, ebp
    pop  ebp

    ret




;;; Display memory infomation

DispMemInfo:
    push esi
    push edi
    push ecx

    mov  esi, MemChkBuf
    mov  ecx, [dwMCRNumber]
.loop:
    mov  edx, 5
    mov  edi, ARDStruct
.1:
    push dword [esi]
    call DispInt
    pop  eax
    stosd
    add  esi, 4
    dec  edx
    cmp  edx, 0
    jnz  .1
    call DispReturn
    cmp  dword [dwType], 1
    jne  .2
    mov  eax, [dwBaseAddrLow]
    add  eax, [dwLengthLow]
    cmp  eax, [dwMemSize]
    jb   .2
    mov  [dwMemSize], eax
.2:
    loop .loop

    call DispReturn
    push szRAMSize
    call DispStr
    add  esp, 4

    push dword [dwMemSize]
    call DispInt
    add  esp, 4

    pop  ecx
    pop  edi
    pop  esi
    ret

;;; Setup paging

SetupPaging:
    ;; calculate how much PDEs and page tables we need
    xor  edx, edx
    mov  eax, [dwMemSize]
    mov  ebx, 400000h           ; 400000h is the size of a page table
    div  ebx
    mov  ecx, eax               ; ecx = the number of page table
    test edx, edx
    jz   .no_remainder          ; if there is a remainder, add one page table
    inc  ecx
.no_remainder:
    push ecx

    ;; for simplism, all liner addres are equal to physical address,
    ;; and we don't consider about memory hole
    ;; next, begin to initial page table directory
    mov  ax, SelectorFlatRW
    mov  es, ax
    mov  edi, PageDirBase
    xor  eax, eax
    mov  eax, PageTblBase | PG_P | PG_USU | PG_RWW
.1:
    stosd
    add  eax, 4096              ; for simplism, all page table is continued in memory
    loop .1

    ;; then, begin to initial all page table
    pop  eax                    ; eax = the number of page tables
    mov  ebx, 1024              ; each page tables has 1024 entries
    mul  ebx
    mov  ecx, eax               ; there are 1024 * (the number of page tables) table entries in all
    mov  edi, PageTblBase
    xor  eax, eax
    mov  eax, PG_P | PG_USU | PG_RWW
.2:
    stosd
    add  eax, 4096              ; each page points to a 4K memory space
    loop .2

    mov  eax, PageDirBase
    mov  cr3, eax
    mov  eax, cr0
    or   eax, 80000000h
    mov  cr0, eax
    jmp  short .3
.3:
    nop

    ret





;;; Analyze the kernel file, and load it to the correct place

InitKernel:
    xor  esi, esi
    mov  cx, word [BaseOfKernelFilePhyAddr + 2Ch]
    movzx  ecx, cx
    mov  esi, [BaseOfKernelFilePhyAddr + 1Ch]
    add  esi, BaseOfKernelFilePhyAddr
.Begin:
    mov  eax, [esi + 0]
    cmp  eax, 0
    jz   .NoAction
    push dword [esi + 010h]
    mov  eax, [esi + 04h]
    add  eax, BaseOfKernelFilePhyAddr
    push eax
    push dword [esi + 08h]
    call MemCpy
    add  esp, 12
.NoAction:
    add  esi, 020h
    dec  ecx
    jnz  .Begin

    ret




[SECTION .data1]

ALIGN   32

LABEL_DATA:
;;; use these symbol in read mode
;;; strings
_szMemChkTitle:         db      "BaseAddrl BaseAddrH LengthLow LengthHigh   Type", 0Ah, 0
_szRAMSize:             db      "RAM size:", 0
_szReturn:              db      0Ah, 0
;;; variables
_dwMCRNumber:           dd      0
_dwDispPos:             dd      (80 * 6 + 0) * 2
_dwMemSize:		        dd	    0
_ARDStruct:
    _dwBaseAddrLow:     dd      0
    _dwBaseAddrHigh:    dd      0
    _dwLengthLow:       dd      0
    _dwLengthHigh:      dd      0
    _dwType:            dd      0
_MemChkBuf: times 256   db      0


;;; use these symbol in protect mode
szMemChkTitle           equ     BaseOfLoaderPhyAddr + _szMemChkTitle
szRAMSize               equ     BaseOfLoaderPhyAddr + _szRAMSize
szReturn                equ     BaseOfLoaderPhyAddr + _szReturn
dwDispPos               equ     BaseOfLoaderPhyAddr + _dwDispPos
dwMemSize               equ     BaseOfLoaderPhyAddr + _dwMemSize
dwMCRNumber             equ     BaseOfLoaderPhyAddr + _dwMCRNumber
ARDStruct               equ     BaseOfLoaderPhyAddr + _ARDStruct
    dwBaseAddrLow       equ     BaseOfLoaderPhyAddr + _dwBaseAddrLow
    dwBaseAddrHigh      equ     BaseOfLoaderPhyAddr + _dwBaseAddrHigh
    dwLengthLow         equ     BaseOfLoaderPhyAddr + _dwLengthLow
    dwLengthHigh        equ     BaseOfLoaderPhyAddr + _dwLengthHigh
    dwType              equ     BaseOfLoaderPhyAddr + _dwType
MemChkBuf               equ     BaseOfLoaderPhyAddr + _MemChkBuf


;;; stack is at the end of data segment
StackSpace: times 1000h db      0
TopOfStack              equ     BaseOfLoaderPhyAddr + $ ; stack pointer
