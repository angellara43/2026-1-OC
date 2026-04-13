; ============================================
; Práctica 7 - Organización de Computadoras
; ============================================

%include "../LIB/pc_iox.inc"

section .data

section .text
    global _start
    extern pHex_dw
    extern putchar      ; NECESARIO para saltos de línea

_start:

; --------------------------------------------
; a) EBX = 0x22446688 -> 0x822446688
; --------------------------------------------
    mov ebx, 0x22446688
    add ebx, 0x22446688

    mov eax, ebx
    call pHex_dw

    push eax
    mov al, 10