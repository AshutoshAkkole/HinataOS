ENTRY(main);

PHDRS
{
    header PT_LOAD FILEHDR PHDRS;
    code PT_LOAD;
}

SECTIONS
{
    .text 0x600 : ALIGN(0x100) { *(.text) } : code
    .data : { *(.data) } : code
    .bss  : { *(.bss)  } : code
    /DISCARD/ : { *(eh_frame) }
}
