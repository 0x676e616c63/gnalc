#include "../../../../include/ir/passes/transforms/loop_rotate.hpp"

#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"

#include <deque>
#include <algorithm>
#include <list>
#include <vector>

namespace IR {
// First try to simplify the loop: merging the latch into exit
//
//                   Exit                                      Exit
//                    ^                                         ^
//                    |                                         |
//        ... ---> Exiting ---> Latch  <to>     ...  ---> Exiting/Latch
//                                |                             |
//       Header <--- ... <--------            Header <-- ... <--
//
bool tryMergeLatchToExiting(const Loop& loop) {
    auto latch = loop.getLatch()->shared_from_this();
    if (!latch) return false;

    auto preds = latch->getPreBB();
    if (preds.size() != 1)
        return false;

    const auto& single_pred = preds.front();
    if (single_pred == latch // Don't merge single block loop
        || !loop.isExiting(single_pred.get()))
        return false;

    auto jmp = latch->getBRInst();
    if (!jmp || jmp->isConditional())
        return false;

    auto jmp_dest = jmp->getDest();
    for (const auto& phi : jmp_dest->getPhiInsts())
        phi->replaceOperand(latch, single_pred);

    auto pred_br = single_pred->getBRInst();
    pred_br->replaceOperand(latch, jmp_dest);

    unlinkBB(latch, jmp_dest);
    unlinkBB(single_pred, latch);
    linkBB(single_pred, jmp_dest);
    foldPHI(latch);
    Err::gassert(latch->getPhiCount() == 0);
    moveInsts(latch->begin(), latch->end(), single_pred, pred_br->getIter());
    return true;
}

PM::PreservedAnalyses LoopRotatePass::run(Function &function, FAM &fam) {
    bool loop_rotate_cfg_modified = false;

    auto loop_info = fam.getResult<LoopAnalysis>(function);

    size_t num_nonsimplified_loops = 0;
    for (const auto& toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto& loop : looppdfv) {
            auto old_latch = loop->getLatch()->shared_from_this();
            bool latch_merged = tryMergeLatchToExiting(*loop);
            if (latch_merged) {
                function.delBlock(old_latch);
                loop->delBlock(old_latch.get());
                loop_rotate_cfg_modified = true;
            }

            if (!loop->isSimplifyForm()) {
                ++num_nonsimplified_loops;
                continue;
            }

            if (loop->getBlocks().size() == 1)
                continue;

            while (true) {
                // We expect the loop is simplified
                if (!loop->isSimplifyForm())
                    break;

                old_latch = loop->getLatch()->shared_from_this();
                auto old_header = loop->getHeader()->shared_from_this();
                // Rotate it!
                //                                                                              (if profitable)
                //                   ---------------------                                          (Exit2)
                //                  |                    |                                          (  ^  )
                //                  v     (New Header)   |                             (New Header) (  |  )
                // PreHeader ---> Header ---> Body ---> Latch     <to>      PreHeader ---> Body ---> Latch
                //                 |                   (  |  )                  |           ^         |
                //                 v                   (  v  )                  v           |         |
                //               Exit1                 (Exit2)                Exit1  <--- Header <-----
                //                                 (if profitable)
                //
                // Finally, if the latch is not exiting, merge the old Header to Latch
                //
                //            (New Header)
                // PreHeader ---> Body ---> Latch
                //     |           ^         |
                //     v           |         |
                //    Exit1 <-----------------
                //
                //
                // We rotate the loop by duplicating the Header to the PreHeader, and merge the old Header to Latch.
                // In general, this can simplify CFG with one basic block eliminated and can enhance LICM.
                //
                // But if the latch is exiting, we can NOT merge the old Header to Latch, thus only duplicating
                // the old Header to PreHeader. This obviously increases the code size, so unless proved profitable,
                // we don't rotate such loops.
                // It can be profitable if there is a phi in the old Header which is only used
                // in the exit from the old Header (typically this is a LCSSA phi). This means rotating the loop can
                // remove the phi in the old Header. Because after rotating, the old Header
                // is dominated by the Latch (see the second Graph above), thus there is no phi needed.

                // The header is exiting
                auto old_header_br = old_header->getBRInst();
                if (!old_header_br || !old_header_br->isConditional()
                    || !loop->isExiting(old_header.get()))
                    break;

                auto old_header_exit = old_header_br->getTrueDest();
                auto new_header = old_header_br->getFalseDest();
                if (loop->contains(old_header_exit.get()))
                    std::swap(old_header_exit, new_header);

                // We rotate only if
                // The latch is not exiting.
                // Or it is merged to exiting before.
                // Or it is profitable. (see above)
                if (loop->isExiting(old_latch.get()) && !latch_merged) {
                    bool is_profitable = false;
                    for (const auto& phi : old_header->getPhiInsts()) {
                        auto phi_uses = phi->getUseList();
                        for (const auto& use : phi_uses) {
                            auto inst = std::dynamic_pointer_cast<Instruction>(use->getValue());
                            Err::gassert(inst != nullptr);
                            if (inst->getParent() != old_header_exit)
                            {
                                is_profitable = true;
                                break;
                            }
                        }
                    }
                    if (!is_profitable)
                        break;
                }

                // Now the loop is suitable for rotating
                auto old_preheader = loop->getPreHeader()->shared_from_this();

                // The header has two successors, one is the exit and one is the body.
                // And header must dominate the body, so the body (new_header)
                // should only have one predecessor.
                // Fold the phi of body (new_header) if any.
                Err::gassert(new_header->getNumPreBBs() == 1);
                foldPHI(new_header);

                // First clone Header to PreHeader
                //
                // Note that when we clone the header for preheader,
                // the phi's value is the one from the original preheader.
                old_preheader->delInst(old_preheader->getBRInst());
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
                            if (old2new.find(usee_inst) != old2new.end())
                                cloned_inst->replaceUse(use, old2new[usee_inst]);
                        }
                    }
                    old_preheader->addInst(cloned_inst);
                    old2new[inst] = cloned_inst;
                }
                unlinkBB(old_preheader, old_header);
                linkBB(old_preheader, new_header);
                linkBB(old_preheader, old_header_exit);

                // Update phi in header's successors (new_header and exit)
                for (const auto& phi : new_header->getPhiInsts())
                    phi->addPhiOper(phi->getValueForBlock(old_header), old_preheader);
                for (const auto& phi : old_header_exit->getPhiInsts())
                    phi->addPhiOper(phi->getValueForBlock(old_header), old_preheader);

                // Now fix up users of values in the old Header
                // Note that the value now has two versions:
                //   1. the initial value in the Preheader
                //   2. the updated value in the old Header.
                // To fix up this, inserting a phi to merge these values.
                //
                //
                // TODO: Is there anyway to insert the minimal number of phi?
                //       The method below is slow and I'm not sure whether it is the optimal or not.
                //       May be a SSAUpdater should be built in the future.
                // To insert less phi, we first replace the uses with a less domtree level,
                // which means they are earlier in the control flow.
                // Get a new Dominator Tree to find available phi that has already inserted.
                auto domtree = fam.getFreshResult<DomTreeAnalysis>(function);
                auto old_header_all_insts = old_header->getAllInsts();
                for (const auto& inst : old_header_all_insts) {
                    if (inst->getUseCount() == 0)
                        continue;

                    std::vector<std::pair<std::shared_ptr<BasicBlock>, std::shared_ptr<PHIInst>>> added_phis;
                    auto uses_raw_list = inst->getUseList();
                    std::vector<std::shared_ptr<Use>> uses{uses_raw_list.begin(), uses_raw_list.end()};
                    std::sort(uses.begin(), uses.end(),
                        [&domtree](const std::shared_ptr<Use>& a, const std::shared_ptr<Use>& b) {
                            auto bb_a = std::dynamic_pointer_cast<Instruction>
                            (a->getValue())->getParent();
                            auto bb_b = std::dynamic_pointer_cast<Instruction>
                            (b->getValue())->getParent();
                        return domtree.nodes[bb_a.get()]->level < domtree.nodes[bb_b.get()]->level;
                    });
                    for (const auto& use : uses) {
                        auto user_inst = std::dynamic_pointer_cast<Instruction>(use->getUser());
                        // Uses in Preheader have been updated, while the old Header don't need to update
                        if (user_inst->getParent() == old_header || user_inst->getParent() == old_preheader)
                            continue;

                        auto user_block = user_inst->getParent();
                        // See if there is an available phi already
                        bool replaced = false;
                        for (const auto& [bb, phi] : added_phis) {
                            if (bb == user_block || domtree.ADomB(bb.get(), user_block.get())) {
                                user_inst->replaceUse(use, phi);
                                replaced = true;
                                break;
                            }
                        }
                        if (!replaced) {
                            auto phi = std::make_shared<PHIInst>(
                                "%lr.phi" + std::to_string(name_cnt++), inst->getType());

                            phi->addPhiOper(inst, old_header);
                            phi->addPhiOper(old2new[inst], old_preheader);

                            user_block->addPhiInst(phi);
                            user_inst->replaceUse(use, phi);
                            added_phis.emplace_back(user_block, phi);
                            Logger::logDebug("[Loop Rotate]: inserting a phi to replace uses.");
                        }
                    }
                }

                // Now the old Header is dominated by the Latch, and all uses of them have been replaced
                // correctly. So just fold them.
                for (const auto& phi : old_header->getPhiInsts())
                    phi->delOnePhiOperByBlock(old_preheader);
                foldPHI(old_header);
                Err::gassert(old_header->getPhiCount() == 0);

                loop->moveToHeader(new_header.get());

                // Now the preheader's BRInst is cloned from header, but its `cond`
                // may become constant if it is a phi before. If so, we fold it into an unconditional BRInst.
                // Though SCCP does this work too, doing here can simplify nested loops' rotating in this pass.
                //
                // But the folded BRInst might not target the NewHeader, which means the loop won't execute at all.
                // We don't bother with it here.
                auto cloned_ph_br = old_preheader->getBRInst();
                Err::gassert(cloned_ph_br->isConditional());
                bool preheader_br_is_conditional = true;
                if (auto ci1 = std::dynamic_pointer_cast<ConstantI1>(cloned_ph_br->getCond())) {
                    std::set<std::shared_ptr<PHIInst>> dead_phis;
                    if (ci1 && cloned_ph_br->getTrueDest() == new_header) {
                        safeUnlinkBB(old_preheader, old_header_exit, dead_phis);
                        preheader_br_is_conditional = false;
                    }
                    else if (!ci1 && cloned_ph_br->getFalseDest() == new_header) {
                        safeUnlinkBB(old_preheader, old_header_exit, dead_phis);
                        preheader_br_is_conditional = false;
                    }
                    old_header_exit->delInstIf([&dead_phis](const auto& inst) {
                        return dead_phis.find(std::dynamic_pointer_cast<PHIInst>(inst)) != dead_phis.end();
                    }, BasicBlock::DEL_MODE::PHI);
                }

                // To keep the Loop Simplify Form, we MUST split some edges if the preheader is conditional,
                // which is not a preheader anymore.
                // Also, dedicated exits should be set up.
                if (preheader_br_is_conditional) {
                    // Make a new PreHeader:
                    // preheader -> new_header
                    // preheader -> new_preheader -> new_header
                    auto new_preheader = std::make_shared<BasicBlock>
                        ("%lr.nph" + std::to_string(name_cnt++));
                    new_preheader->addInst(std::make_shared<BRInst>(new_header));

                    for (const auto& phi : new_header->getPhiInsts())
                        phi->replaceOperand(old_preheader, new_preheader);

                    cloned_ph_br->replaceOperand(new_header, new_preheader);

                    // Fix CFG
                    unlinkBB(old_preheader, new_header);
                    linkBB(new_preheader, new_header);
                    linkBB(old_preheader, new_preheader);

                    function.addBlock(new_header->getIter(), new_preheader);

                    // Dedicated Exits
                    // Note that the exit could be an exit block for multiple nested loops
                    //
                    //                                                                     --->  Exit
                    //                                                                     |      ^
                    //                                                                     |      |
                    //                        --->  Exit                                   g      h
                    //                        |      ^                                     ^      ^
                    //                        |      |                                     |      |
                    //   a ---> b ---> c ---> d ---> e      <to>      a ---> b ---> c ---> d ---> e
                    //   ^      ^             |      |                ^      ^             |      |
                    //   |      |             |      |                |      |             |      |
                    //   |       -------------       |                |       -------------       |
                    //   |---------------------------                 |---------------------------
                    //
                    // In practice, this is the same as critical edges breaking.
                    auto exit_preds = old_header_exit->getPreBB();
                    for (const auto& exit_pred : exit_preds) {
                        const auto& exit_pred_loop = loop_info.getLoopFor(exit_pred.get());
                        // We only split exiting edges
                        if (!exit_pred_loop || exit_pred_loop->contains(old_header_exit.get()))
                            continue;
                        auto new_bb = breakCriticalEdge(exit_pred, old_header_exit);
                        new_bb->setName("%lr.exit" + std::to_string(name_cnt++));
                    }
                }

                // Now the old header should have only one predecessor, which is the latch.
                auto old_header_pred = old_header->getPreBB();
                Err::gassert(old_header_pred.size() == 1 && old_header_pred.front() == old_latch);
                // Try merge the old Header to old Latch
                // auto latch_br = old_latch->getBRInst();
                // if (!latch_br->isConditional()) {
                //     old_latch->delInst(latch_br);
                //     Err::gassert(old_header->getPhiCount() == 0);
                //     moveInsts(old_header->begin(), old_header->end(), old_latch);
                //     unlinkBB(old_latch, old_header);
                //     // After edge splitting, the header's successors might have changed.
                //     auto old_header_succs = old_header->getNextBB();
                //     for (const auto& succ : old_header_succs) {
                //         unlinkBB(old_header, succ);
                //         linkBB(old_latch, succ);
                //         for (const auto& phi : succ->getPhiInsts())
                //             phi->replaceOperand(old_header, old_latch);
                //     }
                //
                //     loop->delBlock(old_header.get());
                //     function.delBlock(old_header);
                // }
                loop_rotate_cfg_modified = true;
            }
            // Err::gassert(loop->isSimplifyForm(),
            //        "Loop Rotate should preserve the Loop Simplify Form.");
        }
    }

    if (num_nonsimplified_loops != 0) {
        Logger::logDebug("[Loop Rotate] Skipped ", num_nonsimplified_loops,
            " loops that are not in the Loop Simplify Form.");
    }

    name_cnt = 0;

    if (loop_rotate_cfg_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<LoopAnalysis>();
        return pa;
    }

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    pa.preserve<PostDomTreeAnalysis>();
    pa.preserve<LoopAnalysis>();
    return pa;
}

} // namespace IR