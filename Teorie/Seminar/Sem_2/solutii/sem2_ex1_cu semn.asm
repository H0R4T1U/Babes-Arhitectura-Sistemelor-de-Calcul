bits 32
global start

extern exit
import exit msvcrt.dll

; a, b, c, d - byte
segment data use32 class=data
    a db 7
    b db 10
    c db 5
    d db 8
	
	x resb 1
    
; x = [(a + b)*c]/d, cu semn
segment code use32 class=code
    start:
        ; a + b
        mov al, [a]
        add al, [b]     ; AL = a+b
        
        ; (...)*c
        mul byte [c]    ; AX = AL*c = (a + b)*c
        
        ; [...]/d
        idiv byte [d]	; AL = AX/d = [(a + b)*c]/d si AH = AX%d
        
        ; stochez rezultatul in memorie
        mov [x], al

        ; exit(0)
        push dword 0
        call [exit]
