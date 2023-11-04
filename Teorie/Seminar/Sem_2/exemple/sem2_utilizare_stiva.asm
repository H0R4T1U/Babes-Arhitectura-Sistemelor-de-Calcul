bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data    

segment code use32 class=code
    start:
		; 1. DX:AX -> EAX 
		; DX:AX = 1234:5678h
        mov dx, 1234h   	; cuvântul superior
        mov ax, 5678h   	; cuvântul inferior
        
        push dx         	; mai intâi punem pe stivă cuvântul superior
        push ax         	; apoi punem pe stivă cuvântul inferior
        pop eax         	; EAX = 12345678h
		
		; 2. EAX -> DX:AX
		; EAX = 12345678h
		mov eax, 12345678h
		
		push eax			; punem registrul EAX pe stivă
		pop ax              ; mai întâi extragem în AX cuvântul inferior (AX = 5678h)
		pop dx              ; apoi extragem în DX cuvântul superior (DX = 1234h)
    
        ; exit(0)
        push dword 0
        call [exit]
