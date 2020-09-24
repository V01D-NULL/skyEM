; games_play_* is the entry point for every skyEM game.

games_play_snake:

    
    ; Game exit
    mov si, newline
    call print
    jmp shell

update:
    call mode_text
    ret
