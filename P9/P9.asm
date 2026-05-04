; ================================================
; Lara Caldera Ángel. 2222625. Práctica de lab #9.
; ================================================

%include "../LIB/pc_iox.inc"

N       equ 5

section .data
msg_title     db "Suma y producto escalar de vectores", 10, 0
msg_first     db "Ingrese primer vector:", 10, 0
msg_second    db "Ingrese segundo vector:", 10, 0
msg_sum       db "Vector suma:", 10, 0
msg_dot       db "Producto escalar: ", 0
msg_enter     db "Ingrese valor (0-9): ", 0

section .bss
vector1       resb N
vector2       resb N
scalar_result resd 1

section .text
global _start
extern getche, puts, putchar, pHex_b, pHex_dw, clrscr

_start:
    call clrscr

    mov edx, msg_title
    call puts

    ; ===== Vector 1 =====
    mov edx, msg_first
    call puts
    mov ebx, vector1
    mov ecx, N
    call input_vector

    ; ===== Vector 2 =====
    mov edx, msg_second
    call puts
    mov ebx, vector2
    mov ecx, N
    call input_vector

    ; ===== Producto escalar =====
    mov ebx, vector1
    mov edx, vector2
    mov ecx, N
    call dot_product
    mov [scalar_result], eax

    ; ===== Suma de vectores =====
    mov ebx, vector1
    mov edx, vector2
    mov ecx, N
    call sum_vectors

    ; ===== Mostrar suma =====
    mov edx, msg_sum
    call puts
    mov ebx, vector1
    mov ecx, N
    call output_vector
    mov al, 10
    call putchar

    ; ===== Mostrar producto escalar =====
    mov edx, msg_dot
    call puts
    mov eax, [scalar_result]
    call pHex_dw
    mov al, 10
    call putchar

    ; ===== Salida =====
    mov eax, 1
    xor ebx, ebx
    int 0x80

;==============================
; A) input_vector
;==============================
input_vector:
    push eax
    push ebx
    push ecx
    push esi

    xor esi, esi

.input_loop:
    cmp esi, ecx
    jge .done

    mov edx, msg_enter
    call puts

.read:
    call getche
    sub al, '0'

    cmp al, 0
    jb .read
    cmp al, 9
    ja .read

    mov [ebx + esi], al
    inc esi
    jmp .input_loop

.done:
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret

;==============================
; B) output_vector
;==============================
output_vector:
    push eax
    push ebx
    push ecx
    push esi

    xor esi, esi

.loop:
    cmp esi, ecx
    jge .done

    mov al, [ebx + esi]
    call pHex_b

    mov al, ' '
    call putchar

    inc esi
    jmp .loop

.done:
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret

;==============================
; C) sum_vectors
;==============================
sum_vectors:
    push eax
    push ebx
    push ecx
    push edx
    push esi

    xor esi, esi

.loop:
    cmp esi, ecx
    jge .done

    mov al, [ebx + esi]
    add al, [edx + esi]
    mov [ebx + esi], al

    inc esi
    jmp .loop

.done:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

;==============================
; D) dot_product (CORREGIDO)
;==============================
dot_product:
    push ebx
    push ecx
    push edx
    push esi
    push edi

    xor eax, eax        ; resultado
    xor esi, esi

.loop:
    cmp esi, ecx
    jge .done

    ; cargar valores SIN destruir punteros
    movzx edi, byte [ebx + esi]   ; v1[i]
    movzx edx, byte [edx + esi]   ; v2[i]

    imul edi, edx
    add eax, edi

    inc esi
    jmp .loop

.done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret