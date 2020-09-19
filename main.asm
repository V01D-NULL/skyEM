[org 0x7c00]

;;;;;;;;;;;;;;;;;;;;;
; Game input (WASD, Arrow keys)
;
    KEY_W equ 0x77
    
;
;;;;;;;;;;;;;;;;;;;;;


call mode_text

mov si, version
call print

; mov bx, sleep_time
; call sleep

mov si, msg
call print

mov al,0xb6     ; Flap sound
out (0x43),al

; call cli
; call shell

jmp $

cli:
    mov ax, 0x00
    int 0x16
    cmp al, 0x0D
    je nl
    cmp al, KEY_W
    je w_key
    cmp al, exit
    je sExit
    mov ah, 0x0E
    int 0x10
;     mov console_in_buffer, [ al ]
    jmp cli

w_key:
    mov si, version
    call print
    jmp cli
    
nl:
    mov si, newline
    call print
    jmp cli

sExit:
    int 0x19 ; Reboot
    
%include "stdio/print.asm"
%include "vga/mode.asm"
; %include "drivers/keyb.asm"

version db "skyEM - The Skyline retro game Emulator - 16 bits", 0x0A, 0x0D, 0
newline db 0x0A, 0x0D, 0 ; Put this in keyb.asm
exit db "exit", 0x0D
console_in_buffer db "", 0
msg db 0xDF, 0 ; Square block - To render extended ascii chars just put in the hex value of the ascii char

times 510-($-$$) db 0
dw 0xaa55
