bits 16

protected_mode:
    lgdt [gdt_descriptor]           ; load global_discriptor_table
    call A20_enable                 ; enable a20 line
    call PIC_remap                  ; init PIC 
    mov eax, cr0                    ; protected_mode on
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_protected_mode ; initialize protected_mode

A20_enable:
    in   al, 0x92
    test al, 00000010b
    jnz  .done          ; already enabled

    or   al, 00000010b  ; set A20 bit
    out  0x92, al

.done:
    ret

PIC_remap:
    mov al, 0x11
    out 0x20, al ; init mode PIC
    call io_wait   ; delay to get PIC set

    mov al, 0x20   ; ICW1
    out 0x21, al   ; offset in IDT start from 0x20
    call io_wait   

    mov al, 0b00000010 ; ICW2
    out 0x21, al       ; master connect to slave by pin 2
    call io_wait

    mov al, 0x01        ;ICW3
    out 0x21, al        ;run PIC in 8086 mode
    call io_wait



    ;for slave PIC chip

    mov al, 0x11
    out 0xA0, al ; init mode PIC
    call io_wait   ; delay to get PIC set

    mov al, 0x28   ; ICW1
    out 0xA1, al   ; offset in IDT start from 0x20
    call io_wait   

    mov al, 0b00000010 ; ICW2
    out 0xA1, al       ; master pin at 2
    call io_wait

    mov al, 0x01        ;ICW3
    out 0xA1, al        ;run PIC in 8086 mode
    call io_wait


    ;unmask interrupt

    mov al, 0b11111101 ; keyboard IRQ line enabled rest is off
    out 0x21, al        

    mov al, 0b11111111 ; slave too whole line is off
    out 0xA1, al

    ret



io_wait:
    mov al,0
    out 0x80, al
    ret



bits 32

init_protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    lidt [interrupt_discriptor]
    sti                ; set CPU interrupt on 

    jmp CODE_SEG:0x600 ; jump to kernel 

