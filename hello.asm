[BITS 64]
;nasm -f elf64 hello.asm -o hello.o
;ld hello.o -o hello
;./hello
section .data
    msg db 27,"[43;30mhello world", 0xA  ; mensagem com quebra de linha
    len equ $ - msg            ; comprimento da mensagem

section .text
    global _start

_start:
    ; syscall write (syscall número 1)
    mov rax, 1          ; número da syscall: sys_write
    mov rdi, 1          ; descritor de arquivo: 1 (stdout)
    mov rsi, msg        ; ponteiro para a mensagem
    mov rdx, len        ; comprimento da mensagem
    syscall

    ; syscall exit (syscall número 60)
    mov rax, 60         ; número da syscall: sys_exit
    xor rdi, rdi        ; código de saída: 0
    syscall