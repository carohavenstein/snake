.global set_food_coords
.global draw_food
.global triangle
.global clean_food

.equ YELLOW, 0xEDC5

// food[30] = { x_food0, y_food0, x_food1, y_food1, ... , x_food14, y_food14 }
.equ FIRST_FOOD_ADDRESS, 0x300000
.equ FOOD_COUNT_ADDRESS, 0x100000
.equ NEXT_FOOD, 16


draw_food:

    mov x29, x30

    mov x9, FOOD_COUNT_ADDRESS
    mov x6, FIRST_FOOD_ADDRESS
    ldur x9, [x9]                   // x9 = food_count
    mov x11, NEXT_FOOD
    madd x3, x9, x11, x6            // actual_food x3 = food_count * next_food + first_food_address

    ldur x1, [x3, X_COORD]          // get actual_food coordinates
    ldur x2, [x3, Y_COORD]
    mov w3, YELLOW
    bl triangle

    br x29


// triangle:
// top vertex coordinates:
// xpixel   x1
// ypixel   x2
// color    w3

triangle:

    mov x12, x2                 // x12 = ypixel
    mov x8, 512
    madd x9, x12, x8, x1        // x9 = (y * 512) + x
    lsl x9, x9, 1               // x9 * 2
    add x9, x9, x0              // x9 = pixel address (top vertex)
    
    mov x13, 1                  // width factor

    mov x10, 20           	    // height
    height_loop:

        mov x11, 1         	    // width
        mul x11, x11, x13       // width * width factor

        width_loop:

            sturh w3, [x9]	   	// set N pixel's color
            sub x9, x9, 2       // previous pixel in x axis
            sub x11, x11, 1	   	// i_width --

        cbnz x11, width_loop	// jump if row not done    
        
        add x12, x12, 1         // next row
        madd x9, x12, x8, x1    // x9 = (y * 512) + x
        lsl x9, x9, 1           // x9 * 2
        add x9, x9, x0          // x9 = pixel address

        sub x10, x10, 1	   		// i_height --
        add x13, x13, 1         // width factor + 1
        cbnz x10, height_loop	// jump if it's not last row		
        
    ret


clean_food:

    mov x27, x30                    // save return address

    mov x9, FOOD_COUNT_ADDRESS
    mov x6, FIRST_FOOD_ADDRESS
    ldur x9, [x9]                   // x9 = food_count
    mov x11, NEXT_FOOD
    madd x3, x9, x11, x6            // actual_food x3 = food_count * next_food + first_food_address

    ldur x1, [x3, X_COORD]          // get actual_food coordinates
    ldur x2, [x3, Y_COORD]
    mov w3, PURPLE                  // delete food from board
    bl triangle

    mov x9, FOOD_COUNT_ADDRESS
    ldur x10, [x9]
    add x10, x10, 1
    stur x10, [x9]                  // food_count += 1

    br x27


set_food_coords:

    mov x9, FIRST_FOOD_ADDRESS

    mov x12, FOOD_COUNT_ADDRESS
    mov x13, 0
    stur x13, [x12]                 // food count starts at 0

    mov x10, 90
    stur x10, [x9, X_COORD]         // x_food0
    stur x10, [x9, Y_COORD]         // y_food0
    add x9, x9, NEXT_FOOD

    mov x10, 400
    stur x10, [x9, X_COORD]         // x_food1
    stur x10, [x9, Y_COORD]         // y_food1
    add x9, x9, NEXT_FOOD

    mov x10, 256
    stur x10, [x9, X_COORD]         // x_food2
    stur x10, [x9, Y_COORD]         // y_food2
    add x9, x9, NEXT_FOOD

    mov x10, 180
    mov x11, 300
    stur x10, [x9, X_COORD]         // x_food3
    stur x11, [x9, Y_COORD]         // y_food3
    add x9, x9, NEXT_FOOD

    mov x10, 300
    mov x11, 180
    stur x10, [x9, X_COORD]         // x_food4
    stur x11, [x9, Y_COORD]         // y_food4
    add x9, x9, NEXT_FOOD

    mov x10, 100
    mov x11, 256
    stur x10, [x9, X_COORD]         // x_food5
    stur x11, [x9, Y_COORD]         // y_food5
    add x9, x9, NEXT_FOOD

    mov x10, 400
    mov x11, 260
    stur x10, [x9, X_COORD]         // x_food6
    stur x11, [x9, Y_COORD]         // y_food6
    add x9, x9, NEXT_FOOD

    mov x10, 230
    mov x11, 180
    stur x10, [x9, X_COORD]         // x_food7
    stur x11, [x9, Y_COORD]         // y_food7
    add x9, x9, NEXT_FOOD

    mov x10, 300
    mov x11, 256
    stur x10, [x9, X_COORD]         // x_food8
    stur x11, [x9, Y_COORD]         // y_food8
    add x9, x9, NEXT_FOOD

    mov x10, 280
    mov x11, 300
    stur x10, [x9, X_COORD]         // x_food9
    stur x11, [x9, Y_COORD]         // y_food9
    add x9, x9, NEXT_FOOD

    mov x10, 100
    mov x11, 400
    stur x10, [x9, X_COORD]         // x_food10
    stur x11, [x9, Y_COORD]         // y_food10
    add x9, x9, NEXT_FOOD

    mov x10, 280
    mov x11, 230
    stur x10, [x9, X_COORD]         // x_food11
    stur x11, [x9, Y_COORD]         // y_food11
    add x9, x9, NEXT_FOOD

    mov x10, 256
    mov x11, 400
    stur x10, [x9, X_COORD]         // x_food12
    stur x11, [x9, Y_COORD]         // y_food12
    add x9, x9, NEXT_FOOD

    mov x10, 256
    mov x11, 100
    stur x10, [x9, X_COORD]         // x_food13
    stur x11, [x9, Y_COORD]         // y_food13
    add x9, x9, NEXT_FOOD

    mov x10, 200
    mov x11, 350
    stur x10, [x9, X_COORD]         // x_food14
    stur x11, [x9, Y_COORD]         // y_food14

    ret

