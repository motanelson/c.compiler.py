
[BITS 64]
section .note.GNU-stack
times 16384 db 0
section .data
    value128 dq 65, 0 ; 128-bit value
    stg db 10,27,'[43;30m%d',10,10,10
section .text
    extern printf
    extern exit
    global main

main:
    ; Encerrar (em Linux, syscall exit)
    mov rax,0
    mov rdi,stg
    mov rsi,[value128]
    call printf
    call exit
    ret
