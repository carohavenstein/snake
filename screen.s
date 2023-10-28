.global you_lose
.global you_win
.global write

.equ BLACK, 0x0000
.equ WHITE, 0xFFFF
.equ LIGHT_BLUE, 0x04BF

you_lose:

    // TURN RED LED ON
    
    mov x1, 0
    mov x2, 0
    mov w3, BLACK
    mov x4, 512
    mov x5, 512
    bl rectangle

    mov x1, 0
    mov x2, 256
    mov w3, WHITE
    mov x4, 2
    mov x5, 512
    bl rectangle        // flatline

    loser_loop:
    b loser_loop

    ret


you_win:

    // TURN GREEN LED ON
    
    mov x1, 0
    mov x2, 0
    mov w3, LIGHT_BLUE
    mov x4, 512
    mov x5, 512
    bl rectangle

    bl write

    winner_loop:
    b winner_loop

    ret


write: // You win.

    mov x29, x30

    mov w3, WHITE
    // Y
    mov x1, 40
    mov x2, 200
    mov x4, 20
    mov x5, 10
    bl rectangle    
    mov x1, 60
    mov x2, 200
    mov x4, 20
    mov x5, 10
    bl rectangle
    mov x1, 40
    mov x2, 210
    mov x4, 10
    mov x5, 30
    bl rectangle
    mov x1, 50
    mov x2, 220
    mov x4, 20
    mov x5, 10
    bl rectangle
    // o
    mov x1, 80
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    mov x1, 90
    mov x2, 210
    mov x4, 10
    mov x5, 10
    bl rectangle
    mov x1, 90
    mov x2, 230
    mov x4, 10
    mov x5, 10
    bl rectangle
    mov x1, 100
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    // u
    mov x1, 120
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    mov x1, 140
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    mov x1, 130
    mov x2, 230
    mov x4, 10
    mov x5, 10
    bl rectangle
    // w
    mov x1, 180
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    mov x1, 195
    mov x2, 220
    mov x4, 10
    mov x5, 10
    bl rectangle
    mov x1, 190
    mov x2, 230
    mov x4, 10
    mov x5, 20
    bl rectangle
    mov x1, 210
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    // i
    mov x1, 230
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    mov x1, 230
    mov x2, 190
    mov x4, 10
    mov x5, 10
    bl rectangle
    // n
    mov x1, 250
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    mov x1, 270
    mov x2, 210
    mov x4, 30
    mov x5, 10
    bl rectangle
    mov x1, 260
    mov x2, 210
    mov x4, 10
    mov x5, 10
    bl rectangle
    // .
    mov x1, 290
    mov x2, 230
    mov x4, 10
    mov x5, 10
    bl rectangle

    br x29

