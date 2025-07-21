// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/mir/passes/analysis/liveanalysis.hpp"

using namespace MIR;

PM::UniqueKey LiveAnalysis::Key;

Liveness LiveAnalysis::run(MIRFunction &mfunc, FAM &fam) {
    LiveAnalysisImpl impl;
    impl.runImpl(mfunc);
    return impl.getInfo();
}

Liveness LiveAnalysisImpl::runImpl(MIRFunction &mfunc) {

    if (liveinfo != std::nullopt) {
        liveinfo->clear();
    } else {
        liveinfo = std::make_optional<Liveness>();
    }

    runOnFunc(mfunc);
    return liveinfo.value();
}

void LiveAnalysisImpl::runOnFunc(MIRFunction &_mfunc) {
    mfunc = &_mfunc;

    auto postDFSSeq = mfunc->getDFVisitor<Util::DFVOrder::PostOrder>();
    bool change = true;
    while (change) {
        change = false;
        for (const auto &mblk : postDFSSeq) {
            for (const auto &succ : mblk->succs()) {
                for (const auto &livevar : liveinfo->liveIn[succ]) {
                    change |= liveinfo->liveOut[mblk].insert(livevar).second;
                }
            }

            change |= runOnBlk(mblk);
        }
    }
}
bool LiveAnalysisImpl::runOnBlk(const MIRBlk_p &mblk) {

    std::unordered_map<MIRInst_p, std::unordered_set<MIROperand_p>> instLiveIn;
    std::unordered_map<MIRInst_p, std::unordered_set<MIROperand_p>> instLiveOut;

    const auto &minsts = mblk->Insts();
    instLiveIn.reserve(minsts.size());
    instLiveOut.reserve(minsts.size());

    instLiveOut[minsts.back()] = liveinfo->liveOut[mblk];

    for (auto it = minsts.rbegin(); it != minsts.rend(); ++it) {
        runOnInst(*it, instLiveIn[*it], instLiveOut[*it]);
        if (it != std::prev(minsts.rend())) {
            instLiveOut[*std::next(it)] = instLiveIn[*it];
        }
    }

    if (liveinfo->liveIn[mblk] == instLiveIn[mblk->Insts().front()]) {
        return false;
    }

    liveinfo->liveIn[mblk] = instLiveIn[mblk->Insts().front()];

    return true;
}
void LiveAnalysisImpl::runOnInst(const MIRInst_p &minst, std::unordered_set<MIROperand_p> &liveIn,
                                 std::unordered_set<MIROperand_p> &liveOut) {

    auto def = extractDef(minst);
    auto uses = extractUses(minst);

    for (auto &muse : uses) {
        liveIn.insert(muse);

        if (!liveinfo->intervalLengths.count(muse)) {
            liveinfo->intervalLengths[muse] = 1;
        } else {
            ++liveinfo->intervalLengths[muse];
        }
    }

    for (auto &live_out : liveOut) {
        if (live_out != def) {
            liveIn.insert(live_out);
        }
    }
}

std::vector<MIROperand_p> LiveAnalysisImpl::extractUses(const MIRInst_p &minst) {
    std::vector<MIROperand_p> uses;
    const auto &mops = minst->operands();

    size_t start = minst->getDef() ? 1 : 0;
    for (size_t i = start; i < mops.size(); ++i) {
        if (mops[i] && mops[i]->isReg()) {
            uses.emplace_back(mops[i]);
        }
    }
    return uses;
}

MIROperand_p LiveAnalysisImpl::extractDef(const MIRInst_p &minst) {
    return minst->getDef(); //
}