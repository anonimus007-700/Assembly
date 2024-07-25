section .text
    global _start

_start:
    mov edx, len
    mov ecx, msg
    mov ebx, 1    ; файловий дескриптор (stdout)
    mov eax, 4    ; номер системного виклику (sys_write)
    int 0x80      ; виклик ядра

    mov edx, 9
    mov ecx, s2
    mov ebx, 1    ; файловий дескриптор (stdout)
    mov eax, 4    ; номер системного виклику (sys_write)
    int 0x80      ; виклик ядра

    mov eax, 1    ; номер системного виклику (sys_exit)
    int 0x80      ; виклик ядра

section	.data
msg db 'Displaying 9 stars',0xa 
len equ $ - msg  ; довжина повідомлення
s2 times 9 db '+'
