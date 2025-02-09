//
// Created by edragain on 2/9/25.
//
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_TAIL_CALL_ELIMINATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_TAIL_CALL_ELIMINATION_HPP
#include "../pass_manager.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../pass_manager/pass_manager.hpp"

namespace IR {
class TailCallEliminationPass:public PM::PassInfo<TailCallEliminationPass> {
public:
    PM::PreservedAnalyses run(Function& function,FAM &manager);
};
}
#endif //GNALC_IR_PASSES_TRANSFORMS_TAIL_CALL_ELIMINATION_HPP
