#include "../../include/config/config.hpp"

#include "../../include/ir/passes/pass_builder.hpp"
#include "../../include/ir/passes/pass_manager.hpp"
#include "../../include/parser/ast.hpp"
#include "../../include/parser/astprinter.hpp"
#include "../../include/parser/irgen.hpp"
#include "../../include/parser/parser.hpp"
#include "../../include/utils/logger.hpp"

#if GNALC_EXTENSION_BRAINFK // in config.hpp
#include "../../include/codegen/brainfk/bfgen.hpp"
#include "../../include/codegen/brainfk/bfprinter.hpp"
#include "../../include/codegen/brainfk/bftrans.hpp"
#endif

#include <fstream>
#include <iostream>
#include <memory>
#include <string>

#include "../../include/ir/passes/utilities/irprinter.hpp"

std::shared_ptr<AST::CompUnit> node = nullptr;
extern FILE *yyin;

int main(int argc, char **argv) {
    // gnalc is still in development, so make it defaults to be `LogLevel::INFO`.
    Logger::setLogLevel(LogLevel::INFO);

    // File
    std::string input_file;
    std::string output_file;

    // Options
    bool only_compilation = false; // -S
    bool emit_llvm = false;        // -emit-llvm
    bool ast_dump = false;         // -ast-dump
    IR::OptInfo opt_info;

#if GNALC_EXTENSION_BRAINFK
    bool bf_target = false;   // -mbrainfk
    bool bf3t_target = false; // -mbrainfk-3tape
#endif

    for (int i = 1; i < argc; ++i) {
        std::string arg(argv[i]);
        // General options:
        if (arg == "--log") {
            ++i;
            if (i >= argc) {
                std::cerr << "Error: Expected log level." << std::endl;
                return -1;
            }
            if (std::string{argv[i]} == "none")
                Logger::setLogLevel(LogLevel::NONE);
            else if (std::string{argv[i]} == "info")
                Logger::setLogLevel(LogLevel::INFO);
            else if (std::string{argv[i]} == "debug")
                Logger::setLogLevel(LogLevel::DEBUG);
            else {
                std::cerr << "Error: Invalid log level." << std::endl;
                return -1;
            }
        } else if (arg == "-o") {
            ++i;
            if (i >= argc) {
                std::cerr << "Error: Expected output." << std::endl;
                return -1;
            }
            output_file = argv[i];
        } else if (arg == "-S")
            only_compilation = true;
        else if (arg == "-emit-llvm")
            emit_llvm = true;
        else if (arg == "-ast-dump")
            ast_dump = true;
        else if (arg == "-O1" || arg == "-O")
            opt_info = IR::o1_opt_info;

        // Optimizations available:
        else if (arg == "--mem2reg")
            opt_info.mem2reg = true;
        else if (arg == "--sccp")
            opt_info.sccp = true;
        else if (arg == "--dce")
            opt_info.dce = true;
        else if (arg == "--adce")
            opt_info.adce = true;
        else if (arg == "--dse")
            opt_info.dse = true;
        else if (arg == "--gvnpre")
            opt_info.tailcall = true;

#if GNALC_EXTENSION_BRAINFK
        // Extensions:
        else if (arg == "-mbrainfk")
            bf_target = true;
        else if (arg == "-mbrainfk-3tape")
            bf3t_target = true;
#endif

        else if (arg == "-h" || arg == "--help") {
            std::cout <<
                R"(OVERVIEW: gnalc compiler

USAGE: " << argv[0] << " [options] file

OPTIONS:

General options:
  -o <file>            - Write output to <file>
  -S                   - Only run compilation steps
  -O,-O1               - Optimization level 1
  -emit-llvm           - Use the LLVM representation for assembler and object files
  -ast-dump            - Build ASTs and then debug dump them
  --log <log-level>    - Enable compiler logger. Available log-level: debug, info, none
  -h, --help           - Display available options

Optimizations available:
  --mem2reg            - Promote Memory to Register
  --sccp               - Sparse Conditional Constant Propagation
  --dce                - Dead Code Elimination
  --adce               - Aggressive Dead Code Elimination
  --dse                - Dead Store Elimination
  --gvnpre             - Value-Based Partial Redundancy Elimination (GVN-PRE)
  --tailcall           - Tail call optimization
)";

#if GNALC_EXTENSION_BRAINFK
            std::cout <<
                R"(
Extensions:
  -mbrainfk            - Translate SySy to brainfk
  -mbrainfk-3tape      - Translate SySy to 3-tape brainfk
)";
#endif
            std::cout << std::flush;
            return 0;
        } else
            input_file = argv[i];
    }

    if (!only_compilation) {
        std::cerr << "Error: Gnalc currently only supports '-S' mode."
                  << std::endl;
        return -1;
    }

    if (!input_file.empty()) {
        yyin = fopen(input_file.c_str(), "r");
        if (!yyin) {
            std::cerr << "Error: Failed to open input file." << std::endl;
            return -1;
        }
    }

    yy::parser parser;
    if (parser.parse()) {
        std::cerr << "Syntax Error" << std::endl;
        return -1;
    }

    if (ast_dump) {
        AST::ASTPrinter printer;
        printer.visit(*node);
        return 0;
    }

    if (!input_file.empty())
        fclose(yyin);

    Parser::IRGenerator generator(input_file);
    generator.visit(*node);

    IR::FAM fam;
    IR::MAM mam;
    IR::PassBuilder::registerFunctionAnalyses(fam);
    IR::PassBuilder::registerModuleAnalyses(mam);
    IR::PassBuilder::registerProxies(fam, mam);

    auto mpm = IR::PassBuilder::buildModulePipeline(opt_info);

    std::ostream *poutstream = &std::cout;
    std::ofstream outfile;

    if (!output_file.empty()) {
        outfile.open(output_file);
        if (!outfile.is_open()) {
            std::cerr << "Error: Failed to open output file." << std::endl;
            return -1;
        }
        poutstream = &outfile;
    }

    if (emit_llvm) {
        mpm.addPass(IR::PrintModulePass(*poutstream));
        mpm.run(generator.get_module(), mam);
        return 0;
    }

    mpm.run(generator.get_module(), mam);

#if GNALC_EXTENSION_BRAINFK
    if (bf_target || bf3t_target) {
        BrainFk::BF3t32bGen bfgen;
        BrainFk::BFPrinter bfprinter(*poutstream);

        bfgen.visit(generator.get_module());

        if (!bf3t_target) {
            BrainFk::BF32t32bTrans trans(false);
            trans.visit(bfgen.getModule());
            bfprinter.printout(trans.getModule());
        } else
            bfprinter.printout(bfgen.getModule());

        return 0;
    }
#endif

    Err::todo("ARM Backend Refactor.");

    return 0;
}