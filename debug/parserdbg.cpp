#include "../include/parser/ast.hpp"
// #include "visitor.hpp"
#include "../include/parser/parser.hpp"

std::shared_ptr<AST::CompUnit> node = nullptr;

int main(int argc, char **argv){
    yy::parser parser;
    parser.parse();

    // for (auto& i : node->getVardefs().front()->getInitVals().front()->getInner()) {
    //     std::cout << i << typeid(i).name() << std::endl;
    // }

    // AST::Printer printer;
    // printer.visit(*node);

    return 0;
}