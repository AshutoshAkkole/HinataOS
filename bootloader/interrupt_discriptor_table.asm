table:
    dw handle_zero ; jump to handle_zero
    dw CODE_SEG ; segment
    db 0x0 ; reserved
    db 0b10001111 ; 1111 from is gate type TRAP GATE. 100 is 00 ring 0 protection, 1 for present bit 
    dw 0x0 ;  offset remaining


interrupt_discriptor:
    dw 0x7  ; size is (total size in bytes -1 )
    dd table    ; table address

jmp $

handle_zero:
    jmp CODE_SEG:init_protected_mode

