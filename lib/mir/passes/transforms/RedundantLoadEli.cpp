#include "mir/passes/transforms/RedundantLoadEli.hpp"
#include "mir/passes/analysis/domtree_analysis.hpp"

using namespace MIR_new;

PM::PreservedAnalyses RedundantLoadEli::run(MIRFunction &mfunc, FAM &fam) {
    class RedundantLoadEliImpl impl(mfunc, fam);
    impl.Impl();

    return PM::PreservedAnalyses::all();
}

void RedundantLoadEliImpl::Impl() {
    MkInfo();
    ApplyCopys();
}

void RedundantLoadEliImpl::MkInfo() {
    // LAMBDA BEGIN

    auto isLoad = [](const MIRInst_p &minst) {
        if (minst->isGeneric() &&
            (minst->opcode<OpC>() == OpC::InstLoadImm || minst->opcode<OpC>() == OpC::InstLoadImmToReg)) {
            return true;
        } else {
            return false;
        }
    };

    // LAMBDA END

    auto &mblks = mfunc.blks();

    for (auto &mblk : mblks) {

        auto &minsts = mblk->Insts();
        for (auto it = minsts.begin(); it != minsts.end(); ++it) {
            auto &minst = *it;
        }
    }
}

void RedundantLoadEliImpl::CulculateLCA() {}

void RedundantLoadEliImpl::ApplyCopys() {}