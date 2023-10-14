.global draw_board

/*
 * cell index
 *
 * ---------------------------
 * | 00 | 01 | 02 | ... | 23 |
 * ---------------------------
 * | 24 | 25 | 26 | ... | 47 |
 * ---------------------------
 * .
 * .
 * ---------------------------
 * |553 |554 |555 | ... |576 |
 * ---------------------------
 */

.equ BOARD_WIDTH, 24	// 12 cells (38 pixels * 38 pixels)
.equ BOARD_HEIGHT, 24
.equ CELL_WIDTH_HEIGHT, 19

.equ TOP_BOTTOM_FRAME_WIDTH, 512
.equ TOP_BOTTOM_FRAME_HEIGHT, 28

.equ LATERAL_FRAMES_HEIGHT, 512
.equ LATERAL_FRAMES_WIDTH, 28

.equ DARK_BLUE, 0x01AB
.equ PURPLE1, 0x398A
.equ PURPLE2, 0x39AB

draw_board:
    mov x29, x30                            // save return address 
						                    // top frame
	mov x1, 0			                    // xpixel
	mov x2, 0			                    // ypixel
	mov w3, DARK_BLUE		                // color
	mov x4, TOP_BOTTOM_FRAME_HEIGHT			// height
	mov x5, TOP_BOTTOM_FRAME_WIDTH			// width
	bl rectangle

						                    // left frame
	mov x1, 0			                    // xpixel
	mov x2, 0			                    // ypixel
	mov x4, LATERAL_FRAMES_HEIGHT			// height
	mov x5, LATERAL_FRAMES_WIDTH			// width
	bl rectangle

						                    // right frame
	mov x1, 484			                    // xpixel
	mov x2, 0			                    // ypixel
	mov x4, LATERAL_FRAMES_HEIGHT			// height
	mov x5, LATERAL_FRAMES_WIDTH			// width
	bl rectangle

						                    // bottom frame
	mov x1, 0			                    // xpixel
	mov x2, 484			                    // ypixel
	mov x4, TOP_BOTTOM_FRAME_HEIGHT			// height
	mov x5, TOP_BOTTOM_FRAME_WIDTH			// width
	bl rectangle

	mov x1, LATERAL_FRAMES_WIDTH			// xpixel
	mov x2, TOP_BOTTOM_FRAME_HEIGHT			// ypixel
	mov x4, CELL_WIDTH_HEIGHT               // height
	mov x5, CELL_WIDTH_HEIGHT               // width

	mov x6, BOARD_WIDTH		                // rows
	board_row_loop:

		mov x7, BOARD_HEIGHT	            // columns

		board_column_loop:	

			add x15, x6, x7 	// x15 = row i + column i
			and x15, x15, 1
			cmp x15, 0			// checks if sum of indexes is even or uneven
			b.ne uneven
			
			mov w3, PURPLE1
			b skip

			uneven: 
			mov w3, PURPLE2
			skip:

			bl rectangle

			add x1, x1, CELL_WIDTH_HEIGHT		// next cell add pixels in x

			sub x7, x7, 1
			cbnz x7, board_column_loop
			add x2, x2, CELL_WIDTH_HEIGHT		// pixely + 52 -> next row
			mov x1, LATERAL_FRAMES_WIDTH			// to start next row

		sub x6, x6, 1
		cbnz x6, board_row_loop

br x29
