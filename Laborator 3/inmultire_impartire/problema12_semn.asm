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
    a db 12h
    c db 12h
    b dw 8765h
    d dd 1234567h
    x dq 123456789ABCDEFh
; the program code will be part of a segment called code
segment code use32 class=code
start:
; .. vx. 
    ;(a*b+2)/(a+7-c)+d+x; a,c-byte; b-word; d-doubleword; x-qword
    mov al, [a] ; adauga a
    cbw
    mov bx, ax; bx = a
    mov ax, [b] ; ax = b
    cwd ; b -> double
    imul bx ; inmulteste cu semn cu a pe b
    ;dx:ax
    push dx
    push ax
    pop eax; muta pe a*b din dx:ax in eax
    cdq ; converteste pe a*b la edx:Eax
    add eax , 2
    adc edx , 0
    push edx
    push eax  ; impingem edx:eax pe stiva
    ;
    ;a+7-c
    mov al, [a]
    cbw
    add al, 7
    adc ah, 0
    sub al, [c]
    sbb ah, 0
    cwde
    mov ebx, eax; mutam a+7-c in ebx
    ;sfarsit a+7-c
    pop eax
    pop edx ; scoatem a*b+2 din stiva
    
    idiv ebx ; impartire a*b+2 la a+7-c
    ;+d + x
    cdq ; converteste partea intreaga de dupa inmpartire in quad, necesara datorita existentei restului imp in edx
    add eax, [d]
    adc edx, 0 ; aduna D
    add eax, [x+0]
    adc edx, [x+4] ; aduna x
	; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program
