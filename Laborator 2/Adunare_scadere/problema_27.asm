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
    a DB 10
    b DB 20
    c DB 5
    d DB 5
    ;(a+b-c)-(a+d) BL = 10 = A
; our code starts here
segment code use32 class=code
    start:
        mov al,[a]
        add [b],al ; b = a+b
        mov al,[c]
        sub [b],al ;b = a+b-c
        mov al,[d]
        add [a],al ;a= a+d
        mov bl,[b]
        sub bl,[a] ; bl = (a+b-c) - (a+d)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
