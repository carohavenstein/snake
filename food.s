.global draw_food
.global triangle

.equ ORANGE, 0xFB80

// food[30] = { x_food1, y_food1, x_food2, y_food2, ... , x_food14, y_food14 }
.equ FIRST_FOOD_ADDRESS, 0x300000
.equ ACTUAL_FOOD_ADDRESS, 0x
.NEXT_FOOD, 16

draw_food:
    mov x29, x30                // save return address

    mov x3, ACTUAL_FOOD_ADDRESS
    ldur x1, [x3, X_COORD]          // get actual_food coordinates
    ldur x2, [x3, Y_COORD]
    bl triangle

    br x29


// triangle:
// top vertex coordinates
// xpixel   x1
// ypixel   x2

triangle:

    mov w3, ORANGE

    mov x12, x2                  // x12 = ypixel
    mov x8, 512
    madd x9, x12, x8, x1        // x9 = (y * 512) + x
    lsl x9, x9, 1                // x9 * 2
    add x9, x9, x0            // dir_pixel = inicio + x9 -> top vertex
    
    mov x13, 1               // width factor

    mov x10, 15           	// height
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

