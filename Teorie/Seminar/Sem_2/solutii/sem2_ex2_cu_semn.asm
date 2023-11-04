bits 32
global start

extern exit
import exit msvcrt.dll

; a, b, c, d - byte
segment data use32 class=data
    a db 10
    b db 5
    c db 20
    d db 30
    
    x resb 1
	
; x = (a - b*c)/d, cu semn
segment code use32 class=code
    start:
        ; b*c
        mov al, [b]
        imul byte [c]   ; AX = AL*c = b*c
        
		push ax			; salvez AX pe stiva
        ; mov bx, ax	; sau pot sa-l mut in BX
        
        ; a - b*c
        mov al, [a]
        cbw             ; AX = a
        pop bx          ; scot BX = b*c de pe stiva
        sub ax, bx      ; AX = a - b*c
        
        ; (...)/d
        idiv byte [d]   ; AL = AX/d si AH = AX%d
        
        ; stochez rezultatul in memorie
        mov [x], al
    
        ; exit(0)
        push dword 0
        call [exit]
