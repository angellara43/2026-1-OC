; ============================================
; Práctica 7 - Organización de Computadoras
; ============================================

%include "../LIB/pc_iox.inc"

section .data

N dw 0

section .text
    global _start
    extern pHex_dw
    extern putchar      ; NECESARIO para saltos de línea

_start:

; --------------------------------------------
; a) EAX = 0x22446688 -> 0x822446688.
; --------------------------------------------
    mov eax, 0x22446688
    add eax, 0x22446688
    add eax, 0x22446688
    add eax, 0x22446688

    mov ebx, eax
    call pHex_dw

    push ebx
    mov al, 10
    call putchar
    pop eax

; --------------------------------------------
; b) CX = 0x3F48 -> 0xFA40.
; --------------------------------------------
    mov cx, 0x3F48
    add bx, 0x3F48
    add bx, 0x3F48
    add bx, 0x3F48

    mov cx, bx
    call pHex_dw

    push cx
    mov al, 10
    call putchar

; --------------------------------------------
; c) ESI = 0x20D685F3 -> invertir bits.
; --------------------------------------------

    mov ESI, 0x20D685F3

;---------------------------------------------
; d) Guardar ESI en la pila.
;---------------------------------------------
    push bx

    push ESI
    mov al, 10
    call putchar
    pop ESI

;---------------------------------------------
; e) CH -> 0xA7.
;---------------------------------------------

    mov CH, 0xA7

;---------------------------------------------
; f) BP = 0x67DA -> desactivar bits: 1, 4, 6, 10 y 14.
;---------------------------------------------

;---------------------------------------------
; g) N = BP / 8
;---------------------------------------------

    mov al, bl
    mov bl, 8
    mul bl

    mov [N], ax

    movzx eax, ax
    call pHex_dw

    push eax
    mov al, 10
    call putchar
    pop eax

;---------------------------------------------
; h) 
;---------------------------------------------

;---------------------------------------------
; i) 
;---------------------------------------------

    mov cx, dx
    mov dx, 8
    mul dx

    mov [N], ax

    movzx eax, ax
    call pHex_dw

    push eax
    mov al, 10
    call putchar
    pop eax

;---------------------------------------------
; j)
;---------------------------------------------

;---------------------------------------------
; k) 
;---------------------------------------------

    mov ESI, eax
    mov eax, 10
    mul eax

    mov [N], ax

    movzx eax, ax
    call pHex_dw

    push eax
    mov al, 10
    call putchar
    pop eax

; --------------------------------------------
; Salida
; --------------------------------------------
    mov eax, 1
    xor ebx, ebx
    int 0x80