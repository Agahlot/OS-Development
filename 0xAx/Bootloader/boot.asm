org 0x7c00

bits 16

segment .text
	global _start
_start:
		jmp boot
		name	dq		"ashish", 0

print:
		lodsb
		or al, al
		jz done
		mov ah, 0x0e
		int 0x10
		jmp print		
done:
		ret		

boot:
		mov si, name
		call print

		cli
		hlt	

times 510 - ($-$$) db 0
			
