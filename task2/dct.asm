extern printf

section .data
    print_int db "%d", 10, 0

section .text

global FDCT

; void DFCT (float* x, float* res, int n)
FDCT:  
    ;print x   
    ;mov eax, [esp + 4]
    ;push eax
    ;push print_int
    ;call printf
    ;add esp, 8

    ; mov 654.321 to xmm1
    push 654.321
    movss xmm1, [esp]
    add esp, 4

    ; write xmm1 to *res
    mov eax, [esp + 8]
    movss [eax], xmm1
  
ret
