#include "../../../../include/ir/passes/transforms/dce.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses DCEPass::run(Function &function, FAM &fam) {
    bool dce_inst_modified = false;

    std::set<std::shared_ptr<Instruction>> visited;
    std::deque<std::shared_ptr<Instruction>> worklist;

    for (const auto &block : function) {
        for (const auto &phi : block->phis())
            worklist.emplace_back(phi);

        for (const auto &inst : *block) {
            if (inst->getVTrait() != ValueTrait::VOID_INSTRUCTION)
                worklist.emplace_back(inst);
        }
    }

    while (!worklist.empty()) {
        auto inst = worklist.front();
        worklist.pop_front();
        visited.emplace(inst);

        if (inst->getUseCount() == 0) {
            if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
                if (hasSideEffect(fam, call.get()))
                    continue;
            }
            inst->getParent()->delInst(inst);
            dce_inst_modified = true;
            if (inst->getOpcode() != OP::PHI) {
                for (const auto &use : inst->getOperands()) {
                    if (auto i = std::dynamic_pointer_cast<Instruction>(use->getValue())) {
                        if (visited.find(i) == visited.end())
                            worklist.emplace_back(i);
                    }
                }
            }
        }
    }

    return dce_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

} // namespace IR