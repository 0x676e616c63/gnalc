#include "../include/parser/ast.hpp"
#include "../include/parser/visitor.hpp"
#include "../include/parser/parser.hpp"
#include "../include/utils/logger.hpp"
#include "../include/utils/exception.hpp"
#include "../include/irvisitors/irprinter.hpp"
#include "../include/irvisitors/cfgbuilder.hpp"
#include "../include/irvisitors/namenormalizer.hpp"
#include "../include/iropt/live_analysis.hpp"

#include "../BackEnd/Arm.hpp"
#include "../BackEnd/include/ArmComplexMIRStruct/ArmModule.hpp"

std::shared_ptr<CompUnit> node = nullptr;
extern FILE *yyin;

int main(int argc, char **argv) {
    LogLevel level = LogLevel::NONE;
    std::string input_file;
    std::string output_file;
    bool only_compilation = false;
    bool emit_llvm = false;
    bool ast_dump = false;
    for (int i = 1; i < argc; ++i)
    {
        std::string arg(argv[i]);
        if (arg == "--log")
        {
            ++i;
            if (i >= argc)
            {
                std::cerr << "Error: Expected log level." << std::endl;
                return -1;
            }
            if (std::string{argv[i]} == "info")
                level = LogLevel::INFO;
            else if (std::string{argv[i]} == "debug")
                level = LogLevel::DEBUG;
            else
            {
                std::cerr << "Error: Invalid log level." << std::endl;
                return -1;
            }
        }
        else if (arg == "-o")
        {
            ++i;
            if (i >= argc)
            {
                std::cerr << "Error: Expected output." << std::endl;
                return -1;
            }
            output_file = argv[i];
        }
        else if (arg == "-S")
        {
            only_compilation = true;
        }
        else if (arg == "-emit-llvm")
        {
            emit_llvm = true;
        }
        else if (arg == "-ast-dump")
        {
            ast_dump = true;
        }
        else if (arg == "--help")
        {
            std::cout << "OVERVIEW: gnalc compiler\n";
            std::cout << "USAGE: " << argv[0] << " [options] file\n";
            std::cout <<
                "OPTIONS:\n"
                "  -o <file>            Write output to <file>\n"
                "  -S                   Only run compilation steps\n"
                "  -emit-llvm           Use the LLVM representation for assembler and object files\n"
                "  -ast-dump            Build ASTs and then debug dump them\n"
                "  --log <log-level>    Enable compiler logger. Available log-level: debug, info\n"
                "  --help               Display available options\n"
            << std::flush;
        }
        else
            input_file = argv[i];
    }

    if (!emit_llvm && !ast_dump && !only_compilation)
    {
        std::cerr << "Error: Gnalc currently only supports '-S' mode." << std::endl;
        return -1;
    }
    if (input_file.empty())
    {
        std::cerr << "Error: Expected input and output file." << std::endl;
        return -1;
    }
    if (emit_llvm && ast_dump)
    {
        std::cerr << "Error: -emit-llvm conflicts with ast_dump" << std::endl;
        return -1;
    }

    Logger::setLogLevel(level);

    yyin = fopen(input_file.c_str(), "r");
    if (!yyin)
    {
        std::cerr << "Error: Failed to open input file." << std::endl;
        return -1;
    }

    yy::parser parser;
    if (parser.parse()) {
        std::cerr << "Synax Error" << std::endl;
        return -1;
    }

    if (ast_dump)
    {
        AST::ASTPrinter printer;
        printer.visit(*node);
        return 0;
    }

    IRGenerator generator;
    generator.visit(*node);

    IR::CFGBuilder cb;
    cb.build(generator.get_module());
    IR::LiveAnalyser la;
    la.cleanLiveInfo(generator.get_module());
    la.processModule(generator.get_module());

    IR::NameNormalizer name_normalizer(false);
    name_normalizer.normalize(generator.get_module());

    std::ostream* outstream;

    if (output_file.empty())
        outstream = &std::cout;
    else
        outstream = new std::ofstream(output_file);

    if (emit_llvm)
    {
        IR::IRPrinter printer(*outstream, false);
        printer.printout(generator.get_module());
    }
    else
    {
        ArmStruct::Module *backEndModule = new ArmStruct::Module(generator.get_module());
        backEndModule->AllocRegister();
        backEndModule->Legalize();
        std::string Asm = backEndModule->toString();
        std::ofstream outstream(output_file);
        outstream << Asm;
        outstream.close();

    }

    la.cleanLiveInfo(generator.get_module());

    if (outstream != &std::cout)
        delete outstream;

    fclose(yyin);
    return 0;
}