; src/saludo.asm
; Programa 1: salida de texto en DOS
; Ensamble: nasm -f bin saludo.asm -o ../bin/saludo.com

org 0x100                ; Formato .COM: el código inicia en el offset 100h

section .data
    ; Mensajes terminados en '$' para la función 09h
    nombre db "Laboratorio 5 - DOSBox y Ensamblador", 0Dh, 0Ah
           db "Estudiante: Ayala", 0Dh, 0Ah
           db "Unidad 5 - Arquitectura de Computadores", 0Dh, 0Ah, "$"

section .text
    ; Mostrar el mensaje
    mov ah, 09h          ; Función DOS: imprimir cadena
    mov dx, nombre       ; Dirección de la cadena en DX
    int 21h              ; Llamada al sistema

    ; Terminar el programa correctamente
    mov ax, 4C00h        ; Función 4Ch: terminar proceso
    int 21h              ; Retorno al sistema operativo