;;; boot.asm
;;; Try to find loader and put it to memory. After that, execute the loader.
;;;                                                    Rewrite by Tim Chen, 2014





;%define	_BOOT_DEBUG_

%ifdef    _BOOT_DEBUG_
    org  0100h
%else
    org  07c00h
%endif


%ifdef    _BOOT_DEBUG_
BaseOfStack    equ    0100h
%else
BaseOfStack    equ    07c00h
%endif

%include    "load.inc"


    jmp  short LABEL_START      ; Start to boot.
    nop

%include    "fat12hdr.inc"

LABEL_START:
    mov  ax, cs
    mov  ds, ax
    mov  es, ax
    mov  ss, ax
    mov  sp, BaseOfStack
    

    ;; Clean screen
    mov  ax, 0600h              ; AH = 6, AL = 0h
    mov  bx, 0700h              ; BL = 07h, black background and white foreground
    mov  cx, 0
    mov  dx, 0184Fh
    int  10h

    mov  dh, 0
    call DispStr

    xor  ah, ah                 ; Init. floppy driver
    xor  dl, dl
    int  13h

    ;; Search 'LOADER.bin' in root directory of A:
    mov  word [wSectorNo], SectorNoOfRootDirectory
LABEL_SEARCH_IN_ROOT_DIR_BEGIN:
    cmp  word [wRootDirSizeForLoop], 0
    jz   LABEL_NO_LOADERBIN     ; Were all files read?
    dec  word [wRootDirSizeForLoop]
    mov  ax, BaseOfLoader
    mov  es, ax                 ; es <- BaseOfLoader
    mov  bx, OffsetOfLoader     ; bx <- OffsetOfLoader, so es:bx = BaseOfLoader:OffsetOfLoader
    mov  ax, [wSectorNo]        ; ax <- the number of the selected sector
    mov  cl, 1
    call ReadSector

    mov  si, LoaderFileName     ; ds:si -> 'LOADER  BIN'
    mov  di, OffsetOfLoader     ; es:di -> BaseOfLoader:0100h
    cld
    mov  dx, 10h
LABEL_SEARCH_FOR_LOADERBIN:
    cmp  dx, 0                  ; Control the loop
    jz   LABEL_GOTO_NEXT_SECTOR_IN_ROOT_DIR ; If finish reading a sector
    dec  dx                          ; Read the next sector
    mov  cx, 11
LABEL_CMP_FILENAME:
    cmp  cx, 0
    jz   LABEL_FILENAME_FOUND   ; If all the 11 characters were equal, file was found
    dec  cx
    lodsb                       ; al <- ds:si
    cmp  al, byte [es:di]
    jz   LABEL_GO_ON
    jmp  LABEL_DIFFERENT        ; If a character is different, current file is not we want to find
    ;; Try to compare the next character
LABEL_GO_ON:
    inc  di
    jmp  LABEL_CMP_FILENAME     ; Continue searching

LABEL_DIFFERENT:
    and  di, 0FFE0h             ; di <- di & E0h, let di points to the head of current directory enrty
    add  di, 20h                ; di <- di + 20h, let di points to the head of next directory entry
    mov  si, LoaderFileName
    jmp  LABEL_SEARCH_FOR_LOADERBIN

LABEL_GOTO_NEXT_SECTOR_IN_ROOT_DIR:
    add  word [wSectorNo], 1
    jmp  LABEL_SEARCH_IN_ROOT_DIR_BEGIN

LABEL_NO_LOADERBIN:
    mov  dh, 2
    call DispStr                ; Display 'No LOADER.'
%ifdef    _BOOT_DEBUG_
    mov  ax, 4c00h              ; If in DOS, turn back to DOS
    int  21h
%else
    jmp  $                      ; Else jump to infinity loop
%endif
    ;; File is found, try to copy it to memory
LABEL_FILENAME_FOUND:
    mov  ax, RootDirSectors
    and  di, 0FFE0h             ; let di points to the head of current directory entry
    add  di, 01Ah               ; let di points to the number of the first sector of current directory entry
    mov  cx, word [es:di]
    push cx                     ; Push the number to stack
    add  cx, ax
    add  cx, DeltaSectorNo      ;
    mov  ax, BaseOfLoader
    mov  es, ax
    mov  bx, OffsetOfLoader
    mov  ax, cx
    
LABEL_GOON_LOADING_FILE:
    push ax
    push bx
    mov  ah, 0Eh
    mov  al, '.'
    mov  bl, 0Fh
    int  10h
    pop  bx
    pop  ax

    mov  cl, 1
    call ReadSector
    pop  ax
    call GetFATEntry
    cmp  ax, 0FFFh
    jz   LABEL_FILE_LOADED
    push ax
    mov  dx, RootDirSectors
    add  ax, dx
    add  ax, DeltaSectorNo
    add  bx, [BPB_BytesPerSec]
    jmp  LABEL_GOON_LOADING_FILE
LABEL_FILE_LOADED:

    mov  dh, 1
    call DispStr                ; Display 'Ready.'


    jmp  BaseOfLoader:OffsetOfLoader ; Jump to the head of LOADER.BIN, begin to run LOADER.BIN








    ;; Variables
wRootDirSizeForLoop dw  RootDirSectors
wSectorNo           dw  0
bOdd                db  0


    ;; Strings
LoaderFileName      db  "LOADER  BIN", 0

MessageLength       equ 9       ; Strings bellow must have 9 characters
BootMessage:        db  "Booting  "
Message1            db  "Ready.   "
Message2            db  "No LOADER"








    ;; Display a string, dh saves the item number of this string(0-based)
DispStr:    
    mov  ax, MessageLength
    mul  dh
    add  ax, BootMessage
    mov  bp, ax
    mov  ax, ds
    mov  es, ax                 ; Let es:bp points to the address of string
    mov  cx, MessageLength
    mov  ax, 01301h             ; Set ah = 13h, al = 01h
    mov  bx, 0007h              ; Set bh = 0(bh saves the page number), bl = 07h(bl saves the display back(fore)ground color parameters)
    mov  dl, 0
    int  10h
    ret






    ;; read sectors, which start number is saved in ax and the number of sectors is saved in cl, to es:bx
ReadSector:









    push bp
    mov  bp, sp
    sub  esp, 2

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







GetFATEntry:
    push es
    push bx
    push ax
    mov  ax, BaseOfLoader
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


times   510 - ($-$$)    db  0   ; Fulfill space with 0, so that the binary code's length is 512 byte
dw  0xaa55    












































