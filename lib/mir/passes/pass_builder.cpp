// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/pass_builder.hpp"
#include "mir/passes/pass_manager.hpp"

// Analysis
#include "mir/passes/analysis/liveanalysis.hpp"
#include "mir/passes/analysis/loop_analysis.hpp"

// Transforms
#include "mir/passes/analysis/domtree_analysis.hpp"
#include "mir/passes/transforms/CFGsimplify.hpp"
#include "mir/passes/transforms/ICF_TailDup.hpp"
#include "mir/passes/transforms/PostRAlegalize.hpp"
#include "mir/passes/transforms/PreRAlegalize.hpp"
#include "mir/passes/transforms/RA.hpp"
#include "mir/passes/transforms/RedundantLoadEli.hpp"
#include "mir/passes/transforms/codelayout.hpp"
#include "mir/passes/transforms/isel.hpp"
#include "mir/passes/transforms/licm.hpp"
#include "mir/passes/transforms/lowering.hpp"
#include "mir/passes/transforms/peephole.hpp"
#include "mir/passes/transforms/registercoalesce.hpp"
#include "mir/passes/transforms/scheduling.hpp"
#include "mir/passes/transforms/stackgenerate.hpp"
#include "mir/passes/transforms/tro.hpp"

// Utilities
#include "mir/passes/utilities/mirprinter.hpp"

namespace MIR {

const OptInfo o1_opt_info = {.peephole_afterIsel = true,
                             .redundantLoadEli = true,
                             .peephole_afterRa = true,
                             .peephole_afterStackGenerate = true,
                             .CFGsimplifyBeforeRa = true,
                             .CFGsimplifyAfterRa = true,
                             .PostRaScheduling = true,
                             .machineLICM = true};

FPM PassBuilder::buildFunctionDebugPipeline() {
    FPM fpm;

    fpm.addPass(ISel());
    fpm.addPass(PrintFunctionPass(std::cerr));
    fpm.addPass(MachineLICMPass());
    fpm.addPass(PrintFunctionPass(std::cerr));
    fpm.addPass(PreRAlegalize());
    fpm.addPass(RegisterAlloc());
    fpm.addPass(GenericPeephole(GenericPeephole::AfterRa));
    fpm.addPass(StackGenerate());
    fpm.addPass(PostRAlegalize());

    return fpm;
}
MPM PassBuilder::buildModuleDebugPipeline() {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionDebugPipeline()));
    return mpm;
}

FPM buildRV64FunctionPipeline(OptInfo opt_info) {
    FPM fpm;
    // For RV64 Development
    fpm.addPass(ISel());
    fpm.addPass(MachineLICMPass());
    fpm.addPass(RedundantLoadEli());
    fpm.addPass(PreRAlegalize());
    fpm.addPass(RegisterAlloc());
    fpm.addPass(GenericPeephole(GenericPeephole::AfterRa));
    fpm.addPass(StackGenerate());
    fpm.addPass(PostRAlegalize());
    return fpm;
}

FPM buildARMv8FunctionPipeline(OptInfo opt_info) {
    FPM fpm;

    using Stage = GenericPeephole::Stage;

    // clang-format off
                                            fpm.addPass(ISel());
    opt_info.peephole_afterIsel ?           fpm.addPass(GenericPeephole(Stage::AfterIsel)) : nop;
    opt_info.CFGsimplifyBeforeRa ?          fpm.addPass(CFGsimplifyBeforeRA()) : nop;
    opt_info.redundantLoadEli ?             fpm.addPass(RedundantLoadEli()) : nop;
                                            fpm.addPass(PreRAlegalize());
    //
                                            // fpm.addPass(PrintFunctionPass(std::cerr));
    // opt_info.machineLICM ?                  fpm.addPass(MachineLICMPass()) : nop;
                                            // fpm.addPass(PrintFunctionPass(std::cerr));  
                                            fpm.addPass(RegisterAlloc());
    opt_info.peephole_afterRa ?             fpm.addPass(GenericPeephole(Stage::AfterRa)) : nop;
                                            fpm.addPass(StackGenerate());
    opt_info.peephole_afterStackGenerate ?  fpm.addPass(GenericPeephole(Stage::AfterPostLegalize)) : nop;
    opt_info.CFGsimplifyAfterRa ?           fpm.addPass(CFGsimplifyAfterRA()) : nop;
                                            fpm.addPass(PostRAlegalize());
    opt_info.PostRaScheduling ?             fpm.addPass(PostRaScheduling()) : nop;

    // clang-format on
    return fpm;
}

FPM PassBuilder::buildFunctionPipeline(Arch arch, OptInfo opt_info) {
    if (arch == Arch::RISCV64)
        return buildRV64FunctionPipeline(opt_info);
    return buildARMv8FunctionPipeline(opt_info);
}

MPM PassBuilder::buildModulePipeline(Arch arch, OptInfo opt_info) {
    MPM mpm;

    mpm.addPass(makeModulePass(buildFunctionPipeline(arch, opt_info)));
    return mpm;
}

void PassBuilder::registerProxies(FAM &fam, MAM &mam) {
    mam.registerPass([&] { return FAMProxy(fam); });
}

void PassBuilder::registerFunctionAnalyses(FAM &fam) {
#define FUNCTION_ANALYSIS(CREATE_PASS) fam.registerPass([&] { return CREATE_PASS; });

    FUNCTION_ANALYSIS(LiveAnalysis())
    FUNCTION_ANALYSIS(DomTreeAnalysis())
    FUNCTION_ANALYSIS(PostDomTreeAnalysis())
    FUNCTION_ANALYSIS(MachineLoopAnalysis())
    // ...

#undef FUNCTION_ANALYSIS
}

void PassBuilder::registerModuleAnalyses(MAM &) {}
}; // namespace MIR
