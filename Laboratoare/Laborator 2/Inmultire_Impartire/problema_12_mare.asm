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
    a db 5
    b db 3
    c db 5
    d db 5
    e dw 5
    f dw 5
    g dw 5
    h dw 5
    ;(a*d+e)/[c+h/(c-b)]  30 / (10/ 2) = 30 / 5 == 6

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        mov al,[a]
        mul byte [d]; ax = a*d
        add ax,[e] ; e = a*d + e
        mov [e],ax
        xor ax , ax
        mov al,[c]
        add ax,[h]
        mov bl,[c]
        sub bl,[b]
        div bl
        mov bl, al
        mov ax ,[e]
        div bl
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
