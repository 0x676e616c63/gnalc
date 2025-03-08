#include "../../../include/ir/passes/pass_builder.hpp"
#include "../../../include/ir/passes/pass_manager.hpp"

// Analysis
#include "../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../include/ir/passes/analysis/live_analysis.hpp"
#include "../../../include/ir/passes/analysis/loop_analysis.hpp"

// Transforms
#include "../../../include/ir/passes/transforms/adce.hpp"
#include "../../../include/ir/passes/transforms/break_critical_edges.hpp"
#include "../../../include/ir/passes/transforms/cfgsimplify.hpp"
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
#include "../../../include/ir/passes/transforms/licm.hpp"
#include "../../../include/ir/passes/utilities/irprinter.hpp"
#include "../../../include/ir/passes/utilities/verifier.hpp"

#include <algorithm>
#include <random>
#include <string>
#include <vector>

namespace IR {

const OptInfo o1_opt_info = {
    // Function Transforms
    .mem2reg = true,
    .sccp = true,
    .dce = true,
    .adce = true,
    .cfgsimplify = true,
    .dse = true,
    .gvnpre = true,
    .tailcall = true,
    .reassociate = true,
    .instsimplify = true,
    .inliner = true,
    .loop_simplify = false,
    .loop_rotate = false,
    .lcssa = false,
    .licm = false,
    .loop_unroll = false,
    .jump_threading = false,
    // Module Transforms
    .tree_shaking = true,
    // Function Debug
    .verify = false,
};

FPM PassBuilder::buildFunctionFixedPointPipeline() {
    // Reassociate does not converge, set a threshold
    auto make_arithmetic = [] {
        PM::FixedPointPM<Function> arithmetic(10);
        arithmetic.addPass(ReassociatePass());
        arithmetic.addPass(InstSimplifyPass());
        arithmetic.addPass(ConstantPropagationPass());
        arithmetic.addPass(DCEPass());
        arithmetic.addPass(ADCEPass());
        return arithmetic;
    };

    auto make_clean = [] {
        PM::FixedPointPM<Function> cleanup;
        cleanup.addPass(InstSimplifyPass());
        cleanup.addPass(ConstantPropagationPass());
        cleanup.addPass(BreakCriticalEdgesPass());
        cleanup.addPass(GVNPREPass());
        cleanup.addPass(DCEPass());
        cleanup.addPass(ADCEPass());
        cleanup.addPass(LoadEliminationPass());
        cleanup.addPass(DSEPass());
        return cleanup;
    };

    auto make_ipo = [] {
        FPM ipo;
        ipo.addPass(TailRecursionEliminationPass());
        ipo.addPass(InlinePass());
        return ipo;
    };

    FPM fpm;
    fpm.addPass(NameNormalizePass(true));
    fpm.addPass(PromotePass());
    fpm.addPass(make_ipo());
    fpm.addPass(make_clean());
    fpm.addPass(make_arithmetic());
    fpm.addPass(make_clean());
    fpm.addPass(CFGSimplifyPass());
    fpm.addPass(NameNormalizePass(true));

    return fpm;
}

MPM PassBuilder::buildModuleFixedPointPipeline() {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionFixedPointPipeline()));
    mpm.addPass(TreeShakingPass());
    return mpm;
}

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

#define FUNCTION_TRANSFORM2(name, pass1, pass2)                                                                        \
    if (opt_info.name) {                                                                                               \
        fpm.addPass(pass1);                                                                                            \
        if (opt_info.verify)                                                                                           \
            fpm.addPass(VerifyPass(opt_info.abort_when_verify_failed));                                                \
        fpm.addPass(pass2);                                                                                            \
        if (opt_info.verify)                                                                                           \
            fpm.addPass(VerifyPass(opt_info.abort_when_verify_failed));                                                \
    }

    FUNCTION_TRANSFORM(mem2reg, PromotePass())
    FUNCTION_TRANSFORM(tailcall, TailRecursionEliminationPass())
    FUNCTION_TRANSFORM(inliner, InlinePass())
    // FIXME: bug here
    FUNCTION_TRANSFORM(reassociate, ReassociatePass())
    FUNCTION_TRANSFORM(sccp, ConstantPropagationPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(reassociate, ReassociatePass())
    FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass())
    FUNCTION_TRANSFORM(sccp, ConstantPropagationPass())
    FUNCTION_TRANSFORM(dce, DCEPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    FUNCTION_TRANSFORM2(gvnpre, BreakCriticalEdgesPass(), GVNPREPass())
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
    FUNCTION_TRANSFORM(licm, LICMPass())
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
    if (opt_info.tree_shaking)
        mpm.addPass(TreeShakingPass());
    return mpm;
}

FPM PassBuilder::buildFunctionFuzzTestingPipeline() {
    FPM fpm;
    fpm.addPass(PromotePass());
    fpm.addPass(NameNormalizePass(true));
    std::vector<std::function<std::string_view()>> passes;

#define REGISTER_FUNCTION_TRANSFORM(pass)                                                                              \
    passes.emplace_back([&fpm] {                                                                                       \
        fpm.addPass(pass());                                                                                           \
        fpm.addPass(VerifyPass(true));                                                                                 \
        return pass::name();                                                                                           \
    });

#define REGISTER_FUNCTION_TRANSFORM2(pass1, pass2)                                                                     \
    passes.emplace_back([&fpm] {                                                                                       \
        fpm.addPass(pass1());                                                                                          \
        fpm.addPass(pass2());                                                                                          \
        fpm.addPass(VerifyPass(true));                                                                                 \
        return pass2::name();                                                                                          \
    });

    REGISTER_FUNCTION_TRANSFORM(TailRecursionEliminationPass)
    REGISTER_FUNCTION_TRANSFORM(InlinePass)
    REGISTER_FUNCTION_TRANSFORM(ReassociatePass)
    REGISTER_FUNCTION_TRANSFORM(ConstantPropagationPass)
    REGISTER_FUNCTION_TRANSFORM(ADCEPass)
    REGISTER_FUNCTION_TRANSFORM(InstSimplifyPass)
    REGISTER_FUNCTION_TRANSFORM(DCEPass)
    REGISTER_FUNCTION_TRANSFORM(CFGSimplifyPass)
    REGISTER_FUNCTION_TRANSFORM2(BreakCriticalEdgesPass, GVNPREPass)
    REGISTER_FUNCTION_TRANSFORM(LoadEliminationPass)
    REGISTER_FUNCTION_TRANSFORM(DSEPass)
    // REGISTER_FUNCTION_TRANSFORM(LoopSimplifyPass)
    // REGISTER_FUNCTION_TRANSFORM(LoopRotatePass)
    // REGISTER_FUNCTION_TRANSFORM(LCSSAPass)
    // REGISTER_FUNCTION_TRANSFORM(LICMPass)
    // REGISTER_FUNCTION_TRANSFORM(LoopUnrollPass)
    // REGISTER_FUNCTION_TRANSFORM(JumpThreadingPass)

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<size_t> distrib(0, passes.size() - 1);

    // Duplicate some passes
    auto duplicating_times = passes.size() * 2;
    for (size_t i = 0; i < duplicating_times; ++i)
        passes.emplace_back(passes[distrib(gen)]);

    std::shuffle(passes.begin(), passes.end(), std::mt19937(std::random_device()()));
    std::string pipeline;
    for (auto &add_pass : passes) {
        std::string name{ add_pass() };
        pipeline += name + ", ";
    }
    if (!pipeline.empty()) {
        pipeline.pop_back();
        pipeline.pop_back();
    }

    Logger::logInfo("[FuzzTesting]: Running pipeline: ", pipeline);

    fpm.addPass(NameNormalizePass(true));
    return fpm;
}

MPM PassBuilder::buildModuleFuzzTestingPipeline() {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionFuzzTestingPipeline()));
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