bits 32 
global start


extern exit 
import exit msvcrt.dll  


segment data use32 class=data
    ;Se da un sir A de dublucuvinte. Cunstruiti doua siruri de octeti  
    ; B1: contine ca elemente partea inferioara a cuvintelor inferioare din A
    ; B2: contine ca elemente partea superioara a cuvintelor superioare din A
    a dd 0xFF1205AB,12345670h,89ABCDEFh
    len equ ($-a)/4
    b1 times len db 0
    b2 times len db 0
    

segment code use32 class=code
start:
; ... 
    cld
    mov esi, a
    mov ecx, len
    mov ebx, 0
    repeta:
        lodsd;incarcam primul dublu cuvant
        mov [b1+ebx], al;b1 = partea inferioara a cuvantului inferior din A
        shr eax, 16
        mov [b2+ebx],ah ;calcul de adresa bazata :), b2= partea superiaoara a cuvantului superior din a
        add ebx, 1;adaugam 1 la ebx ca urmatorul calcul de adresa sa fie cu un byte mai in fata
    loop repeta
	; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program