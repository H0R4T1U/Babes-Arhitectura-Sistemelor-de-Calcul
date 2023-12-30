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
    ;(a-b-c)+(d-b-c)-(a-d) 
    a db 12h
    b dw 1234h
    c dd 12345678h
    d dq 0xFEDCBA9876543210
; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        ;a - b - c)
        clc 
        mov al, [a] 
        cbw ; convertim a la word pentru al putea scadea cu b
        sub ax, [b]
        cwd ; convertim la double in caz de borrow
        sbb dx, 0
        push dx
        push ax
        pop eax ; dx:ax -> eax
        cdq ; eax=> edx:eax
        sub eax,[c]
        sbb edx,0 ; scadem din edx:eax dword C
        push edx
        push eax ; impingem pe stiva
        ; final (a - b - c)
        
        ;(d-b-c)
        clc
        mov ebx, [d+0]
        mov ecx, [d+4]; ecx:ebx = qword D
        mov ax, [b]
        cwde ; eax = b
        sub ebx,eax
        sbb ecx, 0 ; d-b
        mov eax, [c]
        sub ebx,eax
        sbb ecx,0 ; d-b-c
        ;(a-b-c)+(d-b-c)

        pop eax
        pop edx ; edx:eax = a-b-c
        add ebx, eax
        adc ecx, edx
        push ecx
        push ebx
        ; stack - > (a-b-c)+(d-b-c)
        ;(a-d)
        mov al, [a]
        cbw
        cwde
        cdq
        sub eax, [d+0]
        sbb edx, [d+4]
        ; sfarsit a-d) (edx:eax) = a-d

        ;ecx:ebx = (a-b-c)+(d-b-c)
        pop ebx
        pop ecx
        sub ebx,eax
        sbb ecx,edx
        ;(a-b-c)+(d-b-c) - (a-d)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
