section .bss
	slice_str resb 32

section .text
	global stof

	extern stoi
	extern stoiAD
	extern strlen
	extern slise

stof:
	push rbp
	mov rbp, rsp

	mov rdi, [rbp+24]

	call finddot		; in: rdi => rax position of dot
	push rax
	mov rdx, rax
	mov rsi, 0
	mov rax, slice_str

	call slise		; slice from 0 to dot position

	push rdi
	mov rdi, slice_str
	call stoi
	mov rbx, rax
	pop rdi
	pop rax

	push rbx
	push rax

	call strlen
	mov rdx, rax
	pop rax
	mov rsi, rax
	mov rax, slice_str

	call slise

	mov rdi, slice_str
	call stoiAD

	pop rax
	cvtsi2sd xmm1, rax

	addsd xmm0, xmm1

	mov rax, 60		; syscall: exit
	xor rdi, rdi		; status: 0
	syscall


finddot:
	xor rax, rax
	xor cl, cl
.find_loop:
	mov cl, [rdi + rax]
	cmp cl, 0
	je .not_found
	cmp cl, '.'
	je .found
	inc rax
	jmp .find_loop
.not_found:
	mov rax, -1
	ret
.found:
	ret

