bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;(a+c)-(d+b)
    a db 12h
    b dw 1234h
    c dd 01234567h
    d dq 0123456789ABCDEFh
; our code starts here
segment code use32 class=code
    start:
        ; a+c
        clc
        mov edx,0
        mov eax, 0
        mov al, [a]
        add eax,[c]
        adc edx, 0
        push edx
        push eax
        ;edx:eax = a+c
        ; d+b
        clc
        mov ebx, [d+0]
        mov ecx, [d+4]
        mov eax,0
        mov ax,[b] 
        add ebx, eax
        adc ecx, 0
        ;a+c - d+b
        clc
        pop eax
        pop edx
        sub eax,ebx
        sbb edx,ecx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
