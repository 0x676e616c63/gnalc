#include "../../../../include/ir/passes/transforms/break_critical_edges.hpp"
#include "../../../../include/ir/instructions/control.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses BreakCriticalEdgesPass::run(Function &function, FAM &fam) {
    bool bce_cfg_modified = false;

    std::vector<std::shared_ptr<BasicBlock>> blocks_to_add;
    for (const auto& curr : function) {
        auto nextbbs = curr->getNextBB();
        if (nextbbs.size() <= 1) continue;
        for (const auto& succ : nextbbs) {
            if (succ->getPreBB().size() > 1) {
                bce_cfg_modified = true;
                // curr <-> succ
                // curr <-> new block <-> succ

                // Create a new block
                auto new_block = std::make_shared<BasicBlock>(
                    curr->getName() + "_no_critical_edge_" + succ->getName());
                blocks_to_add.emplace_back(new_block);

                // CFG
                unlinkBB(curr, succ);
                linkBB(curr, new_block);
                linkBB(new_block, succ);

                // BRInst
                auto br = std::dynamic_pointer_cast<BRInst>(curr->getInsts().back());
                Err::gassert(br != nullptr);
                bool ok = br->replaceOperand(succ, new_block);
                Err::gassert(ok);
                new_block->addInst(std::make_shared<BRInst>(succ));

                // PHI
                for (const auto& phi : succ->getPhiInsts()) {
                    ok = phi->replaceOperand(curr, new_block);
                    Err::gassert(ok);
                }
            }
        }
    }
    for (const auto& bb : blocks_to_add)
        function.addBlock(bb);

    if (bce_cfg_modified)
        return PM::PreservedAnalyses::none();

    return PM::PreservedAnalyses::all();
}
} // namespace IR