;
;   gfx_256.asm ~ highest possible resolution with 256 colors
;

plot_pixel:
    mov ah, 0x0C ; Prepare to put pixel
    mov al, 0x9F ; Color
    mov bh, 0    ; Page number
    mov cx, 10   ; X
    mov dx, 5    ; Y
    int 0x10     ; Draw pixel

    
; TODO: pusha, create registers that will pass the paramters for al, cx, dx, and the length of the line
draw_line:
    mov ah, 0x0C ; Prepare to put pixel
    mov al, 0x9F ; Color
    mov bh, 0    ; Page number
    mov cx, 10   ; X
    mov dx, 5    ; Y
    int 0x10     ; Draw pixel

    ;DUMMY CODE
    ; Create dummy register to increment and check against line length register
;     mov dummyRegister, 0
;     cmp register_for_lineLength, dummyRegister
;     je done ; Pusha, ret
;     inc dummyRegister / inc cx or dx
;     int 0x10
;     jmp draw_line
    ;DUMMY CODE
    
