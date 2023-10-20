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

	bl draw_board
	bl draw_snake_start

InfLoop:

	bl inputRead
	
	bl update_position
	
	bl slither_snake
	
	bl draw_snake

	mov x1, 250
	mov x2, 50
	bl draw_food


	// --- Delay loop ---
	movz x11, 0x10, lsl #16
	delay1: 
	sub x11,x11,#1
	cbnz x11, delay1
	// ------------------


	b InfLoop
	
