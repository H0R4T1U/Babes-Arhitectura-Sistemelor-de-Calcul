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
    ;(a*b+2)/(a+7-c)+d+x; a,c-byte; b-word; d-doubleword; x-qword
    a db 34h
    c db 12h
    b dw 1234h
    d dd 1234567h
    x dq 0xFEDCBA987654321
; the program code will be part of a segment called code
segment code use32 class=code
start:
; .. vx. 
    ;(a*b+2)/(a+7-c)+d+x; a,c-byte; b-word; d-doubleword; x-qword
    mov eax, 0
    mov ax, [b]
    mov bx, 0
    mov bl, [a]
    mul bx
    ;dx:ax = a*b
    push dx
    push ax
    pop eax ; eax = a*b
    mov edx, 0
    add eax , 2
    adc edx , 0
    ;edx: eax = a*b+2
    ;a+7-c
    mov ebx, 0
    mov bl, [a]
    add bl, 7
    adc bh, 0
    sub bl, [c]
    sbb bh, 0
    ;sfarsit a+7-c

    div ebx ; impartire a*b+2 la a+7-c

    ;+d + x
    mov edx, 0 ; stergem restu impartirii la ebx din edx
    add eax, [d]
    adc edx, 0 ; adunam d
    add eax, [x+0]
    adc edx, [x+4] ; adunam x
	; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program