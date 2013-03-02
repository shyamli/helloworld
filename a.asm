org 0x7C00
jmp _start

	message: db 'Input :', 10
	len: equ $-message
	message1: db 'The key entered is :', 10
	len1: equ $-message1

_start:

	mov ax,0
	mov al,03
	int 10h		; set video mode

	mov bp,message

	mov ah,13h	; write string
	mov al,01h	; write mode
	mov bh,00	; page no
	mov bl,10	; color
	mov cx,len	; length of string
	mov dh,05	; row
	mov dl,05	; column
	int 10h
	
	mov ah, 10h   
	int 16h		; get ascii code of pressed key in al
	cmp al, 0
	jz other
	jmp def
other:
	mov [7D00h], ah
	jmp next
def:
	mov [7D00h], al
	jmp next
next:
	mov bp,message1

        mov ah,13h      ; write string
        mov al,01h      ; write mode
        mov bh,00       ; page no
        mov bl,10       ; color
        mov cx,len1     ; length of string
        mov dh,10       ; row
        mov dl,05       ; column
        int 10h

	mov al, [7D00h]	
	
      	mov ah, 09h	; write character at cursor position
	mov cx, 01h	; COUNT
	mov bl, 05	; COLOR
	int 10h

times 510 - ($ - $$) db 0
dw 0xAA55

