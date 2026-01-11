table:
    dw handle_zero ; jump to handle_zero
    dw CODE_SEG ; segment
    db 0x0 ; reserved
    db 0b10001111 ; 1111 from is gate type TRAP GATE. 100 is 00 ring 0 protection, 1 for present bit 
    dw 0x0 ;  offset remaining

    times 0x20-0x01 dq 0 ; set rest IDT to zero for now

    ; hardware interrupt
    ; First IRQ don't know what it's map to
    dq 0

    ; keyboard interrupt
    dw handle_zero      ; dummy for now
    dw CODE_SEG
    db 0x0
    db 0b10001110
    dw 0x0


interrupt_discriptor:
    dw 0x10F  ; size is (total size in bytes -1 )
    dd table    ; table address

jmp $

handle_zero:
    jmp CODE_SEG:init_protected_mode

