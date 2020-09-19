shell:
    pusha
    mov si, shell_init_msg
    call print
    popa
    mov si, shell_input_msg
    call print
    jmp handle_stdin
    
handle_stdin:
    call commandLine
    mov si, newline
    call print
    jmp handle_stdin
    
commandLine:
    xor cl, cl
    mov ax, 0x00
    int 0x16
    cmp cl, 0x3F
    je commandLine
    
    mov ah, 0x0E
    int 0x10
;     int 0x19 ; Reboot
    ; if (al == "enterkey") -> ret
    jmp commandLine
;     ret
    
shell_init_msg db "Loaded into sOS shell", 0x0A, 0x0D, 0
shell_input_msg db "sOS> ", 0
newline db "DONE", 0x0A, 0x0D, 0
