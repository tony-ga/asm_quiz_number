; --- ADIVINA EL NUMERO ENTERO ---

section .data
	out1 db "Adivina el numero entero secreto entre 0-9: "
	out1_len equ $ - out1

	out2 db "Adivinaste :)", 10
	out2_len equ $ - out2

	out3 db "Intentalo nuevamente: "
	out3_len equ $ - out3

section .bss

	user_input resb 8

section .text

	global _start

_start:
	; 1. PREPARACION (Esconder el numero)
	mov rax, 0x9b	
	push rax	

	xor rax, rax

	mov rax, 1
	mov rdi, 1
	mov rsi, out1
	mov rdx, out1_len
	syscall

input:
	
	mov rax, 0
	mov rdi, 0
	mov rsi, user_input
	mov rdx, 8
	syscall

	pop rax
	call comprobar_numero
	push rax

	mov rax, 1
	mov rdi, 1
	mov rsi, out3
	mov rdx, out3_len
	syscall

	jmp input

comprobar_numero:
	movzx rbx, byte [user_input]

	sub rbx, 0x30

	xor rax, 157

	cmp bl, al 
	jz correct

	xor rax, 157

	ret

correct:

	mov rax, 1
	mov rdi, 1
	mov rsi, out2
	mov rdx, out2_len
	syscall

end:
	mov rax, 60
	xor rdi, rdi
	syscall
