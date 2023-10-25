.global check_crash

check_crash:

    mov x29, x30                            // save return address
    
    mov x6, SNAKE_NEXT_POS_ADDRESS
    ldur x1, [x6, X_COORD]                 // x1 = next_x_head
    ldur x2, [x6, Y_COORD]                 // x2 = next_y_head

    mov w3, GREEN
    mov w4, BLUE
    mov w5, YELLOW

    mov x15, LAST_PRESSED_ADDRESS
    ldur x22, [x15]                     // x22 = last pressed key

    check_vertical_crash:

        cmp x22, UP_ARROW
        b.eq set_x_coord
        cmp x22, DOWN_ARROW
        b.ne check_horizontal_crash
        
        set_x_coord:
        add x1, x1, 10                  // center_next_x_head = next_x_head + 10
        b get_pixel_coord

    
    check_horizontal_crash:
        cmp x22, RIGHT_ARROW
        b.eq set_y_coord
        cmp x22, LEFT_ARROW
        b.ne check_done

        set_y_coord:
        add x2, x2, 10                  // center_next_y_head = next_y_head + 10
    

    get_pixel_coord:
    mov x8, 512
    madd x9, x2, x8, x1             // x9 = (y * 512) + x
    lsl x9, x9, 1                   // x9 * 2
    add x9, x9, x0                  // dir_pixel = inicio + x9

    ldurh w7, [x9]                  // w7 = color of center_next_x_head pixel
    sub w12, w7, w3                 // w12 = w7 - GREEN
    sub w13, w7, w4                 // w13 = w7 - BLUE       
    and w14, w12, w13               // if 0, snake crashed own segment or board frame
    cbz w14, you_loose
    
    // check if snake ate cheese

    check_done:


    br x29
        

        







