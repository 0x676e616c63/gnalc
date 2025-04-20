#include "mir/passes/pass_builder.hpp"
#include "mir/passes/pass_manager.hpp"

// Analysis
#include "mir/passes/analysis/domtree_analysis.hpp"
#include "mir/passes/analysis/live_analysis.hpp"

// Transforms
#include "mir/passes/transforms/const2reg.hpp"
#include "mir/passes/transforms/peephole.hpp"
#include "mir/passes/transforms/phiEliminate.hpp"
#include "mir/passes/transforms/postRAstackformat.hpp"
#include "mir/passes/transforms/preRAlegalize.hpp"
#include "mir/passes/transforms/registeralloc.hpp"
#include "mir/passes/transforms/uselessBlkEli.hpp"
#include "mir/passes/transforms/uselessMovEli.hpp"

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

    // fpm.addPass(uselessMovEli());
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