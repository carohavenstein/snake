.global check_crash_down
.global check_crash_up
.global check_crash_right
.global check_crash_left


check_crash_down:

    mov x6, SNAKE_NEXT_POS_ADDRESS
    ldur x7, [x6, X_COORD]                 // x7 = next_x_head
    ldur x8, [x6, Y_COORD]                 // x8 = next_y_head
    
    mov x1, GREEN
    mov x2, PURPLE
    mov x3, ORANGE

    add x8, x8, 4                          // x8 = next_y_head + 4 pixels (down in y axis)
    mov x9, 0
    mov x10, SEGMENT_HEIGHT_WIDTH

    for1:
        ldurh w12, [x0, x7]                 // w12 = color of x_head pixel[i]
        add x7, x7, 1                       // next pixel
        
        







