// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/tail_recursion_elimination.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/memory.hpp"

namespace IR {
PM::PreservedAnalyses TailRecursionEliminationPass::run(Function &function, FAM &manager) {
    bool tailopt_cfg_modified = false;
    auto exitbbs = function.getExitBBs();
    std::vector<std::pair<pCall, pRet>> worklist;
    for (const auto &block : exitbbs) {
        for (auto iter = block->begin(); std::next(iter) != block->end(); ++iter) {
            auto call = (*iter)->as<CALLInst>();
            auto ret = (*std::next(iter))->as<RETInst>();
            if (call != nullptr && ret != nullptr && ((call->isVoid() && ret->isVoid()) || ret->getRetVal() == call)) {
                // Tail position: (ret immediately follows call and ret uses value of call or is void)
                // If call->func == function, tail recursion.
                // Otherwise, tail call
                if (call->getFunc().get() == &function)
                    worklist.emplace_back(call, ret);
                else
                    call->setTailCall(true);
            }
        }
    }

    if (!worklist.empty()) {
        // If the entry block have ALLOCInst, we divide it into two blocks
        // Otherwise we create a new block as the new entry block
        auto oldEntryBlock = *function.begin();

        std::vector<pAlloca> allocas;
        for (const auto &inst : *oldEntryBlock) {
            if (auto alloc = inst->as<ALLOCAInst>())
                allocas.emplace_back(alloc);
            else
                break;
        }

        auto newEntryBlock = std::make_shared<BasicBlock>("%tre.bb" + std::to_string(name_cnt++));
        for (const auto &alloc : allocas)
            moveInst(alloc, newEntryBlock, newEntryBlock->begin());

        newEntryBlock->addInst(std::make_shared<BRInst>(oldEntryBlock));
        linkBB(newEntryBlock, oldEntryBlock);
        function.addBlockAsEntry(newEntryBlock);

        // replace params with PHI
        auto &params = function.getParams();
        std::vector<pPhi> param_phis;
        for (const auto &param : params) {
            auto phiInst = std::make_shared<PHIInst>("%tre.fp" + std::to_string(name_cnt++), param->getType());
            param->replaceSelf(phiInst);
            phiInst->addPhiOper(param, newEntryBlock);
            param_phis.emplace_back(phiInst);
        }
        for (const auto &[call, ret] : worklist) {
            auto exit_block = call->getParent();
            const auto &args = call->getArgs();
            for (size_t i = 0; i < args.size(); ++i)
                param_phis[i]->addPhiOper(args[i], exit_block);

            exit_block->delFirstOfInst(call);
            exit_block->delFirstOfInst(ret);

            // Then we jump to the old entry block
            exit_block->addInst(std::make_shared<BRInst>(oldEntryBlock));
            linkBB(exit_block, oldEntryBlock);
        }

        for (const auto &phi : param_phis) {
            oldEntryBlock->addPhiInst(phi);
        }

        tailopt_cfg_modified = true;
    }

    return tailopt_cfg_modified ? PreserveNone() : PreserveAll();
}

} // namespace IR