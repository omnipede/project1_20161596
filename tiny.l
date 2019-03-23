%{
	#include "globals.h"
	#include "util.h"
	#include "scan.h"
	#define YY_NO_UNPUT
	char tokenString[MAXTOKENLEN+1];
	struct ErrorType lexError;
%}

digit		[0-9]
number		{digit}+
letter		[a-zA-Z]
identifier	{letter}+
newline		\n
whitespace	[ \t]+

%%
"else"			{return ELSE;}
"if"			{return IF;}
"int"			{return INT;}
"return"		{return RETURN;}
"void"			{return VOID;}
"while"			{return WHILE;}

"+"				{return PLUS;}
"-"				{return MINUS;}
"*"				{return TIMES;}
"/"				{return OVER;}
"<"				{return LT;}
"<="			{return LE;}
">"				{return GT;}
">="			{return GE;}
"=="			{return EQ;}
"!="			{return NE;}
"="				{return ASSIGN;}
";"				{return SEMI;}
","				{return COMMA;}
"("				{return LPAREN;}
")"				{return RPAREN;}
"["				{return LSQUARE;}
"]"				{return RSQUARE;}
"{"				{return LCURLY;}
"}"				{return RCURLY;}

{number}		{return NUM;}
{identifier}	{return ID;}
{newline}		{lineno++;}
{whitespace}	{/* skip whitespace. */}
"/*"			{ 
					register int c, temp_lineno = lineno;
					while(1) {
						while( (c = input() ) != '*' && c != EOF){
							if (c == '\n')
								temp_lineno++;
						}
						if ( c == '*' ) {
							while( (c = input()) == '*')
								;
							if (c == '\n')
								temp_lineno++;
							if (c == '/') {
								lineno = temp_lineno;
								break; /* Found the end. */
							}
						}
						if ( c == EOF ) {/* Error occured.*/
							error(&lexError, lineno, "Comment Error");
							lineno = temp_lineno;
							return ERROR;
						}
					}	
			  	}
<<EOF>>			{return ENDFILE;}
.				{
					error(&lexError, lineno, "Invalid token error");
					return ERROR;
				}
%%

TokenType getToken(void) {
	static int firstTime = TRUE;
	TokenType currentToken;
	if (firstTime) {
		firstTime = FALSE;
		lineno++;
		yyin = source;
		yyout = listing;
	}
	currentToken = yylex();
	strncpy(tokenString, yytext, MAXTOKENLEN);
	if (TraceScan) {
		if (currentToken == ERROR) {
			fprintf(listing,"\t%d\t", lexError.pos);
			printToken(currentToken, lexError.msg);
		}
		else {
			fprintf(listing,"\t%d\t", lineno);
			printToken(currentToken, tokenString);
		}
	}
	return currentToken;
}

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
