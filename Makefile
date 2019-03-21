20161596: main.o util.o lex.yy.o
	gcc -o 20161596 main.o util.o lex.yy.o -lfl

main.o: globals.h util.h scan.h main.c
	gcc -c main.c

util.o: globals.h util.h util.c
	gcc -c util.c

lex.yy.o: globals.h util.h scan.h tiny.l
	flex tiny.l
	gcc -c lex.yy.c -lfl

clean:
	rm -rf *.o 20161596 lex.yy.c
