BUILD_DIR=../build
OS=$(BUILD_DIR)/kernel

CFLAGS += -ffreestanding

OS_SRCS := $(wildcard *.c)
OS_OBJS := $(patsubst %.c, $(OS)/%.o, $(OS_SRCS))

all: $(OS)

$(OS)/%.o: %.c
	i686-elf-gcc $(CFLAGS) -c -g $< -o $@


$(OS): $(OS_OBJS)
	i686-elf-ld -nmagic -T kernel.lds $(OS_OBJS) -o $(OS)/kernel_sample.o.elf

clean:
	rm $(OS)/*