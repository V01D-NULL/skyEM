sleep:
    pusha
    mov ah, 0x86
    mov cx, [ bx ]
    int 0x15
    popa
    ret
