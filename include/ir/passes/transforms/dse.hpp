// Implementation of DeadStoreElimination
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DSE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DSE_HPP

#include "../pass_manager.hpp"

namespace IR {
class DSEPass : public PM::PassInfo<DSEPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
