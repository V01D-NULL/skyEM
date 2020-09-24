;
;   load_sectors.asm loads more sectors to be able to take up more than 512 bytes - Remember that skyEM emulates multiple games, instead of one. For this reason skyEM cannot be a bootsector game
;
;   Reference:
;       https://stanislavs.org/helppc/int_13-2.html
;
;   Errors:
;       https://stanislavs.org/helppc/int_13-1.html

expand_sector:
    pusha
    push dx
    mov ah, 0x02        ; Prepare to read new sectors
    mov al, dh          ; Number of sectors to read
    mov cl, 0x02        ; track / cylinder number
    mov ch, 0x00        ; Sector number
    mov dh, 0x00        ; Head number
    mov dl, 0x80        ; Drive number. 80 = Harddrive (0)
    int 0x13            ; Dew it! (My best palpatine impression)
    jc disk_read_error  ; The carry flag (CF) is set to 1 if something went wrong. If it was set,  something went wrong.
    pop dx
    
    cmp al, dh        ; al contains the number of sectors which were actually read. If al != the number of sectors, something went wrong.
    jne sector_error
    popa
    ret

disk_read_error:
    mov si, disk_read_error_msg
    call print
    cmp al, 0x02
    je error
    jmp $
    
error:
    mov si, common_qemu_error
    call print
    jmp $
    
sector_error:
    mov si, sector_error_msg
    call print
    jmp $

common_qemu_error: db "Address mark not found or bad sector.", 0
disk_read_error_msg: db "FATAL_ERROR: Error reading from drive!", 0x0A, 0x0D, 0
sector_error_msg: db "FATAL_ERROR: al is not equal to the number of sectors that were supposed to be read.", 0x0A, 0x0D, 0
