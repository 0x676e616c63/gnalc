// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/licm.hpp"

#include "mir/passes/analysis/domtree_analysis.hpp"
#include "mir/passes/analysis/loop_analysis.hpp"

#include <algorithm>
#include <string>
#include <vector>

namespace MIR {
bool hasDefInBlock(const MIRBlk_p &block, const MIRInst_p &inst) {
    for (const auto &candidate : block->Insts()) {
        if (candidate == inst)
            continue;

        if (candidate->getDef() && candidate->getDef() == inst->getDef())
            return true;
    }
    return false;
}
bool isSafeToMove(const MLoop_p &loop, const MIRInst_p &inst) {
    if (inst->isGeneric()) {
        switch (inst->opcode<OpC>()) {
        case OpC::InstLoadAddress:
        case OpC::InstLoadStackObjectAddr:
        case OpC::InstLoadImm:
        case OpC::InstLoadImmEx:
        case OpC::InstLoadFPImm:
        case OpC::InstLoadImmToReg:
        case OpC::InstLoadFPImmToReg:
            break;
        default:
            return false;
        }
    } else if (inst->isRV()) {
        switch (inst->opcode<RVOpC>()) {
        case RVOpC::LA:
            break;
        default:
            return false;
        }
    } else if (inst->isARM()) {
        // FIXME
        return false;
    } else
        return false;

    // Now check if this register is defined in the loop.
    for (const auto &block : loop->getBlocks()) {
        if (hasDefInBlock(block, inst))
            return false;
    }

    return true;
}

PM::PreservedAnalyses MachineLICMPass::run(MIRFunction &function, FAM &fam) {
    auto &loop_info = fam.getResult<MachineLoopAnalysis>(function);
    auto &postdom = fam.getResult<PostDomTreeAnalysis>(function);

    bool licm_inst_modified = false;
    // Record the index in a Reverse Post Order Traversal.
    // This can make it easier to traverse basic blocks in a loop in a certain order.
    auto bbrpodfv = function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    std::unordered_map<MIRBlk_p, size_t> rpo_index;
    for (size_t i = 0; i < bbrpodfv.size(); ++i)
        rpo_index[bbrpodfv[i]] = i;

    for (const auto &top_level : loop_info) {
        // Do a post order traversal of the loop tree, so that we can move instructions in one go.
        auto lpdfv = top_level->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : lpdfv) {
            //
            // Hoist
            //
            auto loop_blocks = loop->getBlocks();
            if (auto preheader = loop->getPreHeader()) {
                // Visit blocks in a topological order
                std::sort(loop_blocks.begin(), loop_blocks.end(),
                          [&rpo_index](const auto &a, const auto &b) { return rpo_index[a] < rpo_index[b]; });
                for (const auto &bb : loop_blocks) {
                    // Don't Aggressive
                    if (!postdom.ADomB(bb.get(), preheader.get()))
                        continue;

                    // Keep the topological order.
                    std::vector<MIRInst_p_l::iterator> to_hoist;
                    for (auto it = bb->Insts().begin(); it != bb->Insts().end(); ++it) {
                        if (isSafeToMove(loop, *it))
                            to_hoist.emplace_back(it);
                    }

                    for (const auto &iter : to_hoist) {
                        auto inst = *iter;

                        preheader->addInstBeforeBr(inst);
                        bb->Insts().erase(iter);

                        inst->appendDbgData("licm_hoisted");
                        Logger::logDebug("[MachineLICM]: Hoisted '", inst->dbgDump(), "' from '", bb->getmSym(),
                                         "' to '", preheader->getmSym(), "'.");

                        // int j = 0, k = 0;
                        // for (const auto &blk : function.blks()) {
                        //     for (auto &i : blk->Insts()) {
                        //         if (i->getDef() == inst->getDef())
                        //             j++;
                        //         for (const auto &o : i->operands())
                        //             if (o == inst->getDef())
                        //                 k++;
                        //     }
                        // }
                        // Logger::logDebug("def Count: ", j, ".");
                        // Logger::logDebug("use Count: ", k, ".");
                        licm_inst_modified = true;
                    }
                }
            }
        }
    }
    name_cnt = 0;
    return licm_inst_modified ? PM::PreservedAnalyses::none() : PM::PreservedAnalyses::all();
}
} // namespace MIR
