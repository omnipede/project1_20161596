%{
	#include "globals.h"
	#include "util.h"
	#include "scan.h"
	#define YY_NO_UNPUT
	char tokenString[MAXTOKENLEN+1];

	#define MAXERRORLEN MAXTOKENLEN
	char errorMsg[MAXERRORLEN+1];
	void error(char* msg);
	void errorFlush(void);
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
					register int c;
					while(1) {
						while( (c = input() ) != '*' && c != EOF){
							if (c == '\n')
								lineno++;
						}
						if ( c == '*' ) {
							while( (c = input()) == '*')
								;
							if (c == '\n')
								lineno++;
							if (c == '/') {
								break; /* Found the end. */
							}
						}
						if ( c == EOF ) {/* Error occured.*/
							error("Comment Error");
							return ERROR;
						}
					}	
			  	}
<<EOF>>			{return ENDFILE;}
.				{
					error("Invalid token error!");
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
		fprintf(listing,"\t%d\t", lineno);
		if (currentToken == ERROR)
			printToken(currentToken, errorMsg);
		else
			printToken(currentToken, tokenString);
	}
	return currentToken;
}

void error(char* msg) {
	errorFlush();
	strncpy(errorMsg, msg, MAXERRORLEN);
	return;
}

void errorFlush(void) {	
	strcpy(errorMsg, "");
	return;
}
