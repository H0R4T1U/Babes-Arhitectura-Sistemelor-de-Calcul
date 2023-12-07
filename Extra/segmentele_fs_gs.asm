bits 32
global start

extern exit
import exit msvcrt.dll




segment code use32 class=code
start:
    jmp real_start
    a db 17
    b dw 1234h
    c dd 12345678h
    d db times 10 (%-d)
    real_start:
        mov eax, [FS:c]
        mov eax,[GS:c]
	push dword 0 
	call [exit] 