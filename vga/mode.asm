mode_text:
    mov ax, 0x03
    int 0x10
    ret
    
mode_video:
    mov ax, 0x01
    mov ch, 1
    mov cl, 1
    int 0x10
    mov ah, 0x00
    mov al, 0x13
    int 0x10
    ret
    
