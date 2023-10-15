.global draw_snake_start
.global update_position
.global draw_snake

.equ SNAKE_MAX_LEN, 15
.equ SNAKE_MIN_LEN, 2
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
    stur x1, [x6, Y_COORD]                      // save y_segment1
    bl rectangle                                // draw first segment

    br x29


.equ UP_ARROW, 0x2000
.equ RIGHT_ARROW, 0x4000
.equ DOWN_ARROW, 0x20000
.equ LEFT_ARROW, 0x60000

// called after inputRead: pressed arrow in x22

update_position:

    mov x6, SNAKE_HEAD_ADDRESS
    mov x8, SNAKE_SIZE_ADDRESS
    ldur x9, [x8]                       // x9 = snake size

    control_up:
        cmp x22, UP_ARROW
        b.ne control_right
        update_up:
            ldur x10, [x6, Y_COORD]      // x10 = y_segment[i]
            sub x10, x10, SLITHER        // move up, sub in y axis
            stur x10, [x6, Y_COORD]      // save updated position
            add x6, x6, NEXT_SEGMENT
            sub x9, x9, 1
            cbnz x9, update_up

    control_right:
        cmp x22, RIGHT_ARROW
        b.ne control_down
        update_right:
            ldur x10, [x6, X_COORD]      // x10 = x_segment[i]
            add x10, x10, SLITHER        // move right, add in x axis
            stur x10, [x6, X_COORD]      // save updated position
            add x6, x6, NEXT_SEGMENT
            sub x9, x9, 1
            cbnz x9, update_right

    control_down:
        cmp x22, DOWN_ARROW
        b.ne control_left
        update_down:
            ldur x10, [x6, Y_COORD]      // x10 = y_segment[i]
            add x10, x10, SLITHER        // move up, add in y axis
            stur x10, [x6, Y_COORD]      // save updated position
            add x6, x6, NEXT_SEGMENT
            sub x9, x9, 1
            cbnz x9, update_down

    control_left:
        cmp x22, LEFT_ARROW
        b.ne update_done 
        update_left:
            ldur x10, [x6, X_COORD]      // x10 = x_segment[i]
            sub x10, x10, SLITHER        // move left, sub in x axis
            stur x10, [x6, X_COORD]      // save updated position
            add x6, x6, NEXT_SEGMENT
            sub x9, x9, 1
            cbnz x9, update_left
    
    update_done:
    ret


draw_snake:

    mov x29, x30                            // save return address 

    mov x6, SNAKE_HEAD_ADDRESS        
    mov x8, SNAKE_SIZE_ADDRESS
    ldur x13, [x8]                           // x13 = snake size
    
    mov w3, GREEN                               // color    w3
    mov x4, SEGMENT_HEIGHT_WIDTH                // height   x4
    mov x5, SEGMENT_HEIGHT_WIDTH                // widht    x5

    drawing_loop:

        ldur x1, [x6, X_COORD]      // x1 = x_segment[i]
        ldur x2, [x6, Y_COORD]      // x2 = y_segment[i]
        bl rectangle                // draw segment[i]
        
        add x6, x6, NEXT_SEGMENT
        sub x13, x13, 1
        cbnz x13, drawing_loop

    br x29

