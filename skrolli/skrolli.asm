.include "basicmacros.h"

DEBUG=1

SCREENCLEAR=$E544

.scope SCREEN
	BASE=$0400
	WIDTH=40
	XSCROLL=$D016
		;----------------------
		;0-Screen xpos
		;1-Screen xpos
		;2-Screen xpos
		;3-Column mode (40/38)
		;4-multicol character mode
		;5-Always 0
		;6-Unused
		;7-Unused
.endscope

.code
MiniBasicStub
setup:
	jsr SCREENCLEAR
	lda #$1F
	sta SCREEN::BASE+SCREEN::WIDTH*1+1
	lda #23
	sta 53272
	lda SCREEN::XSCROLL
	and #%11110111 ; Asetetaan Column Mode bitti 0:ksi (38 merkin leveys)
	sta SCREEN::XSCROLL
	lda #%01111111
	sta $DC0D
	and $D011
	sta $D011
	lda #210
	sta $D012
	lda #<keskeytys
	sta $0314
	lda #>keskeytys
	sta $0315
	lda #%0000001
	sta $D01A
;	rts
busyloop:
	jmp busyloop

keskeytys:
.if DEBUG
	inc $D020
.endif
	dec delaycounter
	bne exitirq
	lda #01
	sta delaycounter
	
;Scroll text by one pixel
	dec xoffset
	bpl nooverflow
	lda #07
	sta xoffset
	
	;Scroll text by one character
	ldx #$00
seuraavamerkki:
	;Kopioi seuraava merkki nykyisen tilalle
	lda SCREEN::BASE+1, x
	sta SCREEN::BASE, x
	inx
	cpx #39
	bne seuraavamerkki

	;Insert new char at the end
	ldx charpointer
	lda scrolltext, x
	bne nozero
	;Restart text
	ldx #0
	stx charpointer
	lda scrolltext
nozero:
	sta SCREEN::BASE+39
	inc charpointer
	
nooverflow:
	lda SCREEN::XSCROLL
	and #%11111000
	ora xoffset
	sta SCREEN::XSCROLL
exitirq:
	asl $D019
.if DEBUG
	dec $D020
.endif
	jmp $EA31

xoffset:
.byte 0

delaycounter:
.byte 10

charpointer:
.byte 0

scrolltext:
.asciiz "ISO PERNTS KOHUHOTELLI "
