cat > comparar.asm << 'EOF'
section .data
    mayor db "Mayor", 10
    menor db "Menor", 10

section .text
    global _start

_start:
    mov eax, 7
    mov ebx, 3
    cmp eax, ebx
    jg mayor_label

    mov ecx, menor
    mov edx, 6
    jmp imprimir

mayor_label:
    mov ecx, mayor
    mov edx, 6

imprimir:
    mov eax, 4
    mov ebx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
EOF

