.globl app

.equ SNAKE_MAX_LEN, 15
.equ SNAKE_MIN_LEN, 2
.equ BOARD_OUT_RANGE, 145 // (BOARD_HEIGHT * BOARD_WIDTH) +1 

/*
 * cell index
 *
 * ---------------------------
 * | 00 | 01 | 02 | ... | 11 |
 * ---------------------------
 * | 12 | 13 | 14 | ... | 23 |
 * ---------------------------
 * .
 * .
 * ---------------------------
 * |132 |133 |134 | ... |143 |
 * ---------------------------
 */

app:
	//---------------- Inicialización GPIO --------------------

	mov w20, PERIPHERAL_BASE + GPIO_BASE     // Dirección de los GPIO.		
	
	// Configurar GPIO 17 como input:
	mov X21,#0
	str w21,[x20,GPIO_GPFSEL1] 		// Coloco 0 en Function Select 1 (base + 4)   	
	
	//---------------- Main code --------------------
	// X0 contiene la dirección base del framebuffer (NO MODIFICAR)
	
		
	add x10, x0, 0		// X10 contiene la dirección base del framebuffer
	
	bl draw_board


InfLoop:



	b InfLoop
	