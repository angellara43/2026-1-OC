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
msg_newline   db 10, 0

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

    mov edx, msg_first
    call puts
    mov ebx, vector1
    mov ecx, N
    call input_vector

    mov edx, msg_second
    call puts
    mov ebx, vector2
    mov ecx, N
    call input_vector

    ; Calcular producto escalar primero
    mov ebx, vector1
    mov edx, vector2
    mov ecx, N
    call dot_product
    mov [scalar_result], eax

    ; Calcular suma de vectores en vector1
    mov ebx, vector1
    mov edx, vector2
    mov ecx, N
    call sum_vectors

    ; Mostrar vector suma
    mov edx, msg_sum
    call puts
    mov ebx, vector1
    mov ecx, N
    call output_vector
    mov al, 10
    call putchar

    ; Mostrar producto escalar
    mov edx, msg_dot
    call puts
    mov eax, [scalar_result]
    call pHex_dw
    mov al, 10
    call putchar

    mov eax, 1
    xor ebx, ebx
    int 0x80

;==============================
; A) Procedimiento input_vector
;==============================
input_vector:
push eax
push ebx
push ecx
push esi

xor esi, esi

.input_loop:
cmp esi, ecx
jge .input_done

mov edx, msg_enter
call puts

;Leer caracter
call getche
sub al, '0'
    
;Validar que esté en rango 0-9
cmp al, 0
jb .input_loop
cmp al, 9
ja .input_loop

;Almacenar el valor en el vector
mov byte [ebx + esi], al
inc esi
jmp .input_loop

.input_done:
pop esi
pop ecx
pop ebx
pop eax
ret

;===============================
; B) Procedimiento output_vector
;===============================
output_vector:
    push eax
    push ebx
    push ecx
    push esi

    xor esi, esi

.output_loop:
    cmp esi, ecx
    jge .output_done

    mov al, [ebx + esi]
    call pHex_b

    mov al, ' '
    call putchar

    inc esi
    jmp .output_loop

.output_done:
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret