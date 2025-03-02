#include "../../../../include/ir/passes/transforms/loop_rotate.hpp"

#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
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

    auto jmp = latch->getBRInst();
    if (!jmp || jmp->isConditional())
        return false;

    auto pred_br = single_pred->getBRInst();
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

            auto latch = loop->getLatch()->shared_from_this();
            bool latch_merged = tryMergeLatchToExit(*loop);
            if (latch_merged) {
                function.delBlock(latch);
                loop_rotate_cfg_modified = true;
            }

            // We expect the loop is simplified before
            if (!loop->isSimplifiedForm())
                continue;

            latch = loop->getLatch()->shared_from_this();
            auto old_header = loop->getHeader()->shared_from_this();
            // Here we only rotate the typical while-loop or the loop with latch merged to exit
            //
            //     ---------------------                             -----------
            //    |                    |                            |          |
            //    v     (New Header)   |                            v          |
            //  Header ---> Body ---> Latch     <to>    Guard ---> Body ---> Latch
            //   |             (       |  )              |      (New Header)    |
            //    \            (       /  )               \                    /
            //     ---->  Exit (<------   )                ---->  Exit  <------
            //                (unless merged)
            //
            // Note that here we always insert a loop guard to preserve the original semantics.
            // However, if the loop can be proved to run at least once by SCCP,
            // the guard can be optimized out.


            // The header is exiting
            auto old_header_br = old_header->getBRInst();
            if (!old_header_br || !old_header_br->isConditional() || !loop->isExiting(old_header.get()))
                continue;

            // Now the loop is suitable for rotating
            auto old_preheader = loop->getPreHeader()->shared_from_this();

            auto exit = old_header_br->getTrueDest();
            auto new_header = old_header_br->getFalseDest();
            if (loop->contains(exit.get()))
                std::swap(exit, new_header);

            // The latch is not exiting. Or it is merged to exiting before.
            // Ensure the latch's exit is the same as the header's exit,
            // thus making the merging of header to latch safe
            if (loop->isExiting(latch.get())) {
                if (!latch_merged)
                    continue;
                auto succs = latch->getNextBB();
                std::shared_ptr<BasicBlock> latch_exit;
                for (const auto& succ : succs) {
                    if (loop->contains(succ.get()))
                        continue;
                    latch_exit = succ;
                }
                if (exit != latch_exit)
                    continue;
            }

            // The header has two successors, one is the exit and one is the body.
            // And header must dominate the body, so the body (new_header)
            // should only have one predecessor.
            // Fold the phi of new_header and old_header if any.
            Err::gassert(new_header->getPreBB().size() == 1);
            foldPHI(new_header);

            //
            // 1. Insert a loop guard
            //
            // Clone the header to make a loop guard
            auto guard = std::make_shared<BasicBlock>("%looprotate.guard");
            // Note that when we clone the header for guard,
            // the phi's value is the one from the original preheader.
            std::map<std::shared_ptr<Instruction>, std::shared_ptr<Value>> old2new;
            for (auto& phi : old_header->getPhiInsts())
                old2new[phi] = phi->getValueForBlock(old_preheader);
            for (const auto& inst : *old_header) {
                auto cloned_inst = makeClone(inst);
                auto operands = cloned_inst->getOperands();
                for (const auto& use : operands) {
                    auto usee = use->getValue();
                    if (usee->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        auto usee_inst = std::dynamic_pointer_cast<Instruction>(usee);
                        Err::gassert(usee_inst != nullptr);
                        cloned_inst->replaceUse(use, old2new[usee_inst]);
                    }
                }
                guard->addInst(cloned_inst);
                old2new[inst] = cloned_inst;
            }
            old_preheader->getBRInst()->replaceOperand(old_header, guard);
            unlinkBB(old_preheader, old_header);
            linkBB(old_preheader, guard);
            linkBB(guard, new_header);
            linkBB(guard, exit);
            function.addBlock(new_header->getIter(), guard);

            //
            // 2. Replace old_header with guard and new_header
            //
            for (const auto& phi : old_header->getPhiInsts())
                phi->replaceOperand(old_preheader, guard);
            auto old_header_preds = old_header->getPreBB();
            for (const auto& pred : old_header_preds) {
                unlinkBB(pred, old_header);
                if (loop->contains(pred.get()))
                    linkBB(pred, new_header);
            }
            auto old_header_succs = old_header->getNextBB();
            for (const auto& succ : old_header_succs) {
                unlinkBB(old_header, succ);
                linkBB(latch, succ);
                for (const auto& phi : succ->getPhiInsts())
                    phi->replaceOperand(old_header, latch);
            }

            //
            // 3. Merge the old header to latch
            //
            auto latch_br = latch->getBRInst();
            latch->delInst(latch_br);
            movePhiInsts(old_header, latch);
            moveInsts(old_header->begin(), old_header->end(), latch);
            function.delBlock(old_header);
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