mode_text:
    mov ah, 0x00
    mov al, 0x07
    int 0x10
    mov si, textMode
    call print
    ret
    
mode_video:
    mov si, videoMode
    call print
    mov ah, 0x00
    mov al, 0x13
    int 0x10
    ret
    
textMode db "Loading text mode", 0x0A, 0x0D, 0
videoMode db "Loading video mode", 0x0A, 0x0D, 0
