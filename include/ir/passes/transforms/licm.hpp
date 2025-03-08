#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LICM_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LICM_HPP

#include "../pass_manager.hpp"

namespace IR {
class LICMPass : public PM::PassInfo<LICMPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
