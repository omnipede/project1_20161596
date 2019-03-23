#include "error.h"
#include "globals.h"

void error(struct ErrorType* e, int line, char* msg) {

	if (!e)
		return;
	errorFlush(e);
	e->pos = line;
	strncpy(e->msg, msg, MAXERRORLEN);
	return;
}

void errorFlush(struct ErrorType* e) {

	if(!e)
		return;
	strcpy(e->msg, "");
	return;
}
