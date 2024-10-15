@echo off

REM Compile and Link
REM You need to compile the libmus using 'zig build --release=fast' first
@REM cl main.c /I../../headers /link /LIBPATH:../../zig-out/lib libmus.lib
zig cc main.c -I../../build  -IC:\ProgramData\chocolatey\lib\zig\tools\zig-windows-x86_64-0.13.0\lib