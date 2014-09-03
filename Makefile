# Makefile for OrangeS

# Entry point of OrangeS
# It must have the same value with "KernelEntryPointPhyAddr" in 'load.inc'
ENTRYPOINT = 0x30400

# Offset of entry point in kernel file
# It depends on ENTRYPOINT
ENTRYOFFSET = 0x400

# Tools, paramaters, and flags
ASM		= nasm
DASM		= ndism
CC		= gcc
LD		= ld
ASMBFLAGS	= -I boot/include/
ASMKFLAGS	= -I include/ -f elf
CFLAGS		= -I include/ -c -fno-builtin -fno-stack-protector  -m32
LDFLAGS		= -s -Ttext $(ENTRYPOINT) -m elf_i386

# This program
ORANGESBOOT	= boot/boot.bin boot/loader.bin
ORANGESKERNEL	= kernel.bin
OBJS		= kernel/kernel.o kernel/start.o kernel/main.o \
			kernel/i8259.o kernel/global.o kernel/protect.o \
			kernel/clock.o kernel/proc.o kernel/syscall.o \
			kernel/keyboard.o kernel/tty.o kernel/console.o \
			lib/klib.o lib/kliba.o lib/string.o lib/printf.o \
			lib/vsprintf.o
DASMOUTPUT	= kernel.bin.asm

IMAGE		= images/boot.img
TEMPIMAGE	= ../boot.img

# All phony targets
.PHONY: everything final image clean realclean disasm all \
	buildimg update

# Default starting position
everything: $(ORANGESBOOT) $(ORANGESKERNEL)

all: realclean everything

final: all clean

image: final buildimg

clean:
	rm -f $(OBJS)

realclean:
	rm -f $(OBJS) $(ORANGESBOOT) $(ORANGESKERNEL)

disasm:
	$(DASM) $(DASMFLAGS) $(ORANGESKERNEL) > $(DASOUTPUT)

buildimg:
	dd if=/dev/zero of=$(TEMPIMAGE) bs=512 count=2880
	mkfs.msdos $(TEMPIMAGE)
	dd if=boot/boot.bin of=$(TEMPIMAGE) bs=512 count=1 conv=notrunc
	sudo mount -o loop $(TEMPIMAGE) /mnt/floppy/
	sudo cp -f boot/loader.bin /mnt/floppy/
	sudo cp -f kernel.bin /mnt/floppy/
	sudo umount -l /mnt/floppy/
	sudo cp $(TEMPIMAGE) $(IMAGE)

update: final
	sudo mount -o loop $(TEMPIMAGE) /mnt/floppy/
	sudo cp -f boot/loader.bin /mnt/floppy/
	sudo cp -f kernel.bin /mnt/floppy/
	sudo umount -l /mnt/floppy/
	sudo cp $(TEMPIMAGE) $(IMAGE)

boot/boot.bin: boot/boot.asm boot/include/load.inc boot/include/fat12hdr.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

boot/loader.bin: boot/loader.asm boot/include/load.inc \
		 boot/include/fat12hdr.inc boot/include/pm.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

kernel/kernel.o: kernel/kernel.asm include/sconst.inc
	$(ASM) $(ASMKFLAGS) -o $@ $<

kernel/syscall.o: kernel/syscall.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

kernel/clock.o: kernel/clock.c include/type.h include/const.h \
		include/protect.h include/console.h include/tty.h \
		include/proto.h include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/console.o: kernel/console.c include/type.h include/const.h \
		include/protect.h include/console.h include/tty.h include/proto.h \
		include/string.h include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/global.o: kernel/global.c include/type.h include/const.h \
		include/protect.h include/console.h include/tty.h include/proto.h \
		include/proc.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/i8259.o: kernel/i8259.c include/type.h include/const.h \
		include/protect.h include/console.h include/tty.h \
		include/proto.h include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/keyboard.o: kernel/keyboard.c include/type.h include/const.h \
		include/protect.h include/console.h include/tty.h include/proto.h \
		include/proc.h include/global.h include/keyboard.h include/keymap.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/main.o: kernel/main.c include/type.h include/const.h include/protect.h \
		include/console.h include/tty.h include/proto.h include/string.h \
		include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/proc.o: kernel/proc.c include/type.h include/const.h include/protect.h \
		include/console.h include/tty.h include/proto.h include/string.h \
		include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/protect.o: kernel/protect.c include/type.h include/const.h \
		include/protect.h include/console.h include/tty.h include/proto.h \
		include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/start.o: kernel/start.c include/type.h include/const.h \
		include/protect.h include/console.h include/tty.h \
		include/proto.h include/string.h include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

kernel/tty.o: kernel/tty.c include/type.h include/const.h include/protect.h \
		include/console.h include/tty.h include/proto.h include/string.h \
		include/proc.h include/global.h include/keyboard.h
	$(CC) $(CFLAGS) -o $@ $<

lib/klib.o: lib/klib.c include/type.h include/const.h include/protect.h \
		include/console.h include/tty.h include/proto.h include/string.h \
		include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

lib/printf.o: lib/printf.c include/type.h include/const.h include/protect.h \
		include/console.h include/tty.h include/proto.h include/string.h \
		include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

lib/vsprintf.o: lib/vsprintf.c include/type.h include/const.h \
		include/protect.h include/console.h include/tty.h include/proto.h \
		include/string.h include/proc.h include/global.h
	$(CC) $(CFLAGS) -o $@ $<

lib/kliba.o: lib/kliba.asm include/sconst.inc
	$(ASM) $(ASMKFLAGS) -o $@ $<

lib/string.o: lib/string.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

$(ORANGESKERNEL): $(OBJS)
	$(LD) $(LDFLAGS) -o $(ORANGESKERNEL) $(OBJS)
