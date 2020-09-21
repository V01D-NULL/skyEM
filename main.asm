[org 0x7c00]

;   TODO:
;       Load all the sectors from the drive that are available to skyEM
;

; FIND OUT HOW TO  PRINT COLORFUL CHARACTERS AND MAKE A GAME SELECTION SCREEN OUT OF IT OR SOMETHING

call mode_text

mov si, version
call print

; mov si, msg
; call print

call shell

jmp $

    
%include "stdio/print.asm"
%include "vga/mode.asm"
%include "drivers/keyb.asm"
%include "vga/gfx_256.asm"

version db "skyEM - The Skyline retro game Emulator - 16 bits", 0x0A, 0x0D, 0

; msg db 0xDF, 0 ; Square block - To render extended ascii chars just put in the hex value of the ascii char

times 510-($-$$) db 0
dw 0xaa55
