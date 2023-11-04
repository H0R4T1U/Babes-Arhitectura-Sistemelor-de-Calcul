bits 32
global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 7
    b dw 25

; a + b (BYTE + WORD)
segment code use32 class=code
    start:
        ;     AH       AL
        ; a =          xxxxxxxx
        ; b = xxxxxxxx xxxxxxxx
		
        ; varianta 1: extindere + adunare
		; fara semn
		mov al, [a]
        mov ah, 0       ; ax = a (extindere fara semn)
		add ax, [b]
		
		; cu semn
        mov al, [a]
        cbw             ; ax = a (extindere cu semn)
        add ax, [b]
		
        ; varianta 2: adunare in 2 etape (ADD urmat de ADC)
		; fara semn
        mov al, [a]
		mov ah, 0       ; ax = a (extindere fara semn)
        add al, [b]
        adc ah, [b+1]   ; ax = a+b
		
		; cu semn
        mov al, [a]
		cbw             ; ax = a (extindere cu semn)
        add al, [b]
        adc ah, [b+1]   ; ax = a+b
    
        ; exit(0)
        push dword 0    ; push the parameter for exit onto the stack
        call [exit]     ; call exit to terminate the program
