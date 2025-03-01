#include "../../../../include/ir/passes/transforms/loop_rotate.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include <deque>

namespace IR {
// First try to simplify the loop: merging the latch into exit
//
//                  Exit                                        Exit
//                   ^                                           ^
//                   |                                           |
//     Header ---> Exiting ---> Latch  <to>   Header ---> Exiting/Latch
//       ^                        |             ^               |
//       |------------------------              |---------------
//
bool tryMergeLatchToExit(const Loop& loop) {
    auto latch = loop.getLatch()->shared_from_this();
    if (!latch) return false;

    auto preds = latch->getPreBB();
    if (preds.size() == 1)
        return false;

    const auto& single_pred = preds.front();
    if (single_pred == latch || !loop.isExiting(single_pred.get()))
        return false;

    auto jmp = std::dynamic_pointer_cast<BRInst>(latch->getInsts().back());
    if (!jmp || jmp->isConditional())
        return false;

    auto pred_br = std::dynamic_pointer_cast<BRInst>(single_pred->getInsts().back());
    pred_br->replaceOperand(latch, jmp->getDest());

    unlinkBB(single_pred, latch);
    linkBB(single_pred, jmp->getDest());

    for (const auto& phi : latch->getPhiInsts())
        phi->replaceSelf(phi->getValueForBlock(single_pred));

    latch->delInst(jmp);
    moveInsts(latch->begin(), latch->end(), single_pred, pred_br->getIter());
    return true;
}

PM::PreservedAnalyses LoopRotatePass::run(Function &function, FAM &fam) {
    bool loop_rotate_cfg_modified = false;

    auto loop_info = fam.getResult<LoopAnalysis>(function);

    for (const auto& toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto& loop : looppdfv) {
            if (loop->getBlocks().size() == 1)
                continue;

            bool latch_merged = tryMergeLatchToExit(*loop);
            if (latch_merged) {
                function.delBlock(loop->getLatch()->shared_from_this());
                loop_rotate_cfg_modified = true;
            }
        }
    }

    if (loop_rotate_cfg_modified)
        return PM::PreservedAnalyses::none();

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    pa.preserve<PostDomTreeAnalysis>();
    pa.preserve<LoopAnalysis>();
    return pa;
}

} // namespace IR