// Simple Implementation of DCE, only deleting useless instructions.
// A more effective implementation of ADCE is required.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DCE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DCE_HPP

#include "../pass_manager.hpp"

namespace IR {
class DCEPass : public PM::PassInfo<DCEPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
