.include "m328pdef.inc"

.dseg
						

.cseg
						.org $000 RJMP    RESET


RESET:                  LDI		R16, low(RAMEND)
                        OUT		SPL, R16
                        LDI		R16, high(RAMEND)
                        OUT		SPH, R16

MAIN:
;============================Выше не смотреть==================================
						
						
;============================Ниже не смотреть==================================	

                        RJMP	MAIN
.eseg
