;nasm -f elf64 -o gccx.o gccx.asm
;ld -dynamic-linker /lib64/ld-linux-x86-64.so.2    -o gccx /usr/lib/x86_64-linux-gnu/crt1.o    /usr/lib/x86_64-linux-gnu/crti.o    gccx.o    -lc    /usr/lib/x86_64-linux-gnu/crtn.o
;gcc --version
;./gccx
[BITS 64]
align 16

section .data

    
    value0 dq 3.1415927, 0 ,0,0,0,0
    value1 dq 100.00, 0 ,0,0,0,0
    value2 dq 0.00, 0 ,0,0,0,0
    stg db 10,27,'[43;30m%lld',10,10,10,0
    stacks2:
    times 16384 db 0
    stacks:
    times 16384 db 0
section .bss
     resq 1024

section .text
    extern printf
    extern exit
    global main

main:
    mov rsp,stacks
    movq xmm0,[value0]
    movq xmm1,[value1]
    mulpd xmm0,xmm1
    movq [value2],xmm0
    fld qword [value2]       ; Load num1 onto the FPU stack
    fistp qword [value2]
    mov rsi,[value2]    
    mov rax,0
    mov rdi,stg
    call printf

    ; Encerrar (em Linux, syscall exit)
    call exit
    ret
section .note.GNU-stack
    times 16384 db 0
