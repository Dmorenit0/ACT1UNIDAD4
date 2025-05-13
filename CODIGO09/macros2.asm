section .data
    msg_mul db "Resultado de la multiplicación: ", 0
    len_mul equ $ - msg_mul
    salto db 10

section .text
    global _start

; Macro para multiplicación
%macro MULTIPLICA 2
    mov eax, %1
    imul eax, %2
%endmacro

_start:
    ; Multiplicar 3 * 4 usando la macro
    MULTIPLICA 3, 4

    ; Mostrar mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mul
    mov edx, len_mul
    int 0x80

    ; Convertir resultado a carácter ASCII
    add eax, '0'
    mov [msg_mul], al  ; Sobrescribe el primer byte del mensaje (solo para mostrar un dígito)

    ; Mostrar resultado (1 carácter)
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mul
    mov edx, 1
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80

