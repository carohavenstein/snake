.global check_crash
.global check_pixel

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

    check_crash_up:

        cmp x22, UP_ARROW
        b.ne check_crash_down

        mov x16, SEGMENT_HEIGHT_WIDTH

        up_outer_loop:
            mov x15, SEGMENT_HEIGHT_WIDTH
            mov x10, x1

            up_inner_loop:
                b check_pixel
                add x10, x1, 1

                sub x15, x15, 1
                cbnz x15, up_inner_loop

            add x11, x2, 1
            sub x16, x16, 1
            cbnz x16, up_outer_loop

        b check_done                            // no crash in snake SNAKE_NEXT_POS pixels
    
    check_crash_down:
        cmp x22, DOWN_ARROW
        b.ne check_crash_right


    check_crash_right:

    check_crash_left:


    //check_horizontal_crash:
    //    cmp x22, RIGHT_ARROW
    //    b.eq y_loop
    //    cmp x22, LEFT_ARROW
    //    b.ne check_done

    //    y_loop:
    //        b check_pixel
    //        add x2, x2, 1
    //        cmp x2, SEGMENT_HEIGHT_WIDTH
    //        bne y_loop
    
    check_done:


    br x29


// x1 = x_coord pixel
// x2 = y_coord pixel
// w3 = GREEN
// w4 = BLUE
// w5 = YELLOW

check_pixel:

    mov x26, x30
    
    mov x8, 512
    madd x9, x2, x8, x1
    lsl x9, x9, 1
    add x9, x9, x0                  // pixel address

    ldurh w7, [x9]                  // w7 = pixel color
    sub w12, w7, w3                 // w12 = w7 - GREEN
    sub w13, w7, w4                 // w13 = w7 - BLUE       
    and w14, w12, w13               // if 0, snake crashed own segment or board frame
    cbz w14, you_loose
    
    sub w14, w7, w5                       // w14 = w7 - YELLOW
    cbnz w14, pixel_check_done            // if not 0, snake didnt eat
        bl clean_food
        bl grow_snake
        b check_done			  // if snake ate, dont keep checking pixels
    
    pixel_check_done:

    br x26

    