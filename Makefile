all: compile run

compile:
	nasm -f bin stage2.asm -o stage2.bin
	nasm -f bin bootloader.asm -o bootloader.bin
	
	dd if=/dev/zero of=skyEM.img bs=1024 count=1440
	dd if=bootloader.bin of=skyEM.img conv=notrunc
	@mv skyEM.img bin/skyEM.img

run:
	qemu-system-i386 -fda bin/skyEM.img --full-screen
