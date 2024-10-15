@REM Will generate the C library
zig build-lib src/libmus.zig -ofmt=c "-femit-bin=build/libmus.h"