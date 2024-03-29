#ifndef _GLOBALS_H_
#define _GLOBALS_H_

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#ifndef FALSE
#define FALSE 0
#endif 

#ifndef TRUE
#define TRUE 1
#endif
#define MAXRESERVED 8

typedef enum {
	ENDFILE, ERROR,
	ELSE, IF, INT, RETURN, VOID, WHILE,
	ID, NUM,
	PLUS, MINUS, TIMES, OVER, LT, LE, GT, GE, EQ, NE, ASSIGN, SEMI, COMMA, 
		LPAREN, RPAREN, LSQUARE, RSQUARE, LCURLY, RCURLY,
	ERROR_IN_COMMENT
} TokenType;

extern FILE* source;
extern FILE* listing;
extern FILE* code;

extern int lineno;

/* Syntax tree for parsing. */
typedef enum {StmtK, ExpK} NodeKind;
typedef enum {IfK, RepeatK, AssignK, ReadK, WriteK} StmtKind;
typedef enum {OpK, ConstK, IdK} ExpKind;

typedef enum {Void, Integer, Boolean} ExpType;

#define MAXCHILDREN 3

typedef struct treeNode {
	struct treeNode* child[MAXCHILDREN];
	struct treeNode* sibling;
	int lineno;
	NodeKind nodekind;
	union { StmtKind stmt; ExpKind exp; } kind;
	union { 
		TokenType op;
		int val;
		char* name; 
	} attr;
	ExpType type;
} TreeNode;

extern int EchoSource;
extern int TraceScan;
extern int TraceParse;
extern int TraceCode;
extern int Error;

#endif
