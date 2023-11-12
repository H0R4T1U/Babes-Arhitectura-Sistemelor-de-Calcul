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
    mnew dd 0 ;0000 0011 1010 0101 1011 0110 1111 0111
              ; 0    3    A    5    B    6     F   7
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ... 
    mov ax, [m]; luam primi 16 biti ai lui m
    and ax, 0000000111100000b ; -> selectam bitii 5-8
    mov cl, 5 ; ii mutam 5 pozitii la dreapta 0-3
    ror ax,cl ; -> al = 07h
    or ax, 0000000011110000b ; -> setam bitii 4-7 la 1
    mov ebx, 0
    or bx, ax ;-> bx = 00 f7

    mov eax, [m]
	and eax, 0x07ffff00;0000 0111 1111 1111 1111 1111 0000 0000, selectam doar biti 26-8
    or ebx,eax ; ii adaugam la ebx obtinand astfel rez final
    mov [mnew],ebx
    ; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program\
