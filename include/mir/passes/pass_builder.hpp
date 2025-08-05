// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_PASSES_PASS_BUILDER_HPP
#define GNALC_MIR_PASSES_PASS_BUILDER_HPP

#include "pass_manager.hpp"

namespace MIR {
struct OptInfo {
    ///@todo to add...
    bool peephole_afterIsel;
    bool redundantLoadEli;
    bool peephole_afterRa;
    bool peephole_afterStackGenerate;
    bool CFGsimplifyBeforeRa;
    bool CFGsimplifyAfterRa;
    bool PostRaScheduling;
    bool machineLICM;
    bool codeLayout;

    size_t redundantLoadEli_weight = 60;
    unsigned registeralloc_dmp_times = 0;
};

extern const OptInfo o1_opt_info;

class PassBuilder {
public:
    static FPM buildFunctionDebugPipeline();
    static MPM buildModuleDebugPipeline();
    static FPM buildFunctionPipeline(Arch arch, OptInfo opt_info);
    static MPM buildModulePipeline(Arch arch, OptInfo opt_info);

    static void registerModuleAnalyses(MAM &);
    static void registerFunctionAnalyses(FAM &);
    static void registerProxies(FAM &, MAM &);
};
} // namespace MIR
#endif
