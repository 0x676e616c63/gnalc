#include "mir/passes/transforms/PostRAlegalize.hpp"
#include "mir/passes/transforms/peephole.hpp"

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
}

void PostRAlegalizeImpl::runOnBlk(MIRBlk_p mblk, CodeGenContext &ctx) {

    auto &minsts = mblk->Insts();
    for (auto iter = minsts.begin(); iter != minsts.end(); ++iter) {
        runOnInst(*iter, minsts, iter, ctx);
    }
}

void PostRAlegalizeImpl::runOnInst(MIRInst_p minst, MIRInst_p_l &minsts, MIRInst_p_l::iterator &iter,
                                   CodeGenContext &_ctx) {

    if (minst->isGeneric()) {
        switch (minst->opcode<OpC>()) {
        case OpC::InstCopyStkPtr: {
            InstLegalizeContext ctx{minst, minsts, iter, _ctx};

            auto mop = minst->ensureDef();
            auto mstkop = minst->getOp(1);

            if (mfunc->StkObjs().count(mstkop)) {
                auto &obj = mfunc->StkObjs().at(mstkop);
                _ctx.iselInfo.legalizeWithStkPtrCast(ctx, mop, obj);
            } else {
                Err::unreachable("PostRAlegalizeImpl::runOnInst: instAddSP without a stk ptr");
            }

        } break;
        case OpC::InstAddSP: {
            InstLegalizeContext ctx{minst, minsts, iter, _ctx};

            auto mop = minst->ensureDef();
            auto mstkop = minst->getOp(1);

            if (mfunc->StkObjs().count(mstkop)) {
                auto &obj = mfunc->StkObjs().at(mstkop);
                _ctx.iselInfo.legalizeWithStkGep(ctx, mop, obj);
            } else {
                Err::unreachable("PostRAlegalizeImpl::runOnInst: instAddSP without a stk ptr");
            }

        } break;
        case OpC::InstLoad: {
            InstLegalizeContext ctx{minst, minsts, iter, _ctx};

            auto mop = minst->ensureDef();
            auto mstkop = minst->getOp(1);

            if (mfunc->StkObjs().count(mstkop)) {
                auto &obj = mfunc->StkObjs().at(mstkop);
                _ctx.iselInfo.legalizeWithStkOp(ctx, mop, obj);
            } else {
                // no offset
                minst->resetOpcode(ARMOpC::LDR);
            }

        } break;
        case OpC::InstLoadRegFromStack: {
            InstLegalizeContext ctx{minst, minsts, iter, _ctx};

            auto mop = minst->ensureDef();
            auto mstkop = minst->getOp(1);
            auto &obj = mfunc->StkObjs().at(mstkop);

            _ctx.iselInfo.legalizeWithStkOp(ctx, mop, obj);
        } break;

        case OpC::InstStore: {
            InstLegalizeContext ctx{minst, minsts, iter, _ctx};

            auto mop = minst->getOp(1);
            auto mstkop = minst->getOp(2);

            if (mfunc->StkObjs().count(mstkop)) {
                auto &obj = mfunc->StkObjs().at(mstkop);
                _ctx.iselInfo.legalizeWithStkOp(ctx, mop, obj);
            } else {
                minst->resetOpcode(ARMOpC::STR);
            }

        } break;
        case OpC::InstStoreRegToStack: {
            InstLegalizeContext ctx{minst, minsts, iter, _ctx};

            auto mop = minst->getOp(1);
            auto mstkop = minst->getOp(2);
            auto &obj = mfunc->StkObjs().at(mstkop);

            _ctx.iselInfo.legalizeWithStkOp(ctx, mop, obj);
        } break;

        default:
            return;
        }
    }
}