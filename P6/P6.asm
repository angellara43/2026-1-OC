; ============================================
; Práctica 6 - Organización de Computadoras
; ============================================

section .data
    N dw 0              ; Variable de 2 bytes

section .text
    global _start
    extern pHex_dw      ; Subrutina para imprimir en hexadecimal

_start:

; --------------------------------------------
; a) EBX = 0x5C4B2A60 + matrícula
; --------------------------------------------
    mov ebx, 0x5C4B2A60
    add ebx, 0x2222625

    mov eax, ebx
    call pHex_dw        ; Imprimir EBX

; --------------------------------------------
; b) Guardar 16 bits bajos de EBX en la pila
; --------------------------------------------
    push bx

; --------------------------------------------
; c) N = BL * 8 (sin signo)
; --------------------------------------------
    mov al, bl          ; AL = BL
    mov bl, 8
    mul bl              ; AX = AL * BL

    mov [N], ax         ; Guardar resultado en N

    movzx eax, ax
    call pHex_dw        ; Imprimir N

; --------------------------------------------
; d) Incrementar N
; --------------------------------------------
    inc word [N]

    movzx eax, word [N]
    call pHex_dw

; --------------------------------------------
; e) División BX / 0xFF
; --------------------------------------------
    mov ax, bx
    mov bl, 0xFF
    div bl              ; AL = cociente, AH = residuo

    ; Imprimir cociente
    movzx eax, al
    call pHex_dw

    ; Imprimir residuo
    movzx eax, ah
    call pHex_dw

; --------------------------------------------
; f) N = N + residuo
; --------------------------------------------
    movzx eax, word [N]
    add al, ah          ; Sumar residuo
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
; h) Sacar dato de la pila
; --------------------------------------------
    pop bx

    movzx eax, bx
    call pHex_dw

; --------------------------------------------
; Salida del programa
; --------------------------------------------
    mov eax, 1          ; syscall: exit
    xor ebx, ebx        ; código de salida 0
    int 0x80