CFLAGS = -O3 -Wall -Wextra -fno-strict-aliasing -g

ALL = test_align

all: $(ALL)

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
	rm -f *.o

install:
	cp $(ALL) ~/bin

package:
	make clean
	tar -zcf daligner.tar.gz README *.h *.c Makefile
