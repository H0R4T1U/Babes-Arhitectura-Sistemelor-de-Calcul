bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data

    x dw 0fffdh

segment code use32 class=code
start:
    mov ax,[ebx]