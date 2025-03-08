#include "../../../../include/ir/passes/transforms/adce.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/block_utils.hpp"

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
            if (auto br = bb->getBRInst()) {
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
        // Note that `getAllInsts()` returns a temporary object.
        // Deleting/Adding Instruction while iterating it is safe.
        auto all_insts = block->getAllInsts();
        for (const auto &inst : all_insts) {
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
                    linkBB(block, nearest_pdom->bb->shared_from_this());
                    // The new BRInst won't be iterated in `all_insts`. So no need to add it to critical.
                    block->addInst(std::make_shared<BRInst>(nearest_pdom->bb->shared_from_this()));
                    adce_cfg_modified = true;
                } else
                    dead.emplace(inst);
            }
        }
    }

    auto dfv = function.getDFVisitor();
    std::unordered_set<std::shared_ptr<BasicBlock>> reachable{dfv.begin(), dfv.end()};

    for (const auto& block : function) {
        if (reachable.find(block) == reachable.end()) {
            for (const auto& succ : block->getNextBB())
                safeUnlinkBB(block, succ, dead_phis);
        }
    }

    adce_cfg_modified |= function.delBlockIf([&reachable](const auto &block) {
        return reachable.find(block) == reachable.end();
    });

    for (auto &block : function) {
        // Trivially dead phi might in `dead`
        adce_inst_modified |= block->delInstIf([&dead](const auto &inst) {
            return dead.find(inst) != dead.end();
        });
        // `dead_phis` is phis that become dead in `safeUnlink`
        adce_inst_modified |= block->delInstIf([&dead_phis](const auto &p) {
            return dead_phis.find(std::dynamic_pointer_cast<PHIInst>(p)) != dead_phis.end();
        }, BasicBlock::DEL_MODE::PHI);
    }

    if (adce_cfg_modified)
        return PreserveNone();

    if (adce_inst_modified)
        return PreserveCFGAnalyses();

    return PreserveAll();
}
} // namespace IR