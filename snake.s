.global draw_snake_start
.global update_position
.global draw_snake
.global slither_snake

.equ SNAKE_MAX_LEN, 15
.equ SNAKE_START_LEN, 2
.equ SEGMENT_HEIGHT_WIDTH, 19

.equ START_X, 256
.equ START_Y, 256

// x_head, y_head, x_segment1, y_segment1, x_segment2, y_segment2, ... , x_segment14, y_segment14 
.equ SNAKE_HEAD_ADDRESS, 0x40000
.equ SNAKE_SIZE_ADDRESS, 0x80000
.equ X_COORD, 0
.equ Y_COORD, 8
.equ NEXT_SEGMENT, 16

.equ SLITHER, 2     // slither 2 pixels

.equ GREEN, 0x2143

// pixelx head x1
// pixely head x2
draw_snake_start:

    mov x7, SNAKE_START_LEN
    mov x8, SNAKE_SIZE_ADDRESS
    stur x7, [x8]                           // x7 = 2 snake size

    mov x29, x30                            // save return address 
    mov x6, SNAKE_HEAD_ADDRESS                

    mov x1, START_X                             // xpixel   x1
    stur x1, [x6, X_COORD]                      // save x_head
    mov x2, START_Y                             // ypixel   x2
    stur x2, [x6, Y_COORD]                      // save y_head

    mov w3, GREEN                               // color    w3
    mov x4, SEGMENT_HEIGHT_WIDTH                // height   x4
    mov x5, SEGMENT_HEIGHT_WIDTH                // widht    x5
    bl rectangle                                // draw head

    add x6, x6, NEXT_SEGMENT                    // segment 1
    stur x1, [x6, X_COORD]                      // save x_segment1
    add x2, x2, SEGMENT_HEIGHT_WIDTH
    stur x2, [x6, Y_COORD]                      // save y_segment1
    bl rectangle                                // draw first segment

    br x29


.equ UP_ARROW, 0x2000
.equ RIGHT_ARROW, 0x4000
.equ DOWN_ARROW, 0x20000
.equ LEFT_ARROW, 0x60000

// pressed arrow x22
update_position:

    mov x6, SNAKE_HEAD_ADDRESS

    control_up:
        cmp x22, UP_ARROW
        b.ne control_right
        ldur x11, [x6, Y_COORD]      // x11 = y_head
        ldur x10, [x6, X_COORD]      // x10 = x_head
        sub x11, x11, SLITHER        // move up, sub in y axis -> x11 = next y_head

    control_right:
        cmp x22, RIGHT_ARROW
        b.ne control_down
        ldur x10, [x6, X_COORD]      // x10 = x_head
        ldur x11, [x6, Y_COORD]      // x11 = y_head
        add x10, x10, SLITHER        // move right, add in x axis -> x10 = next x_head

    control_down:
        cmp x22, DOWN_ARROW
        b.ne control_left
        ldur x11, [x6, Y_COORD]      // x11 = y_head
        ldur x10, [x6, X_COORD]      // x10 = x_head
        add x11, x11, SLITHER        // move up, add in y axis -> x11 = next y_head

    control_left:
        cmp x22, LEFT_ARROW
        b.ne slither_snake
        ldur x10, [x6, X_COORD]      // x10 = x_head
        ldur x11, [x6, Y_COORD]      // x11 = y_head
        sub x10, x10, SLITHER        // move left, sub in x axis -> x10 = next x_head

    ret
    

// x10 = x_head
// x11 = y_head
slither_snake:

    mov x6, SNAKE_HEAD_ADDRESS
    mov x8, SNAKE_SIZE_ADDRESS
    ldur x9, [x8]                       // x9 = snake size
    sub x9, x9, 1                       // i = x9 = snake size - 1
    sub x12, x9, 1                      // x12 = i - 1
    mov x13, NEXT_SEGMENT

    slither_loop:
                                        // get segment[i-1] coordinates
        madd x14, x12, x13, x6          // x14 = x12 * x13 + x6 -> x14 = segment[i-1] address
        ldur x13, [x14, X_COORD]        // x13 = x_segment[i-1]
        ldur x15, [x14, Y_COORD]        // x15 = y_segment[i-1]
        sub x12, x12, 1                 // i - 1 --

                                        // segment[i] = segment[i-1]
        madd x14, x9, x13, x6           // x14 = x9 * x13 + x6 -> x14 = segment[i] address
        stur x13, [x14, X_COORD]        // x_segment[i] = x_segment[i-1]
        stur x15, [x14, Y_COORD]        // y_segment[i] = y_segment[i-1]

        sub x9, x9, 1                   // i --
        cbnz x9, slither_loop
    
    stur x10, [x6, X_COORD]             // x_head = x10
    stur x11, [x6, Y_COORD]             // y_head = x11

    ret

//  1 al 5 params rectangle
// 8 al 12 usa rectangle
draw_snake:

    mov x29, x30                            // save return address 

    mov x6, SNAKE_HEAD_ADDRESS        
    mov x7, SNAKE_SIZE_ADDRESS
    ldur x7, [x7]                           // x7 = snake size
    //sub x7, x7, 1                           // x7 = snake size - 1
    
    //mov w3, GREEN                         // color    w3
    mov w3, 0xF821
    mov x4, SEGMENT_HEIGHT_WIDTH            // height   x4
    mov x5, SEGMENT_HEIGHT_WIDTH            // widht    x5

    mov x13, 0                              // i

    drawing_loop:

        ldur x1, [x6, X_COORD]     // x1 = x_segment[i]
        ldur x2, [x6, Y_COORD]     // x2 = y_segment[i]
        bl rectangle               // draw segment[i]
        
        add x6, x6, NEXT_SEGMENT   // next segment address
        add x13, x13, 1
        sub x14, x13, x7           // x14 = i - (snakesize -1)
        cbnz x14, drawing_loop          // keep looping

    br x29


