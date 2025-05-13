section .data
    msg1 db "Ingresa al ciclo de espera del temporizador de salida", 0xA
    len1 equ $ - msg1

    msg2 db "Salir del temporizador", 0xA, 0xA
    len2 equ $ - msg2

    msg3 db "Presiona Enter para salir", 0xA
    len3 equ $ - msg3

section .bss
    buffer resb 2      ; Para leer 1 carácter + salto de línea

section .text
    global _start

_start:

    ; Mensaje inicial
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Temporizador con bucle
    mov ecx, 0x300

espera:
    xor eax, eax
    loop espera

    ; Mensaje final
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Solicitar Enter para salir
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 0x80

    ; Leer un carácter (espera Enter)
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 2
    int 0x80

    ; Salida
    mov eax, 1
    xor ebx, ebx
    int 0x80

