; timining-critical flipping of top border colours
; 224 t-states per row
TOP_BORDER_RENDER:		
	LD		C, $FE
	LD 		HL, TOP_BORDER_BUFFER

	LD 		B, 88		; 56 plus bonus 32 as I don't need the t-states for this example
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


	; hblank & timing desu...
	.5 NOP
	LD  	B, A
	LD 		A, (HL)

	DJNZ    TOP_BORDER_RENDER_LOOP

	LD  	A, 4		; green
	OUT		($FE), A

	ret								; TOP_BORDER_RENDER


