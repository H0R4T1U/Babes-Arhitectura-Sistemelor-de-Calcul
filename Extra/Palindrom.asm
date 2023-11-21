bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;Se da un sir de octeti reprezentand un text (succesiune de cuvinte separate de spatii). 
    ;Sa se identifice cuvintele de tip palindrom (ale caror oglindiri sunt similare cu cele de plecare):
    ;"cojoc", "capac" etc. 
    sir_cuvinte db "cojoc copac capac otto pisica ",0
    len EQU $-sir_cuvinte
    cuvant times len db 0
    cuvant_de_afisat times len db 0
    mesaj db "Cuvintele %ssunt palindroame"
; our code starts here
segment code use32 class=code
    start:
        ;ne setam registri si flagurile
        push cuvant_de_afisat ; adresa stringului cu cuvinte de afisat
        mov ebx, 0
        mov esi, sir_cuvinte 
        mov edi, cuvant+len-1
        adauga_cuvant:
            mov edi, cuvant+len-1
            mov ebx,esi ;ebx = inc cuv
            loop :
                cld 
                lodsb ;incarcam in al un caracter
                cmp al,' ' ; verificam sa nu fie spatiu
                je sfarsit_cuvant ; daca este spatiu sa termint cuvant
                std ; punem in ordine inversa in edi setand d flag -> 1s
                stosb ; stocam in edi un byte
            jmp loop ; daca am ajuns aici cunvatul nu este gata
        sfarsit_cuvant:
            
            ;mov edx,esi; edx = adresa sfarsitului cuv
            mov esi, ebx ; esi= inceput cuvant 
            cld
            add edi, 1; aliniem edi si esi
            repeta:
                cld
                lodsb 
                cmp al, ' '
                je final_palindrom ; daca se executa inseamna ca elementele au fost egale pana atunci
                scasb ; comparam edi cu al
                jne nu_palindrom; daca caracterele nu sunt identice sarim la ne_palindrom
            jmp repeta
            
        sfarsit:
            push dword cuvant_de_afisat
            push dword mesaj
            call [printf] ;afisam cuvintele ce sunt palindraome
            add esp, 4*2
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program

        final_palindrom:
            mov esi, ebx
            pop edi ; luam adresa string-ului cuvintelor de afisat din stack
            repeta2:
                lodsb ; incarcam cuvantul pana la ' '
                cmp al, ' '
                je salveaza
                stosb 
            jmp repeta2
            salveaza:
                stosb ; aduagam ' '
                push edi ; salvam locatia in sirul cuvintelor de afisat
                jmp clear_cuvant


        clear_cuvant:
            std
            mov edi, cuvant+len-1
            mov ecx, len
            mov al, 0
            repz stosb ; setam cuvantul inversat la 0
            ;comparam esi cu final sir cuvinte
            mov eax,(sir_cuvinte+len-2)
            cmp esi,eax
            jb adauga_cuvant ; continuam
            jmp sfarsit ; sfarsim program
        nu_palindrom:
            repeta3:
                lodsb
                cmp al, ' ' ; trece la urmatorul 
                je clear_cuvant
            jmp repeta3


