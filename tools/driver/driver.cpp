// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include <cstddef>
#define GNALC_STACKTRACE_ENABLE

// Logger
#include "utils/logger.hpp"

// SIR
#include "sir/passes/pass_builder.hpp"
#include "sir/passes/pass_manager.hpp"
#include "sir/passes/utilities/sirprinter.hpp"

// IR
#include "ir/cfgbuilder.hpp"
#include "ir/passes/pass_builder.hpp"
#include "ir/passes/pass_manager.hpp"
#include "ir/passes/utilities/irprinter.hpp"

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

#ifdef GNALC_EXTENSION_ARMv7 // in CMakeLists.txt
#include "codegen/armv7/armprinter.hpp"
#include "legacy_mir/builder/lowering.hpp"
#include "legacy_mir/passes/pass_builder.hpp"
#include "legacy_mir/passes/pass_manager.hpp"
#include "legacy_mir/passes/utilities/mirprinter.hpp"
#endif

// MIR
#include "codegen/armv8/armprinter.hpp"
#include "codegen/riscv64/rv64printer.hpp"
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

enum class Target { ARMv8, ARMv7, RISCV64, BrainFk, BrainFk3Tape };

int main(int argc, char **argv) {
    // gnalc is still in development, so make it defaults to be `LogLevel::DEBUG`.
    Logger::setLogLevel(LogLevel::DEBUG);

    // File
    std::string input_file;
    std::string output_file;

    // Options
    bool only_compilation = false;              // -S
    bool emit_sir = false;                      // -emit-sir
    bool emit_llvm = false;                     // -emit-llvm
    bool emit_llvm_with_asm = false;            // -emit-llvm-with-asm
    bool emit_llc = false;                      // -emit-llc
    bool ast_dump = false;                      // -ast-dump
    bool std_pipeline = false;                  // -std-pipeline
    bool fixed_point_pipeline = false;          // -O, -O1, -fixed-point
    bool o0_optnone = false;                    // -O0
    bool fuzz_testing = false;                  // -fuzz
    double fuzz_testing_duplication_rate = 1.0; // -fuzz-rate
    std::string fuzz_testing_repro;             // -fuzz-repro
    bool debug_pipeline = false;                // -debug-pipeline
    bool sir_debug_pipeline = false;            // -sir-debug-pipeline
    bool mir_debug_pipeline = false;            // -mir-debug-pipeline
    bool with_runtime = false;                  // -with-runtime
    IR::CliOptions cli_opt_options;             // --xxx, --no-xxx

#ifdef GNALC_EXTENSION_ARMv7
    LegacyMIR::OptInfo bkd_opt_info_A32;
#endif
    MIR::OptInfo bkd_opt_info = MIR::o1_opt_info;

#ifdef GNALC_DEFAULT_RISCV64
    Target target = Target::RISCV64;
#else
    Target target = Target::ARMv8;
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
        else if (arg == "-emit-sir")
            emit_sir = true;
        else if (arg == "-emit-llvm")
            emit_llvm = true;
        else if (arg == "-emit-llvm-with-asm")
            emit_llvm_with_asm = true;
        else if (arg == "-with-runtime")
            with_runtime = true;
        else if (arg == "-emit-llc")
            emit_llc = true;
        else if (arg == "-ast-dump") {
#ifdef GNALC_EXTENSION_GGC
            std::cerr << "Error: AST dump is not available in GGC mode." << std::endl;
            return -1;
#endif
            ast_dump = true;
        } else if (arg == "-O1" || arg == "-O" || arg == "-fixed-point")
            fixed_point_pipeline = true;
        else if (arg == "-O0")
            o0_optnone = true;
        else if (arg == "-std-pipeline")
            std_pipeline = true;

#define OPT_ARG(cli_arg, cli_no_arg, opt_name)                                                                         \
    else if (arg == (cli_arg)) cli_opt_options.opt_name.enable();                                                      \
    else if (arg == (cli_no_arg)) cli_opt_options.opt_name.disable();
        // Optimizations available:
        // IR Function Transforms
        OPT_ARG("--mem2reg", "--no-mem2reg", mem2reg)
        OPT_ARG("--sccp", "--no-sccp", sccp)
        OPT_ARG("--dce", "--no-dce", dce)
        OPT_ARG("--adce", "--no-adce", adce)
        OPT_ARG("--cfgsimplify", "--no-cfgsimplify", cfgsimplify)
        OPT_ARG("--ifconv", "--no-ifconv", if_conversion)
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
        OPT_ARG("--parallel", "--no-parallel", loop_parallel)
        OPT_ARG("--loopelim", "--no-loopelim", loopelim)
        OPT_ARG("--vectorizer", "--no-vectorizer", vectorizer)
        OPT_ARG("--rngsimplify", "--no-rngsimplify", rngsimplify)
        OPT_ARG("--dae", "--no-dae", dae)
        OPT_ARG("--memo", "--no-memo", memo)
        OPT_ARG("--unifyexits", "--no-unifyexits", unify_exits)
        OPT_ARG("--internalize", "--no-internalize", internalize)
        OPT_ARG("--globalize", "--no-globalize", globalize)
        OPT_ARG("--gepflatten", "--no-gepflatten", gep_flatten)
        OPT_ARG("--storerng", "--no-storerng", store_range)
        OPT_ARG("--codesink", "--no-codesink", code_sink)
        OPT_ARG("--cgprepare", "--no-cgprepare", codegen_prepare)
        // SIR Function Transforms
        OPT_ARG("--earlymem2reg", "--no-earlymem2reg", early_mem2reg)
        OPT_ARG("--earlyinline", "--no-earlyinline", early_inline)
        OPT_ARG("--while2for", "--no-while2for", while2for)
        OPT_ARG("--reshapefold", "--no-reshapefold", reshape_fold)
        OPT_ARG("--earlydce", "--no-earlydce", early_dce)
        OPT_ARG("--constantfold", "--no-constantfold", constant_fold)
        OPT_ARG("--interchange", "--no-interchange", loop_interchange)
        OPT_ARG("--unswitch", "--no-unswitch", loop_unswitch)
        OPT_ARG("--fuse", "--no-fuse", loop_fuse)
        // IR Module Transforms
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
        else if (arg == "--test-in") {
            ++i;
            if (i >= argc) {
                std::cerr << "Error: Expected testcase in file." << std::endl;
                return -1;
            }
            cli_opt_options.run_test.enable();
            cli_opt_options.testcase_in = argv[i];
        }
        else if (arg == "--test-out") {
            ++i;
            if (i >= argc) {
                std::cerr << "Error: Expected testcase out file." << std::endl;
                return -1;
            }
            cli_opt_options.run_test.enable();
            cli_opt_options.testcase_out = argv[i];
        }
        else if (arg == "-debug-pipeline") debug_pipeline = true;
        else if (arg == "-sir-debug-pipeline") sir_debug_pipeline = true;
        else if (arg == "-mir-debug-pipeline") mir_debug_pipeline = true;
        else if (arg == "--ann") cli_opt_options.advance_name_norm = true;
        else if (arg == "--verify") cli_opt_options.verify.enable();
        else if (arg == "--strict") {
            cli_opt_options.verify.enable();
            cli_opt_options.strict = true;
        }
        // backend opt options
        else if (arg == "-fno-PreRaCFGsimp") {
            bkd_opt_info.CFGsimplifyBeforeRa = false;
        }
        else if (arg == "-fno-redundantLoadEli") {
            bkd_opt_info.redundantLoadEli = false;
        }
        else if (arg == "-fno-PostRaScheduling") {
            bkd_opt_info.PostRaScheduling = false;
        }
        else if (arg == "-fno-machineLICM") {
            bkd_opt_info.machineLICM = false;
        }
        else if (arg == "-fno-codeLayout") {
            bkd_opt_info.codeLayout = false;
        }
        else if (arg.substr(0, 9) == "-loadEli=") {
            bkd_opt_info.redundantLoadEli_weight = std::stoull(arg.substr(9));
        }
        else if (arg.substr(0, 9) == "-dumpMap=") {
            bkd_opt_info.registeralloc_dmp_times = std::stoul(arg.substr(9));
        }

        else if (arg == "-march=armv8" || arg == "-march=armv8-a") target = Target::ARMv8;
        else if (arg == "-march=armv7" || arg == "-march=armv7-a") target = Target::ARMv7;
        else if (arg == "-march=riscv64") target = Target::RISCV64;
        else if (arg == "-march=brainfk") target = Target::BrainFk;
        else if (arg == "-march=brainfk-3tape") target = Target::BrainFk3Tape;
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
  -O0                  - Optimization level 0 (disable all optimization)
  -O,-O1, -fixed-point - Optimization level 1 (fixed-point pipeline)
  -emit-llvm           - Use LLVM intermediate representation for output
  -emit-llvm-with-asm  - Enable both LLVM IR and Asm output
  -ast-dump            - Build and dump AST (Unavailable in GGC mode)
  --log <log-level>    - Set logging level (debug|info|none)
  -h, --help           - Display this help message
  -march=<value>       - Set target architecture. (armv8|armv7|riscv64|brainfk|brainfk-3tape)
  -v, --version        - Display version information

Optimizations Flags:
  --earlymem2reg       - Promote memory to register in SIR
  --while2for          - Canonicalize while loops to for loops
  --reshapefold        - Eliminate redundant reshape
  --earlyinline        - Early function inline.
  --earlydce           - Early dead code elimination
  --constantfold       - Early constant folding
  --interchange        - Loop interchange
  --unswitch           - Loop unswitch
  --fuse               - Loop fusion
  --mem2reg            - Promote memory to register
  --sccp               - Sparse conditional constant propagation
  --dce                - Dead code elimination
  --adce               - Aggressive dead code elimination
  --cfgsimplify        - Control flow graph simplification
  --ifconv             - Simple If-Conversion performed on IR
  --dse                - Dead store elimination
  --loadelim           - Redundant load elimination
  --gvnpre             - Value-Based partial redundancy elimination (GVN-PRE)
  --tailcall           - Tail call optimization
  --reassociate        - Reassociate commutative expressions
  --instsimplify       - Instruction simplification
  --inline             - Function inlining
  --loopunroll         - Loop unrolling
  --parallel           - Loop parallelization
  --indvars            - Induction variable simplification
  --lsr                - Loop strength reduction
  --loopelim           - Loop elimination
  --vectorizer         - BoUpSLP Vectorizer
  --rngsimplify        - Value range aware redundancy elimination
  --dae                - Dead argument elimination
  --memo               - Automatic function memoization
  --unifyexits         - Unify function return nodes
  --internalize        - Internalize global variables
  --globalize          - Globalize local variables
  --gepflatten         - Flatten getelementptr to binarys
  --storerng           - Store Range Analysis result. (For backend)
  --codesink           - Code Sink
  --cgprepare          - Codegen preparation
  --treeshaking        - Shake off unused functions, function declarations and global variables

Backend options:
  -fno-PreRaCFGsimp     - Disable PreRa CFG simplification
  -fno-redundantLoadEli - Disable redundant load elimination
  -fno-PostRaScheduling - Disable PostRa Scheduling
  -fno-machineLICM      - Disable machine LICM
  -fno-codeLayout        - Disable code layout optimization

Debug options:
  -with-runtime              - Emit gnalc runtime when emitting LLVM IR
  -fuzz                      - Enable fuzz testing pipeline
  -fuzz-rate <rate: double>  - Set the duplication rate for fuzz testing pipeline
  -fuzz-repro <pipeline>     - Reproduce specific fuzz pipeline. Find <pipeline> in the fuzz testing log
  -debug-pipeline            - Use built-in debugging IR pipeline
  -sir-debug-pipeline        - Use built-in debugging SIR pipeline
  -mir-debug-pipeline        - Use built-in debugging MIR pipeline
  --no-<pass>                - Disable specific optimization pass
  --ann                      - Use the advance name normalization result (after IRGen) (This disables the one at the last)
  --verify                   - Enable IR verification after passes
  --strict                   - Strict mode (verify + abort on failure)
  --test-in <file>           - Enable Test after each pass an set the testcase input file
  --test-out <file>          - Enable Test after each pass an set the testcase output file

Note: For -O1/-fixed-point/-std-pipeline/-fuzz modes:
  --<opt> flags have no effect, but --no-<opt> can disable specific passes
)";
            // 0x676e616c63
            auto magic = "\x67\x6e\x61\x6c\x63";
            std::cout << "\nThis " << magic << " has Super Loong Powers." << std::endl;
            return 0;
        }
        else if (arg == "-v" || arg == "--version") {
            std::cout << "gnalc version 0.0.1" << std::endl;

            // Targets
            std::cout << "Supported targets: armv8, riscv64";
#ifdef GNALC_EXTENSION_ARMv7
            std::cout << ", armv7";
#endif
#ifdef GNALC_EXTENSION_BRAINFK
            std::cout << ", brainfk, brainfk-3tape";
#endif
            std::cout << std::endl;

            // Build time
            std::cout << "Built at " << __DATE__ << " " << __TIME__ << std::endl;
            return 0;
        }
        else if (arg == "loong") {
            std::cout <<
#include "loong.txt"

                      << "\n...\"Have you loonged today?\"..." << std::endl;
            return 0;
        }
        else input_file = argv[i];
    }

    // Check arguments consistency

    // Single pipeline
    {
        std::vector check = {o0_optnone, std_pipeline, fuzz_testing, fixed_point_pipeline, debug_pipeline};
        if (std::count(check.begin(), check.end(), true) > 1) {
            std::cerr << "Error: Multiple IR pipelines specified." << std::endl;
            return -1;
        }
    }

    // Available target
#ifndef GNALC_EXTENSION_ARMv7
    if (target == Target::ARMv7) {
        std::cerr << "Error: Target ARMv7 is not available in this build." << std::endl;
        return -1;
    }
#endif

#ifndef GNALC_EXTENSION_BRAINFK
    if (target == Target::BrainFk || target == Target::BrainFk3Tape) {
        std::cerr << "Error: Target BrainFk or BrainFk3Tape is not available in this build." << std::endl;
        return -1;
    }
#endif

    // Input file
    if (!input_file.empty()) {
        yyin = fopen(input_file.c_str(), "r");
        if (!yyin) {
            std::cerr << "Error: Failed to open input file '" << input_file << "'." << std::endl;
            return -1;
        }
    }

    if (!only_compilation) {
        std::cerr << "Warning: Gnalc currently only supports '-S' mode."
                     " Only run compilation steps currently."
                  << std::endl;
        only_compilation = true;
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

    cli_opt_options.run_test.disableIfDefault();
    if (cli_opt_options.run_test.isEnable() && cli_opt_options.testcase_out.empty()) {
        std::cerr << "Warning: Ignored testcase in since no expected output is specified." << std::endl;
        cli_opt_options.run_test.disable();
    }

    IR::PMOptions pm_options{};
    if (o0_optnone)
        pm_options = cli_opt_options.toPMOptions(IR::CliOptions::Mode::DisableIfDefault);
    else if (fuzz_testing) {
        cli_opt_options.strict = true;
        cli_opt_options.verify.enableIfDefault();
        cli_opt_options.run_test.disableIfDefault();
        pm_options = cli_opt_options.toPMOptions(IR::CliOptions::Mode::EnableIfDefault);
    } else if (std_pipeline || fixed_point_pipeline) {
        cli_opt_options.verify.disableIfDefault();
        cli_opt_options.run_test.disableIfDefault();
        pm_options = cli_opt_options.toPMOptions(IR::CliOptions::Mode::EnableIfDefault);
    } else {
        cli_opt_options.verify.disableIfDefault();
        cli_opt_options.run_test.disableIfDefault();
        cli_opt_options.licm.disableIfDefault();
        cli_opt_options.loop_unroll.disableIfDefault();
        pm_options = cli_opt_options.toPMOptions(IR::CliOptions::Mode::EnableIfDefault);
    }

    // SIR
    SIR::LFAM sir_lfam;
    SIR::MAM sir_mam;
    SIR::LinearPassBuilder::registerFunctionAnalyses(sir_lfam);
    SIR::LinearPassBuilder::registerModuleAnalyses(sir_mam);
    SIR::LinearPassBuilder::registerProxies(sir_lfam, sir_mam);

    SIR::MPM sir_mpm;
    if (sir_debug_pipeline)
        sir_mpm = SIR::LinearPassBuilder::buildModuleDebugPipeline();
    else if (fixed_point_pipeline)
        sir_mpm = SIR::LinearPassBuilder::buildModuleFixedPointPipeline(pm_options);
    else
        sir_mpm = SIR::LinearPassBuilder::buildModulePipeline(pm_options);

    if (emit_sir) {
        sir_mpm.addPass(SIR::PrintLinearModulePass(*poutstream));
        sir_mpm.run(generator.get_module(), sir_mam);
        return 0;
    }

    sir_mpm.run(generator.get_module(), sir_mam);
    IR::CFGBuilder cfg_builder;
    cfg_builder.build(generator.get_module());

    // IR
    IR::FAM fam;
    IR::MAM mam;

    switch (target) {
    case Target::ARMv8:
        IR::PassBuilder::registerARMv8TargetAnalyses(fam, mam);
        break;
    case Target::ARMv7:
        IR::PassBuilder::registerARMv7TargetAnalyses(fam, mam);
        break;
    case Target::RISCV64:
        IR::PassBuilder::registerRISCV64TargetAnalyses(fam, mam);
        break;
    case Target::BrainFk:
    case Target::BrainFk3Tape:
        IR::PassBuilder::registerBrainFkTargetAnalyses(fam, mam);
        break;
    default:
        std::cerr << "Error: Unsupported target." << std::endl;
        return -1;
    }

    IR::PassBuilder::registerFunctionAnalyses(fam);
    IR::PassBuilder::registerModuleAnalyses(mam);
    IR::PassBuilder::registerProxies(fam, mam);

    IR::MPM mpm;
    if (debug_pipeline)
        mpm = IR::PassBuilder::buildModuleDebugPipeline();
    else if (fuzz_testing)
        mpm = IR::PassBuilder::buildModuleFuzzTestingPipeline(pm_options, fuzz_testing_duplication_rate,
                                                              fuzz_testing_repro);
    else
        mpm = IR::PassBuilder::buildModuleFixedPointPipeline(pm_options);
    // else if (fixed_point_pipeline)
    //     mpm = IR::PassBuilder::buildModuleFixedPointPipeline(pm_options);
    // else
    //     mpm = IR::PassBuilder::buildModulePipeline(pm_options);

    if (emit_llvm || emit_llvm_with_asm) {
        mpm.addPass(IR::PrintModulePass(*poutstream, with_runtime));
        if (!emit_llvm_with_asm) {
            mpm.run(generator.get_module(), mam);
            return 0;
        }
    }

#ifdef GNALC_EXTENSION_BRAINFK
    if (target == Target::BrainFk || target == Target::BrainFk3Tape) {
        BrainFk::BF3t32bGen bfgen;
        BrainFk::BFPrinter bfprinter(*poutstream);

        bfgen.visit(generator.get_module());

        if (target != Target::BrainFk3Tape) {
            BrainFk::BF32t32bTrans trans(false);
            trans.visit(bfgen.getModule());
            bfprinter.printout(trans.getModule());
        } else
            bfprinter.printout(bfgen.getModule());

        return 0;
    }
#endif

#ifdef GNALC_EXTENSION_ARMv7
    if (target == Target::ARMv7) {
        mpm.run(generator.get_module(), mam);

        LegacyMIR::Lowering lower(generator.get_module());

        LegacyMIR::FAM bkd_fam;
        LegacyMIR::MAM bkd_mam;

        LegacyMIR::PassBuilder::registerFunctionAnalyses(bkd_fam);
        LegacyMIR::PassBuilder::registerModuleAnalyses(bkd_mam);
        LegacyMIR::PassBuilder::registerProxies(bkd_fam, bkd_mam);

        auto bkd_mpm = LegacyMIR::PassBuilder::buildModulePipeline(bkd_opt_info_A32);

        if (emit_llc) {
            bkd_mpm.addPass(LegacyMIR::PrintModulePass(*poutstream));
            bkd_mpm.run(lower.getModule(), bkd_mam);
            return 0;
        }

        bkd_mpm.run(lower.getModule(), bkd_mam);

        // Assembler
        if (only_compilation) {
            LegacyMIR::ARMPrinter armv7gen(*poutstream);
            armv7gen.printout(lower.getModule());
        }

        return 0;
    }
#endif

    mpm.run(generator.get_module(), mam);
    MIR::Arch mir_arch;
    switch (target) {
    case Target::ARMv8:
        mir_arch = MIR::Arch::ARMv8;
        break;
    case Target::RISCV64:
        mir_arch = MIR::Arch::RISCV64;
        break;
    default:
        std::cerr << "Error: Unsupported target." << std::endl;
        return -1;
    }

    MIR::BkdInfos infos{.arch = mir_arch};
    auto ctx = MIR::CodeGenContext::create(infos);
    auto mModule = MIR::loweringModule(generator.get_module(), ctx);

    MIR::FAM bkd_fam;
    MIR::MAM bkd_mam;

    MIR::PassBuilder::registerFunctionAnalyses(bkd_fam);
    MIR::PassBuilder::registerModuleAnalyses(bkd_mam);
    MIR::PassBuilder::registerProxies(bkd_fam, bkd_mam);

    MIR::MPM bkd_mpm;
    if (mir_debug_pipeline)
        bkd_mpm = MIR::PassBuilder::buildModuleDebugPipeline();
    else
        bkd_mpm = MIR::PassBuilder::buildModulePipeline(mir_arch, bkd_opt_info);

    bkd_mpm.run(*mModule, bkd_mam);

    if (only_compilation) {
        if (target == Target::ARMv8) {
            MIR::ARMA64Printer armv8gen(*poutstream, with_runtime, emit_llc);
            armv8gen.printout(*mModule);
        } else {
            MIR::RV64Printer riscv64gen(*poutstream, with_runtime);
            riscv64gen.printout(*mModule);
        }
        return 0;
    }

    return 0;
}
