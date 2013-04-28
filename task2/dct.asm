extern printf

section .data
    hw_string db "Hello, world!", 10, 0

section .text

global FDCT

; void DFCT ()
FDCT:     
    push hw_string

    call printf

    add esp, 4
  
ret
