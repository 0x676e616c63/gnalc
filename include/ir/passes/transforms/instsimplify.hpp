#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_INSTSIMPLIFY_HPP
#define GNALC_IR_PASSES_TRANSFORMS_INSTSIMPLIFY_HPP

#include "../pass_manager.hpp"
#include "../../../../include/ir/base.hpp"

namespace IR {
class InstSimplifyPass : public PM::PassInfo<InstSimplifyPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
