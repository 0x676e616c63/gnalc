// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/passes/transforms/uselessBlkEli.hpp"
#include "legacy_mir/instructions/branch.hpp"

using namespace LegacyMIR;

PM::PreservedAnalyses uselessBlkEli::run(Function &function, FAM &fam) {
    func = &function;

    impl();

    return PM::PreservedAnalyses::all();
}

void uselessBlkEli::impl() {
    auto &blks = func->getBlocks();

    for (auto it = blks.begin(); it != blks.end();) {
        auto &blk = *it;
        ++it;

        if (isUseless(blk))
            blkConsolidate(blk);
    }
}

bool uselessBlkEli::isUseless(const BlkP &blk) {
    ///@note 仅有一个branch语句, 一个succ的是无用块
    ///@todo 也许还有别的种类

    const auto insts = blk->getInsts();

    if (blk->getSuccs().size() == 1 && insts.size() == 1 &&
        std::get<OpCode>(insts.begin()->get()->getOpCode()) == OpCode::B)
        return true;

    return false;
}

void uselessBlkEli::blkConsolidate(const BlkP &blk) {
    ///@brief 1. 访问preds, 改写branch和对应的Succ
    ///@brief 2. 访问succs, 删除对应Pred, 更新为新Preds
    ///@brief 3. 移除blk

    auto blk_label = blk->getName();
    auto dest = std::dynamic_pointer_cast<branchInst>(*(blk->getInsts().begin())); // string

    auto preds = blk->getPreds();
    auto succ = *(blk->getSuccs().begin()); // only one

    for (const auto &pred : preds) {
        auto &insts = pred->getInsts();

        for (auto it = insts.begin(); it != insts.end(); ++it) {
            auto branch = std::dynamic_pointer_cast<branchInst>(*it);

            if (!branch || branch->getJmpTo() != blk_label)
                continue; // maybe more than one

            branch->changeJmpTo(dest->getJmpTo());
        }

        pred->delSucc_try(blk);
        pred->addSucc(succ); // maybe exist already

        succ->addPred(pred);
    }
    succ->delPred(blk);

    func->delBlock(blk);
}
#endif