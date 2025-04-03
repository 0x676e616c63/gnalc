// TODO
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_SROA_HPP
#define GNALC_IR_PASSES_TRANSFORMS_SROA_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class SROAPass : public PM::PassInfo<SROAPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
