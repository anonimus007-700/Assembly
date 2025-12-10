all:
	nasm -f elf -g $(prog).asm
	ld -m elf_i386 -g $(prog).o -o $(prog)
	rm $(prog).o
all64:
	nasm -f elf64 -g $(prog).asm
	ld -m elf_x86_64 -g $(prog).o -o $(prog)
	rm $(prog).o

