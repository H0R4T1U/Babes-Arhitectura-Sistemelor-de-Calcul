bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s db 'abcdef'
    len equ $-s
    d times len db 0
    
; 1. Se da un sir de caractere S.
; Se cere sirul de caractere D obtinut prin copierea sirului S.
segment code use32 class=code
    start:
        mov ecx, len        ; ciclul se executa de len ori
        jecxz final			; prevenim intrarea intr-un ciclu infinit
        mov esi, 0          ; ESI - index in sirul s
        mov edi, 0          ; EDI - index in sirul d
    repeta:
        mov al, [s+esi]     ; AL <- s[ESI]
        inc esi             ; trec la urmatorul element din sirul s
        mov [d+edi], al     ; s[EDI] <- AL
        inc edi             ; trec la urmatorul element din sirul d
    loop repeta
    
    final:
        push dword 0
        call [exit]
