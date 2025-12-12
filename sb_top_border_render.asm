; timining-critical flipping of top border colours
; 224 t-states per row
TOP_BORDER_RENDER:		
	LD		C, $FE
	LD 		HL, TOP_BORDER_BUFFER

	LD 		B, 56
TOP_BORDER_RENDER_LOOP:	
	;11 cols
	LD 		A, B

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
	OUTI	

	LD  	B, A

	; hblank
	NOP
	LD 		A, (HL)
	;LD 		A, (HL)
	;LD 		A, (HL)

	DJNZ    TOP_BORDER_RENDER_LOOP

	ret								; TOP_BORDER_RENDER


