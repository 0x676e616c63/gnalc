#include "ir/passes/transforms/adce.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/control.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"

#include <deque>

namespace IR {
PM::PreservedAnalyses ADCEPass::run(Function &function, FAM &fam) {
    bool adce_inst_modified = false;
    bool adce_cfg_modified = false;

    std::deque<pInst> worklist;
    std::set<pInst> critical;
    // Mark
    for (const auto &block : function) {
        for (const auto &inst : *block) {
            if (inst->getOpcode() == OP::STORE || inst->getOpcode() == OP::RET) {
                critical.emplace(inst);
                worklist.emplace_back(inst);
            } else if (auto call = inst->as<CALLInst>()) {
                if (hasSideEffect(fam, call)) {
                    critical.emplace(inst);
                    worklist.emplace_back(inst);
                }
            } else if (auto br = inst->as<BRInst>()) {
                // The treatment of control-flow operations is more complex.
                // Every jump is considered useful.
                // Branches are considered useful only if the execution of a useful operation
                // depends on their presence.
                if (!br->isConditional() || block->getIndex() == 0) {
                    critical.emplace(br);
                    worklist.emplace_back(br);
                }
            }
        }
    }

    auto &postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    while (!worklist.empty()) {
        auto inst = worklist.front();
        worklist.pop_front();

        std::vector new_alive_blocks{inst->getParent()};

        auto uses = inst->getRawOperands();
        for (const auto &use : uses) {
            if (auto oper = use->getValue()->as<Instruction>()) {
                if (critical.find(oper) == critical.end()) {
                    critical.emplace(oper);
                    worklist.emplace_back(oper);
                }
            }
        }

        if (auto phi = inst->as<PHIInst>()) {
            for (const auto &[_val, bb] : phi->incomings())
                new_alive_blocks.emplace_back(bb);
        }

        for (const auto &alivebb : new_alive_blocks) {
            auto rdf = postdomtree.getDomFrontier(alivebb);
            for (const auto &bb : rdf) {
                auto br = bb->getBRInst();
                Err::gassert(br != nullptr);
                if (critical.find(br) == critical.end()) {
                    critical.emplace(br);
                    worklist.emplace_back(br);
                }
            }
        }
    }

    // postdomtree.printDomTree();
    // for (const auto& bb : function) {
    //     auto rdf = postdomtree.getDomFrontier(bb.get());
    //     std::cerr << bb->getName() << ": ";
    //     for (const auto &b : rdf) {
    //         std::cerr << b->getName() << ", ";
    //     }
    //     if (postdomtree.ADomB(bb.get(), bb.get())) {
    //         std::cerr << "TRUE";
    //     }
    //     else
    //         std::cerr << "F";
    //     std::cerr << std::endl;
    // }
    //
    // for (const auto& c : critical) {
    //     std::cerr << c->getName() << ", " << c->getParent()->getName() << std::endl;
    // }
    // std::cerr << std::endl;

    std::set<pPhi> dead_phis;
    std::set<pInst> dead;

    // Sweep
    for (const auto &block : function) {
        // Note that `getAllInsts()` returns a temporary object.
        // Deleting/Adding Instruction while iterating it is safe.
        auto all_insts = block->getAllInsts();
        for (const auto &inst : all_insts) {
            if (critical.find(inst) == critical.end()) {
                if (auto br = inst->as<BRInst>()) {
                    Err::gassert(br->isConditional());
                    // Rewrite it with an unconditional BRInst
                    // to the nearest marked post dominator
                    bool dead_br = safeUnlinkBB(block, br->getTrueDest(), dead_phis);
                    Err::gassert(!dead_br);
                    // After safeUnlink, br becomes a jump, but not dead.
                    dead_br = safeUnlinkBB(block, br->getDest(), dead_phis);
                    // Here br is dead.
                    Err::gassert(dead_br);
                    block->delInst(br);

                    auto nearest_pdom = postdomtree[block];
                    bool found = false;
                    do {
                        nearest_pdom = nearest_pdom->parent();
                        for (const auto &pdomphi : nearest_pdom->block()->phis()) {
                            if (critical.find(pdomphi) != critical.end()) {
                                found = true;
                                break;
                            }
                        }
                        for (const auto &pdominst : *nearest_pdom->block()) {
                            if (critical.find(pdominst) != critical.end()) {
                                found = true;
                                break;
                            }
                        }
                        if (found)
                            break;
                    } while (nearest_pdom->parent() != nullptr);
                    // Since, by definition, the exit block is useful, this search must terminate.
                    // Also, if there is a virtual root, its children must also be exit blocks. Thus, the
                    // search can't terminate at the virtual root.
                    Err::gassert(found && nearest_pdom->block() != nullptr);
                    linkBB(block, nearest_pdom->block());
                    // The new BRInst won't be iterated in `all_insts`. So no need to add it to critical.
                    block->addInst(std::make_shared<BRInst>(nearest_pdom->block()));
                    adce_cfg_modified = true;
                    Logger::logDebug("[ADCE]: Retargeting '", block->getName(), "' to '",
                                     nearest_pdom->block()->getName());
                } else
                    dead.emplace(inst);
            }
        }
    }

    auto dfv = function.getDFVisitor();
    std::unordered_set<pBlock> reachable{dfv.begin(), dfv.end()};

    for (const auto &block : function) {
        if (reachable.find(block) == reachable.end()) {
            auto succs = block->getNextBB();
            for (const auto &succ : succs)
                safeUnlinkBB(block, succ, dead_phis);
        }
    }

    adce_cfg_modified |=
        function.delBlockIf([&reachable](const auto &block) { return reachable.find(block) == reachable.end(); });

    for (auto &block : function) {
        // Trivially dead phi might in `dead`
        adce_inst_modified |= block->delInstIf([&dead](const auto &inst) { return dead.find(inst) != dead.end(); });
        // `dead_phis` is phis that become dead in `safeUnlink`
        adce_inst_modified |= block->delInstIf(
            [&dead_phis](const auto &p) { return dead_phis.find(p->template as<PHIInst>()) != dead_phis.end(); },
            BasicBlock::DEL_MODE::PHI);
    }

    if (adce_cfg_modified)
        return PreserveNone();

    if (adce_inst_modified)
        return PreserveCFGAnalyses();

    return PreserveAll();
}
} // namespace IR