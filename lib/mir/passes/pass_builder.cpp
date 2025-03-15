#include "../../../include/mir/passes/pass_builder.hpp"
#include "../../../include/mir/passes/pass_manager.hpp"

// Analysis
#include "../../../include/mir/passes/analysis/live_analysis.hpp"
#include "../../../include/mir/passes/analysis/domtree_analysis.hpp"


// Transforms
#include "../../../include/mir/passes/transforms/peephole.hpp"
#include "../../../include/mir/passes/transforms/phiEliminate.hpp"
#include "../../../include/mir/passes/transforms/preRAlegalize.hpp"
#include "../../../include/mir/passes/transforms/registeralloc.hpp"

namespace MIR {

const OptInfo o1_opt_info = {
    .peephole = true,
};

FPM PassBuilder::buildFunctionPipeline(OptInfo opt_info) {
    FPM fpm;

    if (opt_info.peephole) {
        fpm.addPass(PeepHolePass());
    }

    fpm.addPass(PreRALegalize());

    // fpm.addPass(NeonRAPass()); // pass name 还有问题

    fpm.addPass(RAPass());
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

} // namespace MIR