#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_TRANSFORMS_PEEPHOLE_HPP
#define GNALC_LEGACY_MIR_PASSES_TRANSFORMS_PEEPHOLE_HPP

#include "legacy_mir/passes/pass_manager.hpp"

namespace LegacyMIR {
class PeepHolePass : public PM::PassInfo<PeepHolePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace MIR
#endif
#endif
