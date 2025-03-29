#include "../../../../include/ir/passes/helpers/constant_fold.hpp"

#include "../../../../include/ir/base.hpp"
#include "../../../../include/ir/basic_block.hpp"
#include "../../../../include/ir/function.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/converse.hpp"

namespace IR {

pVal foldConstant(ConstantPool &cpool, const pVal &raw) {
    if (auto binary = raw->as<BinaryInst>()) {
        auto lhs = binary->getLHS();
        auto rhs = binary->getRHS();
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            ConstantProxy cpl(&cpool, lhs);
            ConstantProxy cpr(&cpool, rhs);
            switch (binary->getOpcode()) {
#define MAKE_FOLD(irop, cppop)                                                                                         \
    case OP::irop:                                                                                                     \
        return (cpl cppop cpr).getConstant();                                                                          \
        break;
#define MAKE_FOLD2(irop, irop2, cppop)                                                                                 \
    case OP::irop:                                                                                                     \
    case OP::irop2:                                                                                                    \
        return (cpl cppop cpr).getConstant();                                                                          \
        break;

                MAKE_FOLD2(ADD, FADD, +)
                MAKE_FOLD2(SUB, FSUB, -)
                MAKE_FOLD2(MUL, FMUL, *)
                MAKE_FOLD2(DIV, FDIV, /)
                MAKE_FOLD(REM, %)
#undef MAKE_FOLD
#undef MAKE_FOLD2
            default:
                break;
            }
        }
    } else if (auto fneg = raw->as<FNEGInst>()) {
        if (auto fneg_val = fneg->getVal()->as<ConstantFloat>())
            return cpool.getConst(-fneg_val->getVal());
    } else if (auto icmp = raw->as<ICMPInst>()) {
        auto lhs = icmp->getLHS();
        auto rhs = icmp->getRHS();
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            auto lhsci = lhs->as<ConstantInt>()->getVal();
            auto rhsci = rhs->as<ConstantInt>()->getVal();
            switch (icmp->getCond()) {
#define MAKE_FOLD(cmpop, cppop)                                                                                        \
    case ICMPOP::cmpop:                                                                                                \
        return lhsci cppop rhsci ? cpool.getConst(true) : cpool.getConst(false);                                       \
        break;
                MAKE_FOLD(eq, ==)
                MAKE_FOLD(ne, !=)
                MAKE_FOLD(sgt, >)
                MAKE_FOLD(sge, >=)
                MAKE_FOLD(slt, <)
                MAKE_FOLD(sle, <=)
#undef MAKE_FOLD
            }
        }
    } else if (auto fcmp = raw->as<FCMPInst>()) {
        auto lhs = fcmp->getLHS();
        auto rhs = fcmp->getRHS();
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            auto lhscf = lhs->as<ConstantFloat>()->getVal();
            auto rhscf = rhs->as<ConstantFloat>()->getVal();
            switch (fcmp->getCond()) {
#define MAKE_FOLD(cmpop, cppop)                                                                                        \
    case FCMPOP::cmpop:                                                                                                \
        return lhscf cppop rhscf ? cpool.getConst(true) : cpool.getConst(false);                                       \
        break;
                MAKE_FOLD(oeq, ==)
                MAKE_FOLD(ogt, >)
                MAKE_FOLD(oge, >=)
                MAKE_FOLD(olt, <)
                MAKE_FOLD(ole, <=)
                MAKE_FOLD(one, !=)
#undef MAKE_FOLD
            default:
                break;
            }
        }
    } else if (auto zext = raw->as<ZEXTInst>()) {
        if (auto ovalci1 = zext->getOVal()->as<ConstantI1>()) {
            switch (zext->getTType()->as<BType>()->getInner()) {
            case IRBTYPE::I8:
                return cpool.getConst(static_cast<char>(ovalci1->getVal()));
            case IRBTYPE::I32:
                return cpool.getConst(static_cast<int>(ovalci1->getVal()));
            default:
                break;
            }
        }
    } else if (auto sitofp = raw->as<SITOFPInst>()) {
        if (auto oval = sitofp->getOVal()->as<ConstantInt>())
            return cpool.getConst(static_cast<float>(oval->getVal()));
    } else if (auto fptosi = raw->as<FPTOSIInst>()) {
        if (auto oval = fptosi->getOVal()->as<ConstantFloat>())
            return cpool.getConst(static_cast<int>(oval->getVal()));
    }
    return raw;
}

} // namespace IR