#include "mirA32/passes/pass_builder.hpp"
#include "mirA32/passes/pass_manager.hpp"

// Analysis
#include "mirA32/passes/analysis/domtree_analysis.hpp"
#include "mirA32/passes/analysis/live_analysis.hpp"

// Transforms
#include "mirA32/passes/transforms/const2reg.hpp"
#include "mirA32/passes/transforms/peephole.hpp"
#include "mirA32/passes/transforms/phiEliminate.hpp"
#include "mirA32/passes/transforms/postRAstackformat.hpp"
#include "mirA32/passes/transforms/preRAlegalize.hpp"
#include "mirA32/passes/transforms/registeralloc.hpp"
#include "mirA32/passes/transforms/uselessBlkEli.hpp"
#include "mirA32/passes/transforms/uselessMovEli.hpp"

namespace MIR {

const OptInfo o1_opt_info = {
    .peephole = true,
};

FPM PassBuilder::buildFunctionPipeline(OptInfo opt_info) {
    FPM fpm;

    if (opt_info.peephole) {
        fpm.addPass(PeepHolePass());
    }

    fpm.addPass(PreRALegalize()); // necessary
    fpm.addPass(Const2Reg());     // necessary

    fpm.addPass(NeonRAPass()); // necessary
    fpm.addPass(RAPass());     // necessary

    fpm.addPass(postRAstackformat());

    fpm.addPass(uselessMovEli());
    fpm.addPass(uselessBlkEli());

    return fpm;
}

MPM PassBuilder::buildModulePipeline(OptInfo opt_info) {
    MPM mpm;
    mpm.addPass(PhiEliminatePass()); // immediately after isel
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

} // namespace MIR