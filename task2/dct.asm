extern printf

section .data
    print_int db "%d", 10, 0

section .text

global FDCT

; void DFCT (float* data, float* res, int n)
FDCT:  
    mov eax, [esp + 4]; data
    mov ebx, [esp + 8]; result

    mov edx, [esp + 12]
    _main_loop:

        mov ecx, 64
        _loop:
            movss xmm1, [eax]
            movss[ebx], xmm1
            add ebx, 4
            add eax, 4
            loop _loop, ecx

        sub edx, 1
        jnz _main_loop
  
ret
