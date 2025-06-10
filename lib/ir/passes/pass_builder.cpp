#include "ir/passes/pass_builder.hpp"
#include "ir/passes/pass_manager.hpp"

// Analysis
#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/live_analysis.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/analysis/range_analysis.hpp"
#include "ir/passes/analysis/scev.hpp"

// Transforms
#include "ir/passes/transforms/adce.hpp"
#include "ir/passes/transforms/break_critical_edges.hpp"
#include "ir/passes/transforms/cfgsimplify.hpp"
#include "ir/passes/transforms/codegen_prepare.hpp"
#include "ir/passes/transforms/dae.hpp"
#include "ir/passes/transforms/dce.hpp"
#include "ir/passes/transforms/dse.hpp"
#include "ir/passes/transforms/gvn_pre.hpp"
#include "ir/passes/transforms/if_conversion.hpp"
#include "ir/passes/transforms/indvar_simplify.hpp"
#include "ir/passes/transforms/inline.hpp"
#include "ir/passes/transforms/instsimplify.hpp"
#include "ir/passes/transforms/internalize.hpp"
#include "ir/passes/transforms/lcssa.hpp"
#include "ir/passes/transforms/licm.hpp"
#include "ir/passes/transforms/load_elimination.hpp"
#include "ir/passes/transforms/loop_elimination.hpp"
#include "ir/passes/transforms/loop_rotate.hpp"
#include "ir/passes/transforms/loop_simplify.hpp"
#include "ir/passes/transforms/loop_strength_reduce.hpp"
#include "ir/passes/transforms/loop_unroll.hpp"
#include "ir/passes/transforms/mem2reg.hpp"
#include "ir/passes/transforms/memoization.hpp"
#include "ir/passes/transforms/namenormalizer.hpp"
#include "ir/passes/transforms/range_aware_simplify.hpp"
#include "ir/passes/transforms/reassociate.hpp"
#include "ir/passes/transforms/sccp.hpp"
#include "ir/passes/transforms/tail_recursion_elimination.hpp"
#include "ir/passes/transforms/tree_shaking.hpp"
#include "ir/passes/transforms/unify_exits.hpp"
#include "ir/passes/transforms/vectorizer.hpp"
// Utilities
#include "ir/passes/utilities/analysis_storer.hpp"
#include "ir/passes/utilities/cfg_export.hpp"
#include "ir/passes/utilities/irprinter.hpp"
#include "ir/passes/utilities/run_test.hpp"
#include "ir/passes/utilities/verifier.hpp"

#include <algorithm>
#include <functional>
#include <optional>
#include <random>
#include <string>
#include <vector>

namespace IR {

#define GNALC_IR_PASS_ENTRY(name) name(StatusType::Default),
CliOptions::CliOptions() : GNALC_IR_PASS_TABLE advance_name_norm(false), strict(false) {}
#undef GNALC_IR_PASS_ENTRY

PMOptions CliOptions::toPMOptions(Mode mode) const {
    switch (mode) {
    case Mode::DisableAnyway:
#define GNALC_IR_PASS_ENTRY(name) .name = false,
        return PMOptions{
            GNALC_IR_PASS_TABLE.strict = strict,
            .advance_name_norm = advance_name_norm,
            .testcase_in = testcase_in,
            .testcase_out = testcase_out,
        };
#undef GNALC_IR_PASS_ENTRY

    case Mode::EnableAnyway:
#define GNALC_IR_PASS_ENTRY(name) .name = true,
        return PMOptions{
            GNALC_IR_PASS_TABLE.strict = strict,
            .advance_name_norm = advance_name_norm,
            .testcase_in = testcase_in,
            .testcase_out = testcase_out,
        };
#undef GNALC_IR_PASS_ENTRY

    case Mode::EnableIfDefault:
        return {
#define GNALC_IR_PASS_ENTRY(name) .name = !(name).isDisable(),
            GNALC_IR_PASS_TABLE.strict = strict,
            .advance_name_norm = advance_name_norm,
            .testcase_in = testcase_in,
            .testcase_out = testcase_out,
        };
#undef GNALC_IR_PASS_ENTRY

    case Mode::DisableIfDefault:
        return {
#define GNALC_IR_PASS_ENTRY(name) .name = (name).isEnable(),
            GNALC_IR_PASS_TABLE.strict = strict,
            .advance_name_norm = advance_name_norm,
            .testcase_in = testcase_in,
            .testcase_out = testcase_out,
        };
#undef GNALC_IR_PASS_ENTRY
    }
    return {};
}

template <typename PM, typename Pass>
void registerPassForOptInfo(PM &fpm, bool enable, PMOptions options, Pass &&pass) {
    if (enable) {
        fpm.addPass(std::forward<Pass>(pass));
        if (options.verify)
            fpm.addPass(VerifyPass(options.strict));
        if (options.run_test)
            fpm.addPass(RunTestPass(options.testcase_out, options.testcase_in, "", options.strict));
    }
}

template <typename PM, typename First, typename... Rest>
void registerPassForOptInfo(PM &fpm, bool enable, PMOptions options, First &&first, Rest &&...rest) {
    registerPassForOptInfo(fpm, enable, options, std::forward<First>(first));
    registerPassForOptInfo(fpm, enable, options, std::forward<Rest>(rest)...);
}

FPM PassBuilder::buildFunctionFixedPointPipeline(PMOptions options) {
#define FUNCTION_TRANSFORM(name, ...) registerPassForOptInfo(fpm, options.name, options, __VA_ARGS__);

    auto make_arithmetic = [&options] {
        PM::FixedPointPM<Function> fpm(10);
        FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass());
        FUNCTION_TRANSFORM(sccp, SCCPPass());
        FUNCTION_TRANSFORM(dce, DCEPass());
        FUNCTION_TRANSFORM(adce, ADCEPass());
        return fpm;
    };

    auto make_clean = [&options] {
        auto make_basic_clean = [&options] {
            PM::FixedPointPM<Function> fpm;
            FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass());
            FUNCTION_TRANSFORM(sccp, SCCPPass());
            FUNCTION_TRANSFORM(rngsimplify, LoopSimplifyPass(), RangeAwareSimplifyPass());
            FUNCTION_TRANSFORM(gvnpre, BreakCriticalEdgesPass(), GVNPREPass());
            FUNCTION_TRANSFORM(dce, DCEPass());
            return fpm;
        };

        auto make_ipo_clean = [&options] {
            FPM fpm;
            FUNCTION_TRANSFORM(dae, LoopSimplifyPass(), DAEPass());
            return fpm;
        };

        auto make_cfg_clean = [&options] {
            PM::FixedPointPM<Function> fpm;
            FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass());
            FUNCTION_TRANSFORM(sccp, SCCPPass())
            FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
            FUNCTION_TRANSFORM(if_conversion, IfConversionPass())
            FUNCTION_TRANSFORM(adce, ADCEPass())
            return fpm;
        };

        auto make_mem_clean = [&options] {
            PM::FixedPointPM<Function> fpm;
            FUNCTION_TRANSFORM(loadelim, LoadEliminationPass());
            FUNCTION_TRANSFORM(dse, DSEPass());
            return fpm;
        };

        // Basic --> (CFG ---> Mem) ---> IPO ---> CFG
        FPM fpm;
        fpm.addPass(make_basic_clean());

        PM::FixedPointPM<Function> fixed;
        fixed.addPass(make_cfg_clean());
        fixed.addPass(make_mem_clean());

        fpm.addPass(std::move(fixed));
        fpm.addPass(make_ipo_clean());
        fpm.addPass(make_cfg_clean());
        return fpm;
    };

    auto make_enabling = [&options] {
        FPM fpm;
        FUNCTION_TRANSFORM(mem2reg, PromotePass());
        FUNCTION_TRANSFORM(tailcall, TailRecursionEliminationPass());
        FUNCTION_TRANSFORM(inliner, InlinePass());
        FUNCTION_TRANSFORM(internalize, InternalizePass());
        FUNCTION_TRANSFORM(mem2reg, PromotePass());
        FUNCTION_TRANSFORM(unify_exits, UnifyExitsPass());
        // FUNCTION_TRANSFORM(memo, MemoizePass());
        return fpm;
    };

    auto make_loop = [&options] {
        FPM fpm;
        FUNCTION_TRANSFORM(loopelim, LoopSimplifyPass(), LoopEliminationPass())
        FUNCTION_TRANSFORM(licm, LoopSimplifyPass(), LoopRotatePass(), LCSSAPass(), LICMPass())
        FUNCTION_TRANSFORM(loop_strength_reduce, LoopSimplifyPass(), LoopStrengthReducePass())
        FUNCTION_TRANSFORM(loopelim, LoopSimplifyPass(), LoopEliminationPass())
        FUNCTION_TRANSFORM(loop_unroll, CFGSimplifyPass(), LoopSimplifyPass(), LCSSAPass(), LoopUnrollPass())
        return fpm;
    };

    auto make_vectorizer = [&options] {
        FPM fpm;
        fpm.addPass(PrintFunctionPass(std::cerr));
        FUNCTION_TRANSFORM(vectorizer, LoopSimplifyPass(), VectorizerPass())
        fpm.addPass(PrintFunctionPass(std::cerr));
        return fpm;
    };

    FPM fpm;
    fpm.addPass(make_enabling());
    fpm.addPass(make_clean());
    fpm.addPass(make_arithmetic());
    fpm.addPass(make_loop());
    fpm.addPass(make_clean());
    // fpm.addPass(make_vectorizer());
    // fpm.addPass(make_clean());

    FUNCTION_TRANSFORM(store_range, LoopSimplifyPass(), StoreAnalysisPass<RangeAnalysis>())
    FUNCTION_TRANSFORM(codegen_prepare, CFGSimplifyPass(), CodeGenPreparePass())
    fpm.addPass(NameNormalizePass(true));

#undef FUNCTION_TRANSFORM
    return fpm;
}

MPM PassBuilder::buildModuleFixedPointPipeline(PMOptions options) {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionFixedPointPipeline(options)));
    if (options.tree_shaking)
        mpm.addPass(TreeShakingPass());
    return mpm;
}

FPM PassBuilder::buildFunctionPipeline(PMOptions opt_info) {
    FPM fpm;

    fpm.addPass(VerifyPass());
#define FUNCTION_TRANSFORM(name, ...) registerPassForOptInfo(fpm, opt_info.name, opt_info, __VA_ARGS__);

    FUNCTION_TRANSFORM(mem2reg, PromotePass())
    FUNCTION_TRANSFORM(tailcall, TailRecursionEliminationPass())
    FUNCTION_TRANSFORM(inliner, InlinePass())
    FUNCTION_TRANSFORM(internalize, InternalizePass(), PromotePass())
    FUNCTION_TRANSFORM(sccp, SCCPPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    // FUNCTION_TRANSFORM(reassociate, ReassociatePass())
    FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass())
    FUNCTION_TRANSFORM(sccp, SCCPPass())
    FUNCTION_TRANSFORM(rngsimplify, LoopSimplifyPass(), RangeAwareSimplifyPass())
    FUNCTION_TRANSFORM(dce, DCEPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(dae, LoopSimplifyPass(), DAEPass())
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    FUNCTION_TRANSFORM(if_conversion, IfConversionPass())
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    FUNCTION_TRANSFORM(gvnpre, BreakCriticalEdgesPass(), GVNPREPass())
    // IMPORTANT, CFGSimplify before LoadElim can shorten
    // the compile time significantly in certain cases
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    FUNCTION_TRANSFORM(loadelim, LoadEliminationPass())
    FUNCTION_TRANSFORM(dse, DSEPass())
    FUNCTION_TRANSFORM(loadelim, LoadEliminationPass())
    FUNCTION_TRANSFORM(dse, DSEPass())
    FUNCTION_TRANSFORM(loadelim, LoadEliminationPass())
    FUNCTION_TRANSFORM(dce, DCEPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(dae, LoopSimplifyPass(), DAEPass())

    // Loop
    FUNCTION_TRANSFORM(loopelim, LoopSimplifyPass(), LoopEliminationPass())
    FUNCTION_TRANSFORM(licm, LoopSimplifyPass(), LoopRotatePass(), LCSSAPass(), LICMPass())
    FUNCTION_TRANSFORM(loop_strength_reduce, LoopSimplifyPass(), LoopStrengthReducePass())
    FUNCTION_TRANSFORM(loopelim, LoopSimplifyPass(), LoopEliminationPass())
    FUNCTION_TRANSFORM(loop_unroll, CFGSimplifyPass(), LoopSimplifyPass(), LCSSAPass(), LoopUnrollPass())

    FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass())
    FUNCTION_TRANSFORM(sccp, SCCPPass())
    FUNCTION_TRANSFORM(rngsimplify, LoopSimplifyPass(), RangeAwareSimplifyPass())
    FUNCTION_TRANSFORM(dce, DCEPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(dae, LoopSimplifyPass(), DAEPass())

    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    FUNCTION_TRANSFORM(unify_exits, UnifyExitsPass())

    FUNCTION_TRANSFORM(store_range, LoopSimplifyPass(), StoreAnalysisPass<RangeAnalysis>())
    FUNCTION_TRANSFORM(codegen_prepare, CFGSimplifyPass(), CodeGenPreparePass())

#undef FUNCTION_TRANSFORM

    if (!opt_info.advance_name_norm)
        fpm.addPass(NameNormalizePass(true)); // bb_rename: true

    fpm.printPipeline();
    return fpm;
}

MPM PassBuilder::buildModulePipeline(PMOptions opt_info) {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionPipeline(opt_info)));
    if (opt_info.tree_shaking)
        mpm.addPass(TreeShakingPass());
    return mpm;
}

FPM PassBuilder::buildFunctionDebugPipeline() {
    FPM fpm;
    fpm.addPass(IR::PromotePass());
    fpm.addPass(IR::TailRecursionEliminationPass());
    fpm.addPass(IR::InlinePass());
    fpm.addPass(IR::InternalizePass());
    fpm.addPass(IR::PromotePass());
    fpm.addPass(IR::NameNormalizePass());
    fpm.addPass(IR::CFGSimplifyPass());
    fpm.addPass(IR::LoopSimplifyPass());
    fpm.addPass(IR::LCSSAPass());
    fpm.addPass(IR::LoopUnrollPass());
    fpm.addPass(IR::LoopSimplifyPass());
    fpm.addPass(IR::LoopRotatePass());
    fpm.addPass(IR::LCSSAPass());
    fpm.addPass(IR::LICMPass());
    fpm.addPass(IR::BreakCriticalEdgesPass());
    fpm.addPass(IR::GVNPREPass());
    fpm.addPass(IR::CFGSimplifyPass());
    fpm.addPass(IR::LoopSimplifyPass());
    fpm.addPass(IR::LCSSAPass());
    fpm.addPass(IR::PngCFGPass("beforeurnoll"));
    fpm.addPass(IR::LoopUnrollPass());
    fpm.addPass(IR::PngCFGPass("afterurnoll"));
    fpm.addPass(IR::RunTestPass("../test/contest/performance_rv_25/rv_h-2-03.out"));
    fpm.addPass(IR::NameNormalizePass());
    return fpm;

    // If-conversion
    // fpm.addPass(PromotePass());
    // fpm.addPass(NameNormalizePass());
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(CFGSimplifyPass());
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(IfConversionPass());
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(CFGSimplifyPass());
    // fpm.addPass(NameNormalizePass());
    // return fpm;
    // Vectorizer
    // fpm.addPass(PromotePass());
    // fpm.addPass(ConstantPropagationPass());
    // fpm.addPass(BreakCriticalEdgesPass());
    // fpm.addPass(GVNPREPass());
    // fpm.addPass(CFGSimplifyPass());
    // fpm.addPass(LoopSimplifyPass());
    // fpm.addPass(NameNormalizePass(true));
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(VectorizerPass());
    // fpm.addPass(VerifyPass());
    // fpm.addPass(DCEPass());
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(NameNormalizePass());

    // For LoopUnroll Test
    // fpm.addPass(PromotePass());
    // // fpm.addPass(InlinePass());
    // fpm.addPass(LoopSimplifyPass());
    // fpm.addPass(NameNormalizePass(true));
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(LoopRotatePass());
    // // fpm.addPass(LCSSAPass());
    // fpm.addPass(PrintSCEVPass(std::cerr));
    // // fpm.addPass(LoopUnrollPass());
    // // fpm.addPass(InstSimplifyPass());
    // // fpm.addPass(BreakCriticalEdgesPass());
    // // fpm.addPass(GVNPREPass());
    // // fpm.addPass(SCCPPass());
    // // fpm.addPass(CFGSimplifyPass());
    // // fpm.addPass(DCEPass());
    // // fpm.addPass(NameNormalizePass(true));
    // fpm.addPass(VerifyPass(true));

    // // For LoopUnroll Debug
    // fpm.addPass(PromotePass());
    // fpm.addPass(LoopSimplifyPass());
    // fpm.addPass(LoopRotatePass());
    // fpm.addPass(LCSSAPass());
    // fpm.addPass(NameNormalizePass(true));
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // // fpm.addPass(PrintSCEVPass(std::cerr));
    // fpm.addPass(LoopUnrollPass());
    // // fpm.addPass(InstSimplifyPass());
    // // fpm.addPass(BreakCriticalEdgesPass());
    // // fpm.addPass(GVNPREPass());
    // // fpm.addPass(ConstantPropagationPass());
    // // fpm.addPass(CFGSimplifyPass());
    // // fpm.addPass(PrintLoopPass(std::cout));
    // // fpm.addPass(NameNormalizePass(true));
    // fpm.addPass(VerifyPass(true));
    return fpm;
}

MPM PassBuilder::buildModuleDebugPipeline() {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionDebugPipeline()));
    return mpm;
}

FPM PassBuilder::buildFunctionFuzzTestingPipeline(PMOptions options, double duplication_rate,
                                                  const std::string &repro) {
    FPM fpm;
    if (options.mem2reg)
        fpm.addPass(PromotePass());
    if (options.tailcall)
        fpm.addPass(TailRecursionEliminationPass());
    if (options.inliner)
        fpm.addPass(InlinePass());
    if (options.internalize)
        fpm.addPass(InternalizePass());
    if (options.mem2reg)
        fpm.addPass(PromotePass());
    fpm.addPass(NameNormalizePass(true));

    // (name, adder, weight)
    std::vector<std::tuple<std::string_view, std::function<void()>, size_t>> passes;

    // FIXME, too many marcos
#define REGISTER_FUNCTION_TRANSFORM(option, pass, weight)                                                              \
    if (options.option)                                                                                                \
        passes.emplace_back(                                                                                           \
            pass::name(),                                                                                              \
            [&fpm, &options]() {                                                                                       \
                fpm.addPass(pass());                                                                                   \
                if (options.verify)                                                                                    \
                    fpm.addPass(VerifyPass(options.strict));                                         \
            },                                                                                                         \
            weight);

#define REGISTER_FUNCTION_TRANSFORM2(option, pass1, pass2, weight)                                                     \
    if (options.option)                                                                                                \
        passes.emplace_back(                                                                                           \
            pass2::name(),                                                                                             \
            [&fpm, &options]() {                                                                                       \
                fpm.addPass(pass1());                                                                                  \
                fpm.addPass(pass2());                                                                                  \
                if (options.verify)                                                                                    \
                    fpm.addPass(VerifyPass(options.strict));                                         \
            },                                                                                                         \
            weight);

#define REGISTER_FUNCTION_TRANSFORM3(option, pass1, pass2, pass3, weight)                                              \
    if (options.option)                                                                                                \
        passes.emplace_back(                                                                                           \
            pass3::name(),                                                                                             \
            [&fpm, &options]() {                                                                                       \
                fpm.addPass(pass1());                                                                                  \
                fpm.addPass(pass2());                                                                                  \
                fpm.addPass(pass3());                                                                                  \
                if (options.verify)                                                                                    \
                    fpm.addPass(VerifyPass(options.strict));                                         \
            },                                                                                                         \
            weight);

#define REGISTER_FUNCTION_TRANSFORM4(option, pass1, pass2, pass3, pass4, weight)                                       \
    if (options.option)                                                                                                \
        passes.emplace_back(                                                                                           \
            pass4::name(),                                                                                             \
            [&fpm, &options]() {                                                                                       \
                fpm.addPass(pass1());                                                                                  \
                fpm.addPass(pass2());                                                                                  \
                fpm.addPass(pass3());                                                                                  \
                fpm.addPass(pass4());                                                                                  \
                if (options.verify)                                                                                    \
                    fpm.addPass(VerifyPass(options.strict));                                         \
            },                                                                                                         \
            weight);

    // REGISTER_FUNCTION_TRANSFORM(ReassociatePass)
    REGISTER_FUNCTION_TRANSFORM(sccp, SCCPPass, 10)
    REGISTER_FUNCTION_TRANSFORM(adce, ADCEPass, 10)
    REGISTER_FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass, 10)
    REGISTER_FUNCTION_TRANSFORM(dce, DCEPass, 10)
    REGISTER_FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(gvnpre, BreakCriticalEdgesPass, GVNPREPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(loadelim, CFGSimplifyPass, LoadEliminationPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(dse, CFGSimplifyPass, DSEPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(dae, LoopSimplifyPass, DAEPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(rngsimplify, LoopSimplifyPass, RangeAwareSimplifyPass, 10)

    REGISTER_FUNCTION_TRANSFORM2(loopelim, LoopSimplifyPass, LoopEliminationPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(loop_strength_reduce, LoopSimplifyPass, LoopStrengthReducePass, 10)
    REGISTER_FUNCTION_TRANSFORM4(licm, LoopSimplifyPass, LoopRotatePass, LCSSAPass, LICMPass, 10)
    REGISTER_FUNCTION_TRANSFORM4(loop_unroll, CFGSimplifyPass, LoopSimplifyPass, LCSSAPass, LoopUnrollPass, 10)

    if (repro.empty()) {
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<size_t> distrib(0, passes.size() - 1);

        // Duplicate some passes
        auto duplicating_times = static_cast<size_t>(static_cast<double>(passes.size()) * duplication_rate);
        for (size_t i = 0; i < duplicating_times; ++i)
            passes.emplace_back(passes[distrib(gen)]);

        std::shuffle(passes.begin(), passes.end(), std::mt19937(std::random_device()()));
        std::stable_sort(passes.begin(), passes.end(),
                         [](const auto &lhs, const auto &rhs) { return std::get<2>(lhs) < std::get<2>(rhs); });

        std::string pipeline;
        for (const auto &[name, pass_adder, _w] : passes) {
            pass_adder();
            pipeline += name;
            pipeline += ", ";
        }
        if (!pipeline.empty()) {
            pipeline.pop_back();
            pipeline.pop_back();
        }

        Logger::logInfo("[FuzzTesting]: Fuzz Testing pipeline"
                        " (not real pipeline, omitted some passes for easier reproduction): '",
                        pipeline + "'. Run with '-fuzz-repro <this pipeline>' to reproduce it.");
    } else {
        auto find_pass = [&passes, &fpm](const std::string &target) -> std::optional<std::function<void()>> {
            if (target == NameNormalizePass::name()) {
                return [&fpm]() { fpm.addPass(NameNormalizePass(true)); };
            }
            if (target == PrintFunctionPass::name()) {
                return [&fpm]() { fpm.addPass(PrintFunctionPass(std::cerr)); };
            }
            if (target == PrintModulePass::name()) {
                return [&fpm]() { fpm.addPass(PrintFunctionPass(std::cerr)); };
            }

            for (const auto &[name, pass_adder, _w] : passes) {
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
                (*p)();
                curr.clear();
            } else if (ch != ' ')
                curr += ch;
        }
        auto p = find_pass(curr);
        Err::gassert(p.has_value(), "[FuzzTesting]: Unknown pass: '" + curr + "'.");
        (*p)();
        curr.clear();

        Logger::logInfo("[FuzzTesting]: Reproducing pipeline: ", repro);
    }

    if (options.unify_exits)
        fpm.addPass(UnifyExitsPass());
    if (options.codegen_prepare)
        fpm.addPass(CodeGenPreparePass());
    fpm.addPass(NameNormalizePass(true));

    Logger::logInfo("[FuzzTesting]: Full Pipeline: ");
    fpm.printPipeline();
    Logger::logInfo("[FuzzTesting]: buildFunctionDebugPipeline Helper: ");
    auto names = fpm.getPassNames();
    std::string debug_pipeline_message = "\n    FPM fpm;";
    for (const auto &name : names) {
        debug_pipeline_message += "\n    fpm.addPass(";
        debug_pipeline_message += name;
        debug_pipeline_message += "());";
    }
    debug_pipeline_message += "\n    return fpm;";
    Logger::logInfo(debug_pipeline_message);
    return fpm;
}

MPM PassBuilder::buildModuleFuzzTestingPipeline(PMOptions options, double duplication_rate, const std::string &repro) {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionFuzzTestingPipeline(options, duplication_rate, repro)));
    // Disable Treeshaking in Repro mode for debugging
    if (repro.empty() && options.tree_shaking)
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
    FUNCTION_ANALYSIS(BasicAliasAnalysis())
    FUNCTION_ANALYSIS(LoopAliasAnalysis())
    FUNCTION_ANALYSIS(LoopAnalysis())
    FUNCTION_ANALYSIS(SCEVAnalysis())
    FUNCTION_ANALYSIS(RangeAnalysis())

#undef FUNCTION_ANALYSIS
}

void PassBuilder::registerModuleAnalyses(MAM &) {}

} // namespace IR