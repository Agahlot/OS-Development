org 0x7c00

bits 16

segment .text
	global _start
	
start:
		xor ax,	ax
		mov ds, ax
		mov es, ds
		
		mov bx, 0x80000	;stack segment can be any usable memory
		mov ss, bx		;top of stack is at 0x80000
		mov sp, ax		;stack starts at sp=0 i.e., 0x8FFFF
		cld				;sets the direction flag in positive direction
		
		mov si, welcome_msg
		call welcome_print
		
		mov si, kernel_msg
		call welcome_print
		
		mov ah, 00
		int 13h
		
read_sector:
		xor ax, ax
		mov es, ax
		mov bx, 0x1000	;ES:BX=0x0:0x1000
		
		mov ah, 02	;read sectors from drive
		mov al, 01	;number of sectors to read
		mov ch, 00	;number of cylinders. 2nd sector is cylinder 0
		mov dh, 00	;Head to read
		mov cl, 02	;sectors to read
			;dl as the drive will be provided by the BIOS
			
		int 13h
		
	jc wel_error
	popf
	jmp 0x0:0x1000
	cli
	hlt
	
wel_eror:
		mov si, wel_error_msg
		call welcome_print
		mov si, wel_error_msg1
		call welcome_print
		mov ah, 00
		int 16h
		xor ax, ax
		int 19h
		
				
