; ================================================
; Lara Caldera Ángel. 2222625. Práctica de lab #9.
; ================================================

%include "../LIB/pc_iox.inc"

section .data
msg_input db "Ingrese un vector de tamaño ", 0
msg_enter db "Ingrese valor (0-9): ", 0

section .bss

vector1 resb 10
vector2 resb 10
vector_sum resb 10

section .text
global _start
extern getche, puts, putchar, pHex_b, pHex_dw, clrscr

_start:
call clrscr

;Leer primer vector
mov ebx, vector1
mov ecx, N
call input_vector

mov edx, msg_newline
call puts

;Leer segundo vector
mov ebx, vector2
mov ecx, N
call input_vector

mov edx, msg_newline
call puts

;Calcular suma de vectores
mov ebx, vector1
mov edx, vector2
mov ecx, N
call sum_vectors

;Desplegar suma
mov edx, msg_sum
call puts
mov ebx, vector_sum
mov ecx, N
call output_vector

mov edx, msg_newline
call puts

;Calcular y desplegar producto escalar
mov edx, msg_dot
call puts
mov ebx, vector1
mov edx, vector2
mov ecx, newline
call dot_product

mov al, 10
call putchar

;Salir
mov eax, 1
xor ebx, ebx
int 0x80

;======================================
; A) Procedimiento input_vector
;======================================
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

;====================================
; B) Procedimiento 
;====================================