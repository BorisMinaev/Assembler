extern printf

section .data
    print_int db "%d", 10, 0

section .text

global FDCT
global transpose
global copy
global copy2
global matrix_mul
global matrix_mul3

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
    rdtsc
    push eax

    mov eax, [esp + 8]; data
    mov ebx, [esp + 12]; result

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

    rdtsc
    sub eax, [esp]
    add esp, 4

    push eax
    push print_int
    call printf
    add esp, 8
  
ret

; void copy (float* data, float* res)
copy:  
    rdtsc
    push eax
    mov eax, [esp + 8]; data
    mov ebx, [esp + 12]; result

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

    rdtsc
    sub eax, [esp]
    add esp, 4

    push eax
    push print_int
    call printf
    add esp, 8
  
ret

; void copy2 (float* data, float* res)
copy2:  
    rdtsc
    push eax
    mov eax, [esp + 8]; data
    mov ebx, [esp + 12]; result

    mov ecx, 0
    _loop_ecx22:

            movaps xmm1, [eax]
            movaps [ebx], xmm1

            movaps xmm1, [eax + 16]
            movaps [ebx + 16], xmm1

        
        add eax, 32
        add ebx, 32
        add ecx, 1
        cmp ecx, 8
        jne _loop_ecx22

    rdtsc
    sub eax, [esp]
    add esp, 4

    push eax
    push print_int
    call printf
    add esp, 8
  
ret


; void matrix_mul (float* data1, float * data2, float* res)
matrix_mul:  
    rdtsc
    push eax
    mov eax, [esp + 8]; data1
    mov ebx, [esp + 12]; data2
    mov ecx, [esp + 16]; data3


    mov dl, 0
    _loop_dl:
        mov dh, 0
        mov ebx, [esp + 12]
        _loop_dh:
            push 0.0
            movss xmm0, [esp]
            add esp, 4

            ; 0
            movss xmm1, [eax]
            movss xmm2, [ebx]
            mulss xmm1, xmm2
            addss xmm0, xmm1
            ; 1
            movss xmm1, [eax + 4]
            movss xmm2, [ebx + 4]
            mulss xmm1, xmm2
            addss xmm0, xmm1
            ; 2
            movss xmm1, [eax + 8]
            movss xmm2, [ebx + 8]
            mulss xmm1, xmm2
            addss xmm0, xmm1
            ; 3
            movss xmm1, [eax + 12]
            movss xmm2, [ebx + 12]
            mulss xmm1, xmm2
            addss xmm0, xmm1

            ; 0
            movss xmm1, [eax + 16]
            movss xmm2, [ebx + 16]
            mulss xmm1, xmm2
            addss xmm0, xmm1
            ; 1
            movss xmm1, [eax + 20]
            movss xmm2, [ebx + 20]
            mulss xmm1, xmm2
            addss xmm0, xmm1
            ; 2
            movss xmm1, [eax + 24]
            movss xmm2, [ebx + 24]
            mulss xmm1, xmm2
            addss xmm0, xmm1
            ; 3
            movss xmm1, [eax + 28]
            movss xmm2, [ebx + 28]
            mulss xmm1, xmm2
            addss xmm0, xmm1

            ;movss xmm1, [eax + ecx * 8]

            movss [ecx], xmm0

            add ebx, 32
            add ecx, 4
            add dh, 4
            cmp dh, 32
            jne _loop_dh
        
        add eax, 32
        add dl, 4
        cmp dl, 32
        jne _loop_dl


    rdtsc
    sub eax, [esp]
    add esp, 4

    push eax
    push print_int
    call printf
    add esp, 8
  
ret

; void matrix_mul3 (float* data1, float * data2, float* res)
matrix_mul3:  
    rdtsc
    push eax
    mov eax, [esp + 8]; data1
    mov ebx, [esp + 12]; data2
    mov ecx, [esp + 16]; data3


    mov dl, 0
    _loop_dl2:
        mov dh, 0
        mov ebx, [esp + 12]
        _loop_dh2:
            push 0.0
            push 0.0
            push 0.0
            push 0.0
            movups xmm0, [esp]
            add esp, 16

            ; first 4 numbers
            movups xmm1, [eax]
            movups xmm2, [ebx]
            mulps xmm1, xmm2
            addps xmm0, xmm1
 
            ; last 4 numbers  
            movups xmm1, [eax + 16]
            movups xmm2, [ebx + 16]
            mulps xmm1, xmm2
            addps xmm0, xmm1

            ; sum all numvers
            haddps xmm0, xmm0;
            haddps xmm0, xmm0

            movss [ecx], xmm0

            add ebx, 32
            add ecx, 4
            add dh, 4
            cmp dh, 32
            jne _loop_dh2
        
        add eax, 32
        add dl, 4
        cmp dl, 32
        jne _loop_dl2

    rdtsc
    sub eax, [esp]
    add esp, 4

    push eax
    push print_int
    call printf
    add esp, 8
  
ret
