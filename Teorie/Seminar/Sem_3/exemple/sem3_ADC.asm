bits 32
global start

extern exit
import exit msvcrt.dll

; a, b, c, d - word
segment data use32 class=data
    a dw 1
    b dw 2
    c dw 3
    d dw 4
    
    x resd 1
    
; x = a*b + c*d, fara semn
segment code use32 class=code
    start:
        ; a*b
        mov ax, [a]
        mul word [b]    ; DX:AX = AX*b = a*b
        
        ; stocam rezultatul pe stiva
        push dx         ; cuvantul superior al operatiei a*b
        push ax         ; cuvantul inferior al operatiei a*b
        
        ; c*d
        mov ax, [c]
        mul word [d]    ; DX:AX = AX*d = c*d
        
        ; a*b + c*d
        pop bx          ; BX = vechea valoare din AX (cuvantul inferior)
        pop cx          ; CX = vechea valoare din DX (cuvantul superior) => CX:BX = a*b
        add ax, bx
        adc dx, cx
        
        ; stocam rezultatul final in memorie
        ; x e un DUBLUCUVANT (4 octeti) plasati little-endian
        ; | x | x+1 | x+2 | x+3 |
        mov [x], ax     ; cuvantul din AX (cuvantul inferior) va fi stocat incepand cu offset-ul x
        mov [x+2], dx   ; cuvantul din DX (cuvantul superior) va fi stocat incepand cu offset-ul x+2
    
        ; exit(0)
        push dword 0        ; push the parameter for exit onto the stack
        call [exit]         ; call exit to terminate the program
