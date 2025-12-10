;------------------------------------------
; Function: atoi
;	Calculates the length of a null-terminated string
;
; Input:
;	rdi - pointer to null-terminated string
;
; Output:
;	rax - string length
;------------------------------------------
section .text
	global strlen

strlen:
	push rbp
	mov rbp, rsp

	xor rcx, rcx		; length = 0
.next_char:
	cmp byte [rdi + rcx], 0
	je .done_strlen
	inc rcx
	jmp .next_char
.done_strlen:
	mov rax, rcx		; move length to rax
	pop rbp
	ret

