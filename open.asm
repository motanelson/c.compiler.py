;nasm -f elf64 -o gccx.o gccx.asm
;ld -dynamic-linker /lib64/ld-linux-x86-64.so.2    -o gccx /usr/lib/x86_64-linux-gnu/crt1.o    /usr/lib/x86_64-linux-gnu/crti.o    gccx.o    -lc    /usr/lib/x86_64-linux-gnu/crtn.o
;gcc --version
;./gccx
[BITS 64]
align 16

section .data

    
    value0 dq 10000, 0 ,0,0,0,0
    value1 dq 11, 0 ,0,0,0,0
    stg db 10,27,'[43;30mwait? ',10,0
    f1 db 'my.txt',0
    inti dd 0
    size dd 0
    strings:
    times 1024 db 0
    stacks2:
    times 16384 db 0
    stacks:
    times 16384 db 0
section .bss
     resq 1024

section .text
    extern printf
    extern exit
    extern fgets
    extern stdin
    extern puts
    extern getc
    extern sleep
    extern open
    extern creat
    extern close
    extern write
    extern strlen
    global main

main:
    mov rsp,stacks
    mov rsi,rax
    mov rax,0
    mov rdi,stg
    call printf
    mov rdi,f1
    mov rsi,777o
    mov rax,777o
    call creat
    mov [inti],rax
    mov rdi,stg
    mov rax,0
    call strlen
    mov [size],rax
    mov rdi,[inti]
    mov rsi,stg
    mov rdx,[size]
    mov rax,rdx
    call write
    mov rdi,[inti]
    call close
    ; Encerrar (em Linux, syscall exit)
    call exit
    ret
section .note.GNU-stack
    times 16384 db 0
