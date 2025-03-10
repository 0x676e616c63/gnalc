#pragma once
#ifndef GNALC_IR_PASSES_PASS_BUILDER_HPP
#define GNALC_IR_PASSES_PASS_BUILDER_HPP

#include "pass_manager.hpp"

#include <string>

namespace IR {
struct OptInfo {
    bool mem2reg{false};
    bool sccp{false};
    bool dce{false};
    bool adce{false};
    bool cfgsimplify{false};
    bool dse{false};
    bool loadelim{false};
    bool gvnpre{false};
    bool tailcall{false};
    bool reassociate{false};
    bool instsimplify{false};
    bool inliner{false}; // Avoid conflict with C++ keyword `inline`
    bool loop_simplify{false};
    bool loop_rotate{false};
    bool lcssa{false};
    bool licm{false};
    bool loop_unroll{false};
    bool jump_threading{false};

    bool tree_shaking{false};

    bool advance_name_norm{false};
    bool verify{true}; // Defaults to verify in development.
    bool abort_when_verify_failed{false};
};

extern const OptInfo o1_opt_info;

class PassBuilder {
public:
    static FPM buildFunctionFixedPointPipeline();
    static MPM buildModuleFixedPointPipeline();

    static FPM buildFunctionPipeline(OptInfo opt_info);
    static MPM buildModulePipeline(OptInfo opt_info);

    static FPM buildFunctionDebugPipeline();
    static MPM buildModuleDebugPipeline();

    // Reproduce or Produce a Fuzz Testing Pipeline.
    static FPM buildFunctionFuzzTestingPipeline(const std::string& repro = "");
    static MPM buildModuleFuzzTestingPipeline(const std::string& repro = "");

    static void registerModuleAnalyses(MAM &);
    static void registerFunctionAnalyses(FAM &);
    static void registerProxies(FAM &, MAM &);
};
} // namespace IR
#endif
