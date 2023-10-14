.global rectangle

// xpixel   x1
// ypixel   x2
// color    w3
// height   x4
// widht    x5

// x8, x9, x10, x11, x12
rectangle:
    mov x12, x2
    mov x8, 512
    madd x9, x12, x8, x1        // x9 = (y * 512) + x
    lsl x9, x9, 1                // x9 * 2
    add x9, x9, x0            // dir_pixel = inicio + x9
    
    mov x10, x4           	// Tamaño en Y
    outer_loop:

        mov x11, x5         	// Tamaño en X
        inner_loop:
            sturh w3, [x9]	   	// Setear el color del pixel N
            add x9, x9, 2	   	    // Siguiente pixel
            sub x11, x11, 1	   	// Decrementar el contador X
        cbnz x11,inner_loop	   	    // Si no terminó la fila, saltar    
        
        add x12, x12, 1             // siguiente fila
        madd x9, x12, x8, x1        // x9 = (y * 512) + x
        lsl x9, x9, 1               // x9 * 2
        add x9, x9, x0            // dir_pixel = inicio + x9 

        sub x10, x10, 1	   		// Decrementar el contador Y
        cbnz x10, outer_loop	  	// Si no es la última fila, saltar		
        
    ret

