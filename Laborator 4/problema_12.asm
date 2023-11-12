bits 32 ;assembling for the 32 bits architecture
global start

; we ask the assembler to give global visibility to the symbol called start 
;(the start label will be the entry point in the program) 
extern exit ; we inform the assembler that the exit symbol is foreign; it exists even if we won't be defining it
import exit msvcrt.dll  ; we specify the external library that defines the symbol
		; msvcrt.dll contains exit, printf and all the other important C-runtime functions

; our variables are declared here (the segment is called data) 
segment data use32 class=data
; ... 
;Se dau doua cuvinte A si B. Sa se obtina dublucuvantul C:

    ;bitii 0-6 ai lui C au valoarea 0
    ;bitii 7-9 ai lui C coincid cu bitii 0-2 ai lui A
    ;bitii 10-15 ai lui C coincid cu bitii 8-13 ai lui B
    ;bitii 16-31 ai lui C au valoarea 1 
    a dw 0111011101010111b
    b dw 1001101110111110b
    c dd 0
    ;0000 0000 1111 0111 , bx = 00F7
    ;1111 1111 0110 1111 1000 0000, C = FF FF 6F 80
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
    mov bx, 0xFFFF ; biti 16-31
    push bx,; impingem partea superioara a lui c

    mov ebx, 0
    mov ax, [a]
    and ax, 0000000000000111b ; selectam bitii 0-2 din a
    mov cl, 7 
    rol ax, cl ; rotim la dreapta 7 pozitii biti  0-2 din a ca sa fie pe bitii 7-9
    or bx, ax ; 0-6=0 7-9=a

    mov ax, [b]
    and ax, 0011111100000000b
    mov cl, 2
    rol ax, cl
    or bx,ax;0-15
    ; 0-15 bx corect
    
    push bx ; impingem si partea inferioara a lui c
    pop dword [c]
	; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program