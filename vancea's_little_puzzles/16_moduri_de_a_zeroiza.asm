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

; the program code will be part of a segment called code
segment code use32 class=code
start:
; ... 
	mov eax, 0xffffffff;0
    mov eax, 0

    mov eax, 0xffffffff;1
    sub eax, eax
    
    mov eax, 0xffffffff;2 
    mov ebx, 0xffffffff
    sub ebx,eax
    add ebx,1
    add eax, ebx

    mov eax, 0xffffffff;3
    and eax, 0

    mov eax, 0xffffffff;4
    mov ebx,eax
    not ebx
    and eax, ebx

    mov eax, 0xffffffff;5 
    xor eax, eax

    mov eax, 0xffffffff;6!!!
    shr eax, 31
    shr eax, 1

    mov eax, 0xffffffff;7
    shl eax, 31
    shl eax, 1
    

    mov eax, 0xffffffff ;8
    mov ebx,0
    mul ebx

    mov eax, 0xffffffff ;9
    mov ebx,0
    imul ebx

    ;CAZURI PARTICULARE
    mov eax, 0x0000fffd ; nr < 65535 10
    mov bx, 0xffff
    div bx


    

    

	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program