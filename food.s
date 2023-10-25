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
    mov x29, x30                // save return address

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
// top vertex coordinates
// xpixel   x1
// ypixel   x2
// color    w3
triangle:


    mov x12, x2                  // x12 = ypixel
    mov x8, 512
    madd x9, x12, x8, x1        // x9 = (y * 512) + x
    lsl x9, x9, 1                // x9 * 2
    add x9, x9, x0            // dir_pixel = inicio + x9 -> top vertex
    
    mov x13, 1               // width factor

    mov x10, 19           	// height
    height_loop:

        mov x11, 1         	// width
        mul x11, x11, x13   // width * width factor

        width_loop:

            sturh w3, [x9]	   	// Setear el color del pixel N
            sub x9, x9, 2       // pixel anterior en x
            sub x11, x11, 1	   	// Decrementar el contador X

        cbnz x11, width_loop	   	    // Si no terminó la fila, saltar    
        
        add x12, x12, 1             // siguiente fila
        madd x9, x12, x8, x1        // x9 = (y * 512) + x
        lsl x9, x9, 1               // x9 * 2
        add x9, x9, x0            // dir_pixel = inicio + x9 

        sub x10, x10, 1	   		// Decrementar el contador Y
        add x13, x13, 1         // width factor + 1
        cbnz x10, height_loop	  	// Si no es la última fila, saltar		
        
    ret


set_food_coords:

    mov x9, FIRST_FOOD_ADDRESS

    mov x12, FOOD_COUNT_ADDRESS
    mov x13, 0
    stur x13, [x12]                 // food count starts at 0

    mov x10, 60
    stur x10, [x9, X_COORD]         // x_food0
    stur x10, [x9, Y_COORD]         // y_food0
    add x9, x9, NEXT_FOOD

    mov x10, 90
    stur x10, [x9, X_COORD]         // x_food1
    stur x10, [x9, Y_COORD]         // y_food1
    add x9, x9, NEXT_FOOD

    mov x10, 180
    mov x11, 90
    stur x10, [x9, X_COORD]         // x_food2
    stur x11, [x9, Y_COORD]         // y_food2
    add x9, x9, NEXT_FOOD

    mov x10, 180
    mov x11, 90
    stur x10, [x9, X_COORD]         // x_food3
    stur x11, [x9, Y_COORD]         // y_food3
    add x9, x9, NEXT_FOOD

    mov x10, 180
    mov x11, 90
    stur x10, [x9, X_COORD]         // x_food4
    stur x11, [x9, Y_COORD]         // y_food4
    add x9, x9, NEXT_FOOD

    ret


clean_food:

    mov x28, x30                // save return address

    mov x9, FOOD_COUNT_ADDRESS
    mov x6, FIRST_FOOD_ADDRESS
    ldur x9, [x9]                   // x9 = food_count
    mov x11, NEXT_FOOD
    madd x3, x9, x11, x6            // actual_food x3 = food_count * next_food + first_food_address

    ldur x1, [x3, X_COORD]          // get actual_food coordinates
    ldur x2, [x3, Y_COORD]
    mov w3, PURPLE
    bl triangle

    mov x9, FOOD_COUNT_ADDRESS
    ldur x10, [x9]
    add x10, x10, 1
    stur x10, [x9]                  // food_count += 1

    br x28

