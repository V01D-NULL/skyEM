; This file just loads skyEM past the 512 byte boundary
;
;   Thanks to Michael Petch on this stackoverflow thread who's answer helped me with this: https://stackoverflow.com/questions/53858770/how-to-fix-os-asm113-error-times-value-138-is-negative-in-assembly-languag
;   (NOTE: This was NOT my question, and I have tried many things with no success)

%include "stage2.inc"

STAGE2_LOAD_SEG equ SKYEM_STAGE2_ADDRESS >> 4

STAGE2_LBA_START equ 1
STAGE2_LBA_END equ STAGE2_LBA_START + NUM_OF_STAGE2_SECTORS

DISK_RETRIES equ 3          ; The floppy disk may fail to spin so a retry of up to 3 times is required

[bits 16]
[org 0x7c00]

%include "bpb.inc"

boot_start:
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov sp, 0x7c00
    
load_stage2:
    mov [disk], dl ; Save disk number
    mov di, STAGE2_LOAD_SEG
    mov si, STAGE2_LBA_START
    jmp .check_last_lba
   

; This can run atleast 3 times due to the platters of the floppy disk not always spinning when they are suppossed to
.read_sector:
    mov bp, DISK_RETRIES
    call lba_to_chs      ; Convert lba to chs
    mov es, di           ;
    xor bx, bx           ; Set bx to 0

.retry:
    mov ax, 0x0201              ; Call function 0x02 of int 13h (read sectors)  AL = 1 = Sectors to read
    int 0x13                    ; BIOS Disk interrupt call
    jc .disk_error              ; If CF set then disk error

.success:
    add di, 512>>4              ; Advance to next 512 byte segment (0x20*16=512)
    inc si                      ; Next LBA

.check_last_lba:
    cmp si, STAGE2_LBA_END
    jl .read_sector

    
.stage2_loaded:
    mov ax, STAGE2_RUN_SEGMENT  ; Set up the segments appropriate for Stage2 to run
    mov ds, ax
    mov es, ax
    ; FAR JMP to the Stage2 entry point at physical address 0x07e00
    jmp STAGE2_RUN_SEGMENT:STAGE2_RUN_OFFSET


.disk_error:
    xor ah, ah                  ; Int13h/AH=0 is drive reset
    int 0x13
    dec bp                      ; Decrease retry count
    jge .retry                  ; If retry count not exceeded then try again

    
error_end:
    ; Unrecoverable error; print drive error; enter infinite loop
    mov si, diskErrorMsg        ; Display disk error message
    call print_string
    cli

.error_loop:
    hlt
    jmp .error_loop

print_string:
    mov ah, 0x0e               
    xor bx, bx                 
    jmp .getch

.repeat:
    int 0x10                   

.getch:
    lodsb                       
    test al,al                  
    jnz .repeat                 

.end:
    ret
    
lba_to_chs:
    push ax                     ; Preserve AX
    mov ax, si                  ; Copy LBA to AX
    xor dx, dx                  ; Upper 16-bit of 32-bit value set to 0 for DIV
    div word [sectorsPerTrack]  ; 32-bit by 16-bit DIV : LBA / SPT
    mov cl, dl                  ; CL = S = LBA mod SPT
    inc cl                      ; CL = S = (LBA mod SPT) + 1
    xor dx, dx                  ; Upper 16-bit of 32-bit value set to 0 for DIV
    div word [numHeads]         ; 32-bit by 16-bit DIV : (LBA / SPT) / HEADS
    mov dh, dl                  ; DH = H = (LBA / SPT) mod HEADS
    mov dl, [disk]        ; boot device, not necessary to set but convenient
    mov ch, al                  ; CH = C(lower 8 bits) = (LBA / SPT) / HEADS
    shl ah, 6                   ; Store upper 2 bits of 10-bit Cylinder into
    or  cl, ah                  ;     upper 2 bits of Sector (CL)
    pop ax                      ; Restore scratch registers
    ret
    
; Disk device is stored in 'dl' by the bios. disk will save that disk device incase dl get's overwritten
disk:
    db 0x00

diskErrorMsg:    db "Unrecoverable disk error!", 0

TIMES 510-($-$$) db  0
dw 0xaa55

NUM_OF_STAGE2_SECTORS equ (stage2_end-stage2_start+511) / 512

stage2_start:
    incbin "stage2.bin"

stage2_end:
