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
    a db 12h
    b dw 3040h
    c dd 30405060h
    d dq 0123456789ABCDEFh
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(a+b+d)-(a-c+d)+(b-c) 
        ; a+b+d : edx:eax 
        ; a-c+d : ecx:ebx
        ; b-c : edx:eax -> push pe stack 
        ; ordine operatii -> B-c dupa a+b+d dupa a-c+d
        ; exit(0)
        ; b-c -> stack
        clc
        xor eax, eax; 0 eax`
        mov ax, [b]; eax = b
        mov edx, 0; edx = 0
        sub eax, [c]; eax = b-c(partea de 32)
        sbb edx, 0; -> b-c = edx:eax(restu scaderii)
        push edx ; partea superioara o luam la final
        push eax ; partea inferioara o luam la inceput
        ; STACK b-c
        
        ; a+b+d a byte b word d quad
        clc
        mov eax, 0
        mov ax, [b] ; ax = b
        mov bx, 0
        mov bl, [a] ; bx = a
        add ax,bx
        adc eax,0
        ;eax = a+b
        mov ebx,[d+0]
        mov ecx, [d+4]
        add ebx,eax
        adc ecx,0
        ;; ecx:ebx = a+b+d
        
        ; a-c+d
        clc
        mov edx, 0
        mov eax, 0 
        mov al, [a]
        sub eax, [c]
        sbb edx, 0
        add eax, [d+0]
        adc edx, [d+4]
        ;sfarsit edx:eax = a-c+d
        
        ;ecx:ebx - edx:eax
        sub ebx, eax
        sbb ecx, edx 

        ; + b-c(stack)
        pop eax
        pop edx
        
        add ebx,eax
        adc ecx,edx
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
