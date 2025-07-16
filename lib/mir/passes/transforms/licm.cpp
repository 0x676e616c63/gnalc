// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/licm.hpp"

#include "mir/passes/analysis/domtree_analysis.hpp"
#include "mir/passes/analysis/loop_analysis.hpp"

#include <algorithm>
#include <string>
#include <vector>

namespace MIR {
bool isSafeAndProfitableToHoist(const MIRInst_p &inst) {
    if (inst->isGeneric()) {
        switch (inst->opcode<OpC>()) {
        case OpC::InstLoadAddress:
        case OpC::InstLoadStackObjectAddr:
        case OpC::InstLoadImmToReg:
        case OpC::InstLoadFPImmToReg:
            break;
        case OpC::InstLoadImm:
        case OpC::InstLoadImmEx:
        case OpC::InstLoadFPImm:
            // They can be optimized by zero register. Hoisting them is not profitable.
            if (inst->getOp(1)->imme() == 0)
                return false;
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
                    std::vector<MIRInst_p> to_hoist;
                    for (const auto &inst : bb->Insts()) {
                        if (isSafeAndProfitableToHoist(inst))
                            to_hoist.emplace_back(inst);
                    }

                    for (const auto &inst : to_hoist) {
                        // Log before we change the instruction.
                        Logger::logDebug("[MachineLICM]: Hoisted '", inst->dbgDump(), "' from '", bb->getmSym(),
                                         "' to '", preheader->getmSym(), "'.");

                        auto hoisted_li = inst->clone();
                        auto &ctx = function.Context();
                        auto hoisted_def = MIROperand::asVReg(ctx.nextId(), OpT::Int32);
                        hoisted_li->setOperand<0>(hoisted_def, ctx);
                        preheader->addInstBeforeBr(hoisted_li);

                        inst->resetOpcode(inst->ensureDef()->isISA() ? OpC::InstCopyToReg : OpC::InstCopy);
                        inst->setOperand<1>(hoisted_def, ctx);

                        hoisted_li->appendDbgData("licm_hoisted");
                        inst->appendDbgData("licm_copy");
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
