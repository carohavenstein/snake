.global check_crash
.global check_pixel

check_crash:

    mov x29, x30                            // save return address
    
    mov x6, SNAKE_NEXT_POS_ADDRESS
    ldur x1, [x6, X_COORD]                  // x1 = next_x_head
    ldur x2, [x6, Y_COORD]                  // x2 = next_y_head

    mov w3, GREEN
    mov w4, BLUE
    mov w5, YELLOW

    mov x15, LAST_PRESSED_ADDRESS
    ldur x22, [x15]                         // x22 = last pressed key

    cbz x22, check_done                     // if x22 == 0, no key was pressed yet

    mov x16, SEGMENT_HEIGHT_WIDTH

    crash_outer_loop:
        mov x15, SEGMENT_HEIGHT_WIDTH
        mov x10, x1

        crash_inner_loop:
            bl check_pixel
            add x10, x10, 1

            sub x15, x15, 1
            cbnz x15, crash_inner_loop

        add x11, x11, 1
        sub x16, x16, 1
        cbnz x16, crash_outer_loop

    
    check_done:

    br x29


// x10 = x_coord pixel
// x11 = y_coord pixel
// w3 = GREEN
// w4 = BLUE
// w5 = YELLOW


check_pixel:

    mov x28, x30
    
    mov x8, 512
    madd x9, x11, x8, x10
    lsl x9, x9, 1
    add x9, x9, x0               // pixel address

    ldurh w7, [x9]               // w7 = pixel color
    sub w12, w7, w3              // w12 = w7 - GREEN
    sub w13, w7, w4              // w13 = w7 - BLUE       
    and w14, w12, w13            // if 0, snake crashed own segment or board frame
    cbz w14, you_lose
    
    cmp w7, w5                   //  w7 vs YELLOW
    bne pixel_check_done         // snake didnt eat
        bl clean_food
        bl grow_snake
        b check_done			 // if snake ate, stop checking pixels
    
    pixel_check_done:

    br x28

    