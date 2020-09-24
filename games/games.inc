;
; games.inc contains the values of the game type. (If the user types 1, 2, etc. Game snake, chrome_dino_game, etc will be loaded)
;

snake equ 0x31
chrome_dino equ 0x32

games_list_msg db "Here is a list of games you can play using skyEM:", 0x0A, 0x0D, 0
g_snake db "1. Snake", 0x0A, 0x0D, 0
g_chrome_dino db "2. Chrome dinosaur game", 0x0A, 0x0D, 0
