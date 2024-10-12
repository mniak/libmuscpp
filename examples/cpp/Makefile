CFLAGS+=-I/opt/homebrew/lib/zig/

main.bin: main.cpp ../../build/libmus.h
	${CXX} -I../../build/ ${CFLAGS} main.cpp -o main.bin

PHONY=run
run: main.bin
	./main.bin
