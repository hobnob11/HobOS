    BITS 16

start:
    mov ax, 0x07C0      ; 4k of stack spase
    add ax, 288         ; 4096+512 / 16 bytes per paragraph
    mov ss, ax          ; ss is uh, a memory thing i think
    mov sp, 4096        ; this is for segments, what ever the fuck they are

    mov ax, 0x07C0      ; sets the data segment (again, no fuckin clue)
    mov ds, ax          ; actually does that ^
    
    call clear_screen
    
    mov si, text_string ; move the source register to the location of the string
    call print_string   ; :D
    
    jmp $               ; $ in NASM means "the current point of code", aka jump to the jump command aka infinate loop hype

    ;Vars
    
    text_string db 'Test String ', 3, 0
    
    ;functions
    
clear_screen:
    pusha               ; saves current registers to stack, so that we dont fuck over things.
    mov ax, 0x0600      ; scroll up, clear 
    mov cx, 0x000         ; top left corner
    mov dx, 0x1950      ; bottom right corner
    mov bh, 0x1f        ; colour
    int 0x10            ; call the bios interupt
    mov dx, 0x0         ; reset cursor pos to 0,0
    call move_cursor    ; ^
    popa                ; unfuck registers
    ret                 ; return out of the "function"

move_cursor:
    pusha               ; dont fuck the registers
    mov ah, 0x02        ; move cursor
    mov bh, 0x0         ; i have no idea what a page number is
    int 0x10            ; bios interupt
    popa                ; dont do eeet
    ret

print_string:
    pusha               ; NO FUCKING WITH REGISTERS OKAI?
    
    mov ah, 0x03        ; first we need the cur cursor pos 
    mov bh, 0x0         ; i can feel the page number hvn a gigl. 
    int 0x10             ; get the cursor pos, and also fuck up all the other registers because lol. 
    
    mov ah, 0x09        ; Write char.
    mov bx, 0           ; set inital page and colour to 0.
    mov cx, 0x1         ; NUMBER OF FUCKING GIGGLES. (unit: gigl.)
    
.repeat:
    lodsb               ; load the next char of the stringu
    cmp al, 0           ; check to see if the string terminated on a null byte yet
    je .done            ; pass directly to go, do not collect $200
    mov bx, 0x1f        ; set colours to blue and white
    int 0x10            ; do the thing.
    
    add dl, 1           ; move along one column.
    call move_cursor
    
    jmp .repeat         ; we a loop now bois.
    
.done:
    popa                ; put the regis back
    ret                 ; go back
    
    
    times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
    dw 0xAA55               ; The standard PC boot signature
