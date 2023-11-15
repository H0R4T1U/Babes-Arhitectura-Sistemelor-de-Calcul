bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
	s dw 1203h, 5601h, 9800h
    len equ ($-s)/2
    d times len db 0
    
; 5. Se da un sir de cuvinte S. Sa se formeze sirul de octeti D
; care contine octetii superiori rotiti spre stanga cu valoarea
; octetilor inferiori din fiecare cuvant al sirului de cuvinte S.
segment code use32 class=code
    start:
        mov ecx, len        ; ciclul se executa de len ori
        jecxz final			; prevenim intrarea intr-un ciclu infinit
        mov esi, 0          ; ESI - index in sirul s
        mov edi, 0          ; EDI - index in sirul d
    repeta:
        push ecx            ; salvam valoarea lui ECX pe stiva
        
        mov cl, [s+esi]     ; octetul inferior in CL
        mov al, [s+esi+1]   ; octetul superior in AL
        rol al, cl          ; rotim octetul din AL
        mov [d+edi], al     ; stocam rezultatul in d
        
        add esi, 2
        inc edi
        
        pop ecx             ; refacem valoarea lui ECX din stiva
        loop repeta
    
    final:
        push dword 0
        call [exit]
