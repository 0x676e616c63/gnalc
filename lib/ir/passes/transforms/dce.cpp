#include "../../../../include/ir/passes/transforms/dce.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses DCEPass::run(Function &function, FAM &fam) {
    bool dce_inst_modified = false;

    std::set<std::shared_ptr<Instruction>> dead;
    std::deque<std::shared_ptr<Instruction>> worklist;

    for (const auto &block : function) {
        for (const auto &phi : block->getPhiInsts())
            worklist.emplace_back(phi);

        for (const auto &inst : *block) {
            if (inst->getVTrait() != ValueTrait::VOID_INSTRUCTION)
                worklist.emplace_back(inst);
        }
    }

    while (!worklist.empty()) {
        auto inst = worklist.front();
        worklist.pop_front();

        if (inst->getUseList().empty()) {
            if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
                if (hasSideEffect(fam, call.get()))
                    continue;
            }
            dead.insert(inst);
            if (inst->getOpcode() != OP::PHI) {
                for (const auto &use : inst->getOperands()) {
                    if (auto i = std::dynamic_pointer_cast<Instruction>(use->getValue()))
                        worklist.emplace_back(i);
                }
            }
        }
    }

    for (const auto &block : function) {
        dce_inst_modified |= block->delInstIf([&dead](const auto &candidate) {
            return dead.find(candidate) != dead.end();
        });
    }

    if (dce_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}

} // namespace IR