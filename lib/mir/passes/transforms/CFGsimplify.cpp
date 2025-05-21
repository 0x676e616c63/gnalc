#include "mir/passes/transforms/CFGsimplify.hpp"

using namespace MIR_new;

// LAMBDA THIS FILE ONLY BEGIN

auto cmp = [](MIRInst_p minst) -> bool {
    if (minst->isGeneric() && // NOLINT
        (minst->opcode<OpC>() == OpC::InstICmp || minst->opcode<OpC>() == OpC::InstFCmp)) {
        return true;
    }
    return false;
};

auto cset = [](MIRInst_p minst) -> bool {
    if (!minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::CSET) {
        return true;
    }
    return false;
};

auto cbnz = [](MIRInst_p minst) -> bool {
    if (!minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::CBNZ) {
        return true;
    }
    return false;
};

auto b = [](MIRInst_p minst) -> bool {
    if (minst->isGeneric() && minst->opcode<OpC>() == OpC::InstBranch) {
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
    i1Eli(); //
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
            ++it; // alert here
            return it == minsts.end() ? nullptr : *it;
        };

        auto recovery = it;
        if (cmp(*it) && cset(next_ptr()) && cbnz(next_ptr()) && b(next_ptr())) {
            i1UseConsolidate(minsts, recovery);
            break;
        }

        recovery == it ? (++it, nop) : nop;
    }
}

void CFGsimplifyBeforeRAImpl::i1UseConsolidate(MIRInst_p_l &minst, MIRInst_p_l::iterator &cmp) {

    ///@brief make consolidate
    auto cset = std::next(cmp);
    auto cbnz = std::next(cset);
    // auto b = std::next(cbnz);

    Err::gassert(cmp != minst.end() && cset != minst.end() && cbnz != minst.end(), "list iterator(s) corrupted");

    auto cond = (*cset)->getOp(1); // MIROperand

    minst.erase(cset);
    (*cbnz)->resetOpcode(OpC::InstBranch);
    (*cbnz)->setOperand<0>(nullptr);
    (*cbnz)->setOperand<1>((*cbnz)->getOp(2)); // true block
    (*cbnz)->setOperand<2>(cond);
    // op3 = prob
}

void CFGsimplifyAfterRAImpl::impl() {
    deadBlkEli();
    brColsure();
    brSeqRev();
    brEli();
}

void CFGsimplifyAfterRAImpl::deadBlkEli() {
    std::unordered_set<MIRBlk_p> dead_blks;

    auto &mblks = mfunc.blks();

    for (auto &mblk : mfunc.blks()) {
        if (mblk->preds().empty() && mblk != mfunc.EntryBlk()) {
            dead_blks.emplace(mblk);
        }
    }

    for (auto &dead_blk : dead_blks) {

        auto mprv = dead_blk->prv();
        auto mnxt = dead_blk->nxt();

        mprv ? mprv->resetNxt(mnxt) : nop;
        mnxt ? mnxt->resetPrv(mprv) : nop;
    }

    mblks.erase(std::remove_if(mblks.begin(), mblks.end(), [&](const auto &mblk) { return dead_blks.count(mblk); }),
                mblks.end());
}

void CFGsimplifyAfterRAImpl::brColsure() {
    auto &mblks = mfunc.blks();

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
            *rm_it = msucc; // replace
            mpred->brReplace(victim, msucc);

            // 3
            msucc->preds().emplace_back(mpred);
        }

        /// step 3: 仅保证正确性的做法, 不一定是最好的空间顺序
        mprv->resetNxt(mnxt);
        mnxt->resetPrv(mprv);
    }

    mblks.erase(std::remove_if(mblks.begin(), mblks.end(),
                               [&useless_blks](const auto &mblk) { return useless_blks.count(mblk); }),
                mblks.end());
}

void CFGsimplifyAfterRAImpl::brSeqRev() {
    auto &mblks = mfunc.blks();

    for (auto &mblk : mblks) {

        if (auto cmp = patternDetect(mblk); cmp != mblk->Insts().end()) {
            auto br_true = std::next(cmp);
            auto br_false = std::next(br_true);
            auto mblk_true = (*br_true)->getOp(1);
            auto mblk_false = (*br_false)->getOp(1);
            auto oldcond = (*br_true)->getOp(2);

            auto newcond = mkReverse(oldcond);
            (*br_true)->setOperand<2>(newcond);
            (*br_true)->setOperand<1>(mblk_false);
            (*br_false)->setOperand<1>(mblk_true); // remain Cond::AL
        }
    }
}

void CFGsimplifyAfterRAImpl::brEli() {
    auto &mblks = mfunc.blks();

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

        minsts.pop_back();
    }
}

MIRInst_p_l::iterator CFGsimplifyAfterRAImpl::patternDetect(MIRBlk_p mblk) {
    auto &minsts = mblk->Insts();

    for (auto it = minsts.begin(); it != minsts.end();) {

        auto next_ptr = [&minsts, &it]() -> MIRInst_p {
            ++it; // alert here
            return it == minsts.end() ? nullptr : *it;
        };

        auto recovery = it;
        if (cmp(*it) && b(next_ptr()) && b(next_ptr())) {
            return recovery;
        }

        recovery == it ? (++it, nop) : nop;
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
