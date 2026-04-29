; src/entrada.asm
; Programa 2: leer carácter del teclado y mostrar eco
; Ensamble: nasm -f bin entrada.asm -o ../bin/entrada.com

org 0x100                ; Origen para archivos .COM[cite: 9]

section .data
    prompt  db "Ingrese una letra (se mostrara su codigo ASCII): $"
    msg_ok  db 0Dh, 0Ah, "Caracter recibido: $"
    msg_cod db 0Dh, 0Ah, "Codigo ASCII (hex): $"
    nl      db 0Dh, 0Ah, "$"

section .text
    ; Mostrar prompt inicial[cite: 9]
    mov ah, 09h
    mov dx, prompt
    int 21h

    ; Leer un carácter sin eco[cite: 9]
    mov ah, 07h          ; Función 07h: entrada directa sin eco[cite: 9]
    int 21h              ; El carácter queda en AL[cite: 9]
    mov bl, al           ; Guardamos el carácter en BL[cite: 9]

    ; Confirmar carácter recibido[cite: 9]
    mov ah, 09h
    mov dx, msg_ok
    int 21h

    mov ah, 02h          ; Función 02h: mostrar un solo carácter[cite: 9]
    mov dl, bl           ; El carácter a mostrar va en DL[cite: 9]
    int 21h

    ; Mostrar mensaje para el código hexadecimal[cite: 9]
    mov ah, 09h
    mov dx, msg_cod
    int 21h

    ; --- Convertir y mostrar el código ASCII en Hex ---
    mov al, bl
    shr al, 4            ; Obtenemos el nibble alto[cite: 9]
    call print_hex_nibble

    mov al, bl
    and al, 0Fh          ; Obtenemos el nibble bajo[cite: 9]
    call print_hex_nibble

    ; Finalizar[cite: 9]
    mov ah, 09h
    mov dx, nl
    int 21h
    mov ax, 4C00h
    int 21h

; Subrutina: convierte el valor en AL a carácter ASCII hexadecimal[cite: 9]
print_hex_nibble:
    cmp al, 9
    jle .digito
    add al, 7            ; Ajuste para letras A-F[cite: 9]
.digito:
    add al, 30h          ; Convertir a ASCII numérico[cite: 9]
    mov ah, 02h
    mov dl, al
    int 21h
    ret