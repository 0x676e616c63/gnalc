// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/licm.hpp"

#include "mir/passes/analysis/domtree_analysis.hpp"
#include "mir/passes/analysis/loop_analysis.hpp"

#include <algorithm>
#include <string>
#include <vector>

namespace MIR {
// Hoisting immload can cause too much register pressure if not restricted.
// Therefore, we only hoist immloads that costs more than one instruction.
bool isSafeAndProfitableToHoist(const MIRInst_p &inst, Arch arch) {
    if (inst->isGeneric()) {
        switch (inst->opcode<OpC>()) {
        case OpC::InstLoadFPImmToReg:
        case OpC::InstLoadFPImm:
            // They can be optimized by zero register. Hoisting them is not profitable.
            if (inst->getOp(1)->imme() == 0)
                return false;
            // Float/Vector register pressure usually is low
            return true;
        // FIXME:
        // case OpC::InstLoadImmEx: {
        //     auto encoding = inst->getOp(1)->imme();
        //     if (encoding == 0)
        //         return false;
        //     if (arch == Arch::ARMv8) // FIXME
        //         return true;
        //     if (arch == Arch::RISCV64) {
        //         if (RV64::is12BitImm(encoding, true))
        //             return true;
        //     }
        //     return false;
        // }
        // case OpC::InstLoadImm: {
        //     auto encoding = inst->getOp(1)->imme();
        //     if (encoding == 0)
        //         return false;
        //     if (arch == Arch::ARMv8) {
        //         if (!ARMv8::isBitMaskImme(encoding) && !ARMv8::is12ImmeWithProbShift(encoding) && encoding > 0XFFFF)
        //             return true;
        //     }
        //     if (arch == Arch::RISCV64) {
        //         if (!RV64::is12BitImm(encoding, false))
        //             return true;
        //     }
        //     return false;
        // }
        case OpC::InstLoadAddress:
        case OpC::InstLoadStackObjectAddr:
        case OpC::InstLoadImmToReg:
            // Hoisting them causes too much register pressure
            // TODO: try to figure out register pressure
            return false;
        default:
            return false;
        }
    }
    return false;
}

PM::PreservedAnalyses MachineLICMPass::run(MIRFunction &function, FAM &fam) {
    auto &loop_info = fam.getResult<MachineLoopAnalysis>(function);
    auto &postdom = fam.getResult<PostDomTreeAnalysis>(function);

    auto arch = function.Context().infos.arch;
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
                    // Don't be aggressive.
                    if (!postdom.ADomB(bb.get(), preheader.get()))
                        continue;

                    // Keep the topological order.
                    std::vector<MIRInst_p> to_hoist;
                    for (const auto &inst : bb->Insts()) {
                        if (isSafeAndProfitableToHoist(inst, arch))
                            to_hoist.emplace_back(inst);
                    }

                    for (const auto &inst : to_hoist) {
                        // Log before we change the instruction.
                        Logger::logDebug("[MachineLICM]: Hoisted '", inst->dbgDump(), "' from '", bb->getmSym(),
                                         "' to '", preheader->getmSym(), "'.");

                        auto hoisted_li = inst->clone();
                        auto &ctx = function.Context();
                        auto hoisted_def = MIROperand::asVReg(ctx.nextId(), inst->ensureDef()->type());
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
