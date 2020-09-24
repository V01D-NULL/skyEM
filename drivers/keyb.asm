;;;;;;;;;;;;;;;;;;;;;
; Game input (WASD, Arrow keys)
;
    KEY_W equ 0x77
    
;   Menu input (Game selection, reboot, shutdown, game
    KEY_TEXT_MODE equ 0x74   ; "t"
    KEY_VIDEO_MODE equ 0x76  ; "v"
    KEY_HELP equ 0x68        ; "h"
    KEY_REBOOT equ 0x72      ; "r"
    KEY_SHUTDOWN equ 0x73    ; "s"
    KEY_GET_GAMES equ 0x67   ; "g"
;
;;;;;;;;;;;;;;;;;;;;;

shell:
    mov si, shell_input_msg
    call print
    jmp commandLine
  
commandLine:
    mov ax, 0x00
    int 0x16
    
    ; Check keyboard input
    cmp al, 0x0D ; Enter
    je nl
    
    cmp al, KEY_TEXT_MODE 
    je switch_mode_text
    
    cmp al, KEY_VIDEO_MODE
    je switch_mode_video
    
    cmp al, KEY_HELP
    je help_menu
    
    cmp al, KEY_REBOOT
    je reboot
    
    cmp al, KEY_SHUTDOWN
    je shutdown
    
    cmp al, KEY_GET_GAMES
    je kb_get_games
    
    ; Print input
    mov ah, 0x0E
    int 0x10
  
nl:
    mov si, newline
    call print
    mov si, shell_input_msg
    call print
    jmp commandLine

switch_mode_text:  
    call mode_text
    jmp shell
    
switch_mode_video:
    call mode_video
    jmp shell

help_menu:
    mov si, help_menu_text
    call print
    jmp shell
    
reboot:
    mov ax, 0
    int 0x19
  
shutdown:
    mov ax, 0x1000
    mov ax, ss
    mov sp, 0xf000
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15
  
kb_get_games:
    mov si, newline
    call print
    call get_games
    mov si, shell_input_msg 
    call print
    jmp commandLine
  
shell_input_msg db "skyEM{-}> ", 0
newline db 0x0A, 0x0D, 0
help_menu_text db 0x0A, 0x0D, "Help menu", 0x0A, 0x0D, "To toggle between screen resolutions, press t (text) or v (video).", 0x0A, 0x0D, "To list available games, type g", 0x0A, 0x0D, "To choose a game, type it's corresponding number.", 0x0A, 0x0D, "To play the selected game, press the spacebar", 0x0A, 0x0D, "To view the help menu, press h", 0x0A, 0x0D, "To reboot the device, press r", 0x0A, 0x0D, "To shutdown the device, press s", 0x0A, 0x0D, 0
