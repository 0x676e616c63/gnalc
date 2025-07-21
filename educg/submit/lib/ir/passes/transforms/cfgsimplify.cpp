// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/cfgsimplify.hpp"
#include "../../../../include/ir/block_utils.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"

namespace IR {
PM::PreservedAnalyses CFGSimplifyPass::run(Function &function, FAM &fam) {
    bool cfgsimplify_cfg_modified = false;

    std::set<pBlock> dead_blocks;
    bool modified = true;
    while (modified) {
        modified = false;
        // Compute Postorder
        // Note that the GenericVisitors do traversals in their constructors, they won't invalidate when
        // BasicBlocks are removed, and they may contain erased blocks.
        auto postorder = function.getDFVisitor<Util::DFVOrder::PostOrder>();
        // One Pass
        for (const auto &curr : postorder) {
            if (dead_blocks.find(curr) != dead_blocks.end()) {
                // Skip dead blocks
                continue;
            }
            auto br = curr->getBRInst();
            if (br == nullptr)
                continue;
            if (br->isConditional()) {
                if (br->getTrueDest() == br->getFalseDest()) {
                    // 1. Fold a Redundant Branch
                    // curr ends in a branch, and both sides of the branch target the same block (dest)
                    //
                    //  curr ----> dest ----> ...   <to>    curr ----> dest ----> ...
                    //  | ----------^
                    //
                    // replace the branch with a jump

                    // Two identical successors -> One successor
                    unlinkOneEdge(curr, br->getFalseDest());
                    br->dropFalseDest();

                    const auto &dest_phis = br->getDest()->phis();
                    for (const auto &phi : dest_phis)
                        phi->delPhiOperByBlock(curr);

                    modified = true;
                    // Logger::logDebug("[CFGSimplify] on '", function.getName(), "': drop BRInst of BasicBlock '",
                    //                  curr->getName(), "' 's identical destination");
                }
            } else {
                auto dest = br->getDest();
                // Don't bother with entry block. They must not have predecessors.
                // Even if the dest only has one predecessor, it should be handled in case3, not here.
                if (curr->getIndex() != 0 && curr->getAllInstCount() == 1) {
                    // curr is empty
                    // 2. Remove an Empty Block
                    // curr contains only a jump
                    //
                    //                         ...                         ...
                    //                         |                            |
                    //           (empty)       v                            v
                    //  ... ----> curr -----> dest      <to>     ... ---> dest
                    //             ^                                        ^
                    //             |                                        |
                    //             |                                        |
                    //            ...                                      ...
                    //
                    // replace transfers to `curr` with transfers to `dest`
                    //    - fix CFG
                    //    - fix BRInst
                    //
                    // However, this case is not safe in SSA. For example,
                    //
                    // bb0:
                    //   // something
                    //   br cond, %bb1, %bb2
                    // bb1:
                    //   br %bb2
                    // bb2:
                    //   %a = phi [ %b, %bb0 ], [ %c, %bb1 ]
                    //
                    // After optimization:
                    //
                    // bb0:
                    //   // something
                    //   br %bb2
                    // bb2:
                    //   %a = phi [ %b, %bb0 ], [ %c, %bb0 ]
                    //
                    // Obviously, the PHIInst is broken.
                    // To get around it, we only do this if dest does not have any identical
                    // predecessor with curr or curr is not used by any PHIInst.

                    bool is_safe_to_remove = [&] {
                        if (dest->getPhiCount() == 0)
                            return true;

                        for (const auto& curr_pred : curr->preds()) {
                            for (const auto& dest_pred : dest->preds()) {
                                if (curr_pred == dest_pred)
                                    return false;
                            }
                        }
                        return true;
                    }();

                    if (is_safe_to_remove) {
                        unlinkBB(curr, dest);

                        // Don't search by use list, dead blocks hasn't been destroyed.
                        auto prebbs = curr->getPreBB();
                        for (const auto &pred : prebbs) {
                            auto pre_br = pred->getBRInst();
                            unlinkOneEdge(pred, curr);
                            linkBB(pred, dest);

                            // Note that if there are multiple identical CFG edges,
                            // this replace can fail since it might have be replaced in the
                            // last iteration. So don't check.
                            // Besides, VerifyPass will check CFG later.
                            pre_br->replaceAllOperands(curr, dest);

                            for (const auto& phi : dest->phis())
                                phi->addPhiOper(phi->getValueForBlock(curr), pred);
                        }

                        for (const auto& phi : dest->phis())
                            phi->delPhiOperByBlock(curr);


                        // Logger::logDebug("[CFGSimplify] on '", function.getName(), "': Remove empty BasicBlock '",
                        //                  curr->getName(), "'.");

                        dead_blocks.emplace(curr);
                        modified = true;
                    }
                }
                // If curr is deleted, we can't combine them. So it's `else if` rather than `if`
                else if (dest->getNumPreds() == 1) {
                    // 3. Combine Blocks
                    // curr ends in a jump to dest and dest has only one predecessor
                    //
                    //          ...           ...                               ...   ...
                    //           |             ^                                 |     ^
                    //           v             |                                 v     |
                    // ... ---> curr  ----->  dest  ---> ...     <to>   ... ---> curr+dest ----> ...
                    //
                    // Combine `curr` and `dest`
                    // To ensure entry block will be handled correctly,
                    // make `dest -> curr` rather than `curr -> dest`.
                    unlinkBB(curr, dest);
                    curr->delInst(br);

                    foldPHI(dest);
                    // all dest's users are its successors' phi, replace them with curr.
                    Err::gassert(dest->getPhiCount() == 0);
                    dest->replaceSelf(curr);

                    moveInsts(dest->begin(), dest->end(), curr);

                    auto dest_nextbbs = dest->getNextBB();
                    for (const auto &dest_succ : dest_nextbbs) {
                        unlinkBB(dest, dest_succ);
                        linkBB(curr, dest_succ);
                    }

                    // Logger::logDebug("[CFGSimplify] on '", function.getName(), "': Combined BasicBlock '",
                    //                  curr->getName(), "' and '", dest->getName(), "'.");

                    // Since `dest` only has one incoming block, and all phi has been replaced,
                    // deleting `curr`'s br will make it have no users, so it's a safe delete.
                    dead_blocks.emplace(dest);
                    modified = true;
                }
                // If dest's BRInst was hoisted to curr in case3, dest is deleted.
                // This will invalidate case4. So it's `else if` rather than `if`
                else if (dest->getAllInstCount() == 1) { // Dest is empty
                    auto dest_br = dest->getBRInst();
                    if (dest_br && dest_br->isConditional()) {
                        // 4. Hoist a Branch
                        // curr ends with a jump to an empty block dest and dest ends with a branch,
                        //
                        //           ...          ...                           ...       ...
                        //           |             ^                             |       /   |
                        //           |             |                             |      /     |
                        //           v             |                             v    /        |
                        // ... ---> curr  ----->  dest  ---> ...  <to> ... ---> curr         dest  ----> ...
                        //                      (empty)                          |          (empty)       ^
                        //                         ^                             |             ^          |
                        //                         |                             |             |          |
                        //                        ...                            |            ...         |
                        //                                                       |-------------------------
                        //
                        // overwrite `curr`'s jump with a copy of dest`'s branch

                        // Note that empty block don't have phi, so `unlink` rather than `safeUnlink`
                        unlinkBB(curr, dest);
                        curr->delInst(br);
                        curr->addInst(makeClone(dest_br)); // Warning: not shallow copy.
                        auto dest_succ0 = dest_br->getTrueDest();
                        auto dest_succ1 = dest_br->getFalseDest();
                        linkBB(curr, dest_succ0);
                        linkBB(curr, dest_succ1);

                        for (const auto &phi : dest_succ0->phis())
                            phi->addPhiOper(phi->getValueForBlock(dest), curr);
                        for (const auto &phi : dest_succ1->phis())
                            phi->addPhiOper(phi->getValueForBlock(dest), curr);

                        // Logger::logDebug("[CFGSimplify] on '", function.getName(), "': Hoisted Branch of '",
                        //                  dest->getName(), "' to '", curr->getName(), "'.");
                        modified = true;
                    }
                }
            }
        }

        cfgsimplify_cfg_modified |= modified;
    }

    function.delBlockIf([&dead_blocks](const auto &bb) { return dead_blocks.find(bb) != dead_blocks.end(); });

    return cfgsimplify_cfg_modified ? PreserveNone() : PreserveAll();
}
} // namespace IR