c equ 9

games_play_dino:
    jmp scroll

scroll:
    call mode_text
    mov si, var
    call print ; To test the scrolling
    mov si, newline
    call print

    mov     ax, 0xb800     ; screen segment
    mov     ds, ax         ; set up segments
    mov     es, ax
    xor     di, di         ; point to the beginning of the screen
    mov     dx, 25         ; process 25 lines
    mov     ax, 0x0700     ; what to scroll in (grey on black blanks)
    
.loop:
    lea     si, [di+2*c]   ; set up SI to the column that is scrolled
;                                into the first column of the line
    mov     cx, 80-c       ; copy all columns beginning at that column
;                                to the end of the row
    rep     movsw          ; scroll row to the left
    mov     cx, c          ; need to blank that many columns
    rep     stosw          ; blank remaining columns
    
    dec     dx             ; decrement loop counter
    jnz     .loop          ; loop until we're done
    jmp .loop
    
exit:
    call mode_text
    
    ; Clear registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    
    jmp shell


    
var db "t--------------------------------------------------------t", 0
