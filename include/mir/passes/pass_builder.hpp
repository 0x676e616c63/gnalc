#pragma once
#ifndef GNALC_MIR_PASSES_PASS_BUILDER_HPP
#define GNALC_MIR_PASSES_PASS_BUILDER_HPP

#include "pass_manager.hpp"

#include <string>

namespace MIR {
struct OptInfo {
    bool peephole{false};
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
