#include "../../../include/ir/passes/pass_builder.hpp"
#include "../../../include/ir/passes/pass_manager.hpp"

// Analysis
#include "../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../include/ir/passes/analysis/live_analysis.hpp"
#include "../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../include/ir/passes/analysis/scev.hpp"

// Transforms
#include "../../../include/ir/passes/transforms/adce.hpp"
#include "../../../include/ir/passes/transforms/break_critical_edges.hpp"
#include "../../../include/ir/passes/transforms/cfgsimplify.hpp"
#include "../../../include/ir/passes/transforms/codegen_prepare.hpp"
#include "../../../include/ir/passes/transforms/constant_propagation.hpp"
#include "../../../include/ir/passes/transforms/dce.hpp"
#include "../../../include/ir/passes/transforms/dse.hpp"
#include "../../../include/ir/passes/transforms/gvn_pre.hpp"
#include "../../../include/ir/passes/transforms/indvar_simplify.hpp"
#include "../../../include/ir/passes/transforms/inline.hpp"
#include "../../../include/ir/passes/transforms/instsimplify.hpp"
#include "../../../include/ir/passes/transforms/jump_threading.hpp"
#include "../../../include/ir/passes/transforms/lcssa.hpp"
#include "../../../include/ir/passes/transforms/licm.hpp"
#include "../../../include/ir/passes/transforms/load_elimination.hpp"
#include "../../../include/ir/passes/transforms/loop_rotate.hpp"
#include "../../../include/ir/passes/transforms/loop_simplify.hpp"
#include "../../../include/ir/passes/transforms/loop_strength_reduce.hpp"
#include "../../../include/ir/passes/transforms/loop_unroll.hpp"
#include "../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../include/ir/passes/transforms/namenormalizer.hpp"
#include "../../../include/ir/passes/transforms/reassociate.hpp"
#include "../../../include/ir/passes/transforms/tail_recursion_elimination.hpp"
#include "../../../include/ir/passes/transforms/tree_shaking.hpp"

// Utilities
#include "../../../include/ir/passes/utilities/irprinter.hpp"
#include "../../../include/ir/passes/utilities/verifier.hpp"

#include <algorithm>
#include <functional>
#include <optional>
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
    .indvars = false,
    .loop_strength_reduce = false,
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
    fpm.addPass(CFGSimplifyPass());
    fpm.addPass(make_clean());
    fpm.addPass(CFGSimplifyPass());
    fpm.addPass(CodeGenPreparePass());
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
    FUNCTION_TRANSFORM(indvars, IndVarSimplifyPass())
    FUNCTION_TRANSFORM(loop_strength_reduce, LoopStrengthReducePass())
    FUNCTION_TRANSFORM(jump_threading, JumpThreadingPass())

#undef FUNCTION_TRANSFORM

    fpm.addPass(CodeGenPreparePass());
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

FPM PassBuilder::buildFunctionDebugPipeline() {
    FPM fpm;
    fpm.addPass(PromotePass());
    fpm.addPass(LoopSimplifyPass());
    fpm.addPass(NameNormalizePass(true));
    fpm.addPass(PrintSCEVPass(std::cerr));
    fpm.addPass(LoopStrengthReducePass());
    fpm.addPass(VerifyPass(true));

    // // For LoopUnroll Test
    // fpm.addPass(PromotePass());
    // fpm.addPass(LoopSimplifyPass());
    // fpm.addPass(LoopRotatePass());
    // fpm.addPass(LCSSAPass());
    // fpm.addPass(NameNormalizePass(true));
    // fpm.addPass(LoopUnrollPass());
    // fpm.addPass(InstSimplifyPass());
    // fpm.addPass(BreakCriticalEdgesPass());
    // fpm.addPass(GVNPREPass());
    // fpm.addPass(ConstantPropagationPass());
    // fpm.addPass(CFGSimplifyPass());
    // fpm.addPass(PrintLoopPass(std::cout));
    // fpm.addPass(VerifyPass(true));
    return fpm;
}

MPM PassBuilder::buildModuleDebugPipeline() {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionDebugPipeline()));
    return mpm;
}

FPM PassBuilder::buildFunctionFuzzTestingPipeline(double duplication_rate, const std::string &repro) {
    FPM fpm;
    fpm.addPass(PromotePass());
    fpm.addPass(TailRecursionEliminationPass());
    fpm.addPass(InlinePass());
    fpm.addPass(NameNormalizePass(true));
    std::vector<std::pair<std::string_view, std::function<void(bool)>>> passes;

#define REGISTER_FUNCTION_TRANSFORM(pass)                                                                              \
    passes.emplace_back(pass::name(), [&fpm](bool strict) {                                                            \
        fpm.addPass(pass());                                                                                           \
        fpm.addPass(VerifyPass(strict));                                                                               \
    });

#define REGISTER_FUNCTION_TRANSFORM2(pass1, pass2)                                                                     \
    passes.emplace_back(pass2::name(), [&fpm](bool strict) {                                                           \
        fpm.addPass(pass1());                                                                                          \
        fpm.addPass(pass2());                                                                                          \
        fpm.addPass(VerifyPass(strict));                                                                               \
    });

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

    if (repro.empty()) {
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<size_t> distrib(0, passes.size() - 1);

        // Duplicate some passes
        auto duplicating_times = static_cast<size_t>(static_cast<double>(passes.size()) * duplication_rate);
        for (size_t i = 0; i < duplicating_times; ++i)
            passes.emplace_back(passes[distrib(gen)]);

        std::shuffle(passes.begin(), passes.end(), std::mt19937(std::random_device()()));
        std::string pipeline;
        for (const auto &[name, pass_adder] : passes) {
            pass_adder(true);
            pipeline += name;
            pipeline += ", ";
        }
        if (!pipeline.empty()) {
            pipeline.pop_back();
            pipeline.pop_back();
        }
        fpm.addPass(CodeGenPreparePass());
        fpm.addPass(NameNormalizePass(true));

        Logger::logInfo("[FuzzTesting]: Running pipeline: '",
                        pipeline + "'. Run with '-fuzz-repro <this pipeline>' to reproduce it.");
    } else {
        auto find_pass = [&passes, &fpm](const std::string &target) -> std::optional<std::function<void(bool)>> {
            if (target == NameNormalizePass::name()) {
                return [&fpm](bool) { fpm.addPass(NameNormalizePass(true)); };
            }
            if (target == PrintFunctionPass::name()) {
                return [&fpm](bool) { fpm.addPass(PrintFunctionPass(std::cerr)); };
            }
            if (target == PrintModulePass::name()) {
                return [&fpm](bool) { fpm.addPass(PrintFunctionPass(std::cerr)); };
            }

            for (const auto &[name, pass_adder] : passes) {
                if (target == name)
                    return pass_adder;
            }
            return std::nullopt;
        };
        std::string curr;
        for (auto ch : repro) {
            if (ch == ',') {
                auto p = find_pass(curr);
                Err::gassert(p.has_value(), "[FuzzTesting]: Unknown pass: '" + curr + "'.");
                // Disable strict mode for debugging
                (*p)(false);
                curr.clear();
            } else if (ch != ' ')
                curr += ch;
        }
        auto p = find_pass(curr);
        Err::gassert(p.has_value(), "[FuzzTesting]: Unknown pass: '" + curr + "'.");
        (*p)(false);
        curr.clear();

        // fpm.addPass(NameNormalizePass(true));

        Logger::logInfo("[FuzzTesting]: Reproducing pipeline: ", repro);
    }
    return fpm;
}

MPM PassBuilder::buildModuleFuzzTestingPipeline(double duplication_rate, const std::string &repro) {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionFuzzTestingPipeline(duplication_rate, repro)));
    // Disable Treeshaking in Repro mode for debugging
    if (repro.empty())
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
    FUNCTION_ANALYSIS(SCEVAnalysis())

#undef FUNCTION_ANALYSIS
}

void PassBuilder::registerModuleAnalyses(MAM &) {}

} // namespace IR