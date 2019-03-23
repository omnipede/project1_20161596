
#ifndef _ERROR_H_
#define _ERROR_H_

#define MAXERRORLEN 40
struct ErrorType {
	int pos;
	char msg[MAXERRORLEN + 1]; 
};
void error (struct ErrorType*, int, char*);
void errorFlush(struct ErrorType*);

#endif
