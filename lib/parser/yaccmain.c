#include <stdio.h>

extern int yyparse();
extern FILE *yyin;

int yaccmain(int argc, char const *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (yyin == NULL) {
            perror("Error opening file");
            return 1;
        }
    }
    // nets();
    yyparse();
    return 0;
}
