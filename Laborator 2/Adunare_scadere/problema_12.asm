bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a DB 15
    b DB 10
    c DB 5
    d DB 5
    ; 2-(c+d)+(a+b-c) 2 - 10 + 20 = 12 = 0c => BX = 000c
; our code starts here
segment code use32 class=code
    start:

        mov al,[c]
        add [d],al; d = c+d
        mov bl,2
        sub bl,[d];2 -(c+d)
        mov al,[a]
        add [b],al; b = a+b
        mov al,[c]
        sub [b],al; b = a+b-c
        add bl,[b]; bx = 2 - (c+d) + (a+b-c)
        
        call    [exit]       