[BITS 64]
section .data
    value dq 65

section .text
    global _start

_start:
    mov edi,[value]

    ; Encerrar (em Linux, syscall exit)
    mov eax, 60     ; syscall: exit
    ;xor edi, edi    ; status 0
    syscall
