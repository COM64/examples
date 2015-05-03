.macro Line arg
	.word arg
.endmacro

.macro LineEnd
	.byte $00
.endmacro

.macro NoMoreLines
	.word $0000
.endmacro

.macro Address address
	.local zerochar
	zerochar=$30
	; Annetun osoitteen muunnos desimaaliluvuiksi
	.byte <(((address / 1000) .mod 10) + zerochar)
	.byte <(((address / 100 ) .mod 10) + zerochar)
	.byte <(((address / 10  ) .mod 10) + zerochar)
	.byte <(((address) .mod 10) + zerochar)
.endmacro

.macro Sys ad
	.byte $9e
	Address ad
.endmacro

.macro MiniBasicStub
.local basicstubstart, _nextline, address
.word basicstubstart ; C64:n binäärien 2 ensimmäistä tavua määrittää, mihin osoitteeseen koodi ladataan.
	basicstubstart:
	.word _nextline ; Rivi alkaa osoittimella seuraavan rivin alkuun
	Line 10
	Sys address
	LineEnd
_nextline:
	NoMoreLines
address: ; Konekielikoodi alkaa tästä.
.endmacro
