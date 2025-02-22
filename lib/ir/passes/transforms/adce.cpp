#include "../../../../include/ir/passes/transforms/adce.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses ADCEPass::run(Function &function, FAM &fam) {
    bool adce_inst_modified = false;
    bool adce_cfg_modified = false;

    std::deque<std::shared_ptr<Instruction>> worklist;
    std::set<std::shared_ptr<Instruction>> critical;
    // Mark
    for (const auto &block : function) {
        for (const auto &inst : *block) {
            if (inst->getOpcode() == OP::STORE || inst->getOpcode() == OP::RET) {
                critical.emplace(inst);
                worklist.emplace_back(inst);
            } else if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
                if (hasSideEffect(fam, call.get())) {
                    critical.emplace(inst);
                    worklist.emplace_back(inst);
                }
            } else if (auto br = std::dynamic_pointer_cast<BRInst>(inst)) {
                // The treatment of control-flow operations is more complex.
                // Every jump is considered useful.
                // Branches are considered useful only if the execution of a useful operation
                // depends on their presence.
                if (!br->isConditional()) {
                    critical.emplace(br);
                    worklist.emplace_back(br);
                }
            }
        }
    }

    auto postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    while (!worklist.empty()) {
        auto inst = worklist.front();
        worklist.pop_front();

        for (const auto &use : inst->getOperands()) {
            if (use->getValue()->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                auto oper = std::dynamic_pointer_cast<Instruction>(use->getValue());
                if (critical.find(oper) == critical.end()) {
                    critical.emplace(oper);
                    worklist.emplace_back(oper);
                }
            }
        }

        auto rdf = postdomtree.getDomFrontier(inst->getParent().get());
        // Logger::logDebug("[ADCE]: ReverseDomFrontier '", inst->getParent()->getName(), "': ");
        // for (const auto& a : rdf) {
        //     Logger::logDebug("[ADCE]: ", a->getName());
        // }
        for (const auto &bb : rdf) {
            if (auto br = std::dynamic_pointer_cast<BRInst>(bb->getInsts().back())) {
                if (br->isConditional() && critical.find(br) == critical.end()) {
                    if (br->getCond()->getVTrait() == ValueTrait::ORDINARY_VARIABLE) {
                        auto cond = std::dynamic_pointer_cast<Instruction>(br->getCond());
                        critical.emplace(cond);
                        worklist.emplace_back(cond);
                    }
                    critical.emplace(br);
                    worklist.emplace_back(br);
                }
            }
        }
    }

    std::set<std::shared_ptr<PHIInst>> dead_phis;
    std::set<std::shared_ptr<Instruction>> dead;

    // Sweep
    for (const auto &block : function) {
        for (const auto &inst : *block) {
            if (critical.find(inst) == critical.end()) {
                if (auto br = std::dynamic_pointer_cast<BRInst>(inst)) {
                    Err::gassert(br->isConditional());
                    // Rewrite it with an unconditional BRInst
                    // to the nearest marked post dominator
                    bool dead_br = safeUnlinkBB(block, br->getTrueDest(), dead_phis);
                    Err::gassert(!dead_br);
                    // After safeUnlink, br becomes a jump, but not dead.
                    dead_br = safeUnlinkBB(block, br->getDest(), dead_phis);
                    // Here br is dead.
                    Err::gassert(dead_br);
                    dead.emplace(br);

                    auto nearest_pdom = postdomtree.nodes[block.get()].get();
                    bool found = false;
                    do {
                        nearest_pdom = nearest_pdom->parent;
                        for (const auto &pdominst : *nearest_pdom->bb) {
                            if (critical.find(pdominst) != critical.end()) {
                                found = true;
                                break;
                            }
                        }
                        if (found)
                            break;
                    } while (nearest_pdom->parent != nullptr);
                    // Since, by definition, the exit block is useful, this search must terminate.
                    // Also, if there is a virtual root, its children must also be exit blocks. Thus, the
                    // search can't terminate at the virtual root.
                    Err::gassert(found && nearest_pdom->bb != nullptr);
                    block->addInst(std::make_shared<BRInst>(nearest_pdom->bb->shared_from_this()));
                    adce_cfg_modified = true;
                } else
                    dead.emplace(inst);
            }
        }
    }

    for (auto &block : function) {
        adce_inst_modified |= block->delInstIf([&dead](const auto &inst) {
            return dead.find(inst) != dead.end();
        }, BasicBlock::DEL_MODE::NON_PHI);
        adce_inst_modified |= block->delInstIf([&dead_phis](const auto &p) {
            return dead_phis.find(std::dynamic_pointer_cast<PHIInst>(p)) != dead_phis.end();
        }, BasicBlock::DEL_MODE::PHI);
    }

    // Clean
    bool modified = true;
    while (modified) {
        modified = false;
        // Compute Postorder
        auto postorder = function.getDFVisitor(Util::DFVOrder::PostOrder);
        // One Pass
        for (const auto &curr : postorder) {
            auto br = std::dynamic_pointer_cast<BRInst>(curr->getInsts().back());
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

                    // No unlinkBB because true_dest and false_dest are identical
                    // So just drop it.
                    br->dropFalseDest();
                    modified = true;
                    Logger::logDebug("[ADCE] on '", function.getName(),
                        "': drop BRInst of BasicBlock '", curr->getName(), "' 's identical destination");
                }
            } else {
                auto dest = br->getDest();
                // The following case is not safe in SSA. For example,
                //
                // bb0:
                //   // something
                //   br cond, bb1, %bb2
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
                //
                /* if (curr->getAllInstCount() == 1) { // curr is empty
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
                    //    - replace dest's phi with curr's dominator
                    unlinkBB(curr, dest);
                    for (const auto &use : curr->getUseList()) {
                        // getUseList -> get PreBB's BRInst or SuccBB's PHI
                        if (auto pre_br
                            = std::dynamic_pointer_cast<BRInst>(use->getUser())) {
                            auto pred = pre_br->getParent();
                            unlinkBB(pred, curr);
                            linkBB(pred, dest);
                            pre_br->replaceOperand(curr, dest);
                        } else if (auto dest_phi
                            = std::dynamic_pointer_cast<PHIInst>(use->getUser())) {
                            Err::gassert(dest_phi->getParent() == dest);
                            auto domtree = fam.getResult<DomTreeAnalysis>(function);
                            auto dom = domtree.nodes[curr.get()]->parent->bb;
                            dest_phi->replaceOperand(curr, dom->shared_from_this());
                        } else
                            Err::unreachable();
                    }
                    function.delBlock(curr);
                    modified = true;
                } */
                if (dest->getPreBB().size() == 1) {
                    // 3. Combine Blocks
                    // curr ends in a jump to dest and dest has only one predecessor
                    //
                    //          ...           ...                               ...   ...
                    //           |             ^                                 |     ^
                    //           v             |                                 v     |
                    // ... ---> curr  ----->  dest  ---> ...     <to>   ... ---> curr+dest ----> ...
                    //
                    // Combine `curr` and `dest`
                    unlinkBB(curr, dest);
                    curr->delInst(br);

                    // Since dest has only one predecessor, there can be no phi.
                    // Also, all dest's users are its successors' phi, replace them with curr.
                    Err::gassert(dest->getPhiCount() == 0);
                    dest->replaceSelf(curr);

                    for (const auto &dest_inst : dest->getInsts())
                        curr->addInst(dest_inst);

                    for (const auto &dest_succ : dest->getNextBB()) {
                        unlinkBB(dest, dest_succ);
                        linkBB(curr, dest_succ);
                    }


                    Logger::logDebug("[ADCE] on '", function.getName(),
                        "': Combined BasicBlock '", curr->getName(), "' and '", dest->getName(), "'.");

                    // Since `dest` only has one incoming block, delete `curr`'s br will
                    // make it have no users, so it's a safe delete.
                    function.delBlock(dest);
                    modified = true;
                }
                 if (dest->getAllInstCount() == 1) { // Dest is empty
                    auto dest_br = std::dynamic_pointer_cast<BRInst>(dest->getInsts().back());
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
                        unlinkBB(curr, dest);
                        curr->delInst(br);
                        curr->addInst(dest_br->clone()); // Warning: not shallow copy.
                        auto dest_succ0 = dest_br->getTrueDest();
                        auto dest_succ1 = dest_br->getFalseDest();
                        linkBB(curr, dest_succ0);
                        linkBB(curr, dest_succ1);

                        for (const auto& phi : dest_succ0->getPhiInsts())
                            phi->addPhiOper(phi->getValueForBlock(dest), curr);
                        for (const auto& phi : dest_succ1->getPhiInsts())
                            phi->addPhiOper(phi->getValueForBlock(dest), curr);

                        Logger::logDebug("[ADCE] on '", function.getName(),
                            "': Hoisted Branch of '", dest->getName(), "' to '", curr->getName(), "'.");
                        modified = true;
                    }
                }
            }
        }

        adce_cfg_modified |= modified;
    }

    if (adce_cfg_modified)
        return PM::PreservedAnalyses::none();

    if (adce_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR