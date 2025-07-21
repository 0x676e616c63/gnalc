// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_PASS_BUILDER_HPP
#define GNALC_LEGACY_MIR_PASSES_PASS_BUILDER_HPP

#include "pass_manager.hpp"

namespace LegacyMIR {
struct OptInfo {
    bool peephole = false;      // func pass
    bool phiEliminate = true;   // module pass
    bool preRAleagalize = true; // func pass
    bool RA = true;             // func pass
};

extern const OptInfo o1_opt_info;

class PassBuilder {
public:
    static FPM buildFunctionPipeline(OptInfo opt_info);
    static MPM buildModulePipeline(OptInfo opt_info);

    static void registerModuleAnalyses(MAM &);
    static void registerFunctionAnalyses(FAM &);
    static void registerProxies(FAM &, MAM &);
};
} // namespace MIR
#endif
#endif