bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    sir db 100, 21, 1, 30, 45, 12, 2, 3, 15
    len equ $-sir


segment code use32 class=code
start:
    mov ebx,len-1
    mov ecx,len-1
    mov esi, sir
    mov edi, sir+1
    loop:
        push ecx
        ja sorteaza
        jbe finish
    
    
    
finish:
    pop ecx
    dec ecx
    cmp ecx,0
    jnz loop
	push dword 0 
	call [exit] 

sorteaza:
    cld
    mov ecx,len-1
    mov esi, sir
    mov edi, sir+1
    repeta:
        lodsb ;al = sir+0]
        scasb; comparam cu edi, urm element
        jbe mai_mic
        dec edi
        push esi
        mov esi, edi
        mov dl, al
        lodsb ;al = edi
        push esi
        dec esi
        mov [esi],dl
        dec esi
        mov [esi],al
        pop edi
        pop esi
        mai_mic:
    loop repeta
    jmp finish

