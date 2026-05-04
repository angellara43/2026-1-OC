;Lara Caldera Angel. 2222625. Practica de laboratorio #10. OC.

section .text
global suma
global strlen
global getBit

suma: 
push ebp
mov ebp, esp
mov eax, [ebp+8] ;num1
add eax, [ebp+12] ;num2

strlen:
push ebp
mov ebp, esp
mov edx, [ebp+8]
xor eax, eax

.ciclo:
mov cl, byte
test cl, cl
jz.fin

inc eax
jmp .ciclo

getBit:


pop ebp
ret