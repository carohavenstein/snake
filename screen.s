.global you_loose
.global you_win

.equ BLACK, 0x0000
.equ WHITE, 0xFFFF
.equ LIGHT_BLUE, 0x0D75

you_loose:

    mov x1, 0
    mov x2, 0
    mov w3, BLACK
    mov x4, 512
    mov x5, 512
    bl rectangle

    mov x1, 0
    mov x2, 258
    mov w3, WHITE
    mov x4, 4
    mov x5, 512
    bl rectangle


    looser_loop:
    b looser_loop

    ret


you_win:

    mov x1, 0
    mov x2, 0
    mov w3, LIGHT_BLUE
    mov x4, 512
    mov x5, 512
    bl rectangle

    winner_loop:
    b winner_loop

    ret

