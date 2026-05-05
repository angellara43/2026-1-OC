;Lara Caldera Ángel. 2222625. Ejercicios Examen #2. OC.

%include "../LIB/pc_iox.inc"

section .data
cadena db "Hola Mundo",0
msg1   db "Cadena original: ",0
msg2   db 10,"Cadena invertida: ",0
msg3   db 10,"Bit probado (CF): ",0
msg4   db 10,"Resultado EsPar (AL): ",0

section .text
global main

; ================================================
; MAIN (prueba de los procedimientos)
; ================================================
main:

    ; ---- Imprimir cadena original ----
    mov ebx, msg1
    call PrintStr

    mov ebx, cadena
    call PrintStr

    ; ---- Invertir cadena ----
    mov ebx, cadena
    call InvertirStr

    mov ebx, msg2
    call PrintStr

    mov ebx, cadena
    call PrintStr

    ; ---- TestBit ----
    mov al, 10101010b   ; ejemplo
    mov cl, 1           ; bit a probar
    call TestBit

    mov ebx, msg3
    call PrintStr

    jc .bit1
    mov al, '0'
    call putchar
    jmp .cont1

.bit1:
    mov al, '1'
    call putchar

.cont1:

    ; ---- EsPar ----
    mov edx, 8
    call EsPar

    mov ebx, msg4
    call PrintStr

    add al, '0'   ; convertir a ASCII
    call putchar

    call newline

    exit


; ================================================
; PrintStr
; Imprime cadena terminada en 0
; Entrada: EBX = dirección cadena
; ================================================
PrintStr:
.next:
    mov al, [ebx]
    cmp al, 0
    je .fin

    call putchar
    inc ebx
    jmp .next

.fin:
    ret


; ================================================
; InvertirStr
; Invierte cadena en memoria
; Entrada: EBX = dirección cadena
; ================================================
InvertirStr:
    mov esi, ebx      ; inicio
    mov edi, ebx      ; fin

.find_end:
    mov al, [edi]
    cmp al, 0
    je .end_found
    inc edi
    jmp .find_end

.end_found:
    dec edi           ; último carácter válido

.swap:
    cmp esi, edi
    jge .fin

    mov al, [esi]
    mov dl, [edi]

    mov [esi], dl
    mov [edi], al

    inc esi
    dec edi
    jmp .swap

.fin:
    ret


; ================================================
; TestBit
; Entrada:
;   AL = valor
;   CL = número de bit (0-7)
; Salida:
;   CF = valor del bit
; ================================================
TestBit:
    mov bl, al
    shr bl, cl
    and bl, 1

    cmp bl, 0
    je .cero

    stc
    ret

.cero:
    clc
    ret


; ================================================
; EsPar
; Entrada:
;   EDX = número
; Salida:
;   AL = 1 si par, 0 si impar
; ================================================
EsPar:
    mov eax, edx
    and eax, 1

    cmp eax, 0
    je .par

    mov al, 0
    ret

.par:
    mov al, 1
    ret