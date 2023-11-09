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
    ; Se da un sir de octeti S. Sa se construiasca sirul D1 ce contine elementele
    ; de pe pozitiile pare din S si sirul D2 ce contine elementele de pe pozitiile
    ; impare din S.  
    ;S: 1, 5, 3, 8, 2, 9
    ;D1: 1, 3, 2
    ;D2: 5, 8, 9
    ; INDEXARE DE LA 0!!!
    s db 1, 5, 3, 8, 2, 9
    len equ $-s
    d1 times len/2 db 0xff
    d2 times len/2 db 0xff
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ... 
    xor ecx, ecx
    mov ecx, len
    jecxz sfarsit
    shr ecx,1; impartim valoarea din ecx la 2
    

    mov esi, 0
    mov edi, 0
    mov ebx, 0
    repeta:
        mov al, [s + esi]
        mov [d1 + edi], al
        inc esi
        inc edi
        mov al, [s+ esi]
        mov [d2 + ebx], al
        inc esi
        inc ebx
    loop repeta

    sfarsit :
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program