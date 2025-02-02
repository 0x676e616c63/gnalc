#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_LEGALIZE_HPP
#define GNALC_MIR_PASSES_TRANSFORMS_LEGALIZE_HPP

#include "../pass_manager.hpp"

namespace MIR {
class LegalizePass : public PM::PassInfo<LegalizePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace MIR
#endif
