section .data
msg0 db "Examen practico unidad # 1", 0xA, 0xD, "Nombre: name surname1 surname2", 0xA, 0xD, "No control: 99999999 grupo 6**", 0xA, 0xD, 0
msg3 db "Numero # 1 ===> ", 0
msg4 db "Numero # 2 ===> ", 0
msg5 db "Numero # 3 ===> ", 0
msg6 db "     ", 0
msg7 db "Valor minimo => ", 0

section .bss
n1 resb 1
n2 resb 1
n3 resb 1

section .text
global _start

_start:
    ; Mostrar mensaje de bienvenida
    mov eax, 4         ; syscall 4: write
    mov ebx, 1         ; file descriptor 1: STDOUT
    mov ecx, msg0      ; mensaje a mostrar
    mov edx, 42        ; longitud del mensaje
    int 0x80           ; llamada al sistema (syscall)

    ; Solicitar número 1
    mov eax, 4         ; syscall 4: write
    mov ebx, 1         ; file descriptor 1: STDOUT
    mov ecx, msg3      ; mensaje a mostrar
    mov edx, 15        ; longitud del mensaje
    int 0x80           ; llamada al sistema (syscall)

    mov eax, 3         ; syscall 3: read
    mov ebx, 0         ; file descriptor 0: STDIN
    mov ecx, n1        ; almacenar entrada
    mov edx, 1         ; leer un byte
    int 0x80           ; llamada al sistema (syscall)

    ; Solicitar número 2
    mov eax, 4         ; syscall 4: write
    mov ebx, 1         ; file descriptor 1: STDOUT
    mov ecx, msg4      ; mensaje a mostrar
    mov edx, 15        ; longitud del mensaje
    int 0x80           ; llamada al sistema (syscall)

    mov eax, 3         ; syscall 3: read
    mov ebx, 0         ; file descriptor 0: STDIN
    mov ecx, n2        ; almacenar entrada
    mov edx, 1         ; leer un byte
    int 0x80           ; llamada al sistema (syscall)

    ; Solicitar número 3
    mov eax, 4         ; syscall 4: write
    mov ebx, 1         ; file descriptor 1: STDOUT
    mov ecx, msg5      ; mensaje a mostrar
    mov edx, 15        ; longitud del mensaje
    int 0x80           ; llamada al sistema (syscall)

    mov eax, 3         ; syscall 3: read
    mov ebx, 0         ; file descriptor 0: STDIN
    mov ecx, n3        ; almacenar entrada
    mov edx, 1         ; leer un byte
    int 0x80           ; llamada al sistema (syscall)

    ; Validar que los números estén en el rango adecuado
    ; Comparar n1 (n1 = al)
    mov al, [n1]
    cmp al, '0'        ; Comparar con '0'
    jb captura
    cmp al, '9'        ; Comparar con '9'
    ja captura

    ; Comparar n2 (n2 = al)
    mov al, [n2]
    cmp al, '0'        ; Comparar con '0'
    jb captura
    cmp al, '9'        ; Comparar con '9'
    ja captura

    ; Comparar n3 (n3 = al)
    mov al, [n3]
    cmp al, '0'        ; Comparar con '0'
    jb captura
    cmp al, '9'        ; Comparar con '9'
    ja captura

captura:
    ; Si no es válido, volver a capturar
    ; (Implementar la lógica de captura nuevamente)

    ; Comparar los valores
    ; Si el primer número es el más pequeño
    mov al, [n1]
    mov bl, [n2]
    mov cl, [n3]

    ; Comparar n1 < n2
    cmp al, bl
    ja valida_2

    ; Comparar n1 < n3
    cmp al, cl
    ja valida_2

valida_2:
    ; Comparar n2 < n3
    cmp bl, cl
    ja fin

    ; Mostrar el valor más pequeño
    mov eax, 4         ; syscall 4: write
    mov ebx, 1         ; file descriptor 1: STDOUT
    mov ecx, msg6      ; mensaje a mostrar
    mov edx, 6         ; longitud del mensaje
    int 0x80           ; llamada al sistema (syscall)

    mov eax, 4         ; syscall 4: write
    mov ebx, 1         ; file descriptor 1: STDOUT
    mov ecx, msg7      ; mensaje a mostrar
    mov edx, 15        ; longitud del mensaje
    int 0x80           ; llamada al sistema (syscall)

fin:
    mov eax, 1         ; syscall 1: exit
    xor ebx, ebx       ; estado de salida 0
    int 0x80           ; llamada al sistema (syscall)

