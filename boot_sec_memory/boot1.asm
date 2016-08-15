bits 16

segment .text
	global _start

_start:
	;mov ah, 0x0e
	;mov bx, hello
	;mov bx, 0x7c1e
	mov al, [0x7c08]
	int 0x10
	jmp $

hello:	db "a"

times 510-($-$$) db 0
dw 0xaa55		