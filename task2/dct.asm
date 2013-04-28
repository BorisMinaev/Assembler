extern printf

section .data
    print_int db "%d", 10, 0

section .text

global FDCT

; void DFCT (int x, int* res)
FDCT:  
    ;print x   
    mov eax, [esp + 4]
    push eax
    push print_int
    call printf
    add esp, 8

    ; save 128 to *res
    mov eax, [esp + 8]
    mov ebx, 128
    mov [eax], ebx
  
ret
