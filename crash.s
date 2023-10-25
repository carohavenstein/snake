.global check_crash

check_crash:

    mov x29, x30                            // save return address
    
    mov x6, SNAKE_NEXT_POS_ADDRESS
    ldur x1, [x6, X_COORD]                 // x1 = next_x_head
    ldur x2, [x6, Y_COORD]                 // x2 = next_y_head

    mov x8, 512
    //madd x9, x2, x8, x1        // x9 = (y * 512) + x
    //lsl x9, x9, 1                // x9 * 2
    //add x9, x9, x0            // dir_pixel = inicio + x9

    mov w3, GREEN
    mov w4, DARK_BLUE
    mov w5, ORANGE

    mov x1, LAST_PRESSED_ADDRESS
    ldur x22, [x1]                    // x22 = last pressed key

    check_crash_up:
        cmp x22, UP_ARROW
        b.ne check_crash_right
        add x1, x1, 10                  // center_next_x_head = next_x_head + 10
        
        madd x9, x2, x8, x1        // x9 = (y * 512) + x
        lsl x9, x9, 1                // x9 * 2
        add x9, x9, x0            // dir_pixel = inicio + x9

        ldurh w7, [x9]                 // w7 = color of center_next_x_head pixel
        sub w12, w7, w3                // w12 = w7 - GREEN
        sub w13, w7, w4                // w13 = w7 - DARK_BLUE       
        and w14, w12, w13              // if 0, snake crashed own segment or board frame
        cbz w14, you_loose 

    check_crash_right:
        cmp x22, RIGHT_ARROW
        b.ne check_crash_down
        

    check_crash_down:
        cmp x22, DOWN_ARROW
        b.ne check_crash_left
        

    check_crash_left:
        cmp x22, LEFT_ARROW
        b.ne crash_control_done
        

    crash_control_done:


    br x29
        

        







