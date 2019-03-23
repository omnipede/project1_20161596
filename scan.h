#ifndef _SCAN_H_
#define _SCAN_H_
#define MAXTOKENLEN 40

extern char tokenString[MAXTOKENLEN+1];
TokenType getToken(void);

#define MAXERRORLEN 40
struct ErrorType {
	int pos;
	char msg[MAXERRORLEN + 1]; 
};
void error (struct ErrorType*, int, char*);
void errorFlush(struct ErrorType*);


#endif
