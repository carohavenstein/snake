.global draw_snake_start

.equ SNAKE_MAX_LEN, 15
.equ SNAKE_MIN_LEN, 2
.equ SEGMENT_HEIGHT_WIDTH, 19

.equ START_X, 256
.equ START_Y, 256

.equ SNAKE_FIRST_POSITION, 0x40000         // x6
.equ X_COORD, 0
.equ Y_COORD, 8
.equ NEXT_SEGMENT, 16

.equ DARK_GREEN, 0x2143

// pixelx head x1
// pixely head x2

draw_snake_start:
    mov x29, x30                            // save return address 
    mov x6, SNAKE_FIRST_POSITION                

    mov x1, START_X                             // xpixel   x1
    stur x1, [x6, X_COORD]                      // save xcoord head

    mov x2, START_Y                             // ypixel   x2
    stur x2, [x6, Y_COORD]                      // save ycoord head

    mov w3, DARK_GREEN                          // color    w3
    mov x4, SEGMENT_HEIGHT_WIDTH                // height   x4
    mov x5, SEGMENT_HEIGHT_WIDTH                // widht    x5
    bl rectangle                                // draw head

    add x2, x2, SEGMENT_HEIGHT_WIDTH
    bl rectangle                                // draw first segment

    br x29
