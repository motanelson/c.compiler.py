[BITS 64]
section .data
    value512 dq 0x1122334455667788, 0x99AABBCCDDEEFF00,0x1122334455667788, 0x99AABBCCDDEEFF00,0x1122334455667788, 0x99AABBCCDDEEFF00,0x1122334455667788, 0x99AABBCCDDEEFF00; 512-bit value

section .text
    global _start

_start:
    ; Reservar espaço na pilha
    sub rsp, 64

    ; Carregar o valor de 512 bits para zmm1
    vmovaps zmm1, [value512]

    ; Fazer "push" do valor 512 bits (armazenar na pilha)
    vmovaps [rsp], zmm1

    ; Fazer "pop" do valor 512 bits (carregar de volta para zmm0)
    vmovaps zmm0, [rsp]

    ; Liberar espaço da pilha
    add rsp, 64

    ; Encerrar (em Linux, syscall exit)
    mov eax, 60     ; syscall: exit
    xor edi, edi    ; status 0
    syscall
