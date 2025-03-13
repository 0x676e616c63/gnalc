#include "../../../../include/ir/passes/transforms/licm.hpp"

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/ir/pattern_match.hpp"

#include <algorithm>
#include <string>
#include <vector>

using namespace PatternMatch;

namespace IR {
bool isSafeToMove(const std::shared_ptr<Loop> &loop, const std::shared_ptr<Instruction> &inst,
                  AliasAnalysisResult &aa_res, FAM &fam) {
    // Only move what we know
    // Do not hoist cmp for codegen
    if (!match(inst, ClassesMatch<BinaryInst, FNEGInst, CALLInst, LOADInst, STOREInst, GEPInst, CastInst>{}))
        return false;

    // If the load's memory can be modified in the loop, give up.
    if (auto load = std::dynamic_pointer_cast<LOADInst>(inst)) {
        for (const auto &bb : loop->getBlocks()) {
            for (const auto &killer : *bb) {
                auto modref = aa_res.getInstModRefInfo(killer.get(), load->getPtr().get(), fam);
                if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef)
                    return false;
            }
        }
    }
    else if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
        if (!isPure(fam, call.get()))
            return false;
    } else if (auto store = std::dynamic_pointer_cast<STOREInst>(inst)) {
        for (const auto &bb : loop->getBlocks()) {
            for (const auto &killer : *bb) {
                auto modref = aa_res.getInstModRefInfo(killer.get(), store->getPtr().get(), fam);
                if (modref == ModRefInfo::Ref || modref == ModRefInfo::ModRef)
                    return false;
            }
        }
    }
    return true;
}

bool noUseInLoop(const std::shared_ptr<Loop> &loop, const std::shared_ptr<Instruction> &inst) {
    Err::gassert(loop->contains(inst->getParent().get()), "The instruction is not defined in the loop.");
    return std::all_of(inst->user_begin(), inst->user_end(), [&loop](const auto &user) {
        auto user_inst = std::dynamic_pointer_cast<Instruction>(user);
        return !loop->contains(user_inst->getParent().get());
    });
}

PM::PreservedAnalyses LICMPass::run(Function &function, FAM &fam) {
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    auto postdomtree = fam.getResult<PostDomTreeAnalysis>(function);
    auto loop_info = fam.getResult<LoopAnalysis>(function);
    auto aa_res = fam.getResult<AliasAnalysis>(function);

    bool licm_inst_modified = false;

    // Record the index in a Reverse Post Order Traversal.
    // This can make it easier to traverse basic blocks in a loop in a certain order.
    auto bbrpodfv = function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    std::map<BasicBlock *, size_t> rpo_index;
    for (size_t i = 0; i < bbrpodfv.size(); ++i)
        rpo_index[bbrpodfv[i].get()] = i;

    for (const auto &top_level : loop_info) {
        // Do a post order traversal of the loop tree, so that we can move instructions in one go.
        auto lpdfv = top_level->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : lpdfv) {
            std::vector<BasicBlock *> loop_blocks{loop->getBlocks().begin(), loop->getBlocks().end()};
            //
            // Sink
            //
            if (loop->hasDedicatedExits()) {
                // Visit blocks that near the exit first
                std::sort(loop_blocks.begin(), loop_blocks.end(),
                          [&rpo_index](const auto &a, const auto &b) { return rpo_index[a] > rpo_index[b]; });
                for (const auto &bb : loop_blocks) {
                    std::set<std::shared_ptr<Instruction>> dead_insts;
                    // Sink instructions that near the exit first
                    for (auto it = bb->rbegin(); it != bb->rend(); ++it) {
                        const auto &inst = *it;
                        if (isSafeToMove(loop, inst, aa_res, fam) && noUseInLoop(loop, inst)) {
                            // Sink instructions to the exit blocks that dominated by it.
                            // Keep track of the instructions we sunk.
                            // exit block -> new version
                            std::map<BasicBlock*, std::shared_ptr<Instruction>> sunk_insts;
                            auto exits = loop->getExitBlocks();
                            for (const auto& exit : exits) {
                                if (domtree.ADomB(bb, exit)) {
                                    auto sunk = makeClone(inst);
                                    if (inst->getType()->getTrait() == IRCTYPE::PTR)
                                        aa_res.addClonedInst(inst.get(), sunk.get());
                                    sunk->setName(inst->getName() + ".licm.s" + std::to_string(name_cnt++));
                                    exit->addInstAfterPhi(sunk);
                                    sunk_insts[exit] = sunk;
                                }
                            }

                            // If the instruction dominates no exit, sink them is not safe.
                            if (sunk_insts.empty())
                                continue;

                            for (const auto &user : inst->users()) {
                                auto user_inst = std::dynamic_pointer_cast<Instruction>(user);
                                if (loop->contains(user_inst->getParent().get()))
                                    continue;

                                // Outside Loop Use
                                auto phi = std::dynamic_pointer_cast<PHIInst>(user_inst);
                                Err::gassert(phi != nullptr, "Expected LCSSA in LICM.");
                                auto exit_block = phi->getParent();
                                Err::gassert(loop->isExit(exit_block.get()),
                                             "Expected LCSSA in LICM.");

                                const auto& sunk = sunk_insts[exit_block.get()];
                                Err::gassert(sunk != nullptr);
                                phi->replaceSelf(sunk);
                                dead_insts.emplace(phi);
                            }
                            dead_insts.emplace(inst);
                            for (const auto& [exit, sunk] : sunk_insts) {
                                if (!match(sunk, ClassesMatch<STOREInst, CALLInst>{}) && sunk->getUseCount() == 0)
                                    dead_insts.emplace(sunk);
                            }
                            Logger::logDebug("[LICM] on '", function.getName(), "': Sunk an instruction '",
                                             inst->getName(), "' to exits.");
                            licm_inst_modified = true;
                        }
                    }
                    bb->delInstIf(
                        [&dead_insts](const auto &inst) {
                            return dead_insts.find(inst) != dead_insts.end();
                        });
                }
            }
            //
            // Hoist
            //
            if (auto preheader = loop->getPreHeader()) {
                // Visit blocks in a topological order
                std::sort(loop_blocks.begin(), loop_blocks.end(),
                          [&rpo_index](const auto &a, const auto &b) { return rpo_index[a] < rpo_index[b]; });
                for (const auto &bb : loop_blocks) {
                    // If this block does not post dominates the preheader,
                    // hoisting them is not safe.
                    if (!postdomtree.ADomB(bb, preheader))
                        continue;
                    std::set<std::shared_ptr<Instruction>> to_hoist;
                    for (const auto &inst : *bb) {
                        if (isSafeToMove(loop, inst, aa_res, fam) &&
                            loop->isAllOperandsLoopInvariant(inst.get()))
                            to_hoist.emplace(inst);
                    }

                    for (const auto &inst : to_hoist) {
                        inst->setName(inst->getName() + ".licm.h" + std::to_string(name_cnt++));
                        auto insert_before = preheader->getTerminator()->getIter();
                        if (auto br = preheader->getBRInst()) {
                            if (br->isConditional()) {
                                if (auto cond_inst = std::dynamic_pointer_cast<Instruction>(br->getCond())) {
                                    if (cond_inst->getParent().get() == preheader)
                                        insert_before = cond_inst->getIter();
                                    else
                                        Logger::logWarning("Cond '", cond_inst->getName(),
                                            "' and BRInst are in separate block.");
                                }
                            }
                        }
                        moveInst(inst, preheader->shared_from_this(), insert_before);
                        Logger::logDebug("[LICM] on '", function.getName(), "': Hoisted an instruction '",
                            inst->getName(), "' to basic block '", preheader->getName(), "'.");
                        licm_inst_modified = true;
                    }
                }
            }
        }
    }
    name_cnt = 0;
    return licm_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR
