// Sparse Conditional Constant Propagation, making use of the generic one in
// `sparse_propagation.hpp`
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_CONSTANT_PROPAGATION_HPP
#define GNALC_IR_PASSES_TRANSFORMS_CONSTANT_PROPAGATION_HPP

#include "../../constant.hpp"
#include "../../constant_proxy.hpp"
#include "../helpers/sparse_propagation.hpp"
#include "../pass_manager.hpp"

// TODO: make it inter procedural.
// Maybe split it into an analysis pass and two transform pass (one inter procedural)
namespace IR {
class ConstantPropagationPass : public PM::PassInfo<ConstantPropagationPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
