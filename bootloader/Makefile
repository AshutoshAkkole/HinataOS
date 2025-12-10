BUILD = ../build/bootloader
SOURCES = $(wildcard *.asm)
BINS = $(patsubst %.asm, $(BUILD)/%.o, $(SOURCES))

all: ${BUILD} $(BINS)

${BUILD}:
	mkdir -p ${BUILD}

$(BUILD)/%.o: %.asm
	nasm -f bin $< -o $@

clean:
	rm $(BUILD)/*
