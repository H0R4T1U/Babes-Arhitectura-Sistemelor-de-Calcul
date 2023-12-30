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
    ;Se dau doua siruri de caractere S1 si S2. 
    ;Sa se construiasca sirul D prin concatenarea elementelor de pe pozitiile pare din S2
    ; cu elementele de pe pozitiile impare din S1.
    
    ;Exemplu:

    ;S1: 'a', 'b', 'c', 'd', 'e', 'f' ; impare
    ;S2: '1', '2', '3', '4', '5' ; par'
    ;D: '2', '4','a','c','e'
    ; SE FOLOSESTE INDEXARE DE LA 1!!!
    s1 db 'a', 'b', 'c', 'd', 'e', 'f'
    lens1 equ $-s1 
    s2 db '1', '2', '3', '4', '5'
    lens2 equ $-s2
    d times (lens2+lens1)/2 db 0xff


; the program code will be part of a segment called code
segment code use32 class=code
start:
; ... 
    mov ecx, lens2
    jecxz finish

    ;mov ax, cx
    ;mov dx, 0
    ;mov bx, 2
    ;div bx
    ;xor ecx,ecx
    ;mov cx, ax; impartim ecx la 2
    shr ecx, 1

    mov esi, 1 ; parcurge s2
    mov edi, 0
    repS2:
        
        mov al, [s2+esi]
        mov [d+edi], al
        add esi, 2
        inc edi
    loop repS2

    mov ecx, lens1
    jecxz finish

    ; mov ax, cx
    ; mov dx, 0
    ; mov bx, 2
    ; div bx
    ; xor ecx,ecx
    ; ; impartim ecx la 2
    ; mov cx, ax
    shr ecx, 1
    mov esi, 0
    repS1:
        
        mov al, [s1+esi]
        mov [d+edi], al
        add esi, 2
        inc edi
    loop repS1
    
    finish:
	    push dword 0 ; saves on stack the parameter of the function exit
	    call [exit] ; function exit is called in order to end the execution of the program