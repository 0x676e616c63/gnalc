#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LCSSA_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LCSSA_HPP

#include "../pass_manager.hpp"

namespace IR {
class LCSSAPass : public PM::PassInfo<LCSSAPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
