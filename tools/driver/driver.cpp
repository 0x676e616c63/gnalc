#include "config/config.hpp"

#include "ir/passes/pass_builder.hpp"
#include "ir/passes/pass_manager.hpp"
#include "ir/passes/utilities/irprinter.hpp"
#include "mir-old/builder/lowering.hpp"
#include "mir-old/passes/pass_builder.hpp"
#include "mir-old/passes/pass_manager.hpp"
#include "mir-old/passes/utilities/mirprinter.hpp"
#include "utils/logger.hpp"

#ifndef GNALC_EXTENSION_GGC // in CMakeLists.txt
#include "parser/ast.hpp"
#include "parser/astprinter.hpp"
#include "parser/irgen.hpp"
#include "parser/parser.hpp"
#else
#include "ggc/irparsertool.hpp"
#endif

#if GNALC_EXTENSION_BRAINFK // in config.hpp
#include "codegen/brainfk/bfgen.hpp"
#include "codegen/brainfk/bfprinter.hpp"
#include "codegen/brainfk/bftrans.hpp"
#endif

#include "../../include/codegen/armv7/armprinter.hpp"

#include <fstream>
#include <iostream>
#include <memory>
#include <string>

#ifndef GNALC_EXTENSION_GGC
std::shared_ptr<AST::CompUnit> node = nullptr;
#endif
extern FILE *yyin;

int main(int argc, char **argv) {
    // gnalc is still in development, so make it defaults to be `LogLevel::DEBUG`.
    Logger::setLogLevel(LogLevel::DEBUG);

    // File
    std::string input_file;
    std::string output_file;

    // Options
    bool only_compilation = false;              // -S
    bool emit_llvm = false;                     // -emit-llvm
    bool emit_llc = false;                      // -emit-llc
    bool ast_dump = false;                      // -ast-dump
    bool fixed_point_pipeline = false;          // -fixed-point
    bool fuzz_testing = false;                  // -fuzz
    double fuzz_testing_duplication_rate = 1.0; // -fuzz-rate
    std::string fuzz_testing_repro;             // -fuzz-repro
    bool debug_pipeline = false;                // -debug-pipeline
    IR::OptInfo opt_info;                       // --xxx
    MIR::OptInfo bkd_opt_info;

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
        else if (arg == "-emit-llc")
            emit_llc = true;
        else if (arg == "-ast-dump") {
#ifdef GNALC_EXTENSION_GGC
            std::cerr << "Error: AST dump is not available in GGC mode." << std::endl;
            return -1;
#endif
            ast_dump = true;
        } else if (arg == "-fixed-point")
            fixed_point_pipeline = true;
        else if (arg == "-O1" || arg == "-O")
            opt_info = IR::o1_opt_info;

#define OPT_ARG(cli_arg, cli_no_arg, opt_name)                                                                         \
    else if (arg == (cli_arg)) opt_info.opt_name = true;                                                               \
    else if (arg == (cli_no_arg)) opt_info.opt_name = false;

        // Optimizations available:
        // Function Transforms
        OPT_ARG("--mem2reg", "--no-mem2reg", mem2reg)
        OPT_ARG("--sccp", "--no-sccp", sccp)
        OPT_ARG("--dce", "--no-dce", dce)
        OPT_ARG("--adce", "--no-adce", adce)
        OPT_ARG("--cfgsimplify", "--no-cfgsimplify", cfgsimplify)
        OPT_ARG("--dse", "--no-dse", dse)
        OPT_ARG("--loadelim", "--no-loadelim", loadelim)
        OPT_ARG("--gvnpre", "--no-gvnpre", gvnpre)
        OPT_ARG("--tailcall", "--no-tailcall", tailcall)
        OPT_ARG("--reassociate", "--no-reassociate", reassociate)
        OPT_ARG("--instsimplify", "--no-instsimplify", instsimplify)
        OPT_ARG("--inline", "--no-inline", inliner)
        OPT_ARG("--loopsimplify", "--no-loopsimplify", loop_simplify)
        OPT_ARG("--looprotate", "--no-looprotate", loop_rotate)
        OPT_ARG("--lcssa", "--no-lcssa", lcssa)
        OPT_ARG("--licm", "--no-licm", licm)
        OPT_ARG("--loopunroll", "--no-loopunroll", loop_unroll)
        OPT_ARG("--indvars", "--no-indvars", indvars)
        OPT_ARG("--lsr", "--no-lsr", loop_strength_reduce)
        OPT_ARG("--loopelim", "--no-loopelim", loopelim)
        OPT_ARG("--slp-vectorizer", "--no-slp-vectorizer", slp_vectorizer)
        OPT_ARG("--sroa", "--no-sroa", sroa)
        OPT_ARG("--jumpthreading", "--no-jumpthreading", jump_threading)
        // Module Transforms
        OPT_ARG("--treeshaking", "--no-treeshaking", tree_shaking)
#undef OPT_ARG
        // Debug options:
        else if (arg == "-fuzz") fuzz_testing = true;
        else if (arg == "-fuzz-rate") {
            ++i;
            if (i >= argc) {
                std::cerr << "Error: Expected fuzz duplication rate." << std::endl;
                return -1;
            }
            fuzz_testing = true;
            try {
                fuzz_testing_duplication_rate = std::stod(argv[i]);
            } catch (std::invalid_argument &) {
                std::cerr << "Error: Invalid fuzz duplication rate. Expected a floating point." << std::endl;
                return -1;
            }
        }
        else if (arg == "-fuzz-repro") {
            ++i;
            if (i >= argc) {
                std::cerr << "Error: Expected fuzz pipeline." << std::endl;
                return -1;
            }
            fuzz_testing = true;
            fuzz_testing_repro = argv[i];
        }
        else if (arg == "-debug-pipeline") debug_pipeline = true;
        else if (arg == "--ann") opt_info.advance_name_norm = true;
        else if (arg == "--verify") opt_info.verify = true;
        else if (arg == "--strict") {
            opt_info.verify = true;
            opt_info.abort_when_verify_failed = true;
        }
#if GNALC_EXTENSION_BRAINFK
        // Extensions:
        else if (arg == "-mbrainfk") bf_target = true;
        else if (arg == "-mbrainfk-3tape") bf3t_target = true;
#endif

        else if (arg == "-h" || arg == "--help") {
#ifndef GNALC_EXTENSION_GGC
            std::cout << "OVERVIEW: gnalc compiler\n\nUSAGE: gnalc [options] file\n\n";
#else
            std::cout << "OVERVIEW: ggc - an extension of the gnalc compiler\n\nUSAGE: ggc [options] <ggfile>\n\n";
#endif
            std::cout <<
                R"(OPTIONS:

General options:
  -o <file>               - Write output to <file>
  -S                      - Only run compilation steps
  -O,-O1                  - Optimization level 1
  -emit-llvm              - Use the LLVM representation for assembler and object files
  -ast-dump               - Build ASTs and then debug dump them. (Unavailable in GGC mode)
  -fixed-point            - Enable the fixed point optimization pipeline. (Ignore other optimization options)
  --log <log-level>       - Enable compiler logger. Available log-level: debug, info, none
  -h, --help              - Display available options

Optimizations available:
  --mem2reg            - Promote memory to register
  --sccp               - Sparse conditional constant propagation
  --dce                - Dead code elimination
  --adce               - Aggressive dead code elimination
  --cfgsimplify        - Simplify control flow
  --dse                - Dead store elimination
  --loadelim           - Redundant load elimination
  --gvnpre             - Value-Based partial redundancy elimination (GVN-PRE)
  --tailcall           - Tail call optimization
  --reassociate        - Reassociate commutative expressions
  --instsimplify       - Simplify instructions
  --inline             - Inline suitable functions
  --loopsimplify       - Canonicalize loops to the Loop Simplify Form
  --looprotate         - Canonicalize loops to the Rotated Loop Form
  --lcssa              - Canonicalize loops to the Loop Closed SSA Form
  --loopunroll         - Unroll loops
  --indvars            - Simplify induction variables
  --lsr                - Loop strength reduction
  --loopelim           - Loop elimination
  --slp-vectorizer     - SLP vectorizer
  --sroa               - Scalar replacement of aggregates
  --jumpthreading      - Jump threading
  --treeshaking        - Shake off unused functions, function declarations and global variables

Debug options:
  -fuzz                      - Enable fuzz testing pipeline. (Ignore other optimization options)
  -fuzz-rate <rate: double>  - Set the duplication rate for fuzz testing pipeline.
  -fuzz-repro <pipeline>     - Reproduce fuzz testing pipeline. Find <pipeline> in the fuzz testing log.
  -debug-pipeline            - Builtin pipeline for debugging.
  --no-<pass>                - Remove <pass> from pipeline, <pass> are specified by 'Optimizations available' above.
  --ann                      - Use the advance name normalization result (after IRGen). (This disables the one at the last).
  --verify                   - Verify IR after each pass
  --strict                   - Enable verify and abort when verify failed
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
        }
        else input_file = argv[i];
    }

    if (!only_compilation) {
        std::cerr << "Error: Gnalc currently only supports '-S' mode." << std::endl;
        return -1;
    }

    if (!input_file.empty()) {
        yyin = fopen(input_file.c_str(), "r");
        if (!yyin) {
            std::cerr << "Error: Failed to open input file '" << input_file << "'." << std::endl;
            return -1;
        }
    }

#ifndef GNALC_EXTENSION_GGC
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

    Parser::IRGenerator generator(input_file); // set Module's name to `input_file`
    generator.visit(*node);
#else
    IRParser::IRGenerator generator(input_file);
    if (generator.generate()) {
        std::cerr << "Syntax Error" << std::endl;
        return -1;
    }
#endif

    if (!input_file.empty())
        fclose(yyin);

    IR::FAM fam;
    IR::MAM mam;
    IR::PassBuilder::registerFunctionAnalyses(fam);
    IR::PassBuilder::registerModuleAnalyses(mam);
    IR::PassBuilder::registerProxies(fam, mam);

    IR::MPM mpm;
    if (debug_pipeline)
        mpm = IR::PassBuilder::buildModuleDebugPipeline();
    else if (fuzz_testing)
        mpm = IR::PassBuilder::buildModuleFuzzTestingPipeline(fuzz_testing_duplication_rate, fuzz_testing_repro);
    else if (fixed_point_pipeline)
        mpm = IR::PassBuilder::buildModuleFixedPointPipeline();
    else
        mpm = IR::PassBuilder::buildModulePipeline(opt_info);

    std::ostream *poutstream = &std::cout;
    std::ofstream outfile;

    if (!output_file.empty()) {
        outfile.open(output_file);
        if (!outfile.is_open()) {
            std::cerr << "Error: Failed to open output file '" << output_file << "'." << std::endl;
            return -1;
        }
        poutstream = &outfile;
    }

    if (emit_llvm) {
        mpm.addPass(IR::PrintModulePass(*poutstream));
        mpm.run(generator.get_module(), mam);
        return 0;
    }

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

    mpm.run(generator.get_module(), mam);

    MIR::Lowering lower(generator.get_module());

    MIR::FAM bkd_fam;
    MIR::MAM bkd_mam;

    MIR::PassBuilder::registerFunctionAnalyses(bkd_fam);
    MIR::PassBuilder::registerModuleAnalyses(bkd_mam);
    MIR::PassBuilder::registerProxies(bkd_fam, bkd_mam);

    auto bkd_mpm = MIR::PassBuilder::buildModulePipeline(bkd_opt_info);

    if (emit_llc) {
        bkd_mpm.addPass(MIR::PrintModulePass(*poutstream));
        bkd_mpm.run(lower.getModule(), bkd_mam);
        return 0;
    }

    bkd_mpm.run(lower.getModule(), bkd_mam);

    // Assembler
    if (only_compilation) {
        MIR::ARMPrinter armv7gen(outfile);
        armv7gen.printout(lower.getModule());
    }

    return 0;
}