CPU = 6502
CA = ca65
LD = ld65
CONFIG = config.cfg
LABELS = labels.txt

DISKNAME = skrolli
DISKID = 12
DISKFILENAME = skrolli.d64

all: d64

skrolli.prg: skrolli.asm
	$(CA) --cpu $(CPU) skrolli.asm
	$(LD) -m $(LABELS) -C $(CONFIG) skrolli.o

d64: skrolli.prg
	# Alusta levyimage
	c1541 -format $(DISKNAME),$(DISKID) d64 $(DISKFILENAME)
	# Kopioi tiedosto levyimageen
	c1541 -attach $(DISKFILENAME) -write skrolli.prg
	# Näytä hakemisto
	c1541 -attach $(DISKFILENAME) -list

clean:
	rm -f *~
	rm -f $(LABELS)
	rm -f *.o
	rm -f *~
	rm -f skrolli.prg
	rm -f $(DISKFILENAME)
