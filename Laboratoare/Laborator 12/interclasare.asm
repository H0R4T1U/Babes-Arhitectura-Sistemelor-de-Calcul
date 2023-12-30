bits 32

global _interclasare

segment data public data use32

segment code public code use32
_interclasare:;interclasare(sir,sir2,sirinterclasat)
	push ebp
	mov ebp, esp

	mov esi, 0
	mov edi,0
	mov eax, [ebp+8]
	mov ebx, [ebp+12]
	mov edx, [ebp+16]
	repeta:
		mov cl, [eax+esi]
		cmp cl, 0
		je finish
		mov [edx+edi], cl
		inc edi
		mov cl, [ebx+esi]
		mov [edx+edi],cl
		inc edi
		inc esi
		jmp repeta
	finish:
		mov byte [edx+edi],13 ; asiguram carriage return si line feed
		inc edi
		mov byte [edx+edi],10
		inc edi
		mov byte [edx+edi],0 ; adaugam null bye la final, se pierde pe parcurs
		mov esp,ebp
		pop ebp
		ret 