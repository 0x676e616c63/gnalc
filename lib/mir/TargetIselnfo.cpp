#include "mir/MIR.hpp"
#include "mir/passes/transforms/isel.hpp"

using namespace MIR_new;

bool TargetISelInfo::isLegalGenericInst(MIRInst_p minst) const {
    Err::gassert(minst->isGeneric(), "isLegalGenericInst: minst is not a generic mir");

    switch (minst->opcode<OpC>()) {
    case OpC::InstCopy:
    case OpC::InstCopyFromReg:
    case OpC::InstCopyToReg:
    case OpC::InstLoadRegFromStack:
    case OpC::InstStoreRegToStack:
    case OpC::InstLoadStackObjectAddr:
        return true;
    default:
        return false;
    }
}

bool TargetISelInfo::matchAndSel(MIRInst_p minst, ISelContext &ctx, bool allow) const {
    bool ret = legalizeInst(minst, ctx); // not impl yet

    ///@todo do something when allow is true

    return ret | matchAndSelectImpl(minst, ctx);
}

bool TargetISelInfo::legalizeInst(MIRInst_p minst, ISelContext &ctx) const {
    bool modified = false;

    // LAMBDA BEGIN

    auto trySwapOps = [&](MIRInst_p minst) -> void {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        if (lhs->isImme() && !rhs->isImme()) {
            minst->setOperand<1>(rhs);
            minst->setOperand<2>(lhs);
            modified |= true;
        } else if (lhs->isImme() && rhs->isImme()) {
            Err::unreachable("legalizeInst::trySwapOps: lhs and rhs are immes");
        } else {
            modified |= false;
        }
    };

    auto loadImm = [&](MIROperand_p mop) -> MIROperand_p {
        auto mop_new = MIROperand::asVReg(ctx.codeGenCtx().nextId(), mop->type());

        ctx.newInst(OpC::InstLoadImm)->setOperand<0>(mop_new)->setOperand<1>(mop);
        modified |= true;

        return mop_new; //  replace by yourself
    };

    // LADMBDA END

    if (!minst->isGeneric()) {
        return false; // modified
    }

    switch (minst->opcode<OpC>()) {
    case OpC::InstStore: {
        auto lhs = minst->getOp(1);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs));
        }
    }

    break;
    case OpC::InstAdd: {
        trySwapOps(minst);
        auto rhs = minst->getOp(2);
        if (rhs->isImme() && !is12ImmeWithProbShift(rhs->imme())) {
            minst->setOperand<2>(loadImm(rhs));
        }

    } break;
    case OpC::InstSub:
    case OpC::InstICmp: {
        auto rhs = minst->getOp(2);
        if (rhs->isImme() && !is12ImmeWithProbShift(rhs->imme())) {
            minst->setOperand<2>(loadImm(rhs));
        }
    } break;
    case OpC::InstFCmp: {
        auto rhs = minst->getOp(2);
        if (rhs->isImme()) {
            minst->setOperand<2>(loadImm(rhs));
        }
    } break;
    case OpC::InstMul: {
        trySwapOps(minst);
        auto rhs = minst->getOp(2);
        if (rhs->isImme()) {
            minst->setOperand<2>(loadImm(rhs));
        }
    } break;
    case OpC::InstAnd:
    case OpC::InstOr:
    case OpC::InstXor:
        Err::todo("legalizeInst: bitwise op not implement yet");
    case OpC::InstTst: // ANDS WZR, Wx, ...
        break;
    case OpC::InstShl:
    case OpC::InstLShr:
    case OpC::InstAShr: {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);

        if (rhs->isImme()) {
            Err::gassert(rhs->imme() < 32 && rhs->imme() >= 0,
                         "legalizeInst: shift imme out of range"); // though rhs == 0 is useless
        }
    } break;
    case OpC::InstSDiv: {
        auto lhs = minst->getOp(1);
        auto rhs = minst->getOp(2);
        if (lhs->isImme()) {
            minst->setOperand<1>(loadImm(lhs));
        }
        if (rhs->isImme()) {
            minst->setOperand<2>(loadImm(rhs));
        }
    } break;
    case OpC::InstSRem:
        Err::unreachable("legalizeInst: SRem should be lower before");
        break;
    case OpC::InstSMin:
    case OpC::InstSMax:
        Err::todo("legalizeInst: min/max op not implement yet");
    case OpC::InstNeg: {
        auto lhs = minst->getOp(1);
        Err::gassert(!lhs->isImme(), "legalizeInst: can not neg a imme");
    } break;
    case OpC::InstAbs:
        Err::todo("legalizeInst: abs op not implement yet");
    case OpC::InstFAdd:
    case OpC::InstFSub:
    case OpC::InstFMul:
    case OpC::InstFDiv:
    case OpC::InstFRem:
        Err::unreachable("legalizeInst: FRem should be lower before");
    case OpC::InstSExt:
    case OpC::InstZExt:
    case OpC::InstTrunc:
        Err::todo("legalizeInst: bitwise convert op not implement yet");
    case OpC::InstF2S:
        break;
    case OpC::InstS2F:
        break;
    default:
        ///@note 各种copy, 内存访问没有合法化
    }
}

// void TargetISelInfo::postLegalizeInst(const InstLegalizeContext &) {
//     ///@todo
// }

// void TargetISelInfo::postLegalizeInst(const InstLegalizeContext &, MIRInst_p_l &) {
//     ///@todo
// }

// void TargetISelInfo::preLegalizeInst(const InstLegalizeContext &) {
//     ///@todo
// }

// void TargetISelInfo::legalizeInstWithStackOperand(const InstLegalizeContext &ctx, MIROperand_p,
//                                                   const StkObj &obj) const {
//     ///@todo
// }
