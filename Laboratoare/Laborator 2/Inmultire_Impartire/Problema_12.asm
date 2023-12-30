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
    a DB 15
    b DB 10
    c DB 15
    d DW 20
    ;a*[b+c+d/b]+d 
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; exit(0)
        mov ax,[d] ; mutam in ax valoarea din d
        div BYTE [b] ; impartim cu b
        add al,[b] ; folosim al ca acolo i stocat catu impartiri
        add al,[c] ; adaugam c si b ca sa ajungem la forma [b+c+d/b]
        mul byte [a] ; inmultim al cu a 
        add ax, [d] ; adaugam la ax pe D
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
