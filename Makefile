CC = fasm
# LIBS = asmlib/fmt.o asmlib/str.o asmlib/sys.o asmlib/mth.o

build:
	clear
	$(CC) main.asm
	ld main.o -o main
	rm -rf main.o
run: 
	./main

dump: 
	objdump -S -M intel -d main > obj.dump
	cat obj.dump