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
    mov esi,0
    mov edi,0
    mov ecx, len
    mov ebx, 0
    repeta:
        mov eax, [a+esi] ; mutam in eax dword-ul de la pozitia a + esi, esi va fi incrementat cu 4 dupa fiecare
        mov [b1+edi],al; edi incrementat cu 1, mutam in b1 partea inf a cuv inf din a
        shr eax, 16; mutam in cuv inferior cuv superior a lui eax
        mov [b2+edi],ah ; mutam in b2 partea sup a cuv sup din eax
        inc edi; edi+=1
        add esi, 4;esi += 4, dword size
    loop repeta
	; call exit(0) ), 0 represents status code: SUCCESS
	push dword 0 ; saves on stack the parameter of the function exit
	call [exit] ; function exit is called in order to end the execution of the program