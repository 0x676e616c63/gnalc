#include "../include/parser/ast.hpp"
#include "../include/parser/visitor.hpp"
#include "../include/parser/parser.hpp"

std::shared_ptr<AST::CompUnit> node = nullptr;

int main(int argc, char **argv){
    yy::parser parser;
    parser.set_debug_level (1);
    if (parser.parse()) {
        std::cerr << "Parser Error" << std::endl;
        return 1;
    }

    // for (auto& i : node->getVardefs().front()->getInitVals().front()->getInner()) {
    //     std::cout << i << typeid(i).name() << std::endl;
    // }

    AST::Printer printer;
    printer.visit(*node);

    return 0;
}