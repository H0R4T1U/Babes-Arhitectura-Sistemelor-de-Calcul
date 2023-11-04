bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
	a dd 24
    b dd 22

segment code use32 class=code
    start:
		; -----------------------------
		; varianta de utilizare CORECTA
		mov eax, [a]
        cmp eax, [b]    ; scadere fictiva EAX - b
        ja mai_mare
		
		; aici tratam cazul a <= b
        jmp final
        
    mai_mare:
        ; aici tratam cazul a > b
		
	final:
		push dword 0
        call [exit]

		; -------------------------------
		; varianta de utilizare INCORECTA
        mov eax, [a]
        cmp eax, [b]    ; scadere fictiva EAX - b
		jb mai_mic
		ja mai_mare
		
    mai_mic:
        ; ...
        jmp final
		
    mai_mare:
        ; ...
        
    final:
        push dword 0
        call [exit]
