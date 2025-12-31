bits 16

start: jmp boot

boot:
cli
cld

; set stack pointer
mov bp, 0x9000
mov sp, bp

call load_kernel
call protected_mode

load_kernel:
    ; int 13 loads kernel from sector 2 into main memory
    ; set buffer
    mov ax, 0x50
    mov es, ax
    xor bx, bx

    ; mode = CHS (cylinder header sector)
    mov ah, 0x2

    mov al, 5  ; read 2 sectors
    mov ch, 0x0  ; read track 0
    mov cl, 0x2  ; sector 2 (weired as track is 0 index and sector is 1 due to IBM duffers)
    mov dh, 0x0  ; head number of floppy disk
    mov dl, 0x0  ; 0=A  means floppy disk 1
    int 0x13     ; BIOS sub-routine read disk/HDD
    ret

%include "global_discriptor_table.asm"
%include "protected_mode.asm"


hlt

times 510 - ($-$$) db 0
dw 0xAA55
