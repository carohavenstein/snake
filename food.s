.global draw_food

.equ ORANGE, 0xFB80

// triangle:
// top vertex coordinates
// xpixel   x1
// ypixel   x2

draw_food:

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

