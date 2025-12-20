; timining-critical flipping of static bottom border colours
; 224 t-states per row
BOTTOM_BORDER_RENDER:		
;	LD 		A, 0
;	OUT		($FE), A				; set border

	; timing for actual bottom border
	LD		B, 178
BOTTOM_BORDER_TIMING_LOOP:
	DJNZ	BOTTOM_BORDER_TIMING_LOOP

	; fiddling
	.6 NOP

	; render bottom border
	LD		C, $FE
	LD 		HL, BOTTOM_BORDER_BUFFER

	LD 		B, 50		; 55 bottom border, giving time to halt and resync
BOTTOM_BORDER_RENDER_LOOP:	
	;11 cols
	LD 		A, B		; save loop B in A

	OUTI	
	OUTI	
	OUTI	
	OUTI	

	OUTI	
	OUTI	
	OUTI	
	OUTI	

	OUTI	
	OUTI	
	OUTI	


	; hblank & timing desu...
	.5 NOP
	LD  	B, A		; restore loop B from A
	LD 		A, (HL)

	DJNZ    BOTTOM_BORDER_RENDER_LOOP

	RET								; BOTTOM_BORDER_RENDER


	; 56 in total (not all used to start with)
BOTTOM_BORDER_BUFFER:
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 1, 1, 1, 4, 4, 4, 4, 4, 4

	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4

	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4

	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4

	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4

	DEFB 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
	DEFB 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



