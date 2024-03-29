OBJECTS= main.o util.o
CC = gcc
CFLAGS = -Wall -c
TARGET = 20161596

$(TARGET): $(OBJECTS) lex.yy.o
	$(CC) -o $(TARGET) $(OBJECTS) lex.yy.o

lex.yy.o: globals.h util.h scan.h
	flex tiny.l
	gcc -Wall -c lex.yy.c

main.o: globals.h util.h scan.h
util.o: globals.h util.h

clean:
	rm -rf *.o 20161596 lex.yy.c
