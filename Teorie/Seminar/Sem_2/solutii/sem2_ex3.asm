bits 32
global start

extern exit
import exit msvcrt.dll

; a, c, d - byte, b - word
segment data use32 class=data
	a db 10
    b dw 200
    c db 20
    d db 30
    
    x resb 2
    
; x = (a*b)/d - c, fara semn
segment code use32 class=code
    start:
        ; a*b
        mov al, [a]
        mov ah, 0       ; AX = a (extindere fara semn)
        mul word [b]    ; DX:AX = AX*b = a*b
        
        ; (a*b)/d
        mov bl, [d]
        mov bh, 0       ; BX = d (extindere fara semn)
        div bx          ; AX = DX:AX/BX = (a * b)/d si DX = (DX:AX)%BX
        
        ; (a*b)/d - c
        mov bl, [c]
        mov bh, 0       ; BX = c (extindere fara semn)
        sub ax, bx      ; AX = (a * b)/d - c
        
        ; stochez rezultatul in memorie
        mov [x], ax
    
        ; exit(0)
        push dword 0
        call [exit]
