section .data
    msg db "El dado muestra: ", 0
    len equ $ - msg
    salto db 10        ; Salto de línea (0xA)

section .bss
    numero resb 1      ; Espacio para guardar el número aleatorio

section .text
    global _start

_start:
    ; Generar un número aleatorio entre 1 y 6
    ; Usamos el tiempo del sistema como fuente de aleatoriedad
    mov eax, 0x10       ; Código de servicio para obtener el tiempo
    int 0x80            ; Llamada al sistema (interrupción)
    
    ; Ahora eax tiene el valor de tiempo en segundos
    ; Realizamos modulo 6 para obtener un número entre 0 y 5
    xor edx, edx        ; Limpiar edx
    mov ecx, 6          ; El número 6 para hacer modulo
    div ecx             ; Dividir eax entre 6 (eax/6), el resto estará en edx
    add dl, 1           ; Aseguramos que el número esté entre 1 y 6 (no entre 0 y 5)
    
    mov [numero], dl    ; Guardamos el número generado en la variable

    ; Imprimir el mensaje inicial "El dado muestra: "
    mov eax, 4          ; Código de servicio para escribir
    mov ebx, 1          ; Salida estándar (stdout)
    mov ecx, msg        ; Dirección del mensaje
    mov edx, len        ; Longitud del mensaje
    int 0x80            ; Llamada al sistema

    ; Imprimir el número aleatorio
    movzx eax, byte [numero]  ; Cargar el número generado (0-5) en eax
    add eax, '0'        ; Convertir el número a su valor ASCII
    mov [numero], al    ; Guardarlo de nuevo como carácter ASCII

    mov eax, 4          ; Código de servicio para escribir
    mov ebx, 1          ; Salida estándar (stdout)
    mov ecx, numero     ; Dirección del número (en formato ASCII)
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

