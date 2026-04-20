; ================================================
; Lara Caldera Ángel. 2222625. Práctica de lab #8.
; ================================================

%include "../LIB/pc_iox.inc"

msg_mnr5 db "Es menor que 5", 0
msg_myr5 db "Es mayor que 5", 0

msg_num db "Es numero", 0
msg_letra db "Es letra", 0
msg_otro db "Es otro caracter", 0

msg_datos db "Datos capturados: ", 0

section .bss
    arreglo resb 10

section .text
    global _start

_start:

;================
;A) Menor que 5.
;=================
call getche
mov bl, al

cmp bl, '5'
jl menor5

mov edx, msg_myr5
call puts
jmp fin_a

menor5:
mov edx, msg_mnr5
call puts

fin_a:

;==================
;B) Letra o numero.
;==================

call getche
mov bl, al

cmp bl, '0'
jl revisar_letra
cmp bl, '9'
jle es_numero

revisar_letra:
cmp bl, 'A'
jl otro
cmp bl, 'Z'
jle es_letra

otro:
mov edx, msg_otro
call puts
jmp fin_b

es_numero:
mov edx, msg_num
call puts
jmp fin_b

es_letra:
mov edx, msg_letra
call puts

fin_b:

;============================
;C) Triangulo con asteriscos.
;============================

mov cx, 5
mov bx, 1

fila_loop:
push cx
mov cx, bx

col_loop:
mov al, '*'
call putc
loop col_loop

call newline

pop cx
inc bx
loop fila_loop

;============
;D) Secuencia
;============

mov cx, 10
mov si, arreglo

captura:
call getche
mov [si], al
inc al
loop captura

mov edx, msg_datos
call puts

mov cx, 10
mov si, arreglo

mostrar:
mov al, [si]
call putc
call newline
inc si
loop mostrar

call exit