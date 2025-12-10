;------------------------------------------
; Function: pow
; Input:
;	rdi - base
;	rsi - exponent
; Output:
;	rax - result
;------------------------------------------

section .text
	global pow

pow:
	push rbp
	mov rbp, rsp

	mov rax, 1
	cmp rsi, 0
	je .done

	mov rcx, rsi

.loop:
	cmp rcx, 0
	je .done
	imul rax, rdi
	dec rcx
	jmp .loop

.done:
	pop rbp
	ret

