;------------------------------------------
; Function: slise
;	Extracts a slice from a string starting at a given index
;
; Input:
;	rdi - pointer to the string
;	rsi - starting index. Default is 0
;	rdx - ending index
;
;	rax - buffer to store the sliced string
;
; Output:
;	rax - pointer to the sliced string
;------------------------------------------
section .text
	global slise

slise:
	push rbp
	mov rbp, rsp

	mov rcx, rsi		; starting index

	cmp rsi, 0
	je .isStart
	jmp .isEnd

.slise_loop:
	mov bl, [rdi + rcx]
	mov [rax], bl
	cmp rcx, rdx
	je .done
	inc rax
	inc rcx
	jmp .slise_loop
.done:
	mov [rax + 1], byte 0	; null-terminate the string
	pop rbp
	ret

.isStart:
	dec rdx
	jmp .slise_loop
.isEnd:
	inc rcx
	jmp .slise_loop

