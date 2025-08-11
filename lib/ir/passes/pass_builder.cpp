// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

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
#include "ir/passes/analysis/target_analysis.hpp"

// Transforms
#include "ir/passes/transforms/adce.hpp"
#include "ir/passes/transforms/break_critical_edges.hpp"
#include "ir/passes/transforms/cfgsimplify.hpp"
#include "ir/passes/transforms/code_sink.hpp"
#include "ir/passes/transforms/codegen_prepare.hpp"
#include "ir/passes/transforms/dae.hpp"
#include "ir/passes/transforms/dce.hpp"
#include "ir/passes/transforms/dse.hpp"
#include "ir/passes/transforms/function_specialization.hpp"
#include "ir/passes/transforms/gep_flatten.hpp"
#include "ir/passes/transforms/globalize.hpp"
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
#include "ir/passes/transforms/loop_parallel.hpp"
#include "ir/passes/transforms/loop_rotate.hpp"
#include "ir/passes/transforms/loop_simplify.hpp"
#include "ir/passes/transforms/loop_strength_reduce.hpp"
#include "ir/passes/transforms/loop_unroll.hpp"
#include "ir/passes/transforms/lower_intrinsics.hpp"
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
#include "ir/passes/utilities/trace.hpp"
#include "ir/passes/utilities/verifier.hpp"

// Target
#include "ir/target/armv7.hpp"
#include "ir/target/armv8.hpp"
#include "ir/target/brainfk.hpp"
#include "ir/target/riscv64.hpp"

#include <algorithm>
#include <functional>
#include <optional>
#include <random>
#include <string>
#include <vector>

namespace IR {

#define GNALC_SIR_IR_PASS_ENTRY(name) name(StatusType::Default),
CliOptions::CliOptions() : GNALC_SIR_IR_PASS_TABLE advance_name_norm(false), strict(false) {}
#undef GNALC_SIR_IR_PASS_ENTRY

PMOptions CliOptions::toPMOptions(Mode mode) const {
    switch (mode) {
    case Mode::DisableAnyway:
#define GNALC_SIR_IR_PASS_ENTRY(name) .name = false,
        return PMOptions{
            GNALC_SIR_IR_PASS_TABLE.strict = strict,
            .advance_name_norm = advance_name_norm,
            .testcase_in = testcase_in,
            .testcase_out = testcase_out,
        };
#undef GNALC_SIR_IR_PASS_ENTRY

    case Mode::EnableAnyway:
#define GNALC_SIR_IR_PASS_ENTRY(name) .name = true,
        return PMOptions{
            GNALC_SIR_IR_PASS_TABLE.strict = strict,
            .advance_name_norm = advance_name_norm,
            .testcase_in = testcase_in,
            .testcase_out = testcase_out,
        };
#undef GNALC_SIR_IR_PASS_ENTRY

    case Mode::EnableIfDefault:
        return {
#define GNALC_SIR_IR_PASS_ENTRY(name) .name = !(name).isDisable(),
            GNALC_SIR_IR_PASS_TABLE.strict = strict,
            .advance_name_norm = advance_name_norm,
            .testcase_in = testcase_in,
            .testcase_out = testcase_out,
        };
#undef GNALC_SIR_IR_PASS_ENTRY

    case Mode::DisableIfDefault:
        return {
#define GNALC_SIR_IR_PASS_ENTRY(name) .name = (name).isEnable(),
            GNALC_SIR_IR_PASS_TABLE.strict = strict,
            .advance_name_norm = advance_name_norm,
            .testcase_in = testcase_in,
            .testcase_out = testcase_out,
        };
#undef GNALC_SIR_IR_PASS_ENTRY
    }
    return {};
}

template <typename PM, typename Pass>
void registerPassForOptInfo(PM &fpm, bool enable, const PMOptions &options, Pass &&pass) {
    if (enable) {
        fpm.addPass(std::forward<Pass>(pass));
        if (options.verify)
            fpm.addPass(VerifyPass(options.strict));
        if (options.run_test)
            fpm.addPass(
                RunTestPass(options.testcase_out, options.testcase_in, "../../test/sylib/sylib.c", options.strict));
    }
}

template <typename PM, typename First, typename... Rest>
void registerPassForOptInfo(PM &fpm, bool enable, const PMOptions &options, First &&first, Rest &&...rest) {
    registerPassForOptInfo(fpm, enable, options, std::forward<First>(first));
    registerPassForOptInfo(fpm, enable, options, std::forward<Rest>(rest)...);
}

#define FUNCTION_TRANSFORM(name, ...) registerPassForOptInfo(fpm, options.name, options, __VA_ARGS__);

auto make_basic_clean(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass());
    FUNCTION_TRANSFORM(dce, DCEPass());
    FUNCTION_TRANSFORM(sccp, SCCPPass());
    FUNCTION_TRANSFORM(rngsimplify, LoopSimplifyPass(), RangeAwareSimplifyPass());
    FUNCTION_TRANSFORM(gvnpre, BreakCriticalEdgesPass(), GVNPREPass());
    FUNCTION_TRANSFORM(dce, DCEPass());
    return fpm;
}

auto make_cfg_clean(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass());
    FUNCTION_TRANSFORM(dce, DCEPass());
    FUNCTION_TRANSFORM(if_conversion, IfConversionPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    return fpm;
}

auto make_mem_clean(const PMOptions &options) {
    PM::FixedPointPM<Function> fpm;
    // fpm.addPass(PrintFunctionPass(std::cerr));
    FUNCTION_TRANSFORM(loadelim, LoadEliminationPass());
    FUNCTION_TRANSFORM(dse, DSEPass());
    return fpm;
}

auto make_arithmetic(const PMOptions &options) {
    FPM fpm;

    FUNCTION_TRANSFORM(reassociate, ReassociatePass());
    FUNCTION_TRANSFORM(dce, DCEPass());

    return fpm;
}

auto make_deep_clean(const PMOptions &options) {
    FPM fpm;
    fpm.addPass(make_basic_clean(options));
    fpm.addPass(make_cfg_clean(options));
    fpm.addPass(make_mem_clean(options));
    fpm.addPass(make_basic_clean(options));
    fpm.addPass(make_cfg_clean(options));
    return fpm;
}

auto make_fast_clean(const PMOptions &options) {
    FPM fpm;
    fpm.addPass(make_basic_clean(options));
    fpm.addPass(make_cfg_clean(options));
    return fpm;
}

auto make_memo(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(dae, LoopSimplifyPass(), DAEPass());
    FUNCTION_TRANSFORM(unify_exits, UnifyExitsPass());
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass());
    FUNCTION_TRANSFORM(memo, MemoizePass());
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass());
    return fpm;
}

auto make_enabling(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(mem2reg, PromotePass());
    FUNCTION_TRANSFORM(tailcall, TailRecursionEliminationPass());
    FUNCTION_TRANSFORM(inliner, InlinePass());
    FUNCTION_TRANSFORM(func_spec, FunctionSpecializationPass());
    FUNCTION_TRANSFORM(internalize, InternalizePass());
    FUNCTION_TRANSFORM(mem2reg, PromotePass());
    return fpm;
}

auto make_loop(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(licm, LoopSimplifyPass(), LCSSAPass(), LICMPass())
    FUNCTION_TRANSFORM(loopelim, LoopSimplifyPass(), LoopEliminationPass())
    FUNCTION_TRANSFORM(loop_parallel, LoopSimplifyPass(), LoopParallelPass())
    FUNCTION_TRANSFORM(licm, LoopSimplifyPass(), LoopRotatePass(), LCSSAPass(), LICMPass())
    FUNCTION_TRANSFORM(loop_strength_reduce, LoopSimplifyPass(), LoopStrengthReducePass())
    FUNCTION_TRANSFORM(loopelim, LoopSimplifyPass(), LoopEliminationPass())
    FUNCTION_TRANSFORM(loop_unroll, CFGSimplifyPass(), LoopSimplifyPass(), LCSSAPass(),
                       LoopUnrollPass(LoopUnrollPass::PO_Peel))
    FUNCTION_TRANSFORM(rngsimplify, LoopSimplifyPass(), RangeAwareSimplifyPass())
    FUNCTION_TRANSFORM(adce, CFGSimplifyPass(), ADCEPass())
    FUNCTION_TRANSFORM(loop_unroll, CFGSimplifyPass(), LoopSimplifyPass(), LCSSAPass(),
                       LoopUnrollPass(LoopUnrollPass::PO_Unroll))
    return fpm;
}

auto make_debug_version_vectorizer(const PMOptions &options) {
    FPM fpm;
    fpm.addPass(LoopSimplifyPass());
    fpm.addPass(NameNormalizePass(true));
    fpm.addPass(PrintFunctionPass(std::cerr));
    fpm.addPass(PrintSCEVPass(std::cerr));
    fpm.addPass(PrintLoopAAPass(std::cerr));
    fpm.addPass(VectorizerPass(true));
    fpm.addPass(PrintFunctionPass(std::cerr));
    return fpm;
}

auto make_vectorizer(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(vectorizer, LoopSimplifyPass(), VectorizerPass())
    return fpm;
}

auto make_pre_canonicalize(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(mem2reg, PromotePass())
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    FUNCTION_TRANSFORM(sccp, SCCPPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(gvnpre, BreakCriticalEdgesPass(), GVNPREPass())
    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    return fpm;
}

auto make_post_legalize(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(globalize, GlobalizePass())
    FUNCTION_TRANSFORM(codegen_prepare, CodeGenPreparePass())

    if (!options.advance_name_norm)
        fpm.addPass(NameNormalizePass());

    return fpm;
}

auto make_gep_opt(const PMOptions &options) {
    FPM fpm;
    FUNCTION_TRANSFORM(gep_flatten, GEPFlattenPass())
    fpm.addPass(make_basic_clean(options));
    fpm.addPass(make_cfg_clean(options));
    fpm.addPass(make_arithmetic(options));
    FUNCTION_TRANSFORM(licm, LoopSimplifyPass(), LCSSAPass(), LICMPass())
    FUNCTION_TRANSFORM(loop_strength_reduce, LoopSimplifyPass(), LoopStrengthReducePass())
    fpm.addPass(make_basic_clean(options));
    fpm.addPass(make_cfg_clean(options));
    fpm.addPass(NameNormalizePass(true));
    return fpm;
}

FPM PassBuilder::buildFunctionFixedPointPipeline(const PMOptions &options) {
    FPM fpm;
    if (options.advance_name_norm)
        fpm.addPass(NameNormalizePass());

    fpm.addPass(make_enabling(options));
    fpm.addPass(make_deep_clean(options));
    fpm.addPass(make_memo(options));
    fpm.addPass(make_arithmetic(options));
    fpm.addPass(make_loop(options));
    // Loop pass can expose many optimization opportunities
    fpm.addPass(make_deep_clean(options));
    fpm.addPass(make_vectorizer(options));
    fpm.addPass(make_fast_clean(options));

    // Sink can cause more register spill. Though I have no idea why.
    // FUNCTION_TRANSFORM(code_sink, CodeSinkPass())

    // Note:
    // `--ann` moved to make_post_legalize()


    return fpm;
}

#undef FUNCTION_TRANSFORM

MPM PassBuilder::buildModuleFixedPointPipeline(const PMOptions &options) {
    MPM mpm;
    // mpm.addPass(makeModulePass(make_pre_canonicalize(options)));
    mpm.addPass(makeModulePass(buildFunctionFixedPointPipeline(options)));
    mpm.addPass(makeModulePass(make_post_legalize(options)));
    // mpm.addPass(makeModulePass(make_gep_opt(options)));
    if (options.tree_shaking)
        mpm.addPass(TreeShakingPass());

    mpm.addPass(LowerIntrinsicsPass());
    return mpm;
}

FPM PassBuilder::buildFunctionPipeline(const PMOptions &options) {
    FPM fpm;

    fpm.addPass(VerifyPass());
#define FUNCTION_TRANSFORM(name, ...) registerPassForOptInfo(fpm, options.name, options, __VA_ARGS__);

    FUNCTION_TRANSFORM(mem2reg, PromotePass())
    FUNCTION_TRANSFORM(tailcall, TailRecursionEliminationPass())
    FUNCTION_TRANSFORM(inliner, InlinePass())
    FUNCTION_TRANSFORM(internalize, InternalizePass(), PromotePass())
    FUNCTION_TRANSFORM(sccp, SCCPPass())
    FUNCTION_TRANSFORM(dce, ADCEPass())
    FUNCTION_TRANSFORM(reassociate, ReassociatePass())
    FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass())
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
    FUNCTION_TRANSFORM(adce, ADCEPass())

    // Loop
    FUNCTION_TRANSFORM(licm, LoopSimplifyPass(), LoopRotatePass(), LCSSAPass(), LICMPass())
    FUNCTION_TRANSFORM(loop_strength_reduce, LoopSimplifyPass(), LoopStrengthReducePass())

    FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass())
    FUNCTION_TRANSFORM(sccp, SCCPPass())
    FUNCTION_TRANSFORM(adce, ADCEPass())
    FUNCTION_TRANSFORM(dae, LoopSimplifyPass(), DAEPass())

    FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass())
    FUNCTION_TRANSFORM(unify_exits, UnifyExitsPass())

    // FUNCTION_TRANSFORM(store_range, LoopSimplifyPass(), StoreAnalysisPass<RangeAnalysis>())
    FUNCTION_TRANSFORM(codegen_prepare, CFGSimplifyPass(), CodeGenPreparePass())

#undef FUNCTION_TRANSFORM

    if (!options.advance_name_norm)
        fpm.addPass(NameNormalizePass(true)); // bb_rename: true

    fpm.printPipeline();
    return fpm;
}

MPM PassBuilder::buildModulePipeline(const PMOptions &options) {
    MPM mpm;
    // Shake off SIR inlined functions
    if (options.tree_shaking)
        mpm.addPass(TreeShakingPass());

    mpm.addPass(makeModulePass(buildFunctionPipeline(options)));
    if (options.tree_shaking)
        mpm.addPass(TreeShakingPass());
    mpm.addPass(LowerIntrinsicsPass());
    return mpm;
}

FPM PassBuilder::buildFunctionDebugPipeline() {
    // For SIR pass debug
    FPM fpm;
    fpm.addPass(VerifyPass());
    fpm.addPass(PromotePass());
    fpm.addPass(PrintFunctionPass(std::cerr));
    fpm.addPass(NameNormalizePass(true));
    return fpm;
    // // Parallel
    // FPM fpm;
    // fpm.addPass(VerifyPass());
    // fpm.addPass(PromotePass());
    // fpm.addPass(SCCPPass());
    // fpm.addPass(BreakCriticalEdgesPass());
    // fpm.addPass(GVNPREPass());
    // fpm.addPass(CFGSimplifyPass());
    // //
    // // fpm.addPass(LoopSimplifyPass());
    // // fpm.addPass(LCSSAPass());
    // // fpm.addPass(LoopUnrollPass());
    // // fpm.addPass(CFGSimplifyPass());
    // // fpm.addPass(BreakCriticalEdgesPass());
    // // fpm.addPass(GVNPREPass());

    // fpm.addPass(ADCEPass());
    // fpm.addPass(CFGSimplifyPass());
    // fpm.addPass(SCCPPass());
    // fpm.addPass(ADCEPass());
    // fpm.addPass(CFGSimplifyPass());

    // fpm.addPass(LoopSimplifyPass());
    // fpm.addPass(LCSSAPass());
    // fpm.addPass(LICMPass());
    // fpm.addPass(NameNormalizePass(true));
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(LoopParallelPass());
    // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(VerifyPass());
    // fpm.addPass(DCEPass());
    // fpm.addPass(NameNormalizePass());

    // return fpm;

    // // For LoopUnroll Test
    // fpm.addPass(PromotePass());
    // // fpm.addPass(CFGSimplifyPass());
    // // fpm.addPass(PrintFunctionPass(std::cerr));
    // // fpm.addPass(InlinePass());
    // fpm.addPass(LoopSimplifyPass());
    // // fpm.addPass(NameNormalizePass(true));
    // // fpm.addPass(PrintFunctionPass(std::cerr));
    // fpm.addPass(LoopRotatePass());
    // fpm.addPass(LCSSAPass());
    // // fpm.addPass(PrintSCEVPass(std::cerr));
    // fpm.addPass(LoopUnrollPass());
    // fpm.addPass(InstSimplifyPass());
    // fpm.addPass(BreakCriticalEdgesPass());
    // fpm.addPass(GVNPREPass());
    // fpm.addPass(CFGSimplifyPass());
    // fpm.addPass(DCEPass());
    // fpm.addPass(SCCPPass());
    // // fpm.addPass(LoopSimplifyPass());
    //
    // // fpm.addPass(LoopRotatePass());
    // // fpm.addPass(LCSSAPass());
    // // fpm.addPass(PrintFunctionPass(std::cerr));
    // // fpm.addPass(LoopUnrollPass());
    // // fpm.addPass(InstSimplifyPass());
    // // fpm.addPass(BreakCriticalEdgesPass());
    // // fpm.addPass(GVNPREPass());
    // // fpm.addPass(CFGSimplifyPass());
    // // fpm.addPass(DCEPass());
    // // fpm.addPass(SCCPPass());
    // // fpm.addPass(LoopSimplifyPass());
    //
    // fpm.addPass(PngCFGPass("../cfg"));
    // fpm.addPass(NameNormalizePass(true));
    // fpm.addPass(RunTestPass("../test/contest/functional/87_many_params.out"));
    // fpm.addPass(VerifyPass(true));
    //
    // fpm.addPass(IR::PromotePass());
    // fpm.addPass(IR::InlinePass());
    // fpm.addPass(IR::NameNormalizePass());
    // fpm.addPass(IR::VerifyPass());
    // fpm.addPass(IR::DCEPass());
    // fpm.addPass(IR::CFGSimplifyPass());
    // fpm.addPass(IR::LoopSimplifyPass());
    // fpm.addPass(IR::LCSSAPass());
    // fpm.addPass(IR::LoopUnrollPass());
    // fpm.addPass(IR::DCEPass());
    // fpm.addPass(IR::CFGSimplifyPass());
    // fpm.addPass(IR::InstSimplifyPass());
    // fpm.addPass(IR::VerifyPass());
    // fpm.addPass(IR::InstSimplifyPass());
    // fpm.addPass(IR::VerifyPass());
    // fpm.addPass(IR::UnifyExitsPass());
    // fpm.addPass(IR::CodeGenPreparePass());
    // fpm.addPass(IR::NameNormalizePass());
    // fpm.addPass(IR::RunTestPass("../test/contest/h_performance/h-6-02.out"
    //     , "../test/contest/h_performance/h-6-02.in"));
    // return fpm;
    //
    // return fpm;
}

MPM PassBuilder::buildModuleDebugPipeline() {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionDebugPipeline()));
    mpm.addPass(LowerIntrinsicsPass());
    return mpm;
}

FPM PassBuilder::buildFunctionFuzzTestingPipeline(const PMOptions &options, double duplication_rate,
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
                    fpm.addPass(VerifyPass(options.strict));                                                           \
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
                    fpm.addPass(VerifyPass(options.strict));                                                           \
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
                    fpm.addPass(VerifyPass(options.strict));                                                           \
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
                    fpm.addPass(VerifyPass(options.strict));                                                           \
            },                                                                                                         \
            weight);

    REGISTER_FUNCTION_TRANSFORM(reassociate, ReassociatePass, 10)
    REGISTER_FUNCTION_TRANSFORM(sccp, SCCPPass, 10)
    REGISTER_FUNCTION_TRANSFORM(adce, ADCEPass, 10)
    REGISTER_FUNCTION_TRANSFORM(instsimplify, InstSimplifyPass, 10)
    REGISTER_FUNCTION_TRANSFORM(dce, DCEPass, 10)
    REGISTER_FUNCTION_TRANSFORM(cfgsimplify, CFGSimplifyPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(gvnpre, BreakCriticalEdgesPass, GVNPREPass, 10)
    // REGISTER_FUNCTION_TRANSFORM2(loadelim, CFGSimplifyPass, LoadEliminationPass, 10)
    // REGISTER_FUNCTION_TRANSFORM2(dse, CFGSimplifyPass, DSEPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(dae, LoopSimplifyPass, DAEPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(rngsimplify, LoopSimplifyPass, RangeAwareSimplifyPass, 10)

    REGISTER_FUNCTION_TRANSFORM2(loopelim, LoopSimplifyPass, LoopEliminationPass, 10)
    REGISTER_FUNCTION_TRANSFORM2(loop_strength_reduce, LoopSimplifyPass, LoopStrengthReducePass, 10)
    REGISTER_FUNCTION_TRANSFORM4(licm, LoopSimplifyPass, LoopRotatePass, LCSSAPass, LICMPass, 10)
    REGISTER_FUNCTION_TRANSFORM4(loop_unroll, CFGSimplifyPass, LoopSimplifyPass, LCSSAPass, LoopUnrollPass, 10)

    REGISTER_FUNCTION_TRANSFORM2(vectorizer, LoopSimplifyPass, VectorizerPass, 10)

    // REGISTER_FUNCTION_TRANSFORM2(loop_parallel, LoopSimplifyPass, LoopParallelPass, 10)

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

MPM PassBuilder::buildModuleFuzzTestingPipeline(const PMOptions &options, double duplication_rate,
                                                const std::string &repro) {
    MPM mpm;
    mpm.addPass(makeModulePass(buildFunctionFuzzTestingPipeline(options, duplication_rate, repro)));
    // Disable Treeshaking in Repro mode for debugging
    if (repro.empty() && options.tree_shaking)
        mpm.addPass(TreeShakingPass());
    mpm.addPass(LowerIntrinsicsPass());
    return mpm;
}

void PassBuilder::registerProxies(FAM &fam, MAM &mam) {
    mam.registerPass([&] { return FAMProxy(fam); });
}

template <typename T> void registerTargetAnalysesHelper(FAM &fam, MAM &mam) {
    fam.registerPass([] { return TargetAnalysis(std::make_shared<T>()); });
    mam.registerPass([] { return TargetAnalysis(std::make_shared<T>()); });
}

void PassBuilder::registerARMv8TargetAnalyses(FAM &fam, MAM &mam) {
    registerTargetAnalysesHelper<ARMv8TargetInfo>(fam, mam);
}
void PassBuilder::registerARMv7TargetAnalyses(FAM &fam, MAM &mam) {
    registerTargetAnalysesHelper<ARMv7TargetInfo>(fam, mam);
}
void PassBuilder::registerRISCV64TargetAnalyses(FAM &fam, MAM &mam) {
    registerTargetAnalysesHelper<RV64TargetInfo>(fam, mam);
}
void PassBuilder::registerBrainFkTargetAnalyses(FAM &fam, MAM &mam) {
    registerTargetAnalysesHelper<BFTargetInfo>(fam, mam);
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