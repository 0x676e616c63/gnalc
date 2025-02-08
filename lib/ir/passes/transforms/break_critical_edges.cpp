#include "../../../../include/ir/passes/transforms/break_critical_edges.hpp"
#include "../../../../include/ir/instructions/control.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses BreakCriticalEdgesPass::run(Function &function, FAM &fam) {
    bool bce_cfg_modified = false;

    for (const auto&  curr : function) {
        auto nextbbs = curr->getNextBB();
        if (nextbbs.size() > 1) {
            for (const auto& succ : nextbbs) {
                if (succ->getPreBB().size() > 1) {
                    bce_cfg_modified = true;
                    // curr <-> succ
                    // curr <-> new block <-> succ

                    // Create a new block
                    auto new_block = std::make_shared<BasicBlock>(
                        curr->getName() + "_no_critical_edge_" + succ->getName());
                    function.addBlock(new_block);

                    // BRInst
                    auto br = curr->getInsts().back();
                    br->replaceUse(succ, new_block);
                    new_block->addInst(std::make_shared<BRInst>(succ));

                    // PHI
                    for (auto& r : succ->getInsts()) {
                        if (auto phi = std::dynamic_pointer_cast<PHIInst>(r)) {
                            auto ok = phi->replaceBlock(curr, new_block);
                            Err::gassert(ok);
                        }
                        else break;
                    }

                    // CFG
                    unlinkBB(curr, succ);
                    linkBB(curr, new_block);
                    linkBB(new_block, succ);
                }
            }
        }
    }

    if (bce_cfg_modified)
        return PM::PreservedAnalyses::none();

    return PM::PreservedAnalyses::all();
}
} // namespace IR