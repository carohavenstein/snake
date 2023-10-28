.global rectangle

// xpixel   x1
// ypixel   x2
// color    w3
// height   x4
// widht    x5

rectangle:

    mov x8, 512
    madd x9, x2, x8, x1             // x9 = (y * 512) + x
    lsl x9, x9, 1                   // x9 * 2
    add x9, x9, x0                  // x9 = pixel address
    
    mov x10, x4           	        // height
    outer_loop:

        mov x11, x5         	    // width
        inner_loop:
            sturh w3, [x9]	   	    // set N pixel's color
            add x9, x9, 2	   	    // next pixel
            sub x11, x11, 1	   	    // i_width --
        cbnz x11, inner_loop        // jump if row not done
        
        add x2, x2, 1               // next row
        madd x9, x2, x8, x1         // x9 = (y * 512) + x
        lsl x9, x9, 1               // x9 * 2
        add x9, x9, x0              // x9 = pixel address

        sub x10, x10, 1	   		    // i_height --
        cbnz x10, outer_loop		// jump if it's not the last row
        
    ret


