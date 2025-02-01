#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_DEAD_CODE_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_DEAD_CODE_ELIMINATION_HPP

#include "../pass_manager.hpp"

namespace IR {
class DeadCodeEliminationPass : public PM::PassInfo<DeadCodeEliminationPass> {
public:
    static PM::PreservedAnalyses run(Function &function, FAM &manager);
};

}
#endif
