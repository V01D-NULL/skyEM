[org 0x7c00]

;;;;;;;;;;;;;;;;;;;;;
; Game input (WASD, Arrow keys)
;
    KEY_W equ 0x77
    
;
;;;;;;;;;;;;;;;;;;;;;

; FIND OUT HOW TO  PRINT COLORFUL CHARACTERS AND MAKE A GAME SELECTION SCREEN OUT OF IT OR SOMETHING

call mode_text

mov si, version
call print

mov si, msg
call print

call cli
; call shell

jmp $

cli:
    mov ax, 0x00
    int 0x16
    cmp al, 0x0D
    je nl
    cmp al, KEY_W
    je w_key
    cmp al, txt_mode
    je new_mode_text
    cmp al, vid_mode
    je vid_mode
    mov ah, 0x0E
    int 0x10
    jmp cli

w_key:
    mov si, version
    call print
    jmp cli
    
nl:
    mov si, newline
    call print
    jmp cli

new_mode_text:  
    call mode_text
    ret
    
new_mode_video:
    call mode_video
    ret
    
%include "stdio/print.asm"
%include "vga/mode.asm"
; %include "drivers/keyb.asm"
%include "vga/gfx_256.asm"

version db "skyEM - The Skyline retro game Emulator - 16 bits", 0x0A, 0x0D, 0
newline db 0x0A, 0x0D, 0 ; Put this in keyb.asm
exit db "exit", 0x0D
txt_mode db "s", 0
vid_mode db "v", 0
msg db 0xDF, 0 ; Square block - To render extended ascii chars just put in the hex value of the ascii char

times 510-($-$$) db 0
dw 0xaa55
