#include "../../include/ir/block_utils.hpp"

#include "../../include/utils/logger.hpp"

#include <list>
#include <utility>
#include <algorithm>

namespace IR {
void linkBB(const std::shared_ptr<BasicBlock> &prebb,
                   const std::shared_ptr<BasicBlock> &nxtbb) {
    prebb->addNextBB(nxtbb);
    nxtbb->addPreBB(prebb);
}

void unlinkBB(const std::shared_ptr<BasicBlock> &prebb,
                   const std::shared_ptr<BasicBlock> &nxtbb) {
    bool ok = prebb->delNextBB(nxtbb);
    Err::gassert(ok);
    ok = nxtbb->delPreBB(prebb);
    Err::gassert(ok);
}

bool safeUnlinkBB(const std::shared_ptr<BasicBlock> &prebb,
                  const std::shared_ptr<BasicBlock> &nxtbb,
                  std::set<std::shared_ptr<PHIInst>>& dead_phis) {
    bool need_to_remove_br = false;
    // Unlink CFG
    unlinkBB(prebb, nxtbb);

    // Break BRInst
    auto br = prebb->getBRInst();
    Err::gassert(br != nullptr);
    if (br->isConditional()) {
        if (br->getTrueDest() == nxtbb)
            br->dropTrueDest();
        else {
            Err::gassert(br->getFalseDest() == nxtbb,
                "The given block is not a successor.");
            br->dropFalseDest();
        }
    }
    else {
        Err::gassert(br->getDest() == nxtbb, "The given block is not a successor.");
        // Well, the block has no successor, this might because we are deleting unreachable blocks.
        // Anyway, tell the caller about it.
        need_to_remove_br = true;
    }

    // Handle PHI
    // This a little tricky because when we're deleting a PHIInst's operand,
    // the result phi might only have one operand. In that case we want to
    // replace the phi with the value in that operand.
    // But when this involving multiple blocks,
    // the replacing might affect other phi in other block, thus cause a replacing propagation.
    // As the propagation goes, a phi can end up self-referenced or even empty (dead block only).
    //
    //        bb0 -- bb1
    //          \    |
    //           bb2
    //
    // bb0:
    //    %0 = phi [ %1, %bb1 ] [ %2, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %2, %bb2 ]
    // bb2:
    //    %2 = phi [ %0, %bb0 ] [ %1, %bb1 ]
    //
    // First we unlink bb1 -> bb2
    //    %2 = phi [ %0, %bb0 ],  then we want to replace %2 with %0
    // So,
    // bb0:
    //    %0 = phi [ %1, %bb1 ] [ %0, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    //
    // Then we unlink bb1 -> bb0
    //    %0 = phi [ %0, %bb2 ],  here we can't replace because that makes no sense.
    // So,
    // bb0:
    //    %0 = phi [ %0, %bb2 ]
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    //
    // Finally we unlink bb2 -> bb0,
    //    %0 = phi [], a weird empty phi occurred.
    // Note that this can only happen in dead block.
    // And we can't figure if a block is dead, because there might be dead loops.
    // So we just mark the phi as dead.
    // So,
    // bb0:
    //    %0 = phi []
    // bb1:
    //    %1 = phi [ %0, %bb0 ] [ %0, %bb2 ]
    // bb2:
    for (const auto& phi : nxtbb->phis()) {
        // Delete the phi operand from the unlinked `prebb`
        if (phi->delPhiOperByBlock(prebb)) {
            // Simplify PHI
            auto opers = phi->getPhiOpers();
            if (opers.size() == 1) {
                // Only one operand, check if it is self-reference.
                // If it is self-reference, replaceSelf makes no sense.
                if (opers[0].value != phi)
                    phi->replaceSelf(opers[0].value);
                dead_phis.emplace(phi);
            }
            else if (opers.empty())
                dead_phis.emplace(phi);
        }
    }
    return need_to_remove_br;
}

void moveBlock(const std::shared_ptr<BasicBlock>& bb,
    const std::shared_ptr<Function>& new_func, FunctionBBIter location) {
    Err::gassert(bb->getParent() != new_func, "Function not changed");
    auto target = std::dynamic_pointer_cast<BasicBlock>(bb->shared_from_this());
    bb->getParent()->delFirstOfBlock(target);
    new_func->addBlock(location, target);
}
void moveBlocks(FunctionBBIter beg, FunctionBBIter end,
    const std::shared_ptr<Function>& new_func, FunctionBBIter location) {
    std::vector<std::shared_ptr<BasicBlock>> tmp{beg, end};
    for (const auto& bb : tmp)
        moveBlock(bb, new_func, location);
}
void moveBlock(const std::shared_ptr<BasicBlock>& bb,
    const std::shared_ptr<Function>& new_func) {
    moveBlock(bb, new_func, new_func->end());
}
void moveBlocks(FunctionBBIter beg, FunctionBBIter end,
    const std::shared_ptr<Function>& new_func) {
    moveBlocks(beg, end, new_func, new_func->end());
}

void foldPHI(const std::shared_ptr<BasicBlock> &bb, bool preserve_lcssa) {
    std::set<std::shared_ptr<Instruction>> dead_phis;
    for (const auto& phi : bb->phis()) {
        if (phi->getUseCount() == 0) {
            dead_phis.emplace(phi);
            continue;
        }
        auto phi_opers = phi->getPhiOpers();
        Err::gassert(!phi_opers.empty());
        if (preserve_lcssa && phi_opers.size() == 1)
            continue;
        std::shared_ptr<Value> common_value = phi_opers[0].value;
        for (const auto& [v, b] : phi_opers) {
            if (common_value != v) {
                common_value = nullptr;
                break;
            }
        }
        if (common_value != nullptr) {
            if (common_value == phi)
                Logger::logWarning("IR::foldPHI: Skipped self-reference phi.");
            else {
                phi->replaceSelf(common_value);
                dead_phis.emplace(phi);
            }
        }
    }
    bb->delInstIf([&dead_phis](const auto& inst) {
        return dead_phis.find(inst) != dead_phis.end();
    }, BasicBlock::DEL_MODE::PHI);
}

void removeIdenticalPhi(const std::shared_ptr<BasicBlock> &bb) {
    using ValBBPair = std::pair<std::shared_ptr<Value>, std::shared_ptr<BasicBlock>>;
    std::vector<std::pair<std::shared_ptr<PHIInst>, std::vector<ValBBPair>>> phi_info;
    for (const auto& phi : bb->phis()) {
        phi_info.emplace_back(phi, std::vector<ValBBPair>{});
        auto phi_opers = phi->getPhiOpers();
        for (const auto& [v, b] : phi_opers)
            phi_info.back().second.emplace_back(v, b);
        std::sort(phi_info.back().second.begin(), phi_info.back().second.end());
    }

    std::set<std::shared_ptr<Instruction>> dead_phis;
    for (size_t i = 0; i < phi_info.size(); ++i) {
        if (dead_phis.count(phi_info[i].first))
            continue;
        for (size_t j = i + 1; j < phi_info.size(); ++j) {
            if (phi_info[i].second == phi_info[j].second) {
                phi_info[j].first->replaceSelf(phi_info[i].first);
                dead_phis.emplace(phi_info[j].first);
            }
        }
    }
    bb->delInstIf([&dead_phis](const auto& inst) {
        return dead_phis.find(inst) != dead_phis.end();
    }, BasicBlock::DEL_MODE::PHI);
}

std::shared_ptr<BasicBlock> breakCriticalEdge(
    const std::shared_ptr<BasicBlock>& pred, const std::shared_ptr<BasicBlock>& succ) {
    {
        bool ok = false;
        for (const auto& s : pred->succs()) {
            if (s == succ) {
                ok = true;
                break;
            }
        }
        Err::gassert(ok, "There is no edge between '"
            + pred->getName() + "' and '" + succ->getName() + "'.");
    }

    if (pred->getNumSuccs() == 1 || succ->getNumPreds() == 1)
        return nullptr;

    // Create a new block
    auto new_block = std::make_shared<BasicBlock>(
        pred->getName() + "_bce_" + succ->getName());
    pred->getParent()->addBlock(succ->getIter(), new_block);

    // CFG
    unlinkBB(pred, succ);
    linkBB(pred, new_block);
    linkBB(new_block, succ);

    // BRInst
    auto br = pred->getBRInst();
    Err::gassert(br != nullptr);
    bool ok = br->replaceOperand(succ, new_block);
    Err::gassert(ok);
    new_block->addInst(std::make_shared<BRInst>(succ));

    // PHI
    for (const auto& phi : succ->phis()) {
        ok = phi->replaceOperand(pred, new_block);
        Err::gassert(ok);
    }

    return new_block;
}
bool breakAllCriticalEdges(const Function & function) {
    bool modified = false;
    auto dfv = function.getDFVisitor();
    for (const auto& curr : dfv) {
        auto nextbbs = curr->getNextBB();
        if (nextbbs.size() <= 1) continue;
        for (const auto& succ : nextbbs) {
            auto newbb = breakCriticalEdge(curr, succ);
            modified |= (newbb != nullptr);
        }
    }
    return modified;
}
} // namespace IR