bits 32 
global start


extern exit 
import exit msvcrt.dll 


segment data use32 class=data
    ;Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat,
    ; apoi sa se citeasca de la tastatura numere si sa se scrie valorile citite in fisier pana cand se citeste de la tastatura valoarea 0. 
segment code use32 class=code
start:

	push dword 0 
	call [exit] 