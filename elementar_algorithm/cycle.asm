section .text
	global _start

_start:
	mov ecx, 10

lp:;	mov edx, 5
;	mov ecx, msg
;	mov ebx, 1
;	mov eax, 4
;	int 0x80

	dec dword [num]
	jnz short lp

	mov eax, 1
	int 0x80

section .data
	msg dw 'Hello', 0xa
	num dd 1000000000

