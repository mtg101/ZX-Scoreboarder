

; if sprite has moved, update it
SPRITE_RENDER:
	LD 		A, (SPRITE_X_NEW)
	LD 		B, A
	LD 		A, (SPRITE_X)
	CP 		B
	RET 	Z			; return if no movement

	CALL 	SPRITE_XOR
	LD 		A, (SPRITE_X_NEW)
	LD		(SPRITE_X), A	; move to new position
	CALL 	SPRITE_XOR

	RET 				; SPRITE_RENDER

SPRITE_XOR:
	RET 				; SPRITE_XOR

; draw initial sprite and any other setup
SPRITE_INIT:	
	CALL 	SPRITE_XOR
	RET 				; SPRITE_INIT

SPRITE_X:
	DEFB 	100

; keys will control this new X
SPRITE_X_NEW:
	DEFB	100

SPRITE_Y:
	DEFB 	100

