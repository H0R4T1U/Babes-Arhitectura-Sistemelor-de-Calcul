bits 32 
global start


extern exit , fopen,fclose, fprintf,scanf,printf

import exit msvcrt.dll 
import scanf msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    ;Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat,
    ; apoi sa se citeasca de la tastatura numere si sa se scrie valorile citite in fisier pana cand se citeste de la tastatura valoarea 0. 
    msg_afis db "Afjsare Program, Citire nr pana la 0", 10 , 13 , 0
    msg_char db "Nr:",0
    nume_fisier db "asdf.txt",0
    mod_acces db "a",0
    descriptor_fisier dd -1
    format_scanf db '%s',0
    format_fprintf db '%s ',0
    a db 0,0
segment code use32 class=code
start:
    deschidere_fisier:
        push dword mod_acces 
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        mov [descriptor_fisier],eax
        cmp eax,0
        je final
    afisare_mesaj:
        push dword msg_afis
        call [printf]
        add esp, 4*1
    afisare_caracter:
        push dword msg_char
        call [printf]
        add esp, 4*1
    citire_caracter:
        push dword a
        push dword format_scanf
        call [scanf]
        add esp, 4*2
        cmp byte [a], '0'
        jz final
        jmp adauga_caracter

    final:
        push dword [descriptor_fisier]
        call [fclose]
	    push dword 0 
	    call [exit] 

    adauga_caracter:
        push dword a
        push dword format_fprintf
        push dword  [descriptor_fisier]
        call [fprintf]
        add esp, 4*3
        jmp afisare_caracter