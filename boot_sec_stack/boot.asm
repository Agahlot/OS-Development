bits 16

segment .text
	global _start

_start:

	mov ah, 0x0e	;scrolling tele-type bios routine for printing on screen

	mov bp, 0x8000	;stack above the where BIOS loads our boot code
	mov sp, bp

	push 'A'	;pushes are 16bits and MSB will be 0x00, added by the compiler
	push 'B'
	push 'C'

	pop bx		;we can pop only 16bits so convert into 8 bits 
	mov al, bl	;and move LSB 8bits in al
	int 0x10

	pop bx
	mov al, bl
	int 0x10	;Interrupt for printing on screen

	mov al, [0x7ffe]	;0x8000-0x0002(16 bits) is 0x7ffe	;	--------------
	int 0x10												;	|  ESP/EBP	 |  <------0x8000	
															;	--------------
	jmp $													;	|	  A		 |	<------0x7ffe
															;	--------------
times 510-($-$$) db 0										;	|	  B		 |	<------0x7ffd
dw 0xaa55													;	--------------
															;	|	  C		 |	<------0x7ffc
															;	--------------