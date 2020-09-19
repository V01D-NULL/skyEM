print:
    pusha
    dummy:
        mov al, [ si ]
        cmp al, 0 ; Check for string terminator
        je done
        mov ah, 0x0e
        mov bx, 3
        int 0x10
        add si, 1
        jmp dummy
        
done:
    popa
    ret
    
