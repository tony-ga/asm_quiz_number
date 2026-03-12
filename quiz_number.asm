; --- ADIVINA EL NUMERO ENTERO ---



section .data

	out1 db "Adivina el numero entero secreto entre 0-9: "

	out1_len equ $ - out1



	out2 db "Adivinaste :)", 10

	out2_len equ $ - out2



	out3 db "Intentalo nuevamente: "

	out3_len equ $ - out3



	num db 6



section .bss

	user_input resb 8



section .text

	global _start



_start:

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



	xor rax, rax



	movzx rax, byte [rsi]

	sub rax, 0x30



	mov rbx, rax

	cmp bl, [num]

	jz correct ; SI bl - num = 0 SE CUMPLE LA CONDICION

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
