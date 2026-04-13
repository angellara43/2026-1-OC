; ============================================
; Práctica 6 - Organización de Computadoras
; Matrícula: 2222625 -> 0x0021E8D1
; ============================================

%include "../LIB/pc_iox.inc"

section .data
    N dw 0              ; Variable de 2 bytes

section .text
    global _start
    extern pHex_dw

_start:

; --------------------------------------------
; a) EBX = 0x5C4B2A60 + matrícula
; --------------------------------------------
    mov ebx, 0x5C4B2A60
    add ebx, 0x0021E8D1

    mov eax, ebx
    call pHex_dw

; --------------------------------------------
; b) Guardar 16 bits bajos en la pila
; --------------------------------------------
    push bx

; --------------------------------------------
; c) N = BL * 8 (sin signo)
; --------------------------------------------
    mov al, bl
    mov bl, 8
    mul bl              ; AX = AL * BL

    mov [N], ax

    movzx eax, ax
    call pHex_dw

; --------------------------------------------
; d) Incrementar N
; --------------------------------------------
    inc word [N]

    movzx eax, word [N]
    call pHex_dw

; --------------------------------------------
; e) BX / 0xFF
; --------------------------------------------
    mov ax, bx
    mov bl, 0xFF
    div bl              ; AL = cociente, AH = residuo

    ; Cociente
    movzx eax, al
    call pHex_dw

    ; Residuo
    movzx eax, ah
    call pHex_dw

; --------------------------------------------
; f) N = N + residuo
; --------------------------------------------
    mov ax, [N]
    add al, ah          ; suma residuo
    mov [N], ax

    movzx eax, word [N]
    call pHex_dw

; --------------------------------------------
; g) Decrementar N
; --------------------------------------------
    dec word [N]

    movzx eax, word [N]
    call pHex_dw

; --------------------------------------------
; h) Recuperar dato de la pila
; --------------------------------------------
    pop bx

    movzx eax, bx
    call pHex_dw

; --------------------------------------------
; Salida
; --------------------------------------------
    mov eax, 1
    xor ebx, ebx
    int 0x80