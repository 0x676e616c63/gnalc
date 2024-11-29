#include "../include/parser/ast.hpp"
#include "../include/parser/visitor.hpp"
#include "../include/parser/parser.hpp"

std::shared_ptr<CompUnit> node = nullptr;

int main(int argc, char **argv){
    yy::parser parser;
    // parser.set_debug_level (1);
    if (parser.parse()) {
        std::cerr << "Parser Error" << std::endl;
        return 1;
    }

    IRGenerator generator;
    generator.visit(*node);

    // TODO: Print IR

    return 0;
}