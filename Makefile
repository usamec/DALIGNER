CFLAGS = -O3 -Wall -Wextra -fno-strict-aliasing -g

ALL = daligner HPCdaligner HPCmapper LAsort LAmerge LAsplit LAcat LAshow LAcheck

all: $(ALL)

daligner: daligner.c filter.c filter.h align.c align.h DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o daligner daligner.c filter.c align.c DB.c QV.c -lpthread -lm

HPCdaligner: HPCdaligner.c DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o HPCdaligner HPCdaligner.c DB.c QV.c -lm

HPCmapper: HPCmapper.c DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o HPCmapper HPCmapper.c DB.c QV.c -lm

LAsort: LAsort.c align.h DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o LAsort LAsort.c DB.c QV.c -lm

LAmerge: LAmerge.c align.h DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o LAmerge LAmerge.c DB.c QV.c -lm

LAshow: LAshow.c align.c align.h DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o LAshow LAshow.c align.c DB.c QV.c -lm

LAcat: LAcat.c align.h DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o LAcat LAcat.c DB.c QV.c -lm

LAsplit: LAsplit.c align.h DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o LAsplit LAsplit.c DB.c QV.c -lm

LAcheck: LAcheck.c align.c align.h DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o LAcheck LAcheck.c align.c DB.c QV.c -lm

LAupgrade.Dec.31.2014: LAupgrade.Dec.31.2014.c align.c align.h DB.c DB.h QV.c QV.h
	gcc $(CFLAGS) -o LAupgrade.Dec.31.2014 LAupgrade.Dec.31.2014.c align.c DB.c QV.c -lm

QV.o: QV.c QV.h
	gcc $(CFLAGS) -c QV.c

DB.o: DB.c DB.h
	gcc $(CFLAGS) -c DB.c

align.o: align.c align.h
	gcc $(CFLAGS) -c align.c
	
test_align.o: test_align.cc
	g++ $(CFLAGS) -c test_align.cc

test_align: test_align.o align.o DB.o QV.o
	g++ $(CFLAGS) test_align.o align.o DB.o QV.o -o test_align

clean:
	rm -f $(ALL)
	rm -fr *.dSYM
	rm -f LAupgrade.Dec.31.2014
	rm -f daligner.tar.gz
	rm test_align *.o

install:
	cp $(ALL) ~/bin

package:
	make clean
	tar -zcf daligner.tar.gz README *.h *.c Makefile
