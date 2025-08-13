[BITS 64]
section .data
    value128 dq 65, 0 ; 128-bit value

section .text
    global _start

_start:
    ; Reservar espaço na pilha
    sub rsp, 16

    ; Carregar o valor de 128 bits para xmm1
    movaps xmm1, [value128]

    ; Fazer "push" do valor 128 bits (armazenar na pilha)
    movaps [rsp], xmm1

    ; Fazer "pop" do valor 128 bits (carregar de volta para xmm0)
    movaps xmm0, [rsp]

    ; Liberar espaço da pilha
    add rsp, 16
    movq rdi,xmm0
    ; Encerrar (em Linux, syscall exit)
    mov eax, 60     ; syscall: exit
    ;xor edi, edi    ; status 0
    syscall
