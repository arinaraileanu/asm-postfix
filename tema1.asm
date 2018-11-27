%include "io.inc"

extern strtok
extern atoi

%define MAX_INPUT_SIZE 4096

section .bss
    expr: resb  MAX_INPUT_SIZE
    
section .data
    delim db    " "
    
section .text
global CMAIN
CMAIN:
    push    EBP
    mov     EBP, ESP

    GET_STRING expr, MAX_INPUT_SIZE

    ; impartim sirul dupa caracterul spatiu
    push    delim
    push    expr
    call    strtok
    add     ESP, 8
        
while:
    cmp     EAX, 0
    je      finish_while
            
    ; retinem valoarea lui EAX pe stiva
    ; o vom folosi in viitor si acum va
    ; fi modificata de atoi
    push    EAX
        
    ; transformam subsirul in numar
    push    EAX
    call    atoi
    add     ESP, 4
            
    mov     EBX, EAX  ; in EBX punem rezultatul atoi
    pop     EAX  ; punem in EAX valoarea de dinaintea atoi
        
    ; verificam daca am gasit un nr. sau nu
    ; atoi returneaza 0 daca nu e numar
    cmp     EBX, 0
    je      is_operator_or_zero
        
is_operand:        
    ; punem in stiva numarul gasit
    push    EBX
    jmp     get_next_string

is_operator_or_zero:
    ; verificam daca nr. e de fapt 0, nu operator
    cmp     byte[EAX], "0"
    je      is_operand 

is_operator:
    ; apelam functia coresp. operatorului gasit
    cmp     byte[EAX], "-"
    je      subtraction

    cmp     byte[EAX], "+"
    je      addition

    cmp     byte[EAX], "*"
    je      multiplication

    cmp     byte[EAX], "/"
    je      division

subtraction:
    ; operatia de scadere
    ; scoatem ultimii 2 operanzi si ii scadem
    pop     EBX
    pop     EAX
    sub     EAX, EBX
    ; punem rezultatul inapoi pe stiva
    push    EAX
    jmp     get_next_string

addition:
    ; operatia de adunare
    ; scoatem ultimii 2 operanzi si ii adunam
    pop     EBX
    pop     EAX
    add     EAX, EBX
    ; punem rezultatul inapoi pe stiva
    push    EAX
    jmp     get_next_string

multiplication:
    ; operatia de inmultire
    ; scoatem ultimii 2 operanzi si ii inmultim
    pop     EAX
    pop     EDX
    imul    EDX
    ; punem rezultatul inapoi pe stiva
    push    EAX
    jmp     get_next_string

division:
    ; operatia de impartire
    pop     ECX
    pop     EAX
    ; extinde cu semn EAX in EDX:EAX
    ; pentru a efectua impartirea ok
    cdq
    idiv    ECX
    ; punem rezultatul inapoi pe stiva
    push    EAX
    jmp     get_next_string

get_next_string:
    ; luam urmatorul subsir delimitat de ' '
    push    delim
    push    0
    call    strtok
    add     ESP, 8
    jmp     while

finish_while:

    ; scoatem rezultatul de pe stiva si il afisam
    pop     EAX
    PRINT_DEC 4, EAX
 
    xor     EAX, EAX
    pop     EBP
    ret
