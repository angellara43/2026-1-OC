BITS 32

section .text

%ifdef WIN32
    %define CNAME(name) _ %+ name
%else
    %define CNAME(name) name
%endif

global CNAME(strlen)
global CNAME(str_mid)
global CNAME(clrBit)

; int strlen(char *str)
; Retorna la cantidad de caracteres antes del byte nulo final.
CNAME(strlen):
    push ebp
    mov  ebp, esp

    mov  edx, [ebp + 8]      ; edx = str
    xor  eax, eax            ; eax = contador / valor de retorno

.strlen_loop:
    cmp  byte [edx + eax], 0
    je   .strlen_done
    inc  eax
    jmp  .strlen_loop

.strlen_done:
    mov  esp, ebp
    pop  ebp
    ret

; void str_mid(char *str_out, char *str1_in, int start, int end)
; Copia str1_in[start] hasta str1_in[end], inclusive, y termina con 0.
CNAME(str_mid):
    push ebp
    mov  ebp, esp
    push ebx                 ; ebx es preservado por la convencion cdecl

    mov  eax, [ebp + 8]      ; eax = posicion actual en str_out
    mov  edx, [ebp + 12]     ; edx = str1_in
    mov  ecx, [ebp + 16]     ; ecx = start

    cmp  ecx, [ebp + 20]     ; si start > end, salida vacia
    jg   .mid_done

    add  edx, ecx            ; edx = &str1_in[start]
    mov  ecx, [ebp + 20]     ; ecx = end
    sub  ecx, [ebp + 16]     ; ecx = end - start
    inc  ecx                 ; ecx = cantidad de caracteres a copiar

.mid_loop:
    cmp  ecx, 0
    jle  .mid_done

    mov  bl, [edx]
    cmp  bl, 0               ; no copiar mas alla del fin real de la cadena
    je   .mid_done

    mov  [eax], bl
    inc  eax
    inc  edx
    dec  ecx
    jmp  .mid_loop

.mid_done:
    mov  byte [eax], 0       ; terminar str_out con caracter nulo

    pop  ebx
    mov  esp, ebp
    pop  ebp
    ret

; int clrBit(int value, int nbit)
; Retorna value con el bit nbit apagado.
CNAME(clrBit):
    push ebp
    mov  ebp, esp

    mov  eax, [ebp + 8]      ; eax = value
    mov  ecx, [ebp + 12]     ; cl = nbit
    mov  edx, 1
    shl  edx, cl             ; edx = 1 << nbit
    not  edx                 ; edx = mascara con ese bit en 0
    and  eax, edx            ; eax = value & ~(1 << nbit)

    mov  esp, ebp
    pop  ebp
    ret