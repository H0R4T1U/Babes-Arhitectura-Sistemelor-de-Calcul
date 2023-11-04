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
    
; x = (a*b)/d - c, cu semn
segment code use32 class=code
    start:
        ; a*b
        mov al, [a]
        cbw             ; AX = a (extindere cu semn)
        imul word [b]   ; DX:AX = AX*b = a*b
        
        push ax			; salvez AX pe stiva
        
        ; (a*b)/d
        mov al, [d]
        cbw             ; AX = d (extindere cu semn)
        mov bx, ax
        pop ax			; refac AX de pe stiva
        idiv bx         ; AX = DX:AX/BX = (a * b)/d si DX = (DX:AX)%BX
        
        push ax			; salvez AX pe stiva
        
        ; (a*b)/d - c
        mov al, [c]
        cbw             ; AX = c (extindere cu semn)
        mov bx, ax
        pop ax			; refac AX de pe stiva
        sub ax, bx      ; AX = (a*b)/d - c
        
        ; stochez rezultatul in memorie
        mov [x], ax
    
        ; exit(0)
        push dword 0
        call [exit]
