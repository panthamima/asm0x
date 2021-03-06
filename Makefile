CC = fasm
# LIBS = asmlib/fmt.o asmlib/str.o asmlib/sys.o asmlib/mth.o

build:
	clear
	$(CC) v2.asm
	ld v2.o -o main
	rm -rf v2.o
run: 
	./main

dump: 
	objdump -S -M intel -d main > obj.dump
	cat obj.dump