@echo off

REM Compile and Link
REM You need to compile the libmus using 'zig build --release=fast' first
cl main.c /I../../headers /link /LIBPATH:../../zig-out/lib libmus.lib