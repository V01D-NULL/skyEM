;
;   Prepare everything for the user to play a game (i.e. interface with the keyboard driver)
;

key_quit equ 0x71

%include "games/games.inc"

get_games:
    mov si, games_list_msg
    call print
    mov si, g_snake
    call print
    mov si, g_chrome_dino
    call print
    jmp load_game


load_game:
    mov si, games_prompt
    call print
    
    mov ax, 0x00
    int 0x16
    
    cmp al, snake ; 1
    je games_play_snake
    
    cmp al, chrome_dino
    je games_play_dino
    
    cmp al, key_quit
    je return
    
    mov ah, 0x0E
    int 0x10
    mov si, newline
    call print
    jmp load_game


return:
    mov si, newline
    call print
    jmp shell
    
games_prompt db "Choose your game: ", 0
%include "games/snake/snake.asm"
%include "games/chrome_dino/chrome_dino.asm"
%include "games/utils.asm"
