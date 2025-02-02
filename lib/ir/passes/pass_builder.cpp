#include "../../../include/ir/passes/pass_builder.hpp"
#include "../../../include/ir/passes/pass_manager.hpp"

// Analysis
#include "../../../include/ir/passes/analysis/live_analysis.hpp"

// Transforms
#include "../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../include/ir/passes/transforms/namenormalizer.hpp"

// Utilities
#include "../../../include/ir/passes/utilities/irprinter.hpp"

namespace IR {

const OptInfo o1_opt_info = {
    .mem2reg = true,
};

FPM PassBuilder::buildFunctionPipeline(OptInfo opt_info) {
    FPM fpm;

    if (opt_info.mem2reg) {
        // fpm.addPass(PromotePass());
    }

    fpm.addPass(NameNormalizePass(true)); // bb_rename: true

    return fpm;
}

MPM PassBuilder::buildModulePipeline(OptInfo opt_info) {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionPipeline(opt_info)));
    return mpm;
}

std::tuple<FAM, MAM> PassBuilder::buildAnalysisManager() {
    FAM fam;
    MAM mam;
    registerFunctionAnalyses(fam);
    registerModuleAnalyses(mam);
    registerProxies(fam, mam);
    return {std::move(fam), std::move(mam)};
}

void PassBuilder::registerProxies(FAM &fam, MAM &mam) {
    mam.registerPass([&] { return FAMProxy(fam); });
}

void PassBuilder::registerFunctionAnalyses(FAM &fam) {
#define FUNCTION_ANALYSIS(CREATE_PASS)                                         \
    fam.registerPass([&] { return CREATE_PASS; });

    FUNCTION_ANALYSIS(LiveAnalyser())
    // ...

#undef FUNCTION_ANALYSIS
}

void PassBuilder::registerModuleAnalyses(MAM &) {}

} // namespace IR