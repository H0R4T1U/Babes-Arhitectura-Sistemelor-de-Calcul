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
    ;Se da dublucuvantul M. Sa se obtina dublucuvantul MNew astfel:

    ;bitii 0-3 a lui MNew sunt identici cu bitii 5-8 a lui M
    ;bitii 4-7 a lui MNew au valoarea 1
    ;bitii 27-31 a lui MNew au valoarea 0
    ;bitii 8-26 din MNew sunt identici cu bitii 8-26 a lui M.
    m dd 11000011101001011011011011110000b ; m = C3A5 B6F0
    mnew dd 0
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ... 
    mov ax, [m]; luam primi 16 biti ai lui m
    and ax, 0000000111100000b ; -> 
    mov cl, 5
    ror ax,cl ; -> al = 07h
    or ax, 0000000011110000b
    mov bx, 0
    or bx, ax ;-> bx = 1111 0111 f7
	; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program