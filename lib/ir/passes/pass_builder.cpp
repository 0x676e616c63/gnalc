#include "../../../include/ir/passes/pass_builder.hpp"
#include "../../../include/ir/passes/pass_manager.hpp"

// Analysis
#include "../../../include/ir/passes/analysis/live_analysis.hpp"
#include "../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../include/ir/passes/analysis/domtree_analysis.hpp"

// Transforms
#include "../../../include/ir/passes/transforms/adce.hpp"
#include "../../../include/ir/passes/transforms/break_critical_edges.hpp"
#include "../../../include/ir/passes/transforms/constant_propagation.hpp"
#include "../../../include/ir/passes/transforms/dce.hpp"
#include "../../../include/ir/passes/transforms/dse.hpp"
#include "../../../include/ir/passes/transforms/gvn_pre.hpp"
#include "../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../include/ir/passes/transforms/namenormalizer.hpp"
#include "../../../include/ir/passes/transforms/mark_tail_call.hpp"

// Utilities
#include "../../../include/ir/passes/utilities/irprinter.hpp"

namespace IR {

const OptInfo o1_opt_info = {
    .mem2reg = true,
    .sccp = true,
    .dce = true,
    .adce = true,
    .dse = true,
    .gvnpre = true,
    .tailcall = true,
};

FPM PassBuilder::buildFunctionPipeline(OptInfo opt_info) {
    FPM fpm;

    if (opt_info.advance_name_norm)
        fpm.addPass(NameNormalizePass(true)); // bb_rename: true

    if (opt_info.mem2reg)
        fpm.addPass(PromotePass(opt_info.advance_name_norm));

    if (opt_info.sccp)
        fpm.addPass(ConstantPropagationPass());

    if (opt_info.dce)
        fpm.addPass(DCEPass());

    if (opt_info.adce)
        fpm.addPass(ADCEPass());

    if (opt_info.dse)
        fpm.addPass(DSEPass());

    if (opt_info.gvnpre)
        fpm.addPass(GVNPREPass());

    if (opt_info.tailcall)
        fpm.addPass(MarkTailCallPass());

    fpm.addPass(NameNormalizePass(true)); // bb_rename: true

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
#define FUNCTION_ANALYSIS(CREATE_PASS)                                         \
    fam.registerPass([&] { return CREATE_PASS; });

    FUNCTION_ANALYSIS(LiveAnalysis())
    FUNCTION_ANALYSIS(DomTreeAnalysis())
    FUNCTION_ANALYSIS(PostDomTreeAnalysis())
    FUNCTION_ANALYSIS(AliasAnalysis())

#undef FUNCTION_ANALYSIS
}

void PassBuilder::registerModuleAnalyses(MAM &) {}

} // namespace IR