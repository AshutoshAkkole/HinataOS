bits 16

protected_mode:
    lgdt [gdt_descriptor]           ; load global_discriptor_table
    call A20_enable                 ; enable a20 line
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

    jmp CODE_SEG:0x600 ; jump to kernel 

