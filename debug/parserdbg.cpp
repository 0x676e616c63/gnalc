#include "../include/parser/ast.hpp"
#include "../include/parser/parser.hpp"

std::shared_ptr<AST::CompUnit> node = nullptr;

int main(int argc, char **argv){
    yy::parser parser;
    parser.parse();

    return 0;
}