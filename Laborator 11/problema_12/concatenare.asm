BITS 32
global concatenare_siruri

segment code use32 class=code
	concatenare_siruri:
		mov esi,0
		mov edi,0
		repeta:
			mov cl, [eax+esi];sir_a+deplasament
			cmp cl, 0
			je return
			mov [edx+edi],cl;sir_intercalat+deplasament = al
			inc edi
			mov cl, [ebx+esi]
			mov [edx+edi],cl
			inc esi
			inc edi
			jmp repeta
		return:
			ret 