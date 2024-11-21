#include "../include/parser/ast.hpp"

using namespace AST;

extern past yyparse();

int main(int argc, char const *argv[]) {
    showAST(yyparse(), 0, true);
    return 0;
}