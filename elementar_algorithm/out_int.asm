section .data
	num dw 45000
	string times 10 db 0

section .text
	global _start

_start:
	call int_to_string

	mov edx, 6
	mov ecx, string
	mov eax, 4
	mov ebx, 1
	int 0x80

	mov eax, 1
	int 0x80

int_to_string:
	mov ax, [num]
	movzx eax, ax

	mov ecx, string
	add ecx, 5

	mov ebx, 10
.to_ascii:
	xor edx, edx
	div ebx
	add dl, '0'
	mov [ecx], dl
	dec ecx

	cmp eax, 0
	jne .to_ascii

	mov byte [ecx], 0

	ret

