; ================================================
; Lara Caldera Ángel. 2222625. Práctica de lab #7.
; ================================================

%include "../LIB/pc_iox.inc"

section .data
N dw 0

section .text
    global _start
    extern pHex_dw
    extern putchar

_start:

; --------------------------------------------
; a) Rotación
; --------------------------------------------
    mov eax, 0x22446688
    rol eax, 4            ; rotar 4 bits

    call pHex_dw
    call salto

; --------------------------------------------
; b) Corrimiento
; --------------------------------------------
    mov cx, 0x3F48
    shl cx, 2             ; *4

    movzx eax, cx
    call pHex_dw
    call salto

; --------------------------------------------
; c) Invertir bits específicos
; --------------------------------------------
    mov esi, 0x20D685F3

    mov eax, 0
    bts eax, 0
    bts eax, 5
    bts eax, 13
    bts eax, 18
    bts eax, 30

    xor esi, eax

    mov eax, esi
    call pHex_dw
    call salto

; --------------------------------------------
; d) Guardar en pila
; --------------------------------------------
    push esi

; --------------------------------------------
; e) Activar bits 3 y 6
; --------------------------------------------
    mov ch, 0xA7
    or ch, (1 << 3) | (1 << 6)

    movzx eax, ch
    call pHex_dw
    call salto

; --------------------------------------------
; f) Desactivar bits
; --------------------------------------------
    mov bp, 0x67DA

    mov ax, 0FFFFh
    btr ax, 1
    btr ax, 4
    btr ax, 6
    btr ax, 10
    btr ax, 14

    and bp, ax

    movzx eax, bp
    call pHex_dw
    call salto

; --------------------------------------------
; g) BP / 8
; --------------------------------------------
    shr bp, 3

    movzx eax, bp
    call pHex_dw
    call salto

; --------------------------------------------
; h) EBX / 32
; --------------------------------------------
    mov ebx, 0x12345678
    shr ebx, 5

    mov eax, ebx
    call pHex_dw
    call salto

; --------------------------------------------
; i) CX * 8
; --------------------------------------------
    shl cx, 3

    movzx eax, cx
    call pHex_dw
    call salto

; --------------------------------------------
; j) Sacar de pila
; --------------------------------------------
    pop esi

; --------------------------------------------
; k) ESI * 10 (8 + 2)
; --------------------------------------------
    mov eax, esi
    shl eax, 3        ; *8

    mov ebx, esi
    shl ebx, 1        ; *2

    add eax, ebx      ; 8 + 2 = 10

    call pHex_dw
    call salto

; --------------------------------------------
; Salida
; --------------------------------------------
    mov eax, 1
    xor ebx, ebx
    int 0x80


; --------------------------------------------
; salto de línea
; --------------------------------------------
salto:
    push eax
    mov al, 10
    call putchar
    pop eax
    ret