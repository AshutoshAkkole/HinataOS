; null descriptor 
gdt_start:
    dq 0x0

; code descriptor 
gdt_code:
    dw 0xffff          ; size full ram
    dw 0x0             ; base 32bit start with 0 0-15
    db 0x0             ; base 15-24
    db 10011010b       ; flags
    db 11001111b       ; flags
    db 0x0             ; base 24 - 31

gdt_data:
    dw 0xffff       ; size full ram
    dw 0x0          ; base 32bit start with 0 0-15
    db 0x0          ; base 15-24
    db 10010010b    ; flags
    db 11001111b    ; flags
    db 0x0          ; base 24-31

; end label for calculation
gdt_end:

; descriptor structure 16 bit size of table, 32 bit starting address
gdt_descriptor:
    dw gdt_end-gdt_start -1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start