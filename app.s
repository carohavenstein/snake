.globl app


.equ BOARD_OUT_RANGE, 145 // (BOARD_HEIGHT * BOARD_WIDTH) +1 


app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)

	bl draw_board
	
	bl draw_snake_start



InfLoop:



	b InfLoop
	