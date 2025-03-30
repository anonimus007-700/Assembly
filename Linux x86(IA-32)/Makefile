all:
	nasm -f elf -g $(prog).asm
	ld -m elf_i386 $(prog).o -o $(prog)
	rm $(prog).o

