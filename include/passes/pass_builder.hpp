#pragma once
#ifndef GNALC_PASSES_PASS_BUILDER_HPP
#define GNALC_PASSES_PASS_BUILDER_HPP

#include "pass_manager.hpp"

#include <string>

namespace IR
{
struct OptInfo {
    bool mem2reg{false};
};

extern const OptInfo o1_opt_info;

class PassBuilder {
    public:
    static FunctionPassManager buildFunctionPipeline(OptInfo opt_info);
    static void registerFunctionAnalyses(FunctionAnalysisManager &fam);
};

}
#endif
