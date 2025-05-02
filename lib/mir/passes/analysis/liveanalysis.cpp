#include "mir/passes/analysis/liveanalysis.hpp"

using namespace MIR_new;

PM::UniqueKey LiveAnalysis::Key;

Liveness LiveAnalysis::run(MIRFunction &mfunc, FAM &fam) {
    LiveAnalysisImpl impl;
    impl.runImpl(mfunc);
    return impl.getInfo();
}

Liveness LiveAnalysisImpl::runImpl(MIRFunction &mfunc) {
    liveinfo->clear();
    runOnFunc(mfunc);
    return liveinfo.value();
}

void LiveAnalysisImpl::runOnFunc(MIRFunction &_mfunc) {
    mfunc = &_mfunc;

    const auto &mblks = mfunc->blks();

    std::vector<MIRBlk_p> postDFSSeq;
    std::set<MIRBlk_p> visited{mblks.front()};

    std::deque<std::pair<MIRBlk_p, bool>> s{{mblks.front(), false}};

    while (!s.empty()) {
        auto [curr, isProcessed] = s.back();
        s.pop_back();

        if (isProcessed) {
            postDFSSeq.emplace_back(curr);
        } else {
            s.emplace_back(curr, true);

            const auto &children = curr->succs();

            for (const auto child : children) {
                if (visited.insert(child).second) {
                    s.emplace_back(child, false);
                }
            }
        }
    }

    bool change = true;

    while (change) {
        change = false;
        for (const auto &mblk : postDFSSeq) {
            for (auto &succ : mblk->succs()) {
                for (auto &livevar : liveinfo->liveIn[succ]) {
                    change |= liveinfo->liveOut[mblk].insert(livevar).second;
                }
            }

            change |= runOnBlk(mblk);
        }
    }
}
bool LiveAnalysisImpl::runOnBlk(const MIRBlk_p &mblk) {

    std::map<MIRInst_p, std::set<MIROperand_p>> instLiveIn;
    std::map<MIRInst_p, std::set<MIROperand_p>> instLiveOut;

    const auto &minsts = mblk->Insts();

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
void LiveAnalysisImpl::runOnInst(const MIRInst_p &minst, std::set<MIROperand_p> &liveIn,
                                 std::set<MIROperand_p> &liveOut) {

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

std::list<MIROperand_p> LiveAnalysisImpl::extractUses(const MIRInst_p &minst) {
    std::list<MIROperand_p> uses{};

    const auto &mops = minst->operands();

    for (auto it = std::next(mops.begin()); it != mops.end(); ++it) {
        auto use = *it;

        if (use->isReg()) {
            uses.emplace_back(use);
        }
    }

    return uses;
}
MIROperand_p LiveAnalysisImpl::extractDef(const MIRInst_p &minst) {
    return minst->getDef(); //
}