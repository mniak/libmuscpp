PHONY=all
all: build/libmus.h build/libmus.a build/libmus.a.o

build/:
	mkdir -p build

build/libmus.h: src/libmus.zig build/
	zig build-lib src/libmus.zig -ofmt=c -femit-bin=build/libmus.h

build/libmus.a build/libmus.a.o: src/libmus.zig
	zig build-lib src/libmus.zig -femit-bin=build/libmus.a
