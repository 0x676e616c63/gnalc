#include "../../include/config/config.hpp"

#include "../../include/parser/ast.hpp"
#include "../../include/parser/visitor.hpp"
#include "../../include/parser/parser.hpp"
#include "../../include/utils/logger.hpp"
#include "../../include/irvisitors/irprinter.hpp"
#include "../../include/irvisitors/cfgbuilder.hpp"
#include "../../include/irvisitors/namenormalizer.hpp"
#include "../../include/iropt/live_analysis.hpp"

#if GNALC_EXTENSION_BRAINFK // in config.hpp
#include "../../include/codegen/brainfk/bfgen.hpp"
#include "../../include/codegen/brainfk/bftrans.hpp"
#include "../../include/codegen/brainfk/bfprinter.hpp"
#endif

std::shared_ptr<CompUnit> node = nullptr;
extern FILE *yyin;

int main(int argc, char **argv) {
    LogLevel level = LogLevel::NONE;
    std::string input_file;
    std::string output_file;
    bool only_compilation = false;
    bool emit_llvm = false;
#if GNALC_EXTENSION_BRAINFK
    bool emit_bf = false;
    bool emit_bf3t = false;
#endif
    bool ast_dump = false;
    bool optimize = false;
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
#if GNALC_EXTENSION_BRAINFK
        else if (arg == "-mbrainfk")
        {
            emit_bf = true;
        }
        else if (arg == "-mbrainfk-3tape")
        {
            emit_bf3t = true;
        }
#endif
        else if (arg == "-ast-dump")
        {
            ast_dump = true;
        }
        else if (arg == "-O1")
        {
            optimize = true;
        }
        else if (arg == "-h" || arg == "--help")
        {
            std::cout << "OVERVIEW: gnalc compiler\n";
            std::cout << "USAGE: " << argv[0] << " [options] file\n";
            std::cout <<
                "OPTIONS:\n"
                "  -o <file>            Write output to <file>\n"
                "  -S                   Only run compilation steps\n"
                "  -O1                  Optimization level 1\n"
                "  -emit-llvm           Use the LLVM representation for assembler and object files\n"
                "  -ast-dump            Build ASTs and then debug dump them\n"
#if GNALC_EXTENSION_BRAINFK
                "  -mbrainfk            Translate SySy to brainfk\n"
                "  -mbrainfk-3tape      Translate SySy to 3-tape brainfk\n"
#endif
                "  --log <log-level>    Enable compiler logger. Available log-level: debug, info\n"
                "  -h, --help           Display available options\n"
            << std::flush;
            return 0;
        }
        else
            input_file = argv[i];
    }

    if (
#if GNALC_EXTENSION_BRAINFK
        !emit_bf &&
#endif
        !emit_llvm && !ast_dump && !only_compilation)
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
        std::cerr << "Error: -emit-llvm conflicts with -ast-dump" << std::endl;
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

    if (optimize)
    {
        Err::todo("Optimization");
    }

    IR::LiveAnalyser la;
    la.cleanLiveInfo(generator.get_module());
    la.processModule(generator.get_module());

    IR::NameNormalizer name_normalizer(false);
    name_normalizer.normalize(generator.get_module());

    std::ostream* poutstream = &std::cout;
    std::ofstream outfile;

    if (!output_file.empty())
    {
        outfile.open(output_file);
        if (!outfile.is_open())
        {
            std::cerr << "Error: Failed to open output file." << std::endl;
            return -1;
        }
        poutstream = &outfile;
    }

    if (emit_llvm)
    {
        IR::IRPrinter printer(*poutstream, false);
        printer.printout(generator.get_module());
    }
#if GNALC_EXTENSION_BRAINFK
    else if (emit_bf)
    {
        BrainFk::BF3t32bGen bfgen;
        bfgen.visit(generator.get_module());
        BrainFk::BF32t32bTrans trans(false);
        trans.visit(bfgen.getModule());
        BrainFk::BFPrinter bfprinter(*poutstream);
        bfprinter.printout(trans.getModule());
    }
    else if (emit_bf3t)
    {
        BrainFk::BF3t32bGen bfgen;
        bfgen.visit(generator.get_module());
        BrainFk::BFPrinter bfprinter(*poutstream);
        bfprinter.printout(bfgen.getModule());
    }
#endif
    else
    {
        Err::todo("Backend Refactor.");
    }

    la.cleanLiveInfo(generator.get_module());
    fclose(yyin);
    return 0;
}