bits 32
global start

extern exit,fopen,fread,fclose,printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    nume_fisier db "text.txt", 0
    mod_acces db "r",0
    descriptor_fisier db -1
    len db 11
    text times 11 db 0
    format db "Textul este:%s",0

segment code use32 class=code
start:
    ;Deschidere fisier
    push dword mod_acces
    push dword nume_fisier
    call [fopen]
    add esp, 4*2

    mov [descriptor_fisier], eax

    cmp eax,0
    jz finish
    
    push dword [descriptor_fisier]
    push dword [len]
    push dword 1
    push dword text   
    call [fread]
    add esp, 4*46

    push dword text
    push dword format
    call [printf]
    add esp, 4*2


    finish:
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4
	    push dword 0 
	    call [exit] 