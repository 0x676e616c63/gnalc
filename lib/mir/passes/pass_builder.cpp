#include "mir/passes/pass_builder.hpp"
#include "mir/passes/pass_manager.hpp"

// Analysis
#include "mir/passes/analysis/liveanalysis.hpp"

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
#include "mir/passes/transforms/lowering.hpp"
#include "mir/passes/transforms/peephole.hpp"
#include "mir/passes/transforms/registercoalesce.hpp"
#include "mir/passes/transforms/scheduling.hpp"
#include "mir/passes/transforms/stackgenerate.hpp"
#include "mir/passes/transforms/tro.hpp"

namespace MIR {

const OptInfo o1_opt_info = {.peephole_afterIsel = true,
                             .redundantLoadEli = true,
                             .peephole_afterRa = true,
                             .peephole_afterStackGenerate = true,
                             .CFGsimplifyBeforeRa = true,
                             .CFGsimplifyAfterRa = true,
                             .PostRaScheduling = true};

FPM PassBuilder::buildFunctionPipeline(OptInfo opt_info) {
    FPM fpm;

    using Stage = GenericPeephole::Stage;

    // clang-format off
                                            fpm.addPass(ISel());
    opt_info.peephole_afterIsel ?           fpm.addPass(GenericPeephole(Stage::AfterIsel)) : nop;
    opt_info.CFGsimplifyBeforeRa ?          fpm.addPass(CFGsimplifyBeforeRA()) : nop;
    opt_info.redundantLoadEli ?             fpm.addPass(RedundantLoadEli()) : nop;
                                            fpm.addPass(PreRAlegalize());
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

MPM PassBuilder::buildModulePipeline(OptInfo opt_info) {
    MPM mpm;

    mpm.addPass(makeModulePass(buildFunctionPipeline(opt_info)));
    return mpm;
}

void PassBuilder::registerProxies(FAM &fam, MAM &mam) {
    mam.registerPass([&] { return FAMProxy(fam); });
}

void PassBuilder::registerFunctionAnalyses(FAM &fam) {
#define FUNCTION_ANALYSIS(CREATE_PASS) fam.registerPass([&] { return CREATE_PASS; });

    FUNCTION_ANALYSIS(LiveAnalysis())
    FUNCTION_ANALYSIS(DomTreeAnalysis())
    // ...

#undef FUNCTION_ANALYSIS
}

void PassBuilder::registerModuleAnalyses(MAM &) {}
}; // namespace MIR
