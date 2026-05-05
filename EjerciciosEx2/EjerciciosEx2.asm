;Lara Caldera Ángel. 2222625. Ejercicios Examen #2. OC.

%include "../LIB/pc_iox.inc"

section .data
cadena db "Hola Mundo", 0
msg1   db "Cadena original: ", 0
msg2   db 10,"Cadena invertida: ", 0
msg3   db 10,"Bit probado (CF): ", 0
msg4   db 10,"Resultado EsPar (AL): ", 0

section .text
global _start

_start:
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
    mov al, 10101010b
    mov cl, 1
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

    add al, '0'
    call putchar

    mov al, 10
    call putchar

    mov eax, 1
    mov ebx, 0
    int 0x80
    
; ================================================ 
; 1. Procedimiento PrintStr. 
; ================================================
PrintStr:
    push ebx

.next:
    mov al, [ebx]
    cmp al, 0
    je .fin

    call putchar
    inc ebx
    jmp .next

.fin:
    pop ebx
    ret

; ================================================ 
; 2. Procedimiento de invertir cadena. 
; ================================================
InvertirStr:
    push esi
    push edi

    mov esi, ebx
    mov edi, ebx

.find_end:
    mov al, [edi]
    cmp al, 0
    je .end_found
    inc edi
    jmp .find_end

.end_found:
    dec edi

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
    pop edi
    pop esi
    ret

; ================================================ 
; 3. Procedimiento del estado de un bit. 
; ================================================
TestBit:
    push eax

    shr al, cl
    shr al, 1

    pop eax
    ret

; ================================================ 
; 4. Procedimiento si EDX es par retorna 1 en AL. 
; ================================================
EsPar:
    mov al, 0
    test edx, 1
    jnz .fin
    mov al, 1
.fin:
    ret