#include "../../include/passes/pass_manager.hpp"
#include "../../include/passes/pass_builder.hpp"

// Analysis
#include "../../include/passes/analysis/live_analysis.hpp"

// Transforms
#include "../../include/passes/transforms/cfgbuilder.hpp"
#include "../../include/passes/transforms/mem2reg.hpp"
#include "../../include/passes/transforms/namenormalizer.hpp"

// Utilities
#include "../../include/passes/utilities/irprinter.hpp"

namespace IR {

const OptInfo o1_opt_info = {
    .mem2reg = true,
};

FunctionPassManager PassBuilder::buildFunctionPipeline(OptInfo opt_info) {
    FunctionPassManager fpm;

    fpm.addPass(BuildCFGPass());

    if (opt_info.mem2reg) {
        fpm.addPass(PromotePass());
    }

    fpm.addPass(NameNormalizePass(true)); // bb_rename: true

    return fpm;
}

void PassBuilder::registerFunctionAnalyses(FunctionAnalysisManager& fam) {
#define FUNCTION_ANALYSIS(CREATE_PASS) fam.registerPass([&] { return CREATE_PASS; });

    FUNCTION_ANALYSIS(LiveAnalyser())
    // ...

#undef FUNCTION_ANALYSIS
}
} // namespace IR