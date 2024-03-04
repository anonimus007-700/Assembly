section .text
    global _start

_start:
    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, sigm_len
    mov ecx, sigm_msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 1
    int 0x80

section .data
msg db 'Hello, world!', 0xa
sigm_msg db 'i am, a sigma :)', 0xa

len equ $ - msg
sigm_len equ $ - sigm_msg