.export BeforeMusic, MusicStart

.segment "InitCode"
BeforeMusic:
.segment "Music"

MusicStart:
;Skip 28 first bytes?
;.incbin "sw/M05BIN.S00", 28
.incbin "music.s00", 26
;.incbin "sw/j04.bin"
