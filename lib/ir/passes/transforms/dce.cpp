// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/dce.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/block_utils.hpp"

#include <vector>

namespace IR {
PM::PreservedAnalyses DCEPass::run(Function &function, FAM &fam) {
    bool dce_inst_modified = false;

    std::vector<pInst> worklist;

    for (const auto &block : function) {
        for (const auto &phi : block->phis())
            worklist.emplace_back(phi);

        for (const auto &inst : *block) {
            if (inst->getVTrait() != ValueTrait::VOID_INSTRUCTION)
                worklist.emplace_back(inst);
        }
    }

    dce_inst_modified |= eliminateDeadInsts(worklist, &fam);

    return dce_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR