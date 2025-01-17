#include "../../../include/parser/ast.hpp"
#include "../../../include/parser/visitor.hpp"
#include "../../../include/parser/parser.hpp"
#include "../../../include/utils/logger.hpp"
#include "../../../include/utils/exception.hpp"
#include "../../../include/irvisitors/irprinter.hpp"
#include "../../../include/irvisitors/cfgbuilder.hpp"
#include "../../../include/irvisitors/namenormalizer.hpp"
#include "../../../include/iropt/live_analysis.hpp"

std::shared_ptr<CompUnit> node = nullptr;

int main(int argc, char **argv){
    LogLevel level = LogLevel::NONE;
    std::string output_file;
    for (int i = 1; i < argc; ++i)
    {
        std::string arg(argv[i]);
        if (arg == "-v" || arg == "--verbose")
            level = LogLevel::DEBUG;
        else if (arg == "-i" || arg == "--info")
            level = LogLevel::INFO;
        else if (arg == "-o" || arg == "--output")
        {
            ++i;
            if (i >= argc)
            {
                std::cerr << "Error: Expected output." << std::endl;
                return -1;
            }
            output_file = argv[i];
        }
    }
    Logger::setLogLevel(level);

    yy::parser parser;
    if (parser.parse()) {
        std::cerr << "Parser Error" << std::endl;
        return 1;
    }

    IRGenerator generator;
    generator.visit(*node);

    IR::CFGBuilder cb;
    cb.build(generator.get_module());
    IR::LiveAnalyser la;
    la.cleanLiveInfo(generator.get_module());
    la.processModule(generator.get_module());

    IR::NameNormalizer name_normalizer(true);
    name_normalizer.normalize(generator.get_module());

    if (!output_file.empty())
    {
        std::ofstream fout(output_file);
        IR::IRPrinter printer(fout, false);
        printer.printout(generator.get_module());
        fout.close();
    }
    else
    {
        IR::IRPrinter printer(std::cout, false);
        printer.printout(generator.get_module());
    }

    la.cleanLiveInfo(generator.get_module()); // 一定清除活跃信息！防止循环引用（后续可放在某个销毁函数中）
    return 0;
}