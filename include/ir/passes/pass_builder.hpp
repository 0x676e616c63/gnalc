// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_PASSES_PASS_BUILDER_HPP
#define GNALC_IR_PASSES_PASS_BUILDER_HPP

#include "pass_manager.hpp"

#include <string>

namespace IR {
// name
#define GNALC_SIR_IR_PASS_TABLE                                                                                        \
    GNALC_SIR_IR_PASS_ENTRY(mem2reg)                                                                                   \
    GNALC_SIR_IR_PASS_ENTRY(sccp)                                                                                      \
    GNALC_SIR_IR_PASS_ENTRY(dce)                                                                                       \
    GNALC_SIR_IR_PASS_ENTRY(adce)                                                                                      \
    GNALC_SIR_IR_PASS_ENTRY(cfgsimplify)                                                                               \
    GNALC_SIR_IR_PASS_ENTRY(if_conversion)                                                                             \
    GNALC_SIR_IR_PASS_ENTRY(dse)                                                                                       \
    GNALC_SIR_IR_PASS_ENTRY(loadelim)                                                                                  \
    GNALC_SIR_IR_PASS_ENTRY(gvnpre)                                                                                    \
    GNALC_SIR_IR_PASS_ENTRY(tailcall)                                                                                  \
    GNALC_SIR_IR_PASS_ENTRY(reassociate)                                                                               \
    GNALC_SIR_IR_PASS_ENTRY(instsimplify)                                                                              \
    GNALC_SIR_IR_PASS_ENTRY(inliner)                                                                                   \
    GNALC_SIR_IR_PASS_ENTRY(licm)                                                                                      \
    GNALC_SIR_IR_PASS_ENTRY(loop_strength_reduce)                                                                      \
    GNALC_SIR_IR_PASS_ENTRY(loopelim)                                                                                  \
    GNALC_SIR_IR_PASS_ENTRY(internalize)                                                                               \
    GNALC_SIR_IR_PASS_ENTRY(globalize)                                                                                 \
    GNALC_SIR_IR_PASS_ENTRY(loop_parallel)                                                                             \
    GNALC_SIR_IR_PASS_ENTRY(loop_unroll)                                                                               \
    GNALC_SIR_IR_PASS_ENTRY(indvars)                                                                                   \
    GNALC_SIR_IR_PASS_ENTRY(vectorizer)                                                                                \
    GNALC_SIR_IR_PASS_ENTRY(rngsimplify)                                                                               \
    GNALC_SIR_IR_PASS_ENTRY(dae)                                                                                       \
    GNALC_SIR_IR_PASS_ENTRY(memo)                                                                                      \
    GNALC_SIR_IR_PASS_ENTRY(gep_flatten)                                                                               \
    GNALC_SIR_IR_PASS_ENTRY(unify_exits)                                                                               \
    GNALC_SIR_IR_PASS_ENTRY(tree_shaking)                                                                              \
    GNALC_SIR_IR_PASS_ENTRY(store_range)                                                                               \
    GNALC_SIR_IR_PASS_ENTRY(code_sink)                                                                                 \
    GNALC_SIR_IR_PASS_ENTRY(codegen_prepare)                                                                           \
    GNALC_SIR_IR_PASS_ENTRY(run_test)                                                                                  \
    GNALC_SIR_IR_PASS_ENTRY(verify)                                                                                    \
    GNALC_SIR_IR_PASS_ENTRY(early_mem2reg)                                                                             \
    GNALC_SIR_IR_PASS_ENTRY(while2for)                                                                                 \
    GNALC_SIR_IR_PASS_ENTRY(early_dce)                                                                                 \
    GNALC_SIR_IR_PASS_ENTRY(reshape_fold)                                                                              \
    GNALC_SIR_IR_PASS_ENTRY(early_inline)                                                                              \
    GNALC_SIR_IR_PASS_ENTRY(constant_fold)                                                                             \
    GNALC_SIR_IR_PASS_ENTRY(loop_unswitch)                                                                             \
    GNALC_SIR_IR_PASS_ENTRY(loop_fuse)                                                                                 \
    GNALC_SIR_IR_PASS_ENTRY(loop_interchange)                                                                          \
    GNALC_SIR_IR_PASS_ENTRY(affine_licm)

struct PMOptions {
#define GNALC_SIR_IR_PASS_ENTRY(name) bool name;
    GNALC_SIR_IR_PASS_TABLE
#undef GNALC_SIR_IR_PASS_ENTRY

    bool strict;
    bool advance_name_norm;

    // Only for run_test is true
    std::string testcase_in;
    std::string testcase_out;

    PMOptions() = default;
};

struct CliOptions {
    enum class StatusType { Default, Enable, Disable };

    class Status {
        StatusType type;

    public:
        Status(StatusType type) : type(type) {}
        void enable() { type = StatusType::Enable; }
        void disable() { type = StatusType::Disable; }
        void reset() { type = StatusType::Default; }
        operator StatusType() const { return type; }
        bool isDefault() const { return type == StatusType::Default; }
        bool isEnable() const { return type == StatusType::Enable; }
        bool isDisable() const { return type == StatusType::Disable; }
        void enableIfDefault() {
            if (type == StatusType::Default)
                type = StatusType::Enable;
        }
        void disableIfDefault() {
            if (type == StatusType::Default)
                type = StatusType::Disable;
        }
    };
#define GNALC_SIR_IR_PASS_ENTRY(name) Status name;
    GNALC_SIR_IR_PASS_TABLE
#undef GNALC_SIR_IR_PASS_ENTRY

    bool advance_name_norm;
    bool strict;

    std::string testcase_in;
    std::string testcase_out;

    enum class Mode {
        EnableIfDefault,
        DisableIfDefault,
        DisableAnyway,
        EnableAnyway,
    };
    PMOptions toPMOptions(Mode mode) const;

    CliOptions();
};

class PassBuilder {
public:
    // -O1, -fixed-point
    static FPM buildFunctionFixedPointPipeline(const PMOptions &options);
    static MPM buildModuleFixedPointPipeline(const PMOptions &options);

    static FPM buildFunctionPipeline(const PMOptions &options);
    static MPM buildModulePipeline(const PMOptions &options);

    // -debug-pipeline
    static FPM buildFunctionDebugPipeline();
    static MPM buildModuleDebugPipeline();

    // Reproduce or Produce a Fuzz Testing Pipeline.
    static FPM buildFunctionFuzzTestingPipeline(const PMOptions &options, double duplication_rate = 1.0,
                                                const std::string &repro = "");
    static MPM buildModuleFuzzTestingPipeline(const PMOptions &options, double duplication_rate = 1.0,
                                              const std::string &repro = "");

    static void registerModuleAnalyses(MAM &);
    static void registerFunctionAnalyses(FAM &);
    static void registerProxies(FAM &, MAM &);

    static void registerARMv8TargetAnalyses(FAM &, MAM &);
    static void registerARMv7TargetAnalyses(FAM &, MAM &);
    static void registerRISCV64TargetAnalyses(FAM &, MAM &);
    static void registerBrainFkTargetAnalyses(FAM &, MAM &);
};
} // namespace IR
#endif
