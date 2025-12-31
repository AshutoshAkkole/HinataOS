BUILD = ../build/bootloader
SOURCES = $(wildcard *.asm)
BINS = $(patsubst %.asm, $(BUILD)/%.o, $(SOURCES))

all: ${BUILD} $(BINS)

${BUILD}:
	mkdir -p ${BUILD}

$(BUILD)/%.o: bootloader.asm
	nasm -f elf $< -F dwarf -g -o $@
	ld -m elf_i386 -T bootloader.lds $@ -o $@.elf
	objcopy -O binary $(BUILD)/bootloader.o.elf $@

clean:
	rm $(BUILD)/*
