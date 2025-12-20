

; if sprite has moved, update it
SPRITE_RENDER:
	LD 		A, (SPRITE_X_NEW)
	LD 		B, A
	LD 		A, (SPRITE_X)
	CP 		B
	RET 	Z			; return if no movement

	CALL 	SPRITE_XOR
	CALL 	SPRITE_SHIFT
	LD 		A, (SPRITE_X_NEW)
	LD		(SPRITE_X), A	; move to new position
	CALL 	SPRITE_XOR

	RET 				; SPRITE_RENDER

SPRITE_SHIFT:
	LD 		HL, SPRITE_ROW_BUFFER	; start of buffer

	LD 		A, (SPRITE_X)			; current x
	AND 	%00000111				; get just 0-7 offset
	LD 		B, A 					; B has current offset

	LD 		A, (SPRITE_X_NEW)		; new x
	AND 	%00000111				; get just 0-7 offset

	CP 		B 						; A = new A - old B
	RET 	Z 						; no change, return
	JP 		C, SPRITE_SHIFT_LEFT	; new A is < old B

SPRITE_SHIFT_RIGHT:					; new A is > old B
	LD 		B, A					; current A is number of shifts
SPRITE_SHIFT_RIGHT_LOOP:
	PUSH 	BC 
	LD 		B, 32 					; 32 sprite rows
SPRITE_SHIFT_RIGHT_ROW_LOOP:
	SRL 	(HL)					; shift first byte right, 0 in bit7, leaving in carry
	INC 	HL 						; next byte in buffer
	RR 		(HL)					; shift byte using carry for bit7, and leaving into carry
	INC 	HL 						; next byte in buffer
	RR 		(HL)					; shift byte using carry for bit7, and leaving into carry
	INC 	HL 						; next byte in buffer for next loop

	DJNZ 	SPRITE_SHIFT_RIGHT_ROW_LOOP

	POP 	BC
	DJNZ 	SPRITE_SHIFT_RIGHT_LOOP

	JP 		SPRITE_SHIFT_DONE

SPRITE_SHIFT_LEFT:					; new A is < old B
	NEG								; A was negative
	LD 		B, A 					; number of shifts

SPRITE_SHIFT_LEFT_LOOP:	
	PUSH 	BC 
	LD 		B, 32 					; 32 sprite rows
SPRITE_SHIFT_LEFT_ROW_LOOP:



	DJNZ 	SPRITE_SHIFT_LEFT_ROW_LOOP

	POP 	BC
	DJNZ 	SPRITE_SHIFT_LEFT_LOOP

SPRITE_SHIFT_DONE:
	RET								; SPRITE_SHIFT


SPRITE_XOR:
	LD		A, (SPRITE_Y)
	LD 		B, A 
	LD 		A, (SPRITE_X)
	LD 		C, A
	CALL 	Get_Pixel_Address ; HL now has screen address

	LD 		DE, SPRITE_ROW_0	; start of sprite buffer
	LD 		B, 32				; 32 rows
SPRITE_XOR_LOOP:
								; col 0
	LD 		A, (HL) 			; current pixels
	LD 		C, A 				; store in B
	LD 		A, (DE)				; sprite pixels
	XOR 	C 					; XOR together
	LD 		(HL), A 			; write result back
	INC 	DE					; next sprite byte

	INC 	HL 					; col 1
	LD 		A, (HL) 			; current pixels
	LD 		C, A 				; store in B
	LD 		A, (DE)				; sprite pixels
	XOR 	C 					; XOR together
	LD 		(HL), A 			; write result back
	INC 	DE					; next sprite byte

	INC 	HL 					; col 2
	LD 		A, (HL) 			; current pixels
	LD 		C, A 				; store in B
	LD 		A, (DE)				; sprite pixels
	XOR 	C 					; XOR together
	LD 		(HL), A 			; write result back
	INC 	DE					; next sprite byte

	DEC 	HL
	DEC 	HL					; back to first column ready to move to next row

	CALL 	Pixel_Address_Down	; moves HL down a pixel row

	DJNZ	SPRITE_XOR_LOOP


	RET 						; SPRITE_XOR

SPRITE_MOVE_LEFT:
	LD 		A, (SPRITE_X_NEW)
	DEC 	A 
	LD 		(SPRITE_X_NEW), A
	RET					; SPRITE_MOVE_LEFT

SPRITE_MOVE_RIGHT:
	LD 		A, (SPRITE_X_NEW)
	INC 	A 
	LD 		(SPRITE_X_NEW), A
	RET					; SPRITE_MOVE_LEFT

; draw initial sprite and any other setup
SPRITE_INIT:	
	CALL 	SPRITE_XOR	; make sure initial SPRITE_X is on byte boundary
	RET 				; SPRITE_INIT

SPRITE_X:
	DEFB 	64

; keys will control this new X
SPRITE_X_NEW:
	DEFB	64

SPRITE_Y:
	DEFB 	100

; 3 blocks/bytes wide, sprite starts in left two only
; 4 blocks tall * 8 = 32 rows
SPRITE_ROW_BUFFER:
SPRITE_ROW_0:
	DEFB 	%00000000, %00000000, %00000000
SPRITE_ROW_1:
	DEFB 	%00000011, %11100000, %00000000
SPRITE_ROW_2:
	DEFB 	%00000111, %11110000, %00000000
SPRITE_ROW_3:
	DEFB 	%00001100, %00011000, %00000000
SPRITE_ROW_4:
	DEFB 	%00011001, %01000110, %00000000
SPRITE_ROW_5:
	DEFB 	%00011000, %00001100, %00000000
SPRITE_ROW_6:
	DEFB 	%00011011, %01101100, %00000000
SPRITE_ROW_7:
	DEFB 	%00011000, %00001100, %00000000
SPRITE_ROW_8:
	DEFB 	%00011001, %01001100, %00000000
SPRITE_ROW_9:
	DEFB 	%00011100, %00011100, %00000000
SPRITE_ROW_10:
	DEFB 	%00001110, %00011000, %00000000
SPRITE_ROW_11:
	DEFB 	%00001111, %00111000, %00000000
SPRITE_ROW_12:
	DEFB 	%00000111, %11110000, %00000000
SPRITE_ROW_13:
	DEFB 	%00000011, %11110000, %00000000
SPRITE_ROW_14:
	DEFB 	%00000011, %11100000, %00000000
SPRITE_ROW_15:
	DEFB 	%00000111, %11100000, %00000000
SPRITE_ROW_16:
	DEFB 	%00001111, %11100000, %00000000
SPRITE_ROW_17:
	DEFB 	%00001111, %11110000, %00000000
SPRITE_ROW_18:
	DEFB 	%00001111, %11110000, %00000000
SPRITE_ROW_19:
	DEFB 	%00001111, %11110000, %00000000
SPRITE_ROW_20:
	DEFB 	%00001111, %11100000, %00000000
SPRITE_ROW_21:
	DEFB 	%00001111, %11100000, %00000000
SPRITE_ROW_22:
	DEFB 	%00001111, %11100000, %00000000
SPRITE_ROW_23:
	DEFB 	%00001111, %11100000, %00000000
SPRITE_ROW_24:
	DEFB 	%00001111, %11100000, %00000000
SPRITE_ROW_25:
	DEFB 	%00011111, %11100000, %00000000
SPRITE_ROW_26:
	DEFB 	%00011111, %11100000, %00000000
SPRITE_ROW_27:
	DEFB 	%00011111, %11110000, %00000000
SPRITE_ROW_28:
	DEFB 	%00011111, %11110000, %00000000
SPRITE_ROW_29:
	DEFB 	%00111111, %11110000, %00000000
SPRITE_ROW_30:
	DEFB 	%01111111, %11100000, %00000000
SPRITE_ROW_31:
	DEFB 	%00000001, %11000000, %00000000

