set disassembly-flavor intel
layout asm
layout reg
set architecture i8086
# --- Disable pagination (no "Type <RET> to continue") ---
# set pagination off
target remote :26000
b *0x7c00
symbol-file build/kernel/kernel_sample.o.elf
b big_bang
layout split

# --- Show CS:IP + real-mode physical address when stopping ---
define hook-stop
    printf "[%04x:%04x] ", $cs, $eip
    x/i $cs*16 + $eip
end
