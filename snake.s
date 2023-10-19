.global draw_snake_start
.global update_position
.global draw_snake
.global slither_snake

.equ SNAKE_MAX_LEN, 17
.equ SNAKE_START_LEN, 2
.equ SEGMENT_HEIGHT_WIDTH, 19

.equ START_X, 256
.equ START_Y, 256

// to store coordinate of top left pixel of each segment
// x_head, y_head, x_segment1, y_segment1, x_segment2, y_segment2, ... , x_segment16, y_segment16 
.equ SNAKE_HEAD_ADDRESS, 0x40000
.equ SNAKE_SIZE_ADDRESS, 0x80000
.equ NEXT_SEGMENT, 16
.equ SNAKE_NEXT_POS_ADDRESS, 0x200000

.equ X_COORD, 0
.equ Y_COORD, 8
.equ SLITHER, 19
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



.equ UP_ARROW, 0x4000
.equ RIGHT_ARROW, 0x8000
.equ DOWN_ARROW, 0x20000
.equ LEFT_ARROW, 0x40000

// pressed arrow x22
update_position:

    mov x29, x30                            // save return address

    mov x6, SNAKE_HEAD_ADDRESS
    ldur x10, [x6, X_COORD]             // x10 = x_head
    ldur x11, [x6, Y_COORD]             // x11 = y_head

    control_up:
        cmp x22, UP_ARROW
        b.ne control_right
        sub x11, x11, SLITHER        // move up, sub in y axis -> x11 = next y_head
        //bl check_crash_down

    control_right:
        cmp x22, RIGHT_ARROW
        b.ne control_down
        add x10, x10, SLITHER        // move right, add in x axis -> x10 = next x_head

    control_down:
        cmp x22, DOWN_ARROW
        b.ne control_left
        add x11, x11, SLITHER        // move up, add in y axis -> x11 = next y_head

    control_left:
        cmp x22, LEFT_ARROW
        b.ne update_done
        sub x10, x10, SLITHER        // move left, sub in x axis -> x10 = next x_head

    update_done:

    mov x6, SNAKE_NEXT_POS_ADDRESS
    stur x10, [x6, X_COORD]             // store next_x_head
    stur x11, [x6, Y_COORD]             // store next_y_head


    br x29
    


slither_snake:

    mov x29, x30                            // save return address

    mov x8, SNAKE_SIZE_ADDRESS
    ldur x8, [x8]                      // x8 = snake size
    sub x9, x8, 1                      // x9 = snake size - 1
    mov x12, NEXT_SEGMENT
    mov x6, SNAKE_HEAD_ADDRESS
    madd x13, x9, x12, x6           // x13 = segment[i-1] address (last segment)

    ldur x1, [x13, X_COORD]         // xpixel   x1
    ldur x2, [x13, Y_COORD]         // ypixel   x2
    mov w3, PURPLE                  // color    w3
    mov x4, SEGMENT_HEIGHT_WIDTH    // height   x4
    mov x5, SEGMENT_HEIGHT_WIDTH    // widht    x5
    bl rectangle                    // cover last segment in purple

    mov x6, SNAKE_NEXT_POS_ADDRESS
    ldur x10, [x6, X_COORD]             // x10 = next_x_head
    ldur x11, [x6, Y_COORD]             // x11 = next_y_head

    mov x8, SNAKE_SIZE_ADDRESS
    ldur x8, [x8]                      // x8 = snake size
    sub x8, x8, 1                      // i = x8 = snake size - 1
    sub x9, x8, 1                      // x9 = i - 1
    
    mov x12, NEXT_SEGMENT
    mov x6, SNAKE_HEAD_ADDRESS
    madd x13, x9, x12, x6           // x13 = segment[i-1] address (last segment)
    madd x14, x8, x12, x6           // x14 = segment[i] address

    slither_loop:
                                        
        ldur x1, [x13, X_COORD]         // x1 = x_segment[i-1]
        ldur x2, [x13, Y_COORD]         // x2 = y_segment[i-1]
        sub x13, x13, NEXT_SEGMENT      // [i-1]address --
        sub x9, x9, 1                   // (i-1) --

        stur x1, [x14, X_COORD]         // x_segment[i] = x_segment[i-1]
        stur x2, [x14, Y_COORD]         // y_segment[i] = y_segment[i-1]
        sub x14, x14, NEXT_SEGMENT      // [i] address --
        sub x8, x8, 1                   // i --
        
        cbnz x8, slither_loop
    
    stur x10, [x6, X_COORD]             // x_head = x10
    stur x11, [x6, Y_COORD]             // y_head = x11

    br x29



draw_snake:

    mov x29, x30                            // save return address 

    mov x6, SNAKE_HEAD_ADDRESS        
    mov x7, SNAKE_SIZE_ADDRESS
    ldur x7, [x7]                           // x7 = snake size
    
    mov w3, GREEN                           // color    w3
    //mov w3, 0xF821
    mov x4, SEGMENT_HEIGHT_WIDTH            // height   x4
    mov x5, SEGMENT_HEIGHT_WIDTH            // widht    x5

    mov x13, 0                              // i

    drawing_loop:

        ldur x1, [x6, X_COORD]     // x1 = x_segment[i]
        ldur x2, [x6, Y_COORD]     // x2 = y_segment[i]
        bl rectangle               // draw segment[i]
        
        add x6, x6, NEXT_SEGMENT   // next segment address
        add x13, x13, 1
        sub x14, x13, x7           // x14 = i - (snakesize - 1)
        cbnz x14, drawing_loop          // keep looping

    br x29


