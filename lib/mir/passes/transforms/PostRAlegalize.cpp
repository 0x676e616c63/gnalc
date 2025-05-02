#include "mir/passes/transforms/PostRAlegalize.hpp"

using namespace MIR_new;

PM::PreservedAnalyses PostRAlegalize::run(MIRFunction &mfunc, FAM &fam) {

    class PostRAlegalizeImpl impl;

    impl.impl(mfunc, fam);

    return PM::PreservedAnalyses::all();
}

void PostRAlegalizeImpl::impl(MIRFunction &_mfunc, FAM &fam) {
    mfunc = &_mfunc;

    for (auto &mblk : mfunc->blks()) {
        runOnBlk(mblk, mfunc->CodeGenContext());
    }

    return;
}

void PostRAlegalizeImpl::runOnBlk(MIRBlk_p mblk, CodeGenContext &ctx) {

    auto minsts = mblk->Insts();
    for (auto iter = minsts.begin(); iter != minsts.end(); ++iter) {
        runOnInst(*iter, minsts, iter, ctx);
    }
}

void PostRAlegalizeImpl::runOnInst(MIRInst_p minst, MIRInst_p_l minsts, MIRInst_p_l::iterator iter,
                                   CodeGenContext &_ctx) {

    if (minst->isGeneric()) {
        switch (minst->opcode<OpC>()) {
        case OpC::InstLoadRegFromStack:
        case OpC::InstLoad:
        case OpC::InstLoadStackObjectAddr: {
            InstLegalizeContext ctx{minst, minsts, iter, _ctx};

            auto mop = minst->getOp(1);
            auto &obj = mfunc->StkObjs().at(mop);

            _ctx.iselInfo.legalizeInstWithStackOperand(ctx, mop, obj);
        } break;

        case OpC::InstStore:
        case OpC::InstStoreRegToStack: {
            InstLegalizeContext ctx{minst, minsts, iter, _ctx};

            auto mop = minst->getOp(2);
            auto &obj = mfunc->StkObjs().at(mop);

            _ctx.iselInfo.legalizeInstWithStackOperand(ctx, mop, obj);
        } break;

        default:
            return;
        }
    }

    return;
}