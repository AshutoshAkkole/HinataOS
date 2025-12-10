;************************************************
; sector 2 would have maybe kernel code
; This is sample code

bits 16

mov ah, 0x2
mov bh, 0x0
mov dl, 0xF
mov dh, 0xF
int 0x10

mov ah, 0x9
mov al, 0x61
mov bl, 0x9
mov cx, 0x1
int 0x10

hlt

times 510 - ($-$$) db 0