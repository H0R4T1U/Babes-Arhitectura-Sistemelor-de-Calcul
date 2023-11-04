bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 5
    b dd 25

; a + b (WORD + DWORD)
segment code use32 class=code
    start:
        ;     DX                AX
        ; a =                   xxxxxxxx xxxxxxxx
        ; b = xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx
		
		; varianta 1: extindere + adunare
		; fara semn
		mov eax, 0
        mov ax, [a]		; EAX = a (extindere fara semn)
        add eax, [b]	; EAX = a+b
		
		; cu semn
        mov ax, [a]		; AX = a
		cwde			; EAX = a (extindere cu semn)
        add eax, [b]	; EAX = a+b
        
		; varianta 2: extindere + adunare in 2 etape (ADD urmat de ADC)
        ; fara semn
        mov ax, [a]		; AX = a
		mov dx, 0		; DX:AX = a (extindere fara semn)
        add ax, [b]
        adc dx, [b+2]   ; DX:AX = a+b
		
		; cu semn
        mov ax, [a]		; AX = a
		cwd				; DX:AX = a (extindere cu semn)
        add ax, [b]
        adc dx, [b+2]   ; DX:AX = a+b

        ; exit(0)
        push dword 0    ; push the parameter for exit onto the stack
        call [exit]     ; call exit to terminate the program
