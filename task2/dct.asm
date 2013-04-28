extern printf

section .data
    align 16
    print_int db "%d", 10, 0

    hw db "Hello, world", 10, 0

    align 16
    matr1: dd 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.12500000, 0.17337997, 0.14698444, 0.09821186, 0.03448742, -0.03448743, -0.09821188, -0.14698446, -0.17337999, 0.16332036, 0.06764951, -0.06764952, -0.16332038, -0.16332036, -0.06764949, 0.06764954, 0.16332039, 0.14698444, -0.03448743, -0.17337999, -0.09821185, 0.09821189, 0.17337997, 0.03448739, -0.14698447, 0.12500000, -0.12500001, -0.12499999, 0.12500001, 0.12499998, -0.12500003, -0.12499996, 0.12500004, 0.09821186, -0.17337999, 0.03448744, 0.14698444, -0.14698447, -0.03448737, 0.17337996, -0.09821194, 0.06764951, -0.16332036, 0.16332039, -0.06764955, -0.06764946, 0.16332035, -0.16332039, 0.06764959, 0.03448742, -0.09821185, 0.14698444, -0.17337997, 0.17338000, -0.14698449, 0.09821194, -0.03448752

    align 16
    matr2: dd 0.12500000, 0.17337997, 0.16332036, 0.14698444, 0.12500000, 0.09821186, 0.06764951, 0.03448742, 0.12500000, 0.14698444, 0.06764951, -0.03448743, -0.12500001, -0.17337999, -0.16332036, -0.09821185, 0.12500000, 0.09821186, -0.06764952, -0.17337999, -0.12499999, 0.03448744, 0.16332039, 0.14698444, 0.12500000, 0.03448742, -0.16332038, -0.09821185, 0.12500001, 0.14698444, -0.06764955, -0.17337997, 0.12500000, -0.03448743, -0.16332036, 0.09821189, 0.12499998, -0.14698447, -0.06764946, 0.17338000, 0.12500000, -0.09821188, -0.06764949, 0.17337997, -0.12500003, -0.03448737, 0.16332035, -0.14698449, 0.12500000, -0.14698446, 0.06764954, 0.03448739, -0.12499996, 0.17337996, -0.16332039, 0.09821194, 0.12500000, -0.17337999, 0.16332039, -0.14698447, 0.12500004, -0.09821194, 0.06764959, -0.03448752

    align 16
    tmp: dd 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0


section .text

global _fdct
global _idct
global transpose
global copy
global copy2
global matrix_mul
global matrix_mul3
global matrix_mul4
global time_test

; void _fdct (float* data, float* res, int n)
_fdct:  
    rdtsc   
    push eax

    mov eax, [esp + 8]; data
    mov ebx, [esp + 12]; result

    mov edx, [esp + 16]

    

    _main_loop:
        pusha
            push tmp
            push eax
            push matr1
            call matrix_mul4    
            add esp, 12
        popa

        pusha
            push ebx
            push matr2 
            push tmp
            call matrix_mul4
            add esp, 12
        popa

        add eax, 64 * 4
        add ebx, 64 * 4
        sub edx, 1
        jnz _main_loop

    pop ebx
    rdtsc
    sub eax, ebx

    push eax
    push print_int
    call printf
    add esp, 8
  
ret

; void _idct (float* data, float* res, int n)
_idct:  
    mov eax, [esp + 4]; data
    mov ebx, [esp + 8]; result
    mov ecx, [esp + 16]

    mov edx, [esp + 12]
    _main_loop2:
        pusha
            push tmp
            push eax
            push matr2
            call matrix_mul4    
            add esp, 12
        popa

        pusha
            push ebx
            push matr1 
            push tmp
            call matrix_mul4
            add esp, 12
        popa

        pusha
            push ebx
            call mul64
            add esp, 4
        popa


        add eax, 64 * 4
        add ebx, 64 * 4
        sub edx, 1
        jnz _main_loop2
  
ret


; void mul64 (float * data) 
mul64:
    mov eax, [esp + 4]
    mov ecx, 16
    push 64.0
    push 64.0
    push 64.0
    push 64.0
    movups xmm0, [esp]
    add esp, 16
    _loop_mul64:
        movaps xmm1, [eax];
        mulps xmm1, xmm0
        movaps [eax], xmm1
        add eax, 16
        sub ecx, 1
        jnz _loop_mul64
ret

; void time_test (float* data, float* res)
time_test:  
    mov ecx, [esp + 4]
    mov ebx, [esp + 8]
    rdtsc
    push eax

    mov edx, 0
    looooop:
    mov eax, [ecx + edx]
    mov [ebx + edx], eax
    add edx, 1
    cmp edx, 640
    jne looooop
 
    

    pop ebx
    rdtsc
    sub eax, ebx

    push eax
    push print_int
    call printf
    add esp, 8


  
ret

; void transpose (float* data, float* res)
transpose:  
    rdtsc
    push eax

    mov esi, 1000

    _lloopp:
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

    sub esi, 1
    jnz _lloopp

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

    mov esi, 1000

    lloopp2:
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

    sub esi, 1
    jnz lloopp2

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

    mov esi, 1000
    lloopp3:
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

    sub esi, 1
    jnz lloopp3

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

    mov esi, 1000
    lloopp4:
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

    sub esi, 1
    jnz lloopp4

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

    mov esi, 1000
    lloopp5:
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

    sub esi, 1
    jnz lloopp5
    
    rdtsc
    sub eax, [esp]
    add esp, 4

    push eax
    push print_int
    call printf
    add esp, 8
  
ret

; void matrix_mul4 (float* data1, float * data2, float* res)
matrix_mul4:  
    ; xmm7 always equals 0
    push 0.0
    push 0.0
    push 0.0
    push 0.0
    movups xmm7, [esp]
    add esp, 16

    mov eax, [esp + 4]; data1
    mov edx, [esp + 12]; res

    ; matrix mul
    mov cl, 0
    _loop_mul1:
        ; first part
        movaps xmm0, xmm7
        
        mov ebx, [esp + 8]
        mov ch, 0
        _loop_mul2:
            movss xmm1, [eax]
            shufps xmm1, xmm1, 0h
            movaps xmm2, [ebx]
            mulps xmm1, xmm2
            addps xmm0, xmm1

            add eax, 4
            add ebx, 32
            inc ch
            cmp ch, 8
            jne _loop_mul2

        movaps [edx], xmm0

        sub eax, 32
        ; second part
        movaps xmm0, xmm7
        mov ebx, [esp + 8]
        mov ch, 0
        _loop_mul22:
            movss xmm1, [eax]
            shufps xmm1, xmm1, 0h
            movaps xmm2, [ebx + 16]
            mulps xmm1, xmm2
            addps xmm0, xmm1

            add eax, 4
            add ebx, 32
            inc ch
            cmp ch, 8
            jne _loop_mul22

        movaps [edx + 16], xmm0

        add edx, 32
        inc cl
        cmp cl, 8
        jne _loop_mul1
 
ret
