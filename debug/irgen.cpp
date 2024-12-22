#include "../include/parser/ast.hpp"
#include "../include/parser/visitor.hpp"
#include "../include/parser/parser.hpp"
#include "../include/utils/logger.hpp"
#include "../include/irvisitors/irprinter.hpp"

std::shared_ptr<CompUnit> node = nullptr;

int main(int argc, char **argv){
    LogLevel level = LogLevel::NONE;
    std::string output_file = "fkir.ll";
    for (int i = 1; i < argc; ++i) {
        if (std::string(argv[i]) == "-v" || std::string(argv[i]) == "--verbose") {
            level = LogLevel::DEBUG;
        } else if (std::string(argv[i]) == "-i" || std::string(argv[i]) == "--info") {
            level = LogLevel::INFO;
        } else if (std::string(argv[i]) == "-o" || std::string(argv[i]) == "--output") {
            ++i;
            output_file = std::string(argv[i]);
        } else {
            Logger::logInfo("Unknown option: " + std::string(argv[i]));
        }
    }
    Logger::setLogLevel(level);

    IRGenerator generator;
    generator.visit(*node);

    IR::LIRPrinter printer(output_file);
    printer.printout(generator.get_module());

    yy::parser parser;
    // parser.set_debug_level (1);
    if (parser.parse()) {
        std::cerr << "Parser Error" << std::endl;
        return 1;
    }

    return 0;
}