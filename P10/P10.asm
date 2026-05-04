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

pop ebp
ret