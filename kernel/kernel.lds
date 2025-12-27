ENTRY(main);

PHDRS
{
code PT_LOAD FILEHDR PHDRS FLAGS(0x5);
}

SECTIONS
{
    .text 0x600 : ALIGN(0x100) { *(.text) }  : code
    .data : { *(.data) }
    .bss : { *(.bss) }
    /DISCARD/ : { *(eh_frame) }
}