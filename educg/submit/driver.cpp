// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "driver.hpp"

#include "include/parser/ast.hpp"
#include "include/parser/irgen.hpp"
#include "include/parser/parser.hpp"
#include "include/utils/logger.hpp"

// SIR
#include "include/sir/passes/pass_builder.hpp"
#include "include/sir/passes/pass_manager.hpp"

// IR
#include "include/ir/passes/pass_builder.hpp"
#include "include/ir/passes/pass_manager.hpp"
#include "include/ir/passes/utilities/irprinter.hpp"

// MIR
#include "include/codegen/armv8/armprinter.hpp"
#include "include/codegen/riscv64/rv64printer.hpp"
#include "include/ir/cfgbuilder.hpp"
#include "include/mir/passes/pass_builder.hpp"
#include "include/mir/passes/pass_manager.hpp"
#include "include/mir/passes/transforms/lowering.hpp"

#include <fstream>
#include <iostream>
#include <memory>
#include <string>

extern FILE *yyin;

std::shared_ptr<AST::CompUnit> node = nullptr;

int main(int argc, char **argv) {
    Logger::setLogLevel(LogLevel::NONE);

    // File
    std::string input_file;
    std::string output_file;

    bool with_o1 = false;
    for (int i = 1; i < argc; ++i) {
        std::string arg(argv[i]);
        // General options:
        if (arg == "-o") {
            ++i;
            if (i >= argc) {
                std::cerr << "Error: Expected output." << std::endl;
                return -1;
            }
            output_file = argv[i];
        } else if (arg == "-O1")
            with_o1 = true;
        else if (arg == "-S")
            continue;
        else
            input_file = argv[i];
    }

    Err::gassert(!input_file.empty() && !output_file.empty(), "Error: No input file or output file specified.");

    yyin = fopen(input_file.c_str(), "r");
    if (!yyin) {
        std::cerr << "Error: Failed to open input file '" << input_file << "'." << std::endl;
        return -1;
    }

    yy::parser parser;
    if (parser.parse()) {
        std::cerr << "Syntax Error" << std::endl;
        return -1;
    }

    Parser::IRGenerator generator(input_file); // set Module's name to `input_file`
    generator.visit(*node);

    fclose(yyin);

    std::ostream *poutstream = &std::cout;
    std::ofstream outfile;

    outfile.open(output_file);
    if (!outfile.is_open()) {
        std::cerr << "Error: Failed to open output file '" << output_file << "'." << std::endl;
        return -1;
    }
    poutstream = &outfile;

    IR::CliOptions cli_opt_options;
    // Disable debug passes
    cli_opt_options.run_test.disable();
    cli_opt_options.verify.disable();

    // // Disable some passes to speed up the compilation
    // if (!with_o1) {
    //     cli_opt_options.inliner.disable();
    //     cli_opt_options.loop_unroll.disable();
    //     cli_opt_options.reassociate.disable();
    //     cli_opt_options.gvnpre.disable();
    //     cli_opt_options.loop_parallel.disable();
    //     cli_opt_options.vectorizer.disable();
    //     cli_opt_options.rngsimplify.disable();
    // }

    auto pm_options = cli_opt_options.toPMOptions(IR::CliOptions::Mode::EnableIfDefault);

    // SIR
    SIR::LFAM sir_lfam;
    SIR::MAM sir_mam;
    SIR::LinearPassBuilder::registerFunctionAnalyses(sir_lfam);
    SIR::LinearPassBuilder::registerModuleAnalyses(sir_mam);
    SIR::LinearPassBuilder::registerProxies(sir_lfam, sir_mam);

    SIR::MPM sir_mpm;
    if (with_o1)
        sir_mpm = SIR::LinearPassBuilder::buildModuleFixedPointPipeline(pm_options);
    else
        sir_mpm = SIR::LinearPassBuilder::buildModulePipeline(pm_options);

    sir_mpm.run(generator.get_module(), sir_mam);

    IR::CFGBuilder cfg_builder;
    cfg_builder.build(generator.get_module());

    // IR
    IR::FAM fam;
    IR::MAM mam;

    if (target == Target::ARMv8)
        IR::PassBuilder::registerARMv8TargetAnalyses(fam, mam);
    else
        IR::PassBuilder::registerRISCV64TargetAnalyses(fam, mam);

    IR::PassBuilder::registerFunctionAnalyses(fam);
    IR::PassBuilder::registerModuleAnalyses(mam);
    IR::PassBuilder::registerProxies(fam, mam);

    auto mpm = IR::PassBuilder::buildModuleFixedPointPipeline(pm_options);

    mpm.run(generator.get_module(), mam);

    MIR::Arch mir_arch;
    if (target == Target::ARMv8)
        mir_arch = MIR::Arch::ARMv8;
    else
        mir_arch = MIR::Arch::RISCV64;

    MIR::BkdInfos infos{.arch = mir_arch};
    auto ctx = MIR::CodeGenContext::create(infos);
    auto mModule = MIR::loweringModule(generator.get_module(), ctx);

    MIR::FAM bkd_fam;
    MIR::MAM bkd_mam;

    MIR::PassBuilder::registerFunctionAnalyses(bkd_fam);
    MIR::PassBuilder::registerModuleAnalyses(bkd_mam);
    MIR::PassBuilder::registerProxies(bkd_fam, bkd_mam);
    MIR::OptInfo bkd_opt_info = MIR::o1_opt_info;
    auto bkd_mpm = MIR::PassBuilder::buildModulePipeline(mir_arch, bkd_opt_info);
    bkd_mpm.run(*mModule, bkd_mam);

    if (target == Target::ARMv8) {
        MIR::ARMA64Printer armv8gen(*poutstream, /* with runtime */ true, /* debug */ false);
        armv8gen.printout(*mModule);
    } else {
        MIR::RV64Printer riscv64gen(*poutstream, /* with runtime */ true);
        riscv64gen.printout(*mModule);
    }
    return 0;
}
