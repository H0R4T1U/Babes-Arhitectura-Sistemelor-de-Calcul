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
    ;Se da octetul A. Sa se obtina numarul intreg n reprezentat de bitii 2-4 ai lui A. 
    ;Sa se obtina apoi in B octetul rezultat prin rotirea spre dreapta a lui A cu n pozitii.
    ;Sa se obtina dublucuvantul C:

    ;bitii 8-15 ai lui C sunt 0
    ;bitii 16-23 ai lui C coincid cu bitii lui B
    ;bitii 24-31 ai lui C coincid cu bitii lui A
    ;bitii 0-7 ai lui C sunt 1
    a db 01011010b
    b db 0
    c dd 0
    ; n = 0001 1000 -> 18h, 
    ;5A = a, b = 5A, 18h = 24 si rotire cu 24 = nr initial 
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ... 
    mov al, [a]
    and al, 00011100b ; biti 2-4 din a, n
    mov cl, al ; cl = 18h = n
    mov al, [a]
    ror al, cl ; rotim pe al cu n pozitii
    mov [b], al
    mov bl, [b] ; bl = 5a
    mov bh, [a]; bh = 5a
    ror ebx, 16; mutam bh:bl -> in partea superioara ebx, 0000 5a5a -> 5a5a 0000
    mov bx, 0
    or bl, 11111111b ; or primi 8 biti a lui bx cu 1  
    ;rezultat final: ebx = 5a5a 00 FF
    mov [c], ebx
	; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program