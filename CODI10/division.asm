section .data
    mensaje db "Resultado de la division: ", 0
    len_mensaje equ $ - mensaje
    salto db 10

    resultado db '0', 0  ; donde se guardará el resultado como texto

section .text
    global _start

%macro DIVIDIR 2
    mov eax, %1
    xor edx, edx        ; limpiar edx antes de div
    mov ebx, %2
    div ebx             ; eax = eax / ebx
%endmacro

_start:
    ; Realiza 20 / 4
    DIVIDIR 20, 4

    ; Convertir resultado a ASCII
    add eax, '0'
    mov [resultado], al

    ; Mostrar mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, len_mensaje
    int 0x80

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 1
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, salto
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

