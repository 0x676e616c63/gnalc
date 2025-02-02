#pragma once
#ifndef GNALC_IR_PASSES_PASS_BUILDER_HPP
#define GNALC_IR_PASSES_PASS_BUILDER_HPP

#include "pass_manager.hpp"

#include <string>

namespace IR {
struct OptInfo {
    bool mem2reg{false};
};

extern const OptInfo o1_opt_info;

class PassBuilder {
public:
    static FPM buildFunctionPipeline(OptInfo opt_info);
    static MPM buildModulePipeline(OptInfo opt_info);

    static std::tuple<FAM, MAM> buildAnalysisManager();

    static void registerModuleAnalyses(MAM &);
    static void registerFunctionAnalyses(FAM &);
    static void registerProxies(FAM &, MAM &);
};
} // namespace IR
#endif
