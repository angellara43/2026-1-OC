;Lara Caldera Ángel. 2222625. Ejercicios Examen #2. OC.

;===========================
; 1. Procedimiento PrintStr.
;===========================

PrintStr:
.next:
mov al, [ebx]
cmp al, 0
je .fin

call putchar

inc ebx
jmp .next

.fin
ret

;=======================================
; 2. Procedimiento para invertir cadena.
;=======================================

invertirStr:
mov esi, ebx
mov edi, ebx

.find_end:
mov al, [edi]
cmp al, 0
je .end_found
inc edi
jmp .find_end

.end_found
dec edi

.swap:
cmp esi, edi
jge .fin

mov al, [esi]
mov dl, [esi]

mov [esi], dl
mov [edi], al

inc esi
dec edi
jmp .swap

.fin:
ret

;==========================================
; 3. Procedimiento para tomar un bit de AL.
;==========================================

TestBit:
mov bl, al
shr bl, cl
and bl, 1

cmp bl, 0
je .cero

stc
ret

.cero
clc
ret

;==============================================================
; 4. Procedimiento para determinar si EDX es par retorna en AL.
;==============================================================

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