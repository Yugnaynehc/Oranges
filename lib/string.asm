






[SECTION .text]

;;; export functions
global memcpy    
global memset



;;; void memcpy(void *es:p_dst, void *ds:p_src, int size);
memcpy:
    push ebp
    mov  ebp, esp

    push esi
    push edi
    push ecx

    mov  edi, [ebp + 8]         ; edi = p_dst
    mov  esi, [ebp + 12]        ; dsi = p_src
    mov  ecx, [ebp + 16]        ; ecx = size
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
    mov  eax, [ebp + 8]

    pop  ecx
    pop  edi
    pop  esi
    mov  esp, ebp
    pop  ebp

    ret
    





;;; void memset(void* p_dst, char ch, int size);
memset:
    push ebp
    mov  ebp, esp

    push esi
    push edi
    push ecx

    mov  edi, [ebp + 8]         ; edi = p_dst
    mov  esi, [ebp + 12]        ; dsi = p_src
    mov  ecx, [ebp + 16]        ; ecx = size
.1:
    cmp  ecx, 0
    jz   .2

    mov  byte [edi], dl
    inc  edi

    dec  ecx
    jmp  .1
.2:

    pop  ecx
    pop  edi
    pop  esi
    mov  esp, ebp
    pop  ebp

    ret
