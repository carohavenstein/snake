.globl app


app:
	//---------------- Inicialización GPIO --------------------

	// GPIO2: green led
	// GPIO3: red led

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		

	// Configurar GPIO 17 como input:
	mov X21, 0
	str w21, [x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)

	mov x1, LAST_PRESSED_ADDRESS
	mov x2, 0
	stur x2, [x1]						// last_pressed_key = 0 (so snake stays still until first key press)

	bl set_food_coords
	bl draw_board
	bl set_snake_start

game_loop:

	bl inputRead
	bl update_position
	bl slither_snake
	bl check_crash
	bl draw_snake
	bl draw_food

	// --- Delay loop ---
	movz x11, 0x10, lsl #16
	delay1: 
	sub x11,x11,#1
	cbnz x11, delay1
	// ------------------
	
	b game_loop
	
