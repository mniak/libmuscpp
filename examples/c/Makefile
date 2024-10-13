CFLAGS+=-I/opt/homebrew/lib/zig/

main.bin: main.c ../../build/libmus.h
	${CC} -I../../build/ ${CFLAGS} main.c -o main.bin

PHONY=run
run: main.bin
	./main.bin

../../build/libmus.h: ../../src/libmus.zig
	cd ../.. && ${MAKE} build/libmus.h