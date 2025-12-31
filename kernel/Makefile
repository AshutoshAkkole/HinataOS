BUILD_DIR=../build
OS=$(BUILD_DIR)/kernel

CFLAGS += -ffreestanding -nostdlib -m32 -ggdb3 -O0 \
          -fno-pie -fno-pic -no-pie \
          -fno-stack-protector \
          -fno-builtin \
          -fno-omit-frame-pointer



OS_SRCS := $(wildcard *.c)
OS_OBJS := $(patsubst %.c, $(OS)/%.o, $(OS_SRCS))

all: $(OS)

$(OS)/%.o: %.c
	gcc $(CFLAGS) -c $< -o $@


$(OS): $(OS_OBJS)
	ld -m elf_i386 -nmagic -T kernel.lds $(OS_OBJS) -o $(OS_OBJS).elf

clean:
	rm $(OS)/*