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

.equ BOARD_WIDTH_HEIGHT, 456		// 24 x 24 cells (19 pixels x 19 pixels)

.equ TOP_BOTTOM_FRAME_WIDTH, 512
.equ TOP_BOTTOM_FRAME_HEIGHT, 28

.equ LATERAL_FRAMES_HEIGHT, 512
.equ LATERAL_FRAMES_WIDTH, 28

.equ DARK_BLUE, 0x01AB
.equ PURPLE, 0x398A

draw_board:
    mov x29, x30                            // save return address

	mov w3, DARK_BLUE		                // color

						                    // top frame
	mov x1, 0			                    // xpixel
	mov x2, 0			                    // ypixel
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
	mov w3, PURPLE							// color
	mov x4, BOARD_WIDTH_HEIGHT              // height
	mov x5, BOARD_WIDTH_HEIGHT              // width
	bl rectangle

br x29

