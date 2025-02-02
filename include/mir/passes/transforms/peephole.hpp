#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_PEEPHOLE_HPP
#define GNALC_MIR_PASSES_TRANSFORMS_PEEPHOLE_HPP

#include "../pass_manager.hpp"

namespace MIR {
class PeepHolePass : public PM::PassInfo<PeepHolePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace MIR
#endif
