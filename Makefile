HEXDMP = xxd
NASM = nasm
NFLAGS = -f bin -g
TARGET = skyEM.img
HEXDMP_OUT = debug/$(TARGET)_dump.hex
QEMU = qemu-system-i386

all: compile flp_img run

run:
	 $(QEMU) -fda bin/$(TARGET) --full-screen

hexdump:
	$(HEXDMP) bin/$(TARGET) > $(HEXDMP_OUT) 

compilerdump:
	$(NASM) $(NFLAGS) stage2.asm -o stage2.bin -l debug/compiler/stage2.lst
	$(NASM) $(NFLAGS) bootloader.asm -o bootloader.bin -l debug/compiler/bootloader.lst
	
# No need for complex Makefile rules since nasm automatically compiles all files included in stage2.asm
compile:
	$(NASM) $(NFLAGS) stage2.asm -o stage2.bin
	$(NASM) $(NFLAGS) bootloader.asm -o bootloader.bin
	
flp_img:
	dd if=/dev/zero of=$(TARGET) bs=1024 count=1440
	dd if=bootloader.bin of=$(TARGET) conv=notrunc
	@mv $(TARGET) bin/$(TARGET)
