; Ne propunem ca programul de mai jos sa citeasca de la tastatura un numar si sa afiseze pe ecran valoarea numarului citit impreuna cu un mesaj.
bits 32
global start        

; declararea functiilor externe folosite de program
extern exit, printf, scanf  ; adaugam printf si scanf ca functii externe           
import exit msvcrt.dll     
import printf msvcrt.dll     ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll      ; similar pentru scanf
                          
segment  data use32 class=data
	a dd 0;exitindem la DWORD ca sa nu dea overflow       ; in aceasta variabila se va stoca valoarea citita de la tastatura
    msg2 db "AFISARE PROGRAM!",10,13,"Introduceti un nr negativ!",10,13,0
    msg_char db "Nr:",0
    pozitiv db 10,13,"Nr introdus nu este negativ!",0
    message  db 10, 13,"A=%d (baza 10), a=%x (baza_16)",0
	format  db "%i", 0  ; %d <=> un numar decimal (baza 10)
    
segment  code use32 class=code
    start:
                                               
        ; vom apela scanf(format, n) => se va citi un numar in variabila n
        ; punem parametrii pe stiva de la dreapta la stanga
        ;Se da un numar natural negativ a (a: dword). Sa se afiseze valoarea lui in baza 10 si in baza 16,
        ;in urmatorul format: "a = <base_10> (baza 10), a = <base_16> (baza 16)" 
        push dword msg2 ; afisam mesajul AFISARE PROGRAM
        call [printf]
        add esp, 4*1
        push dword msg_char
        call [printf]
        add esp, 4*1

        ;citire 
        push dword a
        push  dword format

        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2
        ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
        
        mov eax, [a] ; VERICAM DACA NR INTRODUS ESTE NEGATIV
        cmp eax, 0
        jge invalid 
        negativ:
            mov  eax,[a]   

            push  eax
            push eax
            push  dword message 
            call  [printf]
            add  esp,4*2 
        
        final:
        ; exit(0)
            push  dword 0     ; punem pe stiva parametrul pentru exit
            call  [exit]       ; apelam exit pentru a incheia programul
     
        invalid :
            push dword pozitiv
            call [printf]
            add esp, 4*1
            jmp final
            
