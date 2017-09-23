    BITS 16

start:
    mov ax, 0x07C0      ; 4k of stack spase
    add ax, 288         ; 4096+512 / 16 bytes per paragraph
    mov ss, ax          ; ss is uh, a memory thing i think
    mov sp, 4096        ; this is for segments, what ever the fuck they are

    mov ax, 0x07C0      ; sets the data segment (again, no fuckin clue)
    mov ds, ax          ; dunno what this is lol
    
    call clear_screen   ; muh clear screen "function"
    mov dx, 0           ; setting row and col of cursor pos to 0
    call set_cursor_pos ; :D
    mov si, text_string ; move the string into the "Source data index register", for retrevial.
    call print_string   ; this calls the "function" we gonna make :D 
    
    jmp $               ; $ in NASM means "the current point of code", aka jump to the jump command aka infinate loop hype

    
    text_string db 'ten chars', 3, 0

print_string:
    mov ah, 0x09        ; 0E is the "print text" bios function in the int 10 interupt
    mov bl, 0
    mov cx, 1
    
.repeat:
    lodsb               ; this gets the current char from the string
    cmp al, 0           ; check to see if the char is 0, which would mean its the end of the string
    je .done            ; if it is, jump to the "done" label
    add bl, 1
    add dh, 1
    mov dl, 1
    call set_cursor_pos
    int 0x10            ; fuckin gasp, an interupt!
    jmp .repeat         ; loooooop
    
.done:
    ret                 ; return back to the call that called us.

    
clear_screen:
    mov ah, 0x06        ; 06 is "scroll screen up"
    mov al, 0           ; 0 is "clear"
    mov cx, 0           ; top left corner
    mov dh, 25          ; bottom row
    mov dl, 80          ; rightmost coloum
    mov bh, 0x1F        ; set background to black, foreground to white
    int 0x10            ; do the interupt
    mov bh, 0           ; dont fuck with bh more than u have too, cuase mmbad mmkay
    ret                 ; go back to main program :D
    
set_cursor_pos:
    mov ah, 0x02
    int 0x10
    ret 

    
    times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
    dw 0xAA55               ; The standard PC boot signature
