section .data
    mayor db "Mayor", 10, 0
    menor db "Menor", 10, 0

section .text
    global _start

_start:
    mov rax, 7
    mov rbx, 3
    cmp rax, rbx
    jg es_mayor

es_menor:
    mov rsi, menor
    mov rdx, 6
    call print_string
    jmp fin

es_mayor:
    mov rsi, mayor
    mov rdx, 6
    call print_string

fin:
    mov rax, 60
    xor rdi, rdi
    syscall

print_string:
    mov rdi, 1      ; stdout
    mov rax, 1      ; syscall write
    syscall
    ret

