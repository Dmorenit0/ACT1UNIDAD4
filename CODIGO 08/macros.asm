cat > operaciones_macros.asm << 'EOF'
section .data
    msg_sum db "Resultado de la suma: ", 0
    len_sum equ $ - msg_sum
    msg_sub db "Resultado de la resta: ", 0
    len_sub equ $ - msg_sub
    salto db 10        ; Salto de línea (0xA)

section .text
    global _start

; Definir macro para suma
%macro SUMA 2
    ; Suma dos números (primer argumento es eax, segundo es el valor a sumar)
    add eax, %1
%endmacro

; Definir macro para resta
%macro RESTA 2
    ; Resta dos números (primer argumento es eax, segundo es el valor a restar)
    sub eax, %1
%endmacro

_start:
    ; Iniciar con un número en eax
    mov eax, 5         ; Número inicial para la operación

    ; Sumar 3 al valor de eax (usando la macro SUMA)
    SUMA 3

    ; Imprimir resultado de la suma
    mov eax, 4          ; Código de servicio para escribir
    mov ebx, 1          ; Salida estándar (stdout)
    mov ecx, msg_sum    ; Dirección del mensaje
    mov edx, len_sum    ; Longitud del mensaje
    int 0x80            ; Llamada al sistema

    ; Imprimir el número resultante de la suma
    movzx eax, eax      ; Convertir número a ASCII
    add eax, '0'        ; Convertir el número a su valor ASCII
    mov [msg_sum], al   ; Guardarlo de nuevo como carácter ASCII
    mov eax, 4          ; Código de servicio para escribir
    mov ebx, 1          ; Salida estándar (stdout)
    mov ecx, msg_sum    ; Dirección del número
    mov edx, 1          ; Longitud (1 carácter)
    int 0x80            ; Llamada al sistema

    ; Salto de línea
    mov eax, 4          ; Código de servicio para escribir
    mov ebx, 1          ; Salida estándar (stdout)
    mov ecx, salto      ; Dirección del salto de línea
    mov edx, 1          ; Longitud (1 byte)
    int 0x80            ; Llamada al sistema

    ; Restar 2 al valor de eax (usando la macro RESTA)
    RESTA 2

    ; Imprimir resultado de la resta
    mov eax, 4          ; Código de servicio para escribir
    mov ebx, 1          ; Salida estándar (stdout)
    mov ecx, msg_sub    ; Dirección del mensaje
    mov edx, len_sub    ; Longitud del mensaje
    int 0x80            ; Llamada al sistema

    ; Imprimir el número resultante de la resta
    movzx eax, eax      ; Convertir número a ASCII
    add eax, '0'        ; Convertir el número a su valor ASCII
    mov [msg_sub], al   ; Guardarlo de nuevo como carácter ASCII
    mov eax, 4          ; Código de servicio para escribir
    mov ebx, 1          ; Salida estándar (stdout)
    mov ecx, msg_sub    ; Dirección del número
    mov edx, 1          ; Longitud (1 carácter)
    int 0x80            ; Llamada al sistema

    ; Salto de línea
    mov eax, 4          ; Código de servicio para escribir
    mov ebx, 1          ; Salida estándar (stdout)
    mov ecx, salto      ; Dirección del salto de línea
    mov edx, 1          ; Longitud (1 byte)
    int 0x80            ; Llamada al sistema

    ; Finalizar el programa
    mov eax, 1          ; Código de servicio para salir
    xor ebx, ebx        ; Código de salida 0
    int 0x80            ; Llamada al sistema
EOF

