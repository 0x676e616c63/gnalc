#pragma once
#ifndef GNALC_IR_PASSES_PASS_BUILDER_HPP
#define GNALC_IR_PASSES_PASS_BUILDER_HPP

#include "pass_manager.hpp"

#include <string>

namespace IR {
// name
#define GNALC_IR_PASS_TABLE \
    GNALC_IR_PASS_ENTRY(mem2reg) \
    GNALC_IR_PASS_ENTRY(sccp) \
    GNALC_IR_PASS_ENTRY(dce) \
    GNALC_IR_PASS_ENTRY(adce) \
    GNALC_IR_PASS_ENTRY(cfgsimplify) \
    GNALC_IR_PASS_ENTRY(if_conversion) \
    GNALC_IR_PASS_ENTRY(dse) \
    GNALC_IR_PASS_ENTRY(loadelim) \
    GNALC_IR_PASS_ENTRY(gvnpre) \
    GNALC_IR_PASS_ENTRY(tailcall) \
    GNALC_IR_PASS_ENTRY(reassociate) \
    GNALC_IR_PASS_ENTRY(instsimplify) \
    GNALC_IR_PASS_ENTRY(inliner) \
    GNALC_IR_PASS_ENTRY(licm) \
    GNALC_IR_PASS_ENTRY(loop_strength_reduce) \
    GNALC_IR_PASS_ENTRY(loopelim) \
    GNALC_IR_PASS_ENTRY(internalize) \
    GNALC_IR_PASS_ENTRY(loop_unroll) \
    GNALC_IR_PASS_ENTRY(indvars) \
    GNALC_IR_PASS_ENTRY(vectorizer) \
    GNALC_IR_PASS_ENTRY(rngsimplify) \
    GNALC_IR_PASS_ENTRY(dae) \
    GNALC_IR_PASS_ENTRY(memo) \
    GNALC_IR_PASS_ENTRY(unify_exits) \
    GNALC_IR_PASS_ENTRY(tree_shaking) \
    GNALC_IR_PASS_ENTRY(verify) \

struct PMOptions {
#define GNALC_IR_PASS_ENTRY(name) bool name;
    GNALC_IR_PASS_TABLE
#undef GNALC_IR_PASS_ENTRY

    bool abort_when_verify_failed;

    // Only for plain mode
    bool advance_name_norm;

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
#define GNALC_IR_PASS_ENTRY(name) Status name;
    GNALC_IR_PASS_TABLE
#undef GNALC_IR_PASS_ENTRY

    bool advance_name_norm;
    bool abort_when_verify_failed;


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
    static FPM buildFunctionFixedPointPipeline(PMOptions options);
    static MPM buildModuleFixedPointPipeline(PMOptions options);

    static FPM buildFunctionPipeline(PMOptions options);
    static MPM buildModulePipeline(PMOptions options);

    // -debug-pipeline
    static FPM buildFunctionDebugPipeline();
    static MPM buildModuleDebugPipeline();

    // Reproduce or Produce a Fuzz Testing Pipeline.
    static FPM buildFunctionFuzzTestingPipeline(PMOptions options, double duplication_rate = 1.0, const std::string &repro = "");
    static MPM buildModuleFuzzTestingPipeline(PMOptions options, double duplication_rate = 1.0, const std::string &repro = "");

    static void registerModuleAnalyses(MAM &);
    static void registerFunctionAnalyses(FAM &);
    static void registerProxies(FAM &, MAM &);
};
} // namespace IR
#endif
