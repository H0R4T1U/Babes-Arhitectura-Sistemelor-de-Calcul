bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
	s dw 1234h, 5678h, 9876h
    len equ ($-s)/2
    suma dw 0
    
; 4. Se da un sir de cuvinte S. Sa se determine suma numerelor
; formate din bitii 6-9 ai fiecarui cuvant din sirul S.
segment code use32 class=code
    start:
        mov ecx, len    ; ciclul se executa de len ori
        jecxz final		; prevenim intrarea intr-un ciclu infinit
        mov dx, 0       ; calculam suma in registrul DX
        mov esi, 0      ; ESI - index in sirul s
    repeta:
        mov ax, [s+esi] ; citim s[i]
        
        and ax, 0000_0011__1100_0000b   ; 03C0h
        shr ax, 6       ; obtinem numarul format din bitii 6-9
        
        add dx, ax      ; adunam numarul obtinut
    
        add esi, 2      ; i++
        loop repeta

        mov [suma], dx  ; stocam suma finala
    
    final:
        push dword 0
        call [exit]
