section .text
global suma
global strlen
global getBit

Suma: push ebp
mov ebp, esp
mov eax, [ebp+8] ;num1
add eax, [ebp+12] ;num2

pop ebp
ret