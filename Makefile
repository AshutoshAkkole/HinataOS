BUILD_PATH = build
DISK = disk.img
BOOTLOADER = $(BUILD_PATH)/bootloader/bootloader.o
KERNEL = $(BUILD_PATH)/kernel/kernel_sample.o.elf


.PHONY: bootloader kernel disk clean qemu

bootloader:
	make -C bootloader

kernel:
	make -C kernel

all:
	make clean
	make bootloader
	make kernel
	make disk

clean:
	make -C kernel clean
	make -C bootloader clean

qemu-real-mode:
	qemu-system-i386 -machine q35 -fda disk.img -s -S & \
	gdb -ix gdb_init_real_mode.txt \
        -ex 'set tdesc filename target.xml' \
        -ex 'target remote localhost:1234'
qemu:
	qemu-system-i386 -machine q35 -fda disk.img -gdb tcp::26000 -S

bochs:
	bochs -debugger -rc bochsgdbinit


disk : bootloader kernel
	dd if=/dev/zero of=$(DISK) bs=512 count=2880
	dd if=$(BOOTLOADER) of=$(DISK) bs=512 count=1 seek=0 conv=notrunc
	dd if=$(KERNEL) of=$(DISK) bs=512 count=$$(($(shell stat --printf="%s" $(KERNEL))/512)) seek=1 conv=notrunc


