;Lara Caldera Angel. 2222625. Practica de laboratorio #11. OC.

bits 32

section .text
global pBin8b
global pBin16b
global pBin32b
global pBin64b

pBin8b:
    push ebp
    mov ebp, esp

    movzx eax, byte[ebp+8]
    mov ecx, 8
    call print_bits_eax

    pop ebp
    ret

pBin16b:
    push ebp
    mov ebp, esp

    movzx eax, word[ebp+8]
    mov ecx, 16
    call print_bits_eax

    pop ebp
    ret

pBin32b:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    mov ecx, 32
    call print_bits_eax

    pop ebp
    ret

pBin64b:
    push ebp
    mov ebp, esp

    mov eax, [ebp+12]
    mov ecx, 32
    call print_bits_eax

    mov eax, [ebp+8]
    mov ecx, 32
    call print_bits_eax

    pop
    ebp
    ret

print_bits_eax:
    push ebx

    mov ebx, eax

.next_bit:
    dec ecx
    bt ebx, ecx
    mov al, '0'
    adc al, 0
    call my_putchar
    test ecx, ecx
    jnz .next_bit

    pop ebx
    ret

;********************************************************************************
; Procedimiento para desplegar un caracter en pantalla dado en el registro AL
; Forma de uso: 
;                               mov al,'X'
;                               call my_putchar   ; se presenta en pantalla X 
;
;   Nota: Este procedimiento salva todos los registros al inicio y los recupera al final  
;              por lo que no al retornar no afecta a los registros utilizados.
;
my_putchar: pushad                 ; salvar todos los registros
                        push eax              ; salvar EAX -- meter el caracter a la pila
                        mov eax,4            ; seleccionar el tipo llamada al sistema --> write (sys_write)
                        mov ebx,1            ;  seleccionar la salida a pantalla ---> File descriptor 1 - standard output
                        mov ecx,esp        ; ECX debe apuntar a la cadena, en este caso un caracter que está en la pila
                        mov edx,1            ; EDX debe tener la longitud de la cadena, en este caso uno solo caracter
                        int 80h                 ; llamar al sistema (escritura al standard output -- pantalla)
                        pop eax                ; recuperar EXA 
                        popad                  ; recuperar todos los registros
                        ret
;********************************************************************************