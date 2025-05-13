section .bss
    buffer resb 2       ; para leer un carácter + \n

section .data
    msg1 db 0xA, 0xA, 'LEE SEIS DIGITOS Y LOS INSERTA EN EL STACK', 0xA
    len1 equ $ - msg1

    msg2 db 'LUEGO LOS EXTRAE EN EL ORDEN LIFO', 0xA
    len2 equ $ - msg2

    msg3 db 'ingresa valor unario (0 <= x <= 9)---> ', 0
    msg3len equ $ - msg3

    msg4 db 0xA, 'impresion de datos', 0xA, 0xA
    len4 equ $ - msg4

    espacio db '      ', 0xA
    lenesp equ $ - espacio

section .text
    global _start

_start:

    ; imprimir msg1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; imprimir msg2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; leer 6 dígitos
    mov ecx, 6

leer_digito:
    ; imprimir msg3
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, msg3len
    int 0x80

    ; leer 1 byte desde stdin
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 2      ; leer 1 char + \n
    int 0x80

    ; verificar que esté entre '0' y '9'
    mov al, [buffer]
    cmp al, '0'
    jb leer_digito
    cmp al, '9'
    ja leer_digito

    ; guardar en stack (convertido en 16 bits para que funcione bien el `pop`)
    movzx ax, al
    push ax

    loop leer_digito

    ; imprimir msg4
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, len4
    int 0x80

    ; imprimir valores en orden LIFO
    mov ecx, 6

imprimir:
    ; espacio
    mov eax, 4
    mov ebx, 1
    mov ecx, espacio
    mov edx, lenesp
    int 0x80

    ; extraer valor
    pop ax
    mov dl, al

    ; imprimir carácter
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov [buffer], dl
    mov edx, 1
    int 0x80

    loop imprimir

    ; salir
    mov eax, 1
    xor ebx, ebx
    int 0x80

