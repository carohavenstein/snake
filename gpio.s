.global inputRead
//DESCRIPCION: Lee el boton en el GPIO17.

// GPIO14: up arrow     0x4000
// GPIO15: right arrow   0x8000
// GPIO17: down arrow  0x20000
// GPIO18: left arrow   0x40000

.equ LAST_PRESSED_ADDRESS, 0x160000

inputRead:

    mov x1, LAST_PRESSED_ADDRESS

	ldr w22, [x20, GPIO_GPLEV0] 	// Leo el registro GPIO Pin Level 0 y lo guardo en X22
							        //		63								 0
	orr x23, xzr, 0x4000 	        // x23 = 0000 ... 0000 0100 0000 0000 0000 (bit 14, GPIO14)
    orr x23, x23, 0x8000 	        // x23 = 0000 ... 0000 1100 0000 0000 0000 (bit 15, GPIO15)
    orr x23, x23, 0x20000  	        // x23 = 0000 ... 0010 1100 0000 0000 0000 (bit 17, GPIO17)
    orr x23, x23, 0x40000	        // x23 = 0000 ... 0110 0000 0000 0000 0000 (bit 18, GPIO18)
	and X22, X22, x23
    cbz x22, no_key_pressed
    stur x22, [x1]                  // if a key is pressed, store pressed key
    no_key_pressed:
	
    ret

