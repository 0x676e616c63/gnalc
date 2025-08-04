// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/pass_builder.hpp"

// IR
#include "ir/passes/pass_manager.hpp"

// Analysis
#include "sir/passes/analysis/instdom_analysis.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"

// Transforms
#include "sir/passes/transforms/early_mem2reg.hpp"
#include "sir/passes/transforms/early_dce.hpp"
#include "sir/passes/transforms/constant_fold.hpp"
#include "sir/passes/transforms/loop_fuse.hpp"
#include "sir/passes/transforms/loop_unswitch.hpp"
#include "sir/passes/transforms/while2for.hpp"
#include "sir/passes/transforms/reshape_fold.hpp"
#include "sir/passes/transforms/early_inline.hpp"
#include "sir/passes/transforms/loop_interchange.hpp"
#include "sir/passes/transforms/affine_licm.hpp"
#include "sir/passes/transforms/relayout.hpp"

// Utilities
#include "sir/passes/utilities/sirprinter.hpp"

#include <algorithm>

namespace SIR {
template <typename PM, typename Pass>
void registerPassForOptInfo(PM &lfpm, bool enable, Pass &&pass) {
    if (enable) {
        lfpm.addPass(std::forward<Pass>(pass));
    } else
        Logger::logDebug("[PB]: '", Pass::name(), "' disabled.");
}

template <typename PM, typename First, typename... Rest>
void registerPassForOptInfo(PM &lfpm, bool enable, First &&first, Rest &&...rest) {
    registerPassForOptInfo(lfpm, enable, std::forward<First>(first));
    registerPassForOptInfo(lfpm, enable, std::forward<Rest>(rest)...);
}

LFPM LinearPassBuilder::buildFunctionFixedPointPipeline(const PMOptions& options) {
    LFPM lfpm;

#define FUNCTION_TRANSFORM(name, ...)                                                                                  \
    registerPassForOptInfo(lfpm, options.name, __VA_ARGS__);

    FUNCTION_TRANSFORM(early_inline, EarlyInlinePass())
    FUNCTION_TRANSFORM(early_mem2reg, EarlyPromotePass())
    FUNCTION_TRANSFORM(constant_fold, ConstantFoldPass())
    FUNCTION_TRANSFORM(early_dce, EarlyDCEPass())
    FUNCTION_TRANSFORM(while2for, While2ForPass())
    FUNCTION_TRANSFORM(reshape_fold, ReshapeFoldPass())
    FUNCTION_TRANSFORM(affine_licm, AffineLICMPass())
    FUNCTION_TRANSFORM(loop_fuse, LoopFusePass())
    // FUNCTION_TRANSFORM(loop_unswitch, LoopUnswitchPass())
    FUNCTION_TRANSFORM(early_dce, EarlyDCEPass())
    // FUNCTION_TRANSFORM(constant_fold, ConstantFoldPass())
    // FUNCTION_TRANSFORM(early_dce, EarlyDCEPass())

#undef FUNCTION_TRANSFORM
    return lfpm;
}

MPM LinearPassBuilder::buildModuleFixedPointPipeline(const PMOptions& options) {
    MPM mpm;
    mpm.addPass(makeLinearModulePass(buildFunctionFixedPointPipeline(options)));
    if (options.relayout)
        mpm.addPass(RelayoutPass());
    return mpm;
}

LFPM LinearPassBuilder::buildFunctionPipeline(const PMOptions& opt_info) {
    LFPM lfpm;

#define FUNCTION_TRANSFORM(name, ...)                                                                                  \
    registerPassForOptInfo(lfpm, opt_info.name, __VA_ARGS__);

#undef FUNCTION_TRANSFORM

    return lfpm;
}

MPM LinearPassBuilder::buildModulePipeline(const PMOptions& opt_info) {
    MPM mpm;
    mpm.addPass(makeLinearModulePass(buildFunctionPipeline(opt_info)));
    return mpm;
}

LFPM LinearPassBuilder::buildFunctionDebugPipeline() {
    LFPM lfpm;
    lfpm.addPass(EarlyInlinePass());
    lfpm.addPass(EarlyPromotePass());
    lfpm.addPass(ConstantFoldPass());
    lfpm.addPass(EarlyDCEPass());
    lfpm.addPass(While2ForPass());
    lfpm.addPass(ReshapeFoldPass());
    lfpm.addPass(PrintLinearFunctionPass(std::cerr));
    lfpm.addPass(PrintAffineAAPass(std::cerr));
    lfpm.addPass(AffineLICMPass());
    lfpm.addPass(EarlyDCEPass());
    return lfpm;
}

MPM LinearPassBuilder::buildModuleDebugPipeline() {
    MPM mpm;
    mpm.addPass(makeLinearModulePass(buildFunctionDebugPipeline()));
    mpm.addPass(PrintLinearModulePass(std::cerr));
    mpm.addPass(RelayoutPass());
    mpm.addPass(PrintLinearModulePass(std::cerr));
    return mpm;
}

void LinearPassBuilder::registerProxies(LFAM &lfam, MAM &mam) {
    mam.registerPass([&] { return LFAMProxy(lfam); });
}

void LinearPassBuilder::registerFunctionAnalyses(LFAM &lfam) {
#define FUNCTION_ANALYSIS(CREATE_PASS) lfam.registerPass([&] { return CREATE_PASS; });

    FUNCTION_ANALYSIS(AffineAliasAnalysis())
    FUNCTION_ANALYSIS(InstDomAnalysis())

#undef FUNCTION_ANALYSIS
}

void LinearPassBuilder::registerModuleAnalyses(MAM &) {}

} // namespace IR