; games_play_* is the entry point for every skyEM game.

x db 0
y db 0
x_max equ 80
y_max equ 24

games_play_snake:
    call mode_text
    mov si, snake_game_message
    call print
    
    mov ax, 0x00
    int 0x16
    
    call mode_text
    
    mov si, snake_sprite
    call print
    
    jmp snake_main_loop

    
snake_main_loop:
    mov ax, 0x00
    int 0x16
    
    cmp al, KEY_W
    je snake_up
    
    cmp al, 0x73 ; 's'
    je snake_down
    
    cmp al, key_quit
    je exit
    
    jmp snake_main_loop
    
    
snake_up:
    call mode_text
    pusha
    cmp byte [ y ], 0 ; Jump to bottom
    je .goto_bottom
    add byte [ y ], 1
    jmp snake_up.handle_key
    
.goto_bottom:
    mov byte [ y ], y_max
    
.handle_key:
    mov dh, [ y ]
    mov dl, [ x ]
    call set_cur ; ../utils.asm
    call character_controller
    jmp snake_main_loop
    
    
snake_down:
    ; Set cursor position
;     mov ah, 0x02
;     mov bh, 0
;     mov dh, 1 ; y -> Use variables for y, x, and increment them. Do some cmp logic to check which should be incremented
;     mov dl, 0 ; x
    int 0x10
    
    call character_controller
    jmp get_snake_offset
    
character_controller:
    ; Put the character at the position of the cursor
    pusha
    mov ah, 0x0A
    mov al, [ snake_sprite ]
    mov bh, 0
    mov cx, 1
    int 0x10
    popa
    ret
    
.update:
    call mode_text
    mov ah, 0x0E
    mov al, '*'
    mov bl, [ y ]
    int 0x10
    ret
    
get_snake_offset:
    mov bh, 0x03
    mov bl, 0
    int 0x10
    mov [x], dh
    mov [y], dl
    jmp snake_main_loop
    
snake_game_over:
    ; TODO: Set cursor position to the middle of the screen
    mov dh, 10
    mov dl, 30
    call set_cur
    mov si, snake_game_over_msg
    call print
    mov ax, 0x00
    int 0x16
    jmp exit
    
    

snake_sprite db "*", 0
snake_game_message db "Use the WASD keys to move, and press q to quit.", 0x0A, 0x0D, "Press any key to continue...", 0
snake_game_over_msg db "Game over!", 0
