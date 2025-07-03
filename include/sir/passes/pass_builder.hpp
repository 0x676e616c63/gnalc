// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_SIR_PASSES_PASS_BUILDER_HPP
#define GNALC_SIR_PASSES_PASS_BUILDER_HPP

#include "sir/base.hpp"
#include "sir/passes/pass_manager.hpp"

#include <string>

namespace SIR {
class LinearPassBuilder {
public:
    // -O1, -fixed-point
    static LFPM buildFunctionFixedPointPipeline(PMOptions options);
    static MPM buildModuleFixedPointPipeline(PMOptions options);

    static LFPM buildFunctionPipeline(PMOptions options);
    static MPM buildModulePipeline(PMOptions options);

    // -debug-pipeline
    static LFPM buildFunctionDebugPipeline();
    static MPM buildModuleDebugPipeline();

    static void registerModuleAnalyses(MAM &);
    static void registerFunctionAnalyses(LFAM &);
    static void registerProxies(LFAM &, MAM &);
};
} // namespace IR
#endif
