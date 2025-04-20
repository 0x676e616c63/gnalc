// TODO
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_JUMP_THREADING_HPP
#define GNALC_IR_PASSES_TRANSFORMS_JUMP_THREADING_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class JumpThreadingPass : public PM::PassInfo<JumpThreadingPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
