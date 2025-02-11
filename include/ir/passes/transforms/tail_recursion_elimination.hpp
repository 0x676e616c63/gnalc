//
// Created by edragain on 2/9/25.
//
// https://discourse.llvm.org/t/how-to-understand-tail-call/51097
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_MARK_TAIL_CALL_HPP
#define GNALC_IR_PASSES_TRANSFORMS_MARK_TAIL_CALL_HPP
#include "../pass_manager.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../pass_manager/pass_manager.hpp"

namespace IR {
class MarkTailCallPass: public PM::PassInfo<MarkTailCallPass> {
public:
    PM::PreservedAnalyses run(Function& function, FAM &manager);
};
}
#endif //GNALC_IR_PASSES_TRANSFORMS_MARK_TAIL_CALL_HPP
