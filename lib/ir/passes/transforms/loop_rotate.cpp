#include "../../../../include/ir/passes/transforms/loop_rotate.hpp"

#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/passes/helpers/constant_fold.hpp"
#include "../../../../include/ir/pattern_match.hpp"
#include "../../../../include/pattern_match/pattern_match.hpp"

#include <algorithm>
#include <deque>
#include <list>
#include <vector>

using namespace PatternMatch;
namespace IR {
// First try to simplify the loop: merging the latch into exit
// Typically this is a post-increment and merging is much better than duplicating the header.
//
//                   Exit                                      Exit
//                    ^                                         ^
//                    |                                         |
//        ... ---> Exiting ---> Latch  <to>     ...  ---> Exiting/Latch
//                                |                             |
//       Header <--- ... <--------            Header <-- ... <--
//
// Returns the dead latch
//
// TODO: A benchmark is needed to see whether merging is profitable
//       when the vectorize and parallel pass is done.
std::shared_ptr<BasicBlock> tryMergeLatchToExiting(const Loop &loop) {
    auto latch = loop.getLatch()->shared_from_this();
    if (!latch)
        return nullptr;

    // Note that after merging, the Latch's instructions at least execute once,
    // which can raise safety or performance issue.
    // To avoid this, we only merge if the latch is safe to hoist and cheap to execute.
    for (const auto &inst : *latch) {
        switch (inst->getOpcode()) {
        case OP::GEP:
            // Constant offset is cheap
            if (!std::dynamic_pointer_cast<GEPInst>(inst)->isConstantOffset())
                return nullptr;
            continue;

        case OP::ADD:
        case OP::SUB:
            if (!match(inst, M::Add(M::Val(), M::Is(1))) &&
                !match(inst, M::Add(M::Is(1), M::Val())) &&
                !match(inst, M::Sub(M::Val(), M::Is(1))) &&
                !match(inst, M::Sub(M::Is(1), M::Val())))
                return nullptr;
            continue;

        case OP::FPTOSI:
        case OP::SITOFP:
        case OP::ZEXT:
        case OP::BITCAST:

        case OP::RET:
        case OP::BR:
            continue;
        default:
            return nullptr;
        }
    }

    if (latch->getNumPreds() != 1)
        return nullptr;

    const auto &single_pred = *latch->pred_begin();
    if (single_pred == latch // Don't merge single block loop
        || !loop.isExiting(single_pred.get()))
        return nullptr;

    auto jmp = latch->getBRInst();
    if (!jmp || jmp->isConditional())
        return nullptr;

    auto jmp_dest = jmp->getDest();
    for (const auto &phi : jmp_dest->getPhiInsts())
        phi->replaceAllUses(latch, single_pred);

    auto pred_br = single_pred->getBRInst();
    Err::gassert(pred_br->isConditional());
    pred_br->replaceAllUses(latch, jmp_dest);

    unlinkBB(latch, jmp_dest);
    unlinkBB(single_pred, latch);
    linkBB(single_pred, jmp_dest);
    foldPHI(latch);
    Err::gassert(latch->getPhiCount() == 0);
    latch->delInst(jmp);

    // Don't mess up the consecutive cmp and br for better codegen
    //   %cond = icmp ...
    //   br %cond ...
    if (auto cond_inst = std::dynamic_pointer_cast<Instruction>(pred_br->getCond())) {
        if (cond_inst->getParent() == single_pred)
            moveInsts(latch->begin(), latch->end(), single_pred, cond_inst->getIter());
        else
            Logger::logWarning("Cond '", cond_inst->getName(),
                "' and BRInst are in separate block.");
    }
    else
        moveInsts(latch->begin(), latch->end(), single_pred, pred_br->getIter());

    return latch;
}

struct RenameData {
    RenameData(const std::shared_ptr<Instruction> &old_header_inst_,
               const std::shared_ptr<Value> &old_preheader_replacement_,
               const std::shared_ptr<Value> &new_header_replacement_)
        : old_header(old_header_inst_), old_preheader(old_preheader_replacement_), new_header(new_header_replacement_) {
    }

    std::shared_ptr<Instruction> old_header;
    std::shared_ptr<Value> old_preheader;
    std::shared_ptr<Value> new_header;
};

PM::PreservedAnalyses LoopRotatePass::run(Function &function, FAM &fam) {
    bool loop_rotate_cfg_modified = false;

    auto loop_info = fam.getResult<LoopAnalysis>(function);

    size_t num_nonsimplified_loops = 0;
    size_t num_rotated_loops = 0;
    for (const auto &toplevel : loop_info) {
        auto looppdfv = toplevel->getDFVisitor<Util::DFVOrder::ReversePostOrder>();
        for (const auto &loop : looppdfv) {
            Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplify Form.");

            bool latch_merged = false;
            if (auto dead_latch = tryMergeLatchToExiting(*loop)) {
                loop_info.delBlock(dead_latch.get());
                if (dead_latch->getNumPreds() == 0)
                    function.delBlock(dead_latch);
                loop_rotate_cfg_modified = true;
                latch_merged = true;
            }

            if (!loop->isSimplifyForm()) {
                ++num_nonsimplified_loops;
                continue;
            }

            if (loop->getBlocks().size() == 1 || loop->getBlocks().size() == 2)
                continue;

            if (!loop->isSimplifyForm())
                continue;

            // We expect the loop is simplified
            if (!loop->isSimplifyForm())
                continue;

            // Rotate it!
            //                                                                              (if profitable)
            //                   ---------------------                                          (Exit)
            //                  |                    |                                          (  ^ )
            //                  v     (New Header)   |                             (New Header) (  | )
            // PreHeader ---> Header ---> Body ---> Latch     <to>      PreHeader ---> Body ---> Latch
            //                 |                   (  | )                   |           ^         |
            //                 v                   (  v )                   v           |         |
            //               Exit1                 (Exit)                 Exit1  <--- Header <-----
            //                                 (if profitable)
            //
            // Finally, merge the old Header to Latch
            //
            //            (New Header)
            // PreHeader ---> Body ---> Latch
            //     |           ^         |
            //     v           |         |
            //    Exit  <-----------------
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
            //
            // Currently, we only handle loops with exactly one exit,
            // and the exit has the header as its single predecessor. This simplifies renaming for the duplicated values.

            // One exit
            if (loop->getExitBlocks().size() != 1)
                continue;

            auto old_latch = loop->getLatch()->shared_from_this();
            auto old_header = loop->getHeader()->shared_from_this();

            // The header is exiting
            // If not, it might be possibly rotated before.
            auto old_header_br = old_header->getBRInst();
            if (!old_header_br || !old_header_br->isConditional() || !loop->isExiting(old_header.get()))
                continue;

            // We expect the Header has two successors, one is the loop body and the other is the exit.
            auto exit = old_header_br->getTrueDest();
            auto new_header = old_header_br->getFalseDest();
            if (loop->contains(exit.get()))
                std::swap(exit, new_header);

            Err::gassert(*loop->getExitBlocks().begin() == exit.get());

            if (exit->getNumPreds() != 1)
                continue;

            // We rotate only if
            // The latch is not exiting.
            // Or it is merged to exiting before.
            // Or it is profitable. (see above)
            if (loop->isExiting(old_latch.get()) && !latch_merged) {
                bool is_profitable = true;
                for (const auto &phi : old_header->getPhiInsts()) {
                    for (const auto &user : phi->inst_users()) {
                        if (user->getParent() != exit) {
                            is_profitable = false;
                            break;
                        }
                    }
                }
                if (!is_profitable)
                    continue;
            }

            // The header has two successors, one is the exit and one is the body.
            // And header must dominate the body, so the body (new_header)
            // should only have one predecessor.
            // If not, give up
            if (new_header->getNumPreds() != 1)
                continue;
            // Fold the phi of body (new_header) if any.
            foldPHI(new_header);

            // Now the loop is suitable for rotating
            auto old_preheader = loop->getPreHeader()->shared_from_this();

            // First clone Header to PreHeader
            //
            // After clone, the value in the old Header comes in two version:
            //   1. the initial value in the Preheader
            //   2. the updated value in the old Header.

            // Delete the original BRInst in preheader, and replacing it with the old Header's one when duplicating.
            old_preheader->delInst(old_preheader->getBRInst());

            // Keep track of the values in the old Header, old PreHeader and the new Header (original Loop Body)
            std::vector<RenameData> rename_datas;
            auto find_rename_data = [&rename_datas](const std::shared_ptr<Instruction> &inst) -> RenameData * {
                auto it = std::find_if(rename_datas.begin(), rename_datas.end(),
                                       [&inst](const RenameData &rd) { return rd.old_header == inst; });
                if (it == rename_datas.end())
                    return nullptr;
                return &*it;
            };

            // For phi, directly propagates them to the new header by inserting a phi merging the values
            // from the old PreHeader and the old Header.
            for (auto &phi : old_header->getPhiInsts()) {
                auto new_phi = std::make_shared<PHIInst>("%lr.phi" + std::to_string(name_cnt++), phi->getType());
                auto oldph_val = phi->getValueForBlock(old_preheader);
                new_phi->addPhiOper(oldph_val, old_preheader);
                new_phi->addPhiOper(phi->getValueForBlock(old_latch), old_header);
                new_header->addPhiInst(new_phi);
                rename_datas.emplace_back(phi, oldph_val, new_phi);
            }
            // For other instructions, clone them to the old PreHeader and replace their operands
            // with the old PreHeader's version. (Looking up from the rename_datas)
            for (const auto &inst : *old_header) {
                auto cloned_inst = makeClone(inst);
                cloned_inst->setName(inst->getName() + ".clonedlr");
                auto operands = cloned_inst->getOperands();
                for (const auto &use : operands) {
                    auto usee = use->getValue();
                    if (usee->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        auto usee_inst = std::dynamic_pointer_cast<Instruction>(usee);
                        Err::gassert(usee_inst != nullptr);
                        if (auto rd = find_rename_data(usee_inst))
                            cloned_inst->replaceUse(use, rd->old_preheader);
                    }
                }
                old_preheader->addInst(cloned_inst);

                // If the inst are used outside the old Header but in the loop,
                // create a phi in the new header for those uses.
                // For uses outside the loop, we create a phi in the exit block later.
                bool used_outside_header_but_in_loop = false;
                for (const auto &user : inst->inst_users()) {
                    auto parent = user->getParent();
                    if (parent != old_header && loop->contains(parent.get())) {
                        used_outside_header_but_in_loop = true;
                        break;
                    }
                }

                if (used_outside_header_but_in_loop) {
                    auto new_phi =
                        std::make_shared<PHIInst>("%lr.phi" + std::to_string(name_cnt++), cloned_inst->getType());
                    new_phi->addPhiOper(inst, old_header);
                    new_phi->addPhiOper(cloned_inst, old_preheader);
                    new_header->addPhiInst(new_phi);
                    rename_datas.emplace_back(inst, cloned_inst, new_phi);
                } else
                    rename_datas.emplace_back(inst, cloned_inst, nullptr);
            }

            // Now scanning the old Header's instructions, updating all uses.
            for (const auto &rd : rename_datas) {
                auto use_list = rd.old_header->getUseList();

                for (const auto &use : use_list) {
                    auto user_inst = std::dynamic_pointer_cast<Instruction>(use->getUser());
                    auto user_block = user_inst->getParent();

                    // If the use is in the old Header, we don't need to update them except it is a phi.
                    // For a value used in the old Header's phi, it is an incoming value from
                    // the latch and the old PreHeader.
                    // However, after rotating, the old Header only has one predecessor which is the latch.
                    // So the values flow to them should be replaced with the new Header's version through the latch.
                    if (user_block == old_header) {
                        if (auto user_phi = std::dynamic_pointer_cast<PHIInst>(user_inst)) {
                            Err::gassert(user_phi->getNumOperands() == 4 && user_phi->hasBlock(old_preheader) &&
                                         user_phi->hasBlock(old_latch));
                            if (user_phi->hasBlock(new_header) && user_phi->getValueForBlock(new_header) == user_inst)
                                continue;
                            user_phi->replaceAllUses(rd.old_header, rd.new_header);
                        }
                    }
                    // If the use is in the loop but not the old Header, replace them with the new Header's version.
                    else if (loop->contains(user_block.get())) {
                        if (user_inst != rd.new_header)
                            user_inst->replaceAllUses(rd.old_header, rd.new_header);
                    }
                    // For uses outside the loop:
                    //   1. If it is used in the exit block, see if it is used by a LCSSA phi.
                    //   2. If it is not in the exit block or not a LCSSA phi, create a new phi
                    //      at the exit block. This is always valid because the loop only has a single exit,
                    //      which means the phi can always dominate all its uses behind the loop.
                    // Replace the use with the phi which merges the old PreHeader's version and the old Header's version.
                    else {
                        if (user_block == exit && user_inst->getOpcode() == OP::PHI) {
                            auto user_phi = std::dynamic_pointer_cast<PHIInst>(user_inst);
                            user_phi->addPhiOper(rd.old_preheader, old_preheader);
                        } else {
                            // Scanning all phis to figure out if the phi we want already exists.
                            std::shared_ptr<PHIInst> avail_phi;
                            for (const auto &phi : exit->getPhiInsts()) {
                                if (phi->hasBlock(old_header) && phi->hasBlock(old_preheader) &&
                                    phi->getValueForBlock(old_header) == rd.old_header &&
                                    phi->getValueForBlock(old_preheader) == rd.old_preheader) {
                                    avail_phi = phi;
                                    break;
                                }
                            }
                            // If not, just create one at the exit block.
                            if (!avail_phi) {
                                avail_phi = std::make_shared<PHIInst>("%lr.phi" + std::to_string(name_cnt++),
                                                                      rd.old_header->getType());
                                avail_phi->addPhiOper(rd.old_header, old_header);
                                avail_phi->addPhiOper(rd.old_preheader, old_preheader);
                                exit->addPhiInst(avail_phi);
                            }
                            // Replace the use with that phi
                            user_inst->replaceAllUses(rd.old_header, avail_phi);
                        }
                    }
                }
            }

            // At this point, all uses have been fixed up.
            // But the original phis in the exit block, typically the LCSSA phis, possibly end up out of date.
            for (const auto &phi : exit->getPhiInsts()) {
                // The exit block have header as its single predecessor previously,
                // just take care of the old PreHeader
                if (!phi->hasBlock(old_preheader)) {
                    auto val = phi->getValueForBlock(old_header);
                    auto inst = std::dynamic_pointer_cast<Instruction>(val);
                    if (!inst)
                        phi->addPhiOper(val, old_preheader);
                    else if (auto rd = find_rename_data(inst))
                        phi->addPhiOper(rd->old_preheader, old_preheader);
                }
            }

            // Fix CFG
            unlinkBB(old_preheader, old_header);
            linkBB(old_preheader, new_header);
            linkBB(old_preheader, exit);

            // Update the old header's phi
            for (const auto &phi : old_header->getPhiInsts())
                phi->delPhiOperByBlock(old_preheader);

            // Now the old header should have only one predecessor, which is the latch.
            Err::gassert(old_header->getNumPreds() == 1 && *old_header->pred_begin() == old_latch);
            foldPHI(old_header);

            // Update Loop Info
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
            if (auto fold = foldConstant(function.getConstantPool(), cloned_ph_br->getCond())) {
                if (fold != cloned_ph_br->getCond())
                    cloned_ph_br->getCond()->replaceSelf(fold);
            }
            if (auto ci1 = std::dynamic_pointer_cast<ConstantI1>(cloned_ph_br->getCond())) {
                std::set<std::shared_ptr<PHIInst>> dead_phis;
                if ((ci1 && cloned_ph_br->getTrueDest() == new_header) ||
                    (!ci1 && cloned_ph_br->getFalseDest() == new_header)) {
                    safeUnlinkBB(old_preheader, exit, dead_phis);
                    preheader_br_is_conditional = false;
                }
                exit->delInstIf(
                    [&dead_phis](const auto &inst) {
                        return dead_phis.find(std::dynamic_pointer_cast<PHIInst>(inst)) != dead_phis.end();
                    },
                    BasicBlock::DEL_MODE::PHI);
            }

            // To keep the Loop Simplify Form, we MUST split some edges if the preheader is conditional, which means
            // it is not a preheader anymore. Also, dedicated exits should be set up.
            if (preheader_br_is_conditional) {
                // Make a new PreHeader:
                // preheader -> new_header
                // preheader -> new_preheader -> new_header
                auto new_preheader = std::make_shared<BasicBlock>("%lr.nph" + std::to_string(name_cnt++));
                new_preheader->addInst(std::make_shared<BRInst>(new_header));

                for (const auto &phi : new_header->getPhiInsts())
                    phi->replaceAllUses(old_preheader, new_preheader);

                cloned_ph_br->replaceAllUses(new_header, new_preheader);

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
                auto exit_preds = exit->getPreBB();
                for (const auto &exit_pred : exit_preds) {
                    const auto &exit_pred_loop = loop_info.getLoopFor(exit_pred.get());
                    // We only split exiting edges
                    if (!exit_pred_loop || exit_pred_loop->contains(exit.get()))
                        continue;
                    auto new_bb = breakCriticalEdge(exit_pred, exit);
                    new_bb->setName("%lr.exit" + std::to_string(name_cnt++));
                }
            }

            // Try merge the old Header to old Latch
            auto latch_br = old_latch->getBRInst();
            if (!latch_br->isConditional()) {
                old_latch->delInst(latch_br);
                Err::gassert(old_header->getPhiCount() == 0);
                moveInsts(old_header->begin(), old_header->end(), old_latch);
                unlinkBB(old_latch, old_header);
                // After edge splitting, the header's successors might have changed.
                auto old_header_succs = old_header->getNextBB();
                for (const auto &succ : old_header_succs) {
                    unlinkBB(old_header, succ);
                    linkBB(old_latch, succ);
                    for (const auto &phi : succ->getPhiInsts())
                        phi->replaceAllUses(old_header, old_latch);
                }

                loop_info.delBlock(old_header.get());
                function.delBlock(old_header->shared_from_this());
            }
            num_rotated_loops++;
            loop_rotate_cfg_modified = true;
            Err::gassert(loop->isSimplifyForm(), "Loop Rotate should preserve the Loop Simplify Form.");
            Err::gassert(loop->isRotatedForm(), "Loop Rotate done but the loop is not in the rotated form.");
        }
    }

    if (num_nonsimplified_loops != 0) {
        Logger::logDebug("[Loop Rotate] Skipped ", num_nonsimplified_loops,
                         " loops that are not in the Loop Simplify Form.");
    }

    if (num_rotated_loops != 0) {
        Logger::logDebug("[Loop Rotate] on '", function.getName(), "': Rotate ", num_rotated_loops,
                         " loop(s) successfully.");
    }

    name_cnt = 0;

    return loop_rotate_cfg_modified ? PreserveLoopAnalyses() : PreserveCFGAnalyses();
}

} // namespace IR
