CC := gcc
CFLAGS := -m32 -c -g -Wall -Wno-implicit-function-declaration -std=gnu11 -ffreestanding -fno-pic -nostdinc -fno-stack-protector
LD := ld
LDFLAGS := -T linker.ld -m elf_i386

kernel.elf: boot.S kernel.c linker.ld multiboot2.h
	$(CC) $(CFLAGS) kernel.c -o kernel.o
	$(CC) $(CFLAGS) boot.S -o boot.o
	$(LD) $(LDFLAGS) boot.o kernel.o -o kernel.elf

.PHONY: newiso clean

newiso: kernel.elf
	@cp kernel.elf ./iso
	@rm -rf kernel.iso
	@grub-mkrescue -o kernel.iso iso
	@echo "[*] ISO ready"

clean:
	rm -rf boot.o kernel.o kernel.elf kernel.iso