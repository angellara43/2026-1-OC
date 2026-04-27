; ================================================
; Lara Caldera Ángel. 2222625. Práctica de lab #9.
; ================================================

%include "../LIB/pc_iox.inc"

section .data

section .bss
arreglo resb 10

section .text
global _start
extern getche, puts, putchar

_start:

;====================
; A) Vector tamaño N.
;====================

