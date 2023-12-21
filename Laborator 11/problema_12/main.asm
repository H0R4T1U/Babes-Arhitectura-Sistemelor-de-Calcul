BITS 32
global start



extern exit,printf

import exit msvcrt.dll
import printf msvcrt.dll
extern concatenare_siruri
segment data use32 class=data
	;Se dau doua siruri de caractere de lungimi egale. Se cere sa se calculeze si sa se afiseze
	;rezultatele intercalarii literelor, pentru cele doua intercalari posibile 
	;(literele din primul sir pe pozitii pare, respectiv literele din primul sir pe pozitii impare).
	nr dd 1
	sir_a db "123456789",0
	len equ $-sir_a
	sir_b db "ABCDEFGHI",0
	sir_intercalat1 times 2*len+1 db 0
	sir_intercalat2 times 2*len+1 db 0
	format_str db 10,13,"sir_intercalat_%d:%s",10,13,0

segment code use32 class=code	


start:
	mov eax, sir_a
	mov ebx, sir_b
	mov edx, sir_intercalat1
	call concatenare_siruri
	push dword sir_intercalat1
	afisare:
		push dword [nr]
		push dword format_str
		call [printf]
		add esp, 4*3
		inc dword [nr]
		cmp dword [nr],3
		je sfarsit
	mov eax, sir_b
	mov ebx, sir_a
	mov edx, sir_intercalat2
	call concatenare_siruri
	push dword sir_intercalat2
	jmp afisare
	sfarsit:
		push dword 0
		call [exit]

