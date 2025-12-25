	SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION	; for VSCODE and debugging
	DEVICE ZXSPECTRUM48 			; needed for SNA export (must be tab indented)
	ORG 	$8000					; the uncontended 32KiB
	
	INCLUDE "speccy_defs.asm"		; must be indented
	INCLUDE "sb_top_border_render.asm"
	INCLUDE "sb_top_border_buffer.asm"
	INCLUDE "sb_bottom_border.asm"
	INCLUDE "sb_game.asm"
	INCLUDE "sb_border_font.asm"
	INCLUDE "sb_sprite_prerender.asm"
	INCLUDE "vector_output.asm"
	
START:
	CALL	INITIALISE_INTERRUPT	; IM2 with ROM trick
	CALL 	INITIAL_SETUP

ANIMATE_MAIN:
	CALL	WAIT_BOTTOM_MAIN_SCREEN_TIGHT	

; hacked off until ready for timing fiddling...
	; CALL	WAIT_BOTTOM_MAIN_SCREEN_TIGHT_OFF
	; CALL	WAIT_BOTTOM_MAIN_SCREEN_TIGHT_OFF
	; CALL	WAIT_BOTTOM_MAIN_SCREEN_TIGHT
	; CALL	WAIT_BOTTOM_MAIN_SCREEN_TIGHT
	; CALL	WAIT_BOTTOM_MAIN_SCREEN_TIGHT_OFF
;	CALL 	BOTTOM_BORDER_RENDER	; timting critical
	HALT							; wait for vsync (fired after bottom border, start of vblank)

	CALL	VBLANK_PERIOD_WORK		; 8 scanline * 224 = 1952 t-states (minus some for alignment timing)
	CALL	TOP_BORDER_RENDER		; timining-critical flipping of top border colours
	CALL 	MAIN_GAME_LOOP			; actual game loop
	JP		ANIMATE_MAIN

; flashing green on green 
ATTR_FGG        = %10100100


WAIT_BOTTOM_MAIN_SCREEN_M2
WAIT_BOTTOM_MAIN_SCREEN_M2_LOOP:
	IN 		A, ($FF)
	CP 		ATTR_FGG
	JP 		NZ, WAIT_BOTTOM_MAIN_SCREEN_M2_LOOP	
	RET 							; WAIT_BOTTOM_MAIN_SCREEN_M2

WAIT_BOTTOM_MAIN_SCREEN_TIGHT:
WAIT_BOTTOM_MAIN_SCREEN_TIGHT_LOOP:
	IN 		A, ($FF)
	CP 		ATTR_FGG
	RET 	Z						; WAIT_BOTTOM_MAIN_SCREEN_TIGHT
	JP 		WAIT_BOTTOM_MAIN_SCREEN_TIGHT_LOOP

WAIT_BOTTOM_MAIN_SCREEN_TIGHT_OFF:
WAIT_BOTTOM_MAIN_SCREEN_TIGHT_LOOP_OFF:
	IN 		A, ($FF)
	CP 		ATTR_FGG
	RET 	NZ						; WAIT_BOTTOM_MAIN_SCREEN_TIGHT_OFF
	JP 		WAIT_BOTTOM_MAIN_SCREEN_TIGHT_LOOP_OFF


; waits for trigger attr to go on/off/on/off to lock down timing
WAIT_BOTTOM_MAIN_SCREEN_MULTI:
WAIT_BOTTOM_MAIN_SCREEN_MULTI_ON_1:
	IN 		A, ($FF)
	CP 		ATTR_FGG
	JP	 	Z, WAIT_BOTTOM_MAIN_SCREEN_MULTI_OFF_1
	JP 		WAIT_BOTTOM_MAIN_SCREEN_MULTI_ON_1

WAIT_BOTTOM_MAIN_SCREEN_MULTI_OFF_1:
	IN 		A, ($FF)
	CP 		ATTR_FGG
	JP	 	NZ, WAIT_BOTTOM_MAIN_SCREEN_MULTI_ON_2
	JP 		WAIT_BOTTOM_MAIN_SCREEN_MULTI_OFF_1

WAIT_BOTTOM_MAIN_SCREEN_MULTI_ON_2:
	IN 		A, ($FF)
	CP 		ATTR_FGG
	JP	 	Z, WAIT_BOTTOM_MAIN_SCREEN_MULTI_OFF_2
	JP 		WAIT_BOTTOM_MAIN_SCREEN_MULTI_ON_2

WAIT_BOTTOM_MAIN_SCREEN_MULTI_OFF_2:
	IN 		A, ($FF)
	CP 		ATTR_FGG
	JP	 	NZ, WAIT_BOTTOM_MAIN_SCREEN_MULTI_ON_3
	JP 		WAIT_BOTTOM_MAIN_SCREEN_MULTI_OFF_2


WAIT_BOTTOM_MAIN_SCREEN_MULTI_ON_3:


	RET 							; WAIT_BOTTOM_MAIN_SCREEN_MULTI



; 8 scanline * 224 = 1,752 t-states (minus some for alignment, push/pop, calls, etc...)
; we use it to flicker a window's colour based on pre-calculated stuff 
VBLANK_PERIOD_WORK:					
	PUSH AF							
	PUSH BC							
	PUSH DE							
	PUSH HL							

	NOP
	NOP

	LD		B, 118
VBLANK_LOOP:						
	DJNZ	VBLANK_LOOP				
									
	; fiddling...
	;.1 LD	A, 7					
	;.3 NOP	

	POP HL							
	POP DE							
	POP BC							
	POP AF							

	RET								; VBLANK_PERIOD_WORK
									
INITIAL_SETUP:
	LD 		A, 0					
	OUT		($FE), A				; set initial border black

	CALL 	SPRITE_INIT				; draw initial sprite and any other setup

	LD 		B, 16					; number of block to set to trigger attr
	LD 		HL, ATTR_END - 15		; first attr to change
	LD 		A, ATTR_FGG				; trigger attr (flashing green on green)
INITIAL_SETUP_TRIGGE_ATTR_LOOP:	
	LD		(HL), A 
	INC  	HL
	DJNZ 	INITIAL_SETUP_TRIGGE_ATTR_LOOP

	RET								; INITIAL_SETUP

; set up IM2 - so we don't wate time scanning keyboard and so on
; use ROM trick for interrupt table
; from http://www.breakintoprogram.co.uk/hardware/computers/zx-spectrum/interrupts 
INITIALISE_INTERRUPT:   			
	di                              ; Disable interrupts
	ld		hl, INTERRUPT
	ld		ix, $FFF0				; This code is to be written at 0xFF
	ld		(ix + $04), $C3         ; Opcode for JP
	ld		(ix + $05), l           ; Store the address of the interrupt routine in
	ld		(ix + $06), h
	ld		(ix + $0F), $18         ; Opcode for JR; this will do JR to FFF4h
	ld		a, $39                  ; Interrupt table at page 0x3900 (ROM)
	ld		i, a                    ; Set the interrupt register to that page
	im		2                       ; Set the interrupt mode
	ei                              ; Enable interrupts
	ret								; INITIALISE_INTERRUPT
 
INTERRUPT:              
	; push af                       ; save all the registers on the stack
	; push bc                       ; this is probably not necessary unless
	; push de                       ; we're looking at returning cleanly
	; push hl                       ; back to basic at some point
	; push ix
	; exx
	; ex af,af
	; push af
	; push bc
	; push de
	; push hl
	; push iy


; do stuff

	; pop iy                        ; restore all the registers
	; pop hl
	; pop de
	; pop bc
	; pop af
	; exx
	; ex af,af
	; pop ix
	; pop hl
	; pop de
	; pop bc
	; pop af
	EI                               ; Enable interrupts
	RET                              ; INTERRUPT

MAIN_FRAME:
	DEFB 		0

; include specific memory areas
	INCLUDE "sb_image.asm"

; Deployment: Snapshot
   SAVESNA 	"zx_scoreboarder.sna", START
   