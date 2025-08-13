;nasm -f elf64 -o gccx.o gccx.asm
;ld -dynamic-linker /lib64/ld-linux-x86-64.so.2    -o gccx /usr/lib/x86_64-linux-gnu/crt1.o    /usr/lib/x86_64-linux-gnu/crti.o    gccx.o    -lc    /usr/lib/x86_64-linux-gnu/crtn.o
;gcc --version
;./gccx
[BITS 64]
section .bss
     resq 1024
section .data
    times 16384 db 0
    stacks:
    times 16384 db 0

    value128 dq 65, 0 ,0,0,0,0; 128-bit value
    stg db 10,27,'[43;30m%ld',10,10,10,0
section .text
    extern printf
    extern exit
    global main

main:
    mov rsp,stacks
    sub rsp,64
    movq xmm0,[value128]
    movq rsi,xmm0
    add rsp,64
    ; Encerrar (em Linux, syscall exit)
    mov rax,0
    mov rdi,stg
    
    call printf
    ; Encerrar (em Linux, syscall exit)
    mov eax, 60     ; syscall: exit
    xor edi, edi    ; status 0
    syscall
    ret
section .note.GNU-stack
    times 16384 db 0
