; timining-critical flipping of static bottom border colours
; 220 t-states per row
BOTTOM_BORDER_RENDER:		
;	LD 		A, 0
;	OUT		($FE), A				; set border



; hack off as it needs exact timing to avoid flashing like shit...
;	RET





	; timing for actual bottom border
	LD		B, 12
BOTTOM_BORDER_TIMING_LOOP:
	DJNZ	BOTTOM_BORDER_TIMING_LOOP


	; fiddling
	.6 NOP

	; render bottom border
	LD		C, $FE
	LD 		HL, BOTTOM_BORDER_BUFFER

	LD 		B, 55		; 55 bottom border, giving time to halt and resync
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
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0

	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0

	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0

	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0

	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0

	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0
	DEFB 	0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0



