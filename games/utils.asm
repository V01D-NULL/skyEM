; Set cursor position
set_cur: ; dh = y, dl = x
    pusha
    mov ah, 0x02
    mov bh, 0
    int 0x10
    popa
    ret

; Get cursor position
get_cur:
    mov ah, 0x03
    mov bh, 0
    int 0x10
    ; Returns: 
    ;   dh = row
    ;   dl = column
    ; (The rest is not needed)
    
    
    
; TODO: Finish delay
delay:
