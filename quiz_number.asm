; --- adivina el numero entero ---

section .data
	out1 db "adivina el numero entero secreto entre 0-9: "
	out1_len equ $ - out1

	out2 db "adivinaste :)", 10
	out2_len equ $ - out2

	out3 db "intentalo nuevamente: "
	out3_len equ $ - out3

section .bss

	user_input resb 8

section .text

	global _start

_start:
	; 1. preparacion (esconder el numero)
	mov rax, 6
	xor al, dl
	push rax
	push rdx

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

	call comprobar_numero

	mov rax, 1
	mov rdi, 1
	mov rsi, out3
	mov rdx, out3_len
	syscall

	jmp input

comprobar_numero:
	movzx rbx, byte [user_input]

	sub rbx, 0x30

	mov rdx, [rsp + 8]		; recuperamos la llave dinamica
	mov rax, [rsp + 16]		; recuperamos el secreto cifrado

	xor al, dl	; desciframos: (6 xor llave)

	cmp bl, al 
	jz correct

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
