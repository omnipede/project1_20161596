#include "globals.h"
#include "util.h"

void printToken(TokenType token, const char* tokenString) {
	switch(token) {
	/*
	 *	Keywords.
	 */
	case ELSE:
		fprintf(listing, "\tELSE\t\t%s\n", tokenString);
		break;
	case IF:
		fprintf(listing, "\tIF\t\t%s\n", tokenString);
		break;
	case INT:
		fprintf(listing, "\tINT\t\t%s\n", tokenString);
		break;
	case RETURN:
		fprintf(listing, "\tRETURN\t\t%s\n", tokenString);
		break;
	case VOID:
		fprintf(listing, "\tVOID\t\t%s\n", tokenString);
		break;
	case WHILE:
		fprintf(listing, "\tWHILE\t\t%s\n", tokenString);
		break;
	/*
	 *	Special symbols.
	 */
	case PLUS:
		fprintf(listing, "\t+\t\t%s\n", tokenString);
		break;
	case MINUS:
		fprintf(listing, "\t-\t\t%s\n", tokenString);
		break;
	case TIMES:
		fprintf(listing, "\t*\t\t%s\n", tokenString);
		break;
	case OVER:
		fprintf(listing, "\t/\t\t%s\n", tokenString);
		break;
	case LT:
		fprintf(listing, "\t<\t\t%s\n", tokenString);
		break;
	case LE:
		fprintf(listing, "\t<=\t\t%s\n", tokenString);
		break;
	case GT:
		fprintf(listing, "\t>\t\t%s\n", tokenString);
		break;
	case GE:
		fprintf(listing, "\t>=\t\t%s\n", tokenString);
		break;
	case EQ:
		fprintf(listing, "\t==\t\t%s\n", tokenString);
		break;
	case NE:
		fprintf(listing, "\t!=\t\t%s\n", tokenString);
		break;
	case ASSIGN:
		fprintf(listing, "\t=\t\t%s\n", tokenString);
		break;
	case SEMI:
		fprintf(listing, "\t;\t\t%s\n", tokenString);
		break;
	case COMMA:
		fprintf(listing, "\t,\t\t%s\n", tokenString);
		break;
	case LPAREN:
		fprintf(listing, "\t(\t\t%s\n", tokenString);
		break;
	case RPAREN:
		fprintf(listing, "\t)\t\t%s\n", tokenString);
		break;
	case LSQUARE:
		fprintf(listing, "\t[\t\t%s\n", tokenString);
		break;
	case RSQUARE:
		fprintf(listing, "\t]\t\t%s\n", tokenString);
		break;
	case LCURLY:
		fprintf(listing, "\t{\t\t%s\n", tokenString);
		break;
	case RCURLY:
		fprintf(listing, "\t}\t\t%s\n", tokenString);
		break;
	/*
	 *	Other tokens.
	 */
	case ENDFILE:
		fprintf(listing, "\tEOF\t\t\n");
		break;
	case NUM:
		fprintf(listing, "\tNUM\t\t%s\n", tokenString);
		break;
	case ID:
		fprintf(listing, "\tID\t\t%s\n", tokenString);
		break;
	case ERROR:
		fprintf(listing, "\tERROR\t\t%s\n", tokenString);
		break;
	default:
		fprintf(listing, "\tUnknown\t\t%s\n", tokenString);
	}
}

char* copyString (char* s) {
	int n;
	char* t;
	if (!s)
		return NULL;
	n = strlen(s) + 1;
	t = malloc(n);
	if (!t)
		fprintf(listing, "Out of memory error at line %d\n", lineno);
	else
		strcpy(t, s);
	return t;
}
