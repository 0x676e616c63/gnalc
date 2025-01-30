// Sparse Conditional Constant Propagation, making use of the generic one in `sparse_propagation.hpp`
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_CONSTANT_PROPAGATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_CONSTANT_PROPAGATION_HPP

#include "../../constant.hpp"
#include "../pass_manager.hpp"
#include "../helpers/sparse_propagation.hpp"

namespace IR {
class ConstantPropagationPass : public PM::PassInfo<ConstantPropagationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

}
#endif
