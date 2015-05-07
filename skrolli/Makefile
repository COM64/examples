CPU = 6502
#         Lisää myös paikalliset symbolit debug-infoon
AS = ca65 -g
ASFLAGS = --cpu $(CPU)
LD = ld65
LDFLAGS = -m labels.txt -Ln symbols -C config.cfg
C1541 = c1541

OBJS = \
	skrolli.o \
	music.o

DISKFILENAME = skrolli.d64
DISKNAME = skrolli
ID = 15

all: d64

skrolli: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS)

d64: skrolli
	$(C1541) -format $(DISKNAME),$(ID) d64 $(DISKFILENAME)
	$(C1541) -attach $(DISKFILENAME) -write skrolli.prg
	$(C1541) -attach $(DISKFILENAME) -list

run: d64
#           Lataa koodissa määritellyt labelit VICE:n monitoriin. Myös esim. "d .init" toimii suoran osoitteen sijaan
	x64 -moncommands symbols $(DISKFILENAME)
	
clean:
	rm *.o skrolli.prg labels.txt symbols $(DISKFILENAME)
