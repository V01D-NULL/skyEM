; This is the main file where all the code that defines skyEM is in
%include "stage2.inc"

[bits 16]
[org STAGE2_RUN_OFFSET]

call mode_text

mov si, welcome_msg
call print

call shell

jmp $

welcome_msg db "skyEM - The Skyline retro game Emulator - 16 bits", 0x0A, 0x0D, 0

%include "vga/mode.asm"
%include "vga/gfx_256.asm"
%include "stdio/print.asm"
%include "drivers/keyb.asm"

