extern printf

section .data
    print_int db "%d", 10, 0

section .text

global FDCT
global transpose
global copy

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


; void transpose (float* data, float* res)
transpose:  
    mov eax, [esp + 4]; data
    mov ebx, [esp + 8]; result

    mov ecx, 0
    _loop_ecx:
        mov edx, 0
        _loop_edx:
            add eax, edx
            add ebx, ecx
            movss xmm1, [eax + ecx * 8]
            movss [ebx + 8 * edx], xmm1
            sub eax, edx
            sub ebx, ecx

            add edx, 4
            cmp edx, 32
            jne _loop_edx
        
        add ecx, 4
        cmp ecx, 32
        jne _loop_ecx

  
ret

; void copy (float* data, float* res)
copy:  
    mov eax, [esp + 4]; data
    mov ebx, [esp + 8]; result

    mov ecx, 0
    _loop_ecx2:
        mov edx, 0
        _loop_edx2:
            add eax, edx
            add ebx, edx
            movss xmm1, [eax + ecx * 8]
            movss [ebx + 8 * ecx], xmm1
            sub eax, edx
            sub ebx, edx

            add edx, 4
            cmp edx, 32
            jne _loop_edx2
        
        add ecx, 4
        cmp ecx, 32
        jne _loop_ecx2

  
ret
