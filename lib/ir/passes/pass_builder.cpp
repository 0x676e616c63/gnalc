#include "../../../include/ir/passes/pass_builder.hpp"
#include "../../../include/ir/passes/pass_manager.hpp"

// Analysis
#include "../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../include/ir/passes/analysis/live_analysis.hpp"
#include "../../../include/ir/passes/analysis/loop_analysis.hpp"

// Transforms
#include "../../../include/ir/passes/transforms/adce.hpp"
#include "../../../include/ir/passes/transforms/constant_propagation.hpp"
#include "../../../include/ir/passes/transforms/dce.hpp"
#include "../../../include/ir/passes/transforms/dse.hpp"
#include "../../../include/ir/passes/transforms/gvn_pre.hpp"
#include "../../../include/ir/passes/transforms/inline.hpp"
#include "../../../include/ir/passes/transforms/instsimplify.hpp"
#include "../../../include/ir/passes/transforms/jump_threading.hpp"
#include "../../../include/ir/passes/transforms/lcssa.hpp"
#include "../../../include/ir/passes/transforms/load_elimination.hpp"
#include "../../../include/ir/passes/transforms/loop_rotate.hpp"
#include "../../../include/ir/passes/transforms/loop_simplify.hpp"
#include "../../../include/ir/passes/transforms/loop_unroll.hpp"
#include "../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../include/ir/passes/transforms/namenormalizer.hpp"
#include "../../../include/ir/passes/transforms/reassociate.hpp"
#include "../../../include/ir/passes/transforms/tail_recursion_elimination.hpp"
#include "../../../include/ir/passes/transforms/tree_shaking.hpp"

// Utilities
#include "../../../include/ir/passes/utilities/irprinter.hpp"
#include "../../../include/ir/passes/utilities/verifier.hpp"

namespace IR {

const OptInfo o1_opt_info = {
    .mem2reg = true,
    .sccp = true,
    .dce = true,
    .adce = true,
    .dse = true,
    .gvnpre = true,
    .tailcall = true,
    .reassociate = true,
    .instsimplify = true,
    .inliner = true,
    .loop_simplify = false,
    .loop_rotate = false,
    .lcssa = false,
    .loop_unroll = false,
    .jump_threading = false,
    .verify = false,
};

FPM PassBuilder::buildFunctionPipeline(OptInfo opt_info) {
    FPM fpm;

    // ANN disables the last name normalization pass.
    fpm.addPass(NameNormalizePass(true)); // bb_rename: true

#define FUNCTION_TRANSFORM(name, pass)                                                                                 \
    if (opt_info.name) {                                                                                               \
        fpm.addPass(pass);                                                                                             \
        if (opt_info.verify)                                                                                           \
            fpm.addPass(VerifyPass(opt_info.abort_when_verify_failed));                                                \
    }

    // FUNCTION_TRANSFORM(mem2reg, PromotePass)
    // FUNCTION_TRANSFORM(inliner, InlinePass)
    // FUNCTION_TRANSFORM(tailcall, TailRecursionEliminationPass)
    // FUNCTION_TRANSFORM(sccp, ConstantPropagationPass)
    // FUNCTION_TRANSFORM(reassociate, ReassociatePass)
    // FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass)
    // FUNCTION_TRANSFORM(dce, DCEPass)
    // FUNCTION_TRANSFORM(adce, ADCEPass)
    // FUNCTION_TRANSFORM(loadelim, LoadEliminationPass)
    // FUNCTION_TRANSFORM(dse, DSEPass)
    // FUNCTION_TRANSFORM(gvnpre, GVNPREPass)

    FUNCTION_TRANSFORM(mem2reg, PromotePass())
    FUNCTION_TRANSFORM(tailcall, TailRecursionEliminationPass())
    FUNCTION_TRANSFORM(inliner, InlinePass())
    FUNCTION_TRANSFORM(sccp, ConstantPropagationPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(reassociate, ReassociatePass())
    FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass())
    FUNCTION_TRANSFORM(sccp, ConstantPropagationPass())
    FUNCTION_TRANSFORM(gvnpre, GVNPREPass())
    FUNCTION_TRANSFORM(loadelim, LoadEliminationPass())
    FUNCTION_TRANSFORM(dse, DSEPass())
    FUNCTION_TRANSFORM(loadelim, LoadEliminationPass())
    FUNCTION_TRANSFORM(dse, DSEPass())
    FUNCTION_TRANSFORM(loadelim, LoadEliminationPass())
    FUNCTION_TRANSFORM(dce, DCEPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(loop_simplify, LoopSimplifyPass())
    FUNCTION_TRANSFORM(loop_rotate, LoopRotatePass())
    FUNCTION_TRANSFORM(lcssa, LCSSAPass())
    FUNCTION_TRANSFORM(loop_unroll, LoopUnrollPass())
    FUNCTION_TRANSFORM(jump_threading, JumpThreadingPass())

#undef FUNCTION_TRANSFORM

    if (!opt_info.advance_name_norm)
        fpm.addPass(NameNormalizePass(true)); // bb_rename: true

    return fpm;
}

MPM PassBuilder::buildModulePipeline(OptInfo opt_info) {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionPipeline(opt_info)));
    mpm.addPass(TreeShakingPass());
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
    FUNCTION_ANALYSIS(AliasAnalysis())
    FUNCTION_ANALYSIS(LoopAnalysis())

#undef FUNCTION_ANALYSIS
}

void PassBuilder::registerModuleAnalyses(MAM &) {}

} // namespace IR