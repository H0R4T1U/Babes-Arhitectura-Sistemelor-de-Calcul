bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s db 12h, 13h, 15h, 18h, 22h, 25h, 27h, 30h
    len equ $-s
    pare times len db 0
    impare times len db 0

; 3. Se da un sir de numere intregi S. Sa se construiasca sirul P care contine
; toate numerele pare din S si sirul R care contine toate numerele impare din S.
segment code use32 class=code
    start:
        mov ecx, len
        jecxz final
        
        mov ebx, 0
        mov esi, 0
        mov edi, 0
    repeta:
        mov al, [s+esi]
        
        test al, 01h            ; verificam daca numarul e par
        jz e_par
        
        mov [impare+ebx], al    ; numarul este impar
        inc ebx
        jmp mai_departe
        
    e_par:                      ; numarul este par
        mov [pare+edi], al
        inc edi
        
    mai_departe:
        inc esi
        loop repeta
    
    final:
        ; exit(0)
        push dword 0        ; push the parameter for exit onto the stack
        call [exit]         ; call exit to terminate the program
