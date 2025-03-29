// Loop Invariant Code Motion
// Move loop invariant code to the loop's preheader or exits.
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LICM_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LICM_HPP

#include "../pass_manager.hpp"
namespace IR {
class LICMPass : public PM::PassInfo<LICMPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
    size_t name_cnt = 0;
};

} // namespace IR
#endif
