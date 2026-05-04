;Lara Caldera Angel. 2222625. Practica de laboratorio #10. OC.

section .text
global suma
global strlen
global getBit

suma: 
push ebp
mov ebp, esp
mov eax, [ebp+8]    ;num1
add eax, [ebp+12]   ;num2

strlen:
push ebp
mov ebp, esp
mov edx, [ebp+8]    ;num1
xor eax, eax        ;num2

.ciclo:
mov cl, byte [edx+eax]
test cl, cl
jz .fin
inc eax
jmp .ciclo
.fin:
pop ebp
ret

getBit:
push ebp
mov ebp, esp
mov eax, [ebp+8]
mov ecx, [ebp+12]
shr eax, cl
and eax, 1
pop ebp
ret