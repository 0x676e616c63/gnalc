#include "../../../../include/ir/passes/helpers/constant_fold.hpp"

#include "../../../../include/ir/base.hpp"
#include "../../../../include/ir/basic_block.hpp"
#include "../../../../include/ir/function.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/converse.hpp"

namespace IR {

std::shared_ptr<Value> foldConstant(ConstantPool &cpool, const std::shared_ptr<Value> &raw) {
    if (auto binary = std::dynamic_pointer_cast<BinaryInst>(raw)) {
        auto lhs = binary->getLHS();
        auto rhs = binary->getRHS();
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            ConstantProxy cpl(&cpool, lhs);
            ConstantProxy cpr(&cpool, rhs);
            switch (binary->getOpcode()) {
#define MAKE_FOLD(irop, cppop)                \
    case OP::irop:                            \
        return (cpl cppop cpr).getConstant(); \
        break;
#define MAKE_FOLD2(irop, irop2, cppop)        \
    case OP::irop:                            \
    case OP::irop2:                           \
        return (cpl cppop cpr).getConstant(); \
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
    } else if (auto fneg = std::dynamic_pointer_cast<FNEGInst>(raw)) {
        if (fneg->getVal()->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            return cpool.getConst(-std::dynamic_pointer_cast<ConstantFloat>(fneg->getVal())->getVal());
        }
    } else if (auto icmp = std::dynamic_pointer_cast<ICMPInst>(raw)) {
        auto lhs = icmp->getLHS();
        auto rhs = icmp->getRHS();
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            auto lhsci = std::dynamic_pointer_cast<ConstantInt>(lhs)->getVal();
            auto rhsci = std::dynamic_pointer_cast<ConstantInt>(rhs)->getVal();
            switch (icmp->getCond()) {
#define MAKE_FOLD(cmpop, cppop)                                                  \
    case ICMPOP::cmpop:                                                          \
        return lhsci cppop rhsci ? cpool.getConst(true) : cpool.getConst(false); \
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
    } else if (auto fcmp = std::dynamic_pointer_cast<FCMPInst>(raw)) {
        auto lhs = fcmp->getLHS();
        auto rhs = fcmp->getRHS();
        if (lhs->getVTrait() == ValueTrait::CONSTANT_LITERAL && rhs->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            auto lhscf = std::dynamic_pointer_cast<ConstantFloat>(lhs)->getVal();
            auto rhscf = std::dynamic_pointer_cast<ConstantFloat>(rhs)->getVal();
            switch (fcmp->getCond()) {
#define MAKE_FOLD(cmpop, cppop)                                                  \
    case FCMPOP::cmpop:                                                          \
        return lhscf cppop rhscf ? cpool.getConst(true) : cpool.getConst(false); \
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
    } else if (auto zext = std::dynamic_pointer_cast<ZEXTInst>(raw)) {
        auto oval = zext->getOVal();
        if (oval->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            if (auto ovalci1 = std::dynamic_pointer_cast<ConstantI1>(oval)->getVal()) {
                switch (toBType(zext->getTType())->getInner()) {
                case IRBTYPE::I8:
                    return cpool.getConst(static_cast<char>(ovalci1));
                case IRBTYPE::I32:
                    return cpool.getConst(static_cast<int>(ovalci1));
                default:
                    break;
                }
            }
        }
    } else if (auto sitofp = std::dynamic_pointer_cast<SITOFPInst>(raw)) {
        auto oval = sitofp->getOVal();
        if (oval->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            auto ovalci32 = std::dynamic_pointer_cast<ConstantInt>(oval)->getVal();
            return cpool.getConst(static_cast<float>(ovalci32));
        }
    } else if (auto fptosi = std::dynamic_pointer_cast<FPTOSIInst>(raw)) {
        auto oval = fptosi->getOVal();
        if (oval->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
            auto ovalcf32 = std::dynamic_pointer_cast<ConstantFloat>(oval)->getVal();
            return cpool.getConst(static_cast<int>(ovalcf32));
        }
    }
    return raw;
}

} // namespace IR