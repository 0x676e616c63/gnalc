#include "ir/passes/pass_builder.hpp"
#include "ir/passes/pass_manager.hpp"
#include "ir/passes/utilities/irprinter.hpp"

#include "utils/logger.hpp"

#ifndef GNALC_EXTENSION_GGC // in CMakeLists.txt
#include "parser/ast.hpp"
#include "parser/astprinter.hpp"
#include "parser/irgen.hpp"
#include "parser/parser.hpp"
#else
#include "ggc/irparsertool.hpp"
#endif

#ifdef GNALC_EXTENSION_BRAINFK // in CMakeLists.txt
#include "codegen/brainfk/bfgen.hpp"
#include "codegen/brainfk/bfprinter.hpp"
#include "codegen/brainfk/bftrans.hpp"
#endif

#if GNALC_EXTENSION_A32 // in config.hpp
#include "codegen/armv7/armprinter.hpp"
#include "mirA32/builder/lowering.hpp"
#include "mirA32/passes/pass_builder.hpp"
#include "mirA32/passes/pass_manager.hpp"
#include "mirA32/passes/utilities/mirprinter.hpp"
#endif

#include "codegen/armv8/armprinter.hpp"
#include "mir/passes/pass_builder.hpp"
#include "mir/passes/pass_manager.hpp"
#include "mir/passes/transforms/lowering.hpp"

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
    bool o1_pipeline = false;                   // -O, -O1
    bool fixed_point_pipeline = false;          // -fixed-point
    bool fuzz_testing = false;                  // -fuzz
    double fuzz_testing_duplication_rate = 1.0; // -fuzz-rate
    std::string fuzz_testing_repro;             // -fuzz-repro
    bool debug_pipeline = false;                // -debug-pipeline
    IR::CliOptions cli_opt_options;             // --xxx, --no-xxx

#if GNALC_EXTENSION_A32
    MIR::OptInfo bkd_opt_info_A32;
    bool A32_target = false; // -march=armv7
#endif

    MIR_new::OptInfo bkd_opt_info;

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
            o1_pipeline = true;

#define OPT_ARG(cli_arg, cli_no_arg, opt_name)                                                                         \
    else if (arg == (cli_arg)) cli_opt_options.opt_name = IR::CliOptions::Status::Enable;                              \
    else if (arg == (cli_no_arg)) cli_opt_options.opt_name = IR::CliOptions::Status::Disable;
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
        OPT_ARG("--licm", "--no-licm", licm)
        OPT_ARG("--loopunroll", "--no-loopunroll", loop_unroll)
        OPT_ARG("--indvars", "--no-indvars", indvars)
        OPT_ARG("--lsr", "--no-lsr", loop_strength_reduce)
        OPT_ARG("--loopelim", "--no-loopelim", loopelim)
        OPT_ARG("--vectorizer", "--no-vectorizer", vectorizer)
        OPT_ARG("--jumpthreading", "--no-jumpthreading", jump_threading)
        OPT_ARG("--internalize", "--no-internalize", internalize)
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
        else if (arg == "--ann") cli_opt_options.advance_name_norm = true;
        else if (arg == "--verify") cli_opt_options.verify = IR::CliOptions::Status::Enable;
        else if (arg == "--strict") {
            cli_opt_options.verify = IR::CliOptions::Status::Enable;
            cli_opt_options.abort_when_verify_failed = true;
        }
#if GNALC_EXTENSION_BRAINFK
        // Extensions:
        else if (arg == "-mbrainfk") bf_target = true;
        else if (arg == "-mbrainfk-3tape") bf3t_target = true;
#endif

#if GNALC_EXTENSION_A32
        else if (arg == "-march=armv7" || arg == "-march=armv7-a") A32_target = true;
#endif

        else if (arg == "-h" || arg == "--help") {
#ifndef GNALC_EXTENSION_GGC
            std::cout << "OVERVIEW: gnalc compiler\n\nUSAGE: gnalc [options] file\n\n";
#else
            std::cout << "OVERVIEW: ggc - an extension of the gnalc compiler\n\nUSAGE: ggc [options] <ggfile>\n\n";
#endif
            std::cout <<
                R"(OPTIONS:

General Options:
  -o <file>            - Write output to <file>
  -S                   - Only run compilation steps (assembly generation)
  -O,-O1               - Optimization level 1
  -emit-llvm           - Use LLVM intermediate representation for output
  -ast-dump            - Build and dump AST (Unavailable in GGC mode)
  -fixed-point         - Enable fixed-point optimization pipeline
  --log <log-level>    - Set logging level (debug|info|none)
  -h, --help           - Display this help message

Optimizations Flags:
  --mem2reg            - Promote memory to register
  --sccp               - Sparse conditional constant propagation
  --dce                - Dead code elimination
  --adce               - Aggressive dead code elimination
  --cfgsimplify        - Control flow graph simplification
  --dse                - Dead store elimination
  --loadelim           - Redundant load elimination
  --gvnpre             - Value-Based partial redundancy elimination (GVN-PRE)
  --tailcall           - Tail call optimization
  --reassociate        - Reassociate commutative expressions
  --instsimplify       - Instruction simplification
  --inline             - Function inlining
  --loopunroll         - Loop unrolling
  --indvars            - Induction variable simplification
  --lsr                - Loop strength reduction
  --loopelim           - Loop elimination
  --vectorizer         - Vectorizer
  --jumpthreading      - Jump threading
  --internalize        - Internalize global variables
  --treeshaking        - Shake off unused functions, function declarations and global variables

Debug options:
  -fuzz                      - Enable fuzz testing pipeline
  -fuzz-rate <rate: double>  - Set the duplication rate for fuzz testing pipeline
  -fuzz-repro <pipeline>     - Reproduce specific fuzz pipeline. Find <pipeline> in the fuzz testing log
  -debug-pipeline            - Use built-in debugging pipeline
  --no-<pass>                - Disable specific optimization pass
  --ann                      - Use the advance name normalization result (after IRGen) (This disables the one at the last)
  --verify                   - Enable IR verification after passes
  --strict                   - Strict mode (verify + abort on failure)

Note: For -fuzz/-fixed-point/-O1 modes:
  --<opt> flags have no effect, but --no-<opt> can disable specific passes
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

    IR::PMOptions pm_options{};
    if (o1_pipeline || fixed_point_pipeline || fuzz_testing) {
        if (!fuzz_testing) {
            if (cli_opt_options.verify == IR::CliOptions::Status::Default)
                cli_opt_options.verify = IR::CliOptions::Status::Disable;
        } else
            cli_opt_options.abort_when_verify_failed = true;
        pm_options = cli_opt_options.toPMOptions(IR::CliOptions::Mode::EnableIfDefault);
    } else
        pm_options = cli_opt_options.toPMOptions(IR::CliOptions::Mode::DisableIfDefault);

    IR::MPM mpm;
    if (debug_pipeline)
        mpm = IR::PassBuilder::buildModuleDebugPipeline();
    else if (fuzz_testing)
        mpm = IR::PassBuilder::buildModuleFuzzTestingPipeline(pm_options, fuzz_testing_duplication_rate,
                                                              fuzz_testing_repro);
    else if (fixed_point_pipeline)
        mpm = IR::PassBuilder::buildModuleFixedPointPipeline(pm_options);
    else
        mpm = IR::PassBuilder::buildModulePipeline(pm_options);

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

#if GNALC_EXTENSION_A32
    if (A32_target) {
        mpm.run(generator.get_module(), mam);

        MIR::Lowering lower(generator.get_module());

        MIR::FAM bkd_fam;
        MIR::MAM bkd_mam;

        MIR::PassBuilder::registerFunctionAnalyses(bkd_fam);
        MIR::PassBuilder::registerModuleAnalyses(bkd_mam);
        MIR::PassBuilder::registerProxies(bkd_fam, bkd_mam);

        auto bkd_mpm = MIR::PassBuilder::buildModulePipeline(bkd_opt_info_A32);

        if (emit_llc) {
            bkd_mpm.addPass(MIR::PrintModulePass(*poutstream));
            bkd_mpm.run(lower.getModule(), bkd_mam);
            return 0;
        }

        bkd_mpm.run(lower.getModule(), bkd_mam);

        // Assembler
        if (only_compilation) {
            MIR::ARMPrinter armv7gen(*poutstream);
            armv7gen.printout(lower.getModule());
        }

        return 0;
    }
#endif

    mpm.run(generator.get_module(), mam);
    MIR_new::BkdInfos infos{};
    MIR_new::ISelInfo isel{};
    MIR_new::FrameInfo frame{};
    MIR_new::CodeGenContext ctx{infos, isel, frame};
    auto mModule = MIR_new::loweringModule(generator.get_module(), ctx);

    MIR_new::FAM bkd_fam;
    MIR_new::MAM bkd_mam;

    MIR_new::PassBuilder::registerFunctionAnalyses(bkd_fam);
    MIR_new::PassBuilder::registerModuleAnalyses(bkd_mam);
    MIR_new::PassBuilder::registerProxies(bkd_fam, bkd_mam);

    auto bkd_mpm = MIR_new::PassBuilder::buildModulePipeline(bkd_opt_info);

    if (emit_llc) {
        Err::todo("mir dumper not impl");
    }

    bkd_mpm.run(*mModule, bkd_mam);

    if (only_compilation) {
        MIR_new::ARMA64Printer armv8gen(*poutstream);
        armv8gen.printout(*mModule);
        return 0;
    }

    return 0;
}