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
	mov rax, 6	; El numero secreto es 6
	push rax	; <--- LO GUARDAMOS EN EL STACK

	xor rax, rax

	mov rax, 1
	mov rdi, 1
	mov rsi, out1
	mov rdx, out1_len
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, user_input
	mov rdx, 8
	syscall
	jmp thread

try:
	mov rax, 1
	mov rdi, 1
	mov rsi, out3
	mov rdx, out3_len
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, user_input
	mov rdx, 8
	syscall

thread:
	; COMPARACION (RECUPERAR EL STACK)
	movzx rbx, byte [user_input]

	sub rbx, 0x30

	pop rax		; <--- SACAMOS EL 6 DEL STACK Y SE QUEDA EN RAX

	cmp bl, al
	jz correct ; SI bl - al = 0 SE CUMPLE LA CONDICION
	push rax
	jmp try

correct:

	mov rax, 1
	mov rdi, 1
	mov rsi, out2
	mov rdx, out2_len
	syscall
	jmp end

end:

	mov rax, 60
	mov rdi, 0
	syscall
