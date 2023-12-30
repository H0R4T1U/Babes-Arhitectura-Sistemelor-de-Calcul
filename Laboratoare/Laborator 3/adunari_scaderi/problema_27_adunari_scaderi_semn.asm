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
    ;(d+d-c)-(c+c-a)+(c+a) 
    a db 12h
    b dw 1234h
    c dd 01234567h
    d dq 0xFEDCBA9876543210

; the program code will be part of a segment called code
segment code use32 class=code

start:
; ... 
    ;(d+d-c)-(c+c-a)+(c+a) 
    ;(d+d-c)
    clc 
    mov eax, [d+0]
    mov edx, [d+4]
    add eax, [d+0]
    adc edx, [d+4];d+d
    sub eax, [c]
    sbb edx, 0
    push edx
    push eax
    ;sf (d+d-c)
    ;(c+c-a)
    mov eax, [c]
    cdq
    add eax, [c]
    adc edx, 0
    sub al, [a]
    sbb ax, 0
    ;sf (c+c-a)
    ; (d+d-c)-(c+c-a)
    pop ebx
    pop ecx
    sub ebx, eax
    sbb ecx, edx
    push ecx
    push ebx
    ;sfarsit calcul 
    ;(c+a)
    mov eax, [c]
    cdq
    add al, [a]
    adc ax, 0
    ; sfarsit c+a 
    ;expresie
    pop ebx
    pop ecx
    add ebx, eax
    adc ecx, edx
	; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program