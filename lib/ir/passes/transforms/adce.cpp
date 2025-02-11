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
            }
            else if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
                if (hasSideEffect(fam, call.get())) {
                    critical.emplace(inst);
                    worklist.emplace_back(inst);
                }
            }
        }
    }

    while (!worklist.empty()) {
        auto inst = worklist.front();
        worklist.pop_front();

        for (const auto& oper : inst->getOperands()) {
            if (oper->getValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                critical.emplace(std::dynamic_pointer_cast<Instruction>(oper->getValue()));
        }

        // TODO :
        // rdf (reverse dominance frontier) calculation
        std::vector<std::shared_ptr<BasicBlock>> rdf;
        for (const auto& bb : rdf) {
            auto terminal = bb->getInsts().back();
            critical.emplace(terminal);
            worklist.emplace_back(terminal);
        }
    }

    // Sweep
    for (const auto &block : function) {
        std::set<std::shared_ptr<Instruction>> dead;
        for (const auto &inst : *block) {
            if (critical.find(inst) == critical.end()) {
                if (auto br = std::dynamic_pointer_cast<BRInst>(inst)) {
                    // Rewrite it with an unconditional BRInst
                    // to the nearest marked post dominator
                    if (br->isConditional()) {
                        unlinkBB(block, br->getTrueDest());
                        unlinkBB(block, br->getFalseDest());
                    }
                    else
                        unlinkBB(block, br->getDest());
                    block->delInst(br);
                    // TODO
                    // block->addInst(std::make_shared<BRInst>(<nearest marked post dominator>))
                    adce_cfg_modified = true;
                }
                else
                    dead.emplace(inst);
            }
        }
        adce_inst_modified |= block->delInstIf([&dead](const auto& inst)
            { return dead.find(inst) != dead.end(); });
    }


    // Clean
    bool modified = true;
    while (modified) {
        modified = false;
        auto end = function.getBlocks().back();
        Err::gassert(end->getInsts().back()->getOpcode() == OP::RET);
        std::set<std::shared_ptr<BasicBlock>> visited;
        auto end_pres = end->getPreBB();
        std::deque postorder(end_pres.begin(), end_pres.end());

        while (!postorder.empty()) {
            auto curr = postorder.front();
            visited.emplace(curr);
            for (const auto& bb : curr->getPreBB()) {
                if (visited.find(bb) == visited.end())
                    postorder.emplace_back(bb);
            }
        }

        // One Pass
        for (const auto& curr : postorder) {
            auto br = std::dynamic_pointer_cast<BRInst>(curr->getInsts().back());
            Err::gassert(br != nullptr);
            if (br->isConditional()) {
                if (br->getTrueDest() == br->getFalseDest())
                {
                    // case 1
                    // replace the branch with a jump

                    // No unlinkBB because true_dest and false_dest are identical
                    // So just drop it.
                    br->dropFalseDest();
                    modified = true;
                }
            }
            else {
                auto dest = br->getDest();
                if (curr->getInsts().size() == 1) { // Curr is empty
                    // case 2
                    // replace transfers to `curr` with transfers to `dest`
                    //    - break in edge to curr and out edge to dest
                    //    - fix BRInst
                    //    - fix phi
                    for (const auto& use : curr->getUseList()) {
                        // getUseList -> get PreBB's BRInst or SuccBB's PHI
                        if (auto pre_br = std::dynamic_pointer_cast<BRInst>(use->getValue())) {
                            auto pred = pre_br->getParent();
                            unlinkBB(pred, curr);
                            linkBB(pred, dest);
                            pre_br->replaceOperand(curr, dest);

                            for (const auto& phi : dest->getPhiInsts())
                                phi->replaceOperand(curr, pred);

                            modified = true;
                        }
                    }
                }
                else if (dest->getPreBB().size() == 1) {
                    // case 3
                    // Combine `curr` and `dest`
                    unlinkBB(curr, dest);
                    curr->delInst(br);

                    // Phi contains Value's ptr, so moving instructions to another block
                    // don't invalidate Phi. Just take care of the CFG.
                    for (const auto& dest_phi : dest->getPhiInsts())
                        curr->addPhiInst(dest_phi);
                    for (const auto& dest_inst : dest->getInsts())
                        curr->addInst(dest_inst);

                    for (const auto& dest_succ : dest->getNextBB()) {
                        unlinkBB(dest, dest_succ);
                        linkBB(curr, dest_succ);
                    }

                    // Since `dest` only has one incoming block, delete `curr`'s br will
                    // make it have no users, so it's a safe delete.
                    function.delBlock(dest);
                    modified = true;
                }
                else if (dest->getInsts().size() == 1) { // Dest is empty
                    auto dest_br = std::dynamic_pointer_cast<BRInst>(dest->getInsts().back());
                    if (dest_br->isConditional()) {
                        // case 4
                        // overwrite `curr`'s jump with a copy of dest`'s branch
                        unlinkBB(curr, dest);
                        curr->delInst(br);

                        curr->addInst(dest_br->clone()); // Warning: not shallow copy.
                        if (dest_br->isConditional()) {
                            linkBB(curr, dest_br->getTrueDest());
                            linkBB(curr, dest_br->getFalseDest());
                        }
                        else
                            linkBB(curr, dest_br->getDest());

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
        return pa;
    }

    return PM::PreservedAnalyses::all();
}
} // namespace IR