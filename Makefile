20161596: main.o util.o lex.yy.o error.o
	gcc -Wall -o 20161596 main.o util.o lex.yy.o error.o -lfl

main.o: globals.h util.h scan.h main.c
	gcc -Wall -c main.c

util.o: globals.h util.h util.c
	gcc -Wall -c util.c

lex.yy.o: globals.h util.h scan.h error.h tiny.l
	flex tiny.l
	gcc -Wall -c lex.yy.c -lfl

error.o: globals.h error.h error.c
	gcc -Wall -c error.c

clean:
	rm -rf *.o 20161596 lex.yy.c
