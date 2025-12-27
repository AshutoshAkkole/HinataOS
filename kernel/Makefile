BUILD_DIR=../build
OS=$(BUILD_DIR)/kernel

CFLAGS+=-ffreestanding -nostdlib -gdwarf-4 -m32 -ggdb3

OS_SRCS := $(wildcard *.c)
OS_OBJS := $(patsubst %.c, $(OS)/%.o, $(OS_SRCS))

all: $(OS)

$(OS)/%.o: %.c
	gcc $(CFLAGS) -c $< -o $@


$(OS): $(OS_OBJS)
	ld -m elf_i386 -T kernel.lds $(OS_OBJS) -o $(OS_OBJS).elf

clean:
	rm $(OS)/*