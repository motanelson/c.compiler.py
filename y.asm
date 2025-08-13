[BITS 64]
section .data
    value256 dq 0x1122334455667788, 0x99AABBCCDDEEFF00,0x1122334455667788, 0x99AABBCCDDEEFF00; 256-bit value

section .text
    global _start

_start:
    ; Reservar espaço na pilha
    sub rsp, 32

    ; Carregar o valor de 256 bits para ymm1
    vmovaps ymm1, [value256]

    ; Fazer "push" do valor 256 bits (armazenar na pilha)
    vmovaps [rsp], ymm1

    ; Fazer "pop" do valor 256 bits (carregar de volta para ymm0)
    vmovaps ymm0, [rsp]

    ; Liberar espaço da pilha
    add rsp, 32

    ; Encerrar (em Linux, syscall exit)
    mov eax, 60     ; syscall: exit
    xor edi, edi    ; status 0
    syscall
