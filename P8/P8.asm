; ================================================
; Lara Caldera Ángel. 2222625. Práctica de lab #8.
; ================================================

%include "../LIB/pc_iox.inc"

msg_mnr5 db "Es menor que 5", 0
msg_myr5 db "Es mayor que 5", 0

msg_num db "Es numero", 0
msg_letra db "Es letra", 0
msg_otro db "Es otro caracter", 0

msg_ datos db "Datos capturados: ", 0

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