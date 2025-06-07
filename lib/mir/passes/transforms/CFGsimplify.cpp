#include "mir/passes/transforms/CFGsimplify.hpp"

using namespace MIR_new;

// LAMBDA THIS FILE ONLY BEGIN

auto cmp = [](MIRInst_p minst) -> bool {
    if (minst && minst->isGeneric() && // NOLINT
        (minst->opcode<OpC>() == OpC::InstICmp || minst->opcode<OpC>() == OpC::InstFCmp)) {
        return true;
    }
    return false;
};

auto cset = [](MIRInst_p minst) -> bool {
    if (minst && !minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::CSET) {
        return true;
    }
    return false;
};

auto cbnz = [](MIRInst_p minst) -> bool {
    if (minst && !minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::CBNZ) {
        return true;
    }
    return false;
};

auto b = [](MIRInst_p minst) -> bool {
    if (minst && minst->isGeneric() && minst->opcode<OpC>() == OpC::InstBranch) {
        ///@note 此处没有检查跳转条件
        return true;
    }
    return false;
};

// LAMBDA THIS FILE ONLY END

PM::PreservedAnalyses CFGsimplifyBeforeRA::run(MIRFunction &func, FAM &fam) {

    class CFGsimplifyBeforeRAImpl impl(func, fam);
    impl.impl();

    return PM::PreservedAnalyses::all();
}

PM::PreservedAnalyses CFGsimplifyAfterRA::run(MIRFunction &func, FAM &fam) {

    class CFGsimplifyAfterRAImpl impl(func, fam);
    impl.impl();

    return PM::PreservedAnalyses::all();
}

void CFGsimplifyBeforeRAImpl::impl() {
    i1Eli();
    while (deadBlkEli())
        ;
}

void CFGsimplifyBeforeRAImpl::i1Eli() {
    for (auto &mblk : mfunc.blks()) {
        i1EliDetect(mblk);
    }
}

void CFGsimplifyBeforeRAImpl::i1EliDetect(MIRBlk_p &mblk) {
    ///@warning 必须假设ir中所有的bool-val都是single def single use

    auto &minsts = mblk->Insts();
    for (auto it = minsts.begin(); it != minsts.end();) {

        auto next_ptr = [&minsts, &it]() -> MIRInst_p {
            if (it == minsts.end()) {
                return nullptr;
            }

            ++it; // alert here
            return it == minsts.end() ? nullptr : *it;
        };

        auto recovery = it;
        if (cmp(*it) && cset(next_ptr()) && cbnz(next_ptr()) && b(next_ptr())) {
            ///@todo cmp maybe appear not to be neighbor cset but still close to it
            i1UseConsolidate(minsts, recovery);
            break;
        }

        recovery == it ? (void)++it : nop;
    }
}

void CFGsimplifyBeforeRAImpl::i1UseConsolidate(MIRInst_p_l &minsts, MIRInst_p_l::iterator &cmp) {

    ///@brief make consolidate
    auto &ctx = mfunc.Context();
    auto cset = std::next(cmp);
    auto cbnz = std::next(cset);
    // auto b = std::next(cbnz);

    Err::gassert(cmp != minsts.end() && cset != minsts.end() && cbnz != minsts.end(), "list iterator(s) corrupted");

    (*cmp)->setOperand<0>(nullptr, ctx);

    auto cond = (*cset)->getOp(1); // MIROperand

    (*cset)->putAllOp(ctx);
    minsts.erase(cset);

    (*cbnz)->resetOpcode(OpC::InstBranch);
    (*cbnz)->setOperand<0>(nullptr, ctx);
    (*cbnz)->setOperand<1>((*cbnz)->getOp(2), ctx); // true block
    (*cbnz)->setOperand<2>(cond, ctx);
    // op3 = prob
}

void CFGsimplifyAfterRAImpl::impl() {
    brColsure();
    ///@todo blk layout opt...
    uselessCmpEli();
    brSeqRev();
    brEli();
}

bool CFGsimplifyBeforeRAImpl::deadBlkEli() {
    std::unordered_set<MIRBlk_p> dead_blks;

    auto &ctx = mfunc.Context();
    auto &mblks = mfunc.blks();

    for (auto &mblk : mfunc.blks()) {
        if (mblk->preds().empty() && mblk != mfunc.EntryBlk()) {
            dead_blks.emplace(mblk);
        }
    }

    for (auto &dead_blk : dead_blks) {

        dead_blk->putAllInstOp(ctx);

        auto mprv = dead_blk->prv();
        auto mnxt = dead_blk->nxt();

        mprv ? mprv->resetNxt(mnxt) : nop;
        mnxt ? mnxt->resetPrv(mprv) : nop;
    }

    if (!dead_blks.empty()) {

        for (auto &dead_blk : dead_blks) {
            auto &msuccs = dead_blk->succs();
            for (auto &msucc : msuccs) {
                auto rm_it = std::find_if(msucc->preds().begin(), msucc->preds().end(),
                                          [&](auto &&mblk) { return mblk == dead_blk; });

                Err::gassert(rm_it != msucc->preds().end(), "deadBlkEli: mpreds_msucc corrupted");

                msucc->preds().erase(rm_it);
            }
        }
        mblks.erase(std::remove_if(mblks.begin(), mblks.end(), [&](const auto &mblk) { return dead_blks.count(mblk); }),
                    mblks.end());

        return true;
    } else {
        return false;
    }
}

void CFGsimplifyAfterRAImpl::brColsure() {
    auto &mblks = mfunc.blks();
    auto &ctx = mfunc.Context();

    std::unordered_set<MIRBlk_p> useless_blks;

    for (auto &mblk : mblks) {
        auto &minsts = mblk->Insts();

        if (auto singleInst = minsts.back();              // NOLINT
            minsts.size() == 1 && singleInst->isGeneric() // NOLINT
            && singleInst->opcode<OpC>() == OpC::InstBranch) {

            useless_blks.emplace(mblk);
        }
    }

    // 理论上闭包跳转有顺序, 但是合并过程本身不需要关注顺序
    // 甚至都不用区分闭包集合
    // 每次操作时保证局部正确即可

    for (auto &victim : useless_blks) {

        Err::gassert(victim->succs().size() == 1, "victim->succs() corrupted");

        auto &mpreds = victim->preds();
        auto msucc = victim->succs().back();
        auto mprv = victim->prv();
        auto mnxt = victim->nxt();

        /// step 1
        auto &mpreds_msucc = msucc->preds();
        auto rm_it = std::find_if(mpreds_msucc.begin(), mpreds_msucc.end(),
                                  [&victim](const auto &mpred_msucc) { return mpred_msucc == victim; });

        Err::gassert(rm_it != mpreds_msucc.end(), "brColsure: mpreds_msucc corrupted");

        mpreds_msucc.erase(rm_it);

        /// step 2
        for (auto &mpred : mpreds) {
            // 1
            auto &msuccs_mpred = mpred->succs();
            auto rm_it = std::find_if(msuccs_mpred.begin(), msuccs_mpred.end(),
                                      [&victim](const auto &msucc_mpred) { return msucc_mpred == victim; });

            Err::gassert(rm_it != msuccs_mpred.end(), "brColsure: msuccs_mpred corrupted " + victim->getmSym());

            // 2
            *rm_it = msucc;                       // replace
            mpred->brReplace(victim, msucc, ctx); // modify InstBranch here

            // 3
            msucc->preds().emplace_back(mpred);
        }

        /// step 3: 仅保证正确性的做法, 不一定是最好的空间顺序
        mprv ? mprv->resetNxt(mnxt) : nop;
        mnxt ? mnxt->resetPrv(mprv) : nop;

        /// step 4: 减少引用计数
        victim->putAllInstOp(ctx);
    }

    mblks.erase(std::remove_if(mblks.begin(), mblks.end(),
                               [&useless_blks](const auto &mblk) { return useless_blks.count(mblk); }),
                mblks.end());
}

void CFGsimplifyAfterRAImpl::uselessCmpEli() {

    auto &ctx = mfunc.Context();

    for (auto &mblk : mfunc.blks()) {
        auto &minsts = mblk->Insts();

        for (auto it = minsts.begin(); it != minsts.end();) {

            auto next_ptr = [&minsts, &it]() -> MIRInst_p {
                if (it == minsts.end()) {
                    return nullptr;
                }

                ++it; // alert here
                return it == minsts.end() ? nullptr : *it;
            };

            auto recovery = it;

            if (cmp(*it) && b(next_ptr()) && b(next_ptr())) {
                auto mblk_dst_1 = (*std::prev(it))->getOp(1)->relocable()->as<MIRBlk>();
                auto mblk_dst_2 = (*it)->getOp(1)->relocable()->as<MIRBlk>();

                if (mblk_dst_1 == mblk_dst_2) {

                    for (auto it_put = recovery; it_put != it; ++it_put) {
                        (*it_put)->putAllOp(ctx);
                    }

                    minsts.erase(recovery, it); // 应当保留一个跳转
                }

                break;
            }

            recovery == it ? (void)++it : nop;
        }
    }
}

void CFGsimplifyAfterRAImpl::brSeqRev() {
    auto &mblks = mfunc.blks();
    auto &ctx = mfunc.Context();

    for (auto &mblk : mblks) {

        if (auto cmp = SeqRevPatternDetect(mblk); cmp != mblk->Insts().end()) {
            auto br_true = std::next(cmp);
            auto br_false = std::next(br_true);
            auto mblk_true = (*br_true)->getOp(1);
            auto mblk_false = (*br_false)->getOp(1);
            auto oldcond = (*br_true)->getOp(2);

            auto newcond = mkReverse(oldcond);
            (*br_true)->setOperand<2>(newcond, ctx);
            (*br_true)->setOperand<1>(mblk_false, ctx);
            (*br_false)->setOperand<1>(mblk_true, ctx); // remain Cond::AL
        }
    }
}

void CFGsimplifyAfterRAImpl::brEli() {
    auto &mblks = mfunc.blks();
    auto &ctx = mfunc.Context();

    for (auto &mblk : mblks) {

        auto &minsts = mblk->Insts();

        auto br = minsts.back();

        if (!br || !br->isGeneric() || br->opcode<OpC>() != OpC::InstBranch) {
            continue;
        }

        auto mblk_br = br->getOp(1)->relocable()->as<MIRBlk>();

        if (mblk_br != mblk->nxt()) {
            continue;
        }

        minsts.back()->putAllOp(ctx);
        minsts.pop_back();
    }
}

MIRInst_p_l::iterator CFGsimplifyAfterRAImpl::SeqRevPatternDetect(MIRBlk_p mblk) {
    auto &minsts = mblk->Insts();

    for (auto it = minsts.begin(); it != minsts.end();) {

        auto next_ptr = [&minsts, &it]() -> MIRInst_p {
            if (it == minsts.end()) {
                return nullptr;
            }

            ++it; // alert here
            return it == minsts.end() ? nullptr : *it;
        };

        auto recovery = it;
        if (cmp(*it) && b(next_ptr()) && b(next_ptr())) {
            auto br_true = std::prev(it);
            auto br_false = it;
            auto mblk_true = (*br_true)->getOp(1)->relocable()->as<MIRBlk>();
            auto mblk_false = (*br_false)->getOp(1)->relocable()->as<MIRBlk>();

            if (mblk_true == mblk->nxt()) {
                return recovery;
            }
        }

        recovery == it ? (void)++it : nop;
    }

    return minsts.end();
}

MIROperand_p CFGsimplifyAfterRAImpl::mkReverse(MIROperand_p condOp) {
    auto cond = static_cast<Cond>(condOp->imme());

    // enum MIRInstCond : unsigned { AL, EQ, NE, LT, GT, LE, GE };

    switch (cond) {
    case AL:
        Err::unreachable("mkReverse: cant rev AL cond");
        return nullptr;
    case EQ:
        return MIROperand::asImme(Cond::NE, OpT::special);
    case NE:
        return MIROperand::asImme(Cond::EQ, OpT::special);
    case LT:
        return MIROperand::asImme(Cond::GE, OpT::special);
    case GT:
        return MIROperand::asImme(Cond::LE, OpT::special);
    case LE:
        return MIROperand::asImme(Cond::GT, OpT::special);
    case GE:
        return MIROperand::asImme(Cond::LT, OpT::special);
    }
}
