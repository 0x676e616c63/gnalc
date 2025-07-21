// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/unify_exits.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"

namespace IR {
PM::PreservedAnalyses UnifyExitsPass::run(Function &function, FAM &fam) {
    auto exits = function.getExitBBs();
    if (exits.size() <= 1)
        return PreserveAll();

    auto single_exit = std::make_shared<BasicBlock>("%unified.exit");
    auto ret_type = function.getType()->as<FunctionType>()->getRet();
    bool is_void = ret_type->is<BType>() && ret_type->as<BType>()->getInner() == IRBTYPE::VOID;
    auto exit_phi = is_void ? nullptr : std::make_shared<PHIInst>("%unified.exitval", ret_type);

    for (const auto &exit : exits) {
        auto candidate = exit->getRETInst();
        Err::gassert(candidate != nullptr, "Expected exit blocks");

        if (!is_void)
            exit_phi->addPhiOper(candidate->getRetVal(), exit);

        auto br = std::make_shared<BRInst>(single_exit);
        exit->delInst(candidate);
        exit->addInst(br);

        linkBB(exit, single_exit);
    }

    if (is_void)
        single_exit->addInst(std::make_shared<RETInst>());
    else {
        single_exit->addPhiInst(exit_phi);
        single_exit->addInst(std::make_shared<RETInst>(exit_phi));
    }

    function.addBlock(single_exit);

    return PreserveNone();
}
} // namespace IR