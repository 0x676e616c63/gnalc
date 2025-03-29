#include "../../../include/ir/passes/pass_manager.hpp"
#include "../../../include/ir/passes/transforms/namenormalizer.hpp"
#include "../../../include/ir/passes/utilities/irprinter.hpp"
#include "../../../include/parser/ast.hpp"
#include "../../../include/parser/irgen.hpp"
#include "../../../include/parser/parser.hpp"
#include "../../../include/utils/logger.hpp"

#include <fstream>
#include <iostream>
#include <memory>
#include <string>

std::shared_ptr<AST::CompUnit> node = nullptr;

int main() {
    yy::parser parser;

    if (parser.parse()) {
        std::cerr << "Syntax Error" << std::endl;
        return -1;
    }

    Parser::IRGenerator irgen;
    irgen.visit(*node);

    IR::FAM fam;
    IR::FPM fpm;
    fam.registerPass([] { return IR::LiveAnalysis(); });
    fpm.addPass(IR::NameNormalizePass(true));
    fpm.addPass(IR::PrintFunctionPass(std::cout, true));
    for (auto &r : irgen.get_module())
        fpm.run(*r, fam);
    return 0;
}
