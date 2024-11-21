#include "../include/lexer/token.h"
#include <stdio.h>

extern int yylex();

void yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}

int main(int argc, char **argv)
{
    int tok;

	while((tok = yylex())) 
	{
		printf("<%d, ", tok);

        if (tok == num_INT) {
            printf("%d", yylval.int_value);
        } else if (tok == num_FLOAT) {
            printf("%f", yylval.float_value);
        } else if (tok == Y_ID) {
            printf("%s", yylval.id_name);
        } else if ((tok >= Y_INT && tok <= Y_RETURN) || tok == Y_FLOAT) {
            printf("KEYWORD");
        } else if (tok >= Y_ADD && tok <= Y_ASSIGN) {
            printf("OPERATOR");
        } else if (tok >= Y_LPAR && tok <= Y_SEMICOLON) {
            printf("SYMBOL");
        }

        printf(">\n");
	}
    return 0;
}