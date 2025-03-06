#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_LOOP_ROTATE_HPP
#define GNALC_IR_PASSES_TRANSFORMS_LOOP_ROTATE_HPP

#include "../pass_manager.hpp"

namespace IR {
class LoopRotatePass : public PM::PassInfo<LoopRotatePass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
private:
    size_t name_cnt{};
};

} // namespace IR
#endif
