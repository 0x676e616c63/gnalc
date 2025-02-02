#include "../../../include/parser/ast.hpp"
#include "../../../include/parser/parser.hpp"
#include "../../../include/parser/visitor.hpp"

std::shared_ptr<AST::CompUnit> node = nullptr;

int main(int argc, char **argv) {
    yy::parser parser;
    // parser.set_debug_level (1);
    if (parser.parse()) {
        std::cerr << "Parser Error" << std::endl;
        return 1;
    }

    AST::ASTPrinter printer;
    printer.visit(*node);

    return 0;
}