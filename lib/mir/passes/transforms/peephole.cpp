#include "mir/passes/transforms/peephole.hpp"

using namespace MIR_new;

PM::PreservedAnalyses GenericPeephole::run(MIRFunction &mfunc, FAM &fam) {

    class GenericPeepholeImpl peephole {};

    peephole.impl(mfunc, fam);

    return PM::PreservedAnalyses::all();
}

void GenericPeepholeImpl::impl(MIRFunction &_mfunc, FAM &_fam) {
    mfunc = &_mfunc;
    fam = &_fam;

    bool modified = true;

    ///@brief run this until no blk is modified
    while (modified) {
        modified = false;
        for (auto &mblk : mfunc->blks()) {
            modified |= runOnBlk(mblk);
        }
    }
}

bool GenericPeepholeImpl::runOnBlk(MIRBlk_p &mblk) {

    bool atLeastOneModfied = false;
    bool modified = true;

    ///@brief run this until no inst is modified
    while (modified) {
        modified = false;

        // MATCHES BEGIN
        auto &minsts = mblk->Insts();
        for (auto iter = minsts.begin(); iter != minsts.end(); /* forword iter in matches */) {

            MatchInfo info(*iter, minsts, iter); // iter pass by reference

            if (matchNop(info) || matchZeros(info) || matchFusedAdr(info)) {
                modified = true;
            }
        }
        // MATCHES END

        atLeastOneModfied |= modified;
    }

    return atLeastOneModfied;
}

// matches impl

bool GenericPeepholeImpl::matchNop(MatchInfo &info) {
    ///@note delete nop inst such as : mov w0, w0

    auto isCpy = [](const MIRInst_p &inst) -> bool {
        if (inst->isGeneric()) {
            if (inRange(inst->opcode<OpC>(), OpC::InstCopy, OpC::InstCopyToReg)) {
                return true;
            }
        } else {
            if (inst->opcode<ARMOpC>() == ARMOpC::MOV) {
                return true;
            }
        }

        return false;
    };

    auto sameReg = [](const MIROperand_p &def, const MIROperand_p &use) -> bool {
        if (def->isISA() && use->isISA()) {
            if (def->isa() == use->isa()) {
                return true;
            }
        }
        return false;
    };

    auto &[minst, minsts, iter] = info;

    if (isCpy(minst) && sameReg(minst->ensureDef(), minst->getOp(1))) {
        auto diter = iter;
        ++iter;
        minsts.erase(diter);
        return true;
    } else {
        ++iter;
        return false;
    }
}

bool GenericPeepholeImpl::matchZeros(MatchInfo &info) {
    ///@note degenerate arithmetics to copy : add %0, %1, 0 -> copy %0, %1
    ///@note replace zeros with WZR/XZR : str 0, [...] (before legalize) -> str wzr, [...]

    ///@todo
    return false;
}

bool GenericPeepholeImpl::matchFusedAdr(MatchInfo &info) {
    ///@note addressing instruction with fused address: [sp, #...], [sp, x<>, lsl, #...]

    ///@todo
    return false;
}
