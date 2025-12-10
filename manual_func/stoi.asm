;------------------------------------------
; Function: stoi
;	Converts a string representation of a decimal integer
;
; Input:
;	rdi - pointer to null-terminated string
;
; Output:
;	rax - integer value
;	rdx - length of processed string
;------------------------------------------
; Function: stoiAD
; stoiAD - string to integer after dot
; Input:
;	rdi - pointer to null-terminated string
; Output:
;	xmm0 - float value
;------------------------------------------

section .text
	global stoi
	global stoiAD

	extern pow

stoi:
	push rbp
	mov rbp, rsp

	xor rax, rax        ; result = 0
	xor rcx, rcx        ; index = 0
	mov rsi, 10         ; base (10 for decimal)
	mov rbx, 1

.loop:
	mov dl, [rdi + rcx]       ; load character

	cmp dl, '-'
	jne .endif
	cmp rcx, 0
	jmp .isNegative

.endif	inc rcx
	cmp dl, '0'
	jl .done
	cmp dl, '9'
	jg .done

	sub dl, '0'
	imul rax, rsi
	movzx rdx, dl
	add rax, rdx

	jmp .loop

.done:
	dec rcx
	mov rdx, rcx
	imul rax, rbx

	xor rbx, rbx
	pop rbp
	ret

.isNegative:
	inc rcx
	neg rbx
	jmp .loop


stoiAD:
	push rbp
	mov rbp, rsp

	xorps xmm0, xmm0
.loopAD:
	call stoi
	push rax

	mov rdi, 10
	mov rsi, rdx
	call pow

	pop rdi

	cvtsi2sd xmm0, rdi
	cvtsi2sd xmm1, rax
	divsd xmm0, xmm1

.doneAD:
	pop rbx
	ret

