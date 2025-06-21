#pragma once
#ifndef GNALC_ARMV8_MIR_STRINGS_HPP
#define GNALC_ARMV8_MIR_STRINGS_HPP

#include "mir/MIR.hpp"

namespace MIR_new {

inline string Cond2S(Cond cond) {
    switch (cond) {
    case Cond::AL:
        return "";
    case Cond::EQ:
        return "eq";
    case Cond::GE:
        return "ge";
    case Cond::GT:
        return "gt";
    case Cond::LE:
        return "le";
    case Cond::LT:
        return "lt";
    case Cond::NE:
        return "ne";
    }
}

inline string Reg2S(const MIROperand_p &mop, unsigned bitWide, bool vector = false) {
    auto isa = mop->isa();

    Err::gassert(isISAReg(isa), "Reg2S: not a isa reg");
    string str;

    auto reg = static_cast<ARMReg>(isa);

    if (inRange(reg, ARMReg::X0, ARMReg::X28)) {
        if (bitWide <= 4) {
            str += 'w';
        } else {
            str += 'x';
        }

        str += std::to_string(isa);
    } else if (reg == ARMReg::FP) {
        str += "fp";
    } else if (reg == ARMReg::LR) {
        str += "lr";
    } else if (reg == ARMReg::SP) {
        str += "sp";
    } else if (inRange(reg, ARMReg::V0, ARMReg::V31)) {
        if (bitWide <= 4) {
            str += 's';
        } else if (bitWide == 8) {
            str += 'd';
        } else if (bitWide == 16) {
            vector ? str += 'v' : str += 'q';
        }

        str += std::to_string(isa - 32);
    }

    return str;
}

inline string Reg2SDebug(const MIROperand_p &mop, unsigned bitWide, const CodeGenContext &ctx, bool vector = false) {
    auto isa = mop->isa();

    Err::gassert(isISAReg(isa), "Reg2S: not a isa reg");
    string str;

    auto reg = static_cast<ARMReg>(isa);

    if (inRange(reg, ARMReg::X0, ARMReg::X28)) {
        if (bitWide <= 4) {
            str += 'w';
        } else {
            str += 'x';
        }

        str += std::to_string(isa);
    } else if (reg == ARMReg::FP) {
        str += "fp";
    } else if (reg == ARMReg::LR) {
        str += "lr";
    } else if (reg == ARMReg::SP) {
        str += "sp";
    } else if (inRange(reg, ARMReg::V0, ARMReg::V31)) {
        if (bitWide <= 4) {
            str += 's';
        } else if (bitWide == 8) {
            str += 'd';
        } else if (bitWide == 16) {
            vector ? str += 'v' : str += 'q';
        }

        str += std::to_string(isa - 32);
    }

    str += '(';

    if (auto recover = mop->getRecover(); recover < 64) {
        str += '$';

        if (inRange(recover, static_cast<unsigned>(ARMReg::X0), static_cast<unsigned>(ARMReg::X28))) {
            str += 'x' + std::to_string(isa) + '[' + std::to_string(bitWide) + ']';
        } else if (recover == ARMReg::FP) {
            str += "fp";
        } else if (recover == ARMReg::LR) {
            str += "lr";
        } else if (recover == ARMReg::SP) {
            str += "sp";
        } else if (inRange(recover, static_cast<unsigned>(ARMReg::V0), static_cast<unsigned>(ARMReg::V31))) {
            str += 'v' + std::to_string(isa - 32);
        }
    } else {
        str += '%' + std::to_string(recover) + '{' + std::to_string(bitWide) + '}' + '[' +
               std::to_string(ctx.queryOp(mop)) + ']';
    }

    str += ')';

    return str;
}

inline string OpC2S(OpC op) {
    switch (op) {
    case OpC::InstAdd:
        return "add";
    case OpC::InstSub:
        return "sub";
    case OpC::InstMul:
        return "mul";
    case OpC::InstAnd:
        return "and";
    case OpC::InstOr:
        return "orr";
    case OpC::InstXor:
        return "eor";
    case OpC::InstShl:
        return "lsl";
    case OpC::InstLShr:
        return "lsr";
    case OpC::InstAShr:
        return "asr";
    case OpC::InstUDiv:
        return "udiv";
    case OpC::InstSDiv:
        return "sdiv";
    case OpC::InstNeg:
        return "neg";
    case OpC::InstFAdd:
        return "fadd";
    case OpC::InstFSub:
        return "fsub";
    case OpC::InstFMul:
        return "fmul";
    case OpC::InstFDiv:
        return "fdiv";
    case OpC::InstFNeg:
        return "fneg";
    case OpC::InstICmp:
        return "cmp";
    case OpC::InstFCmp:
        return "fcmp";
    case OpC::InstF2S:
        return "fcvtzs";
    case OpC::InstS2F:
        return "scvtf";
    case OpC::InstFRINTZ:
        return "frintz";
    default:
        ///@todo vectorize
        Err::unreachable("OpC2S: op not support");
    }
    return ""; // just to make clang happy
}

inline string ARMOpC2S(ARMOpC op) {
    switch (op) {
    case LDR:
        return "ldr";
    case STR:
        return "str";
    case LDUR:
        return "ldur";
    case STUR:
        return "stur";
    case LD1:
        return "ld1";
    case LD2:
        return "ld2";
    case LD3:
        return "ld3";
    case LD4:
        return "ld4";
    case LD5:
        return "ld5";
    case ST1:
        return "st1";
    case ST2:
        return "st2";
    case ST3:
        return "st3";
    case ST4:
        return "st4";
    case ST5:
        return "st5";
    case MADD:
        return "madd";
    case MSUB:
        return "msub";
    case FMADD:
        return "fmadd";
    case FMSUB:
        return "fmsub";
    case CSEL:
        return "csel";
    case FCSEL:
        return "fcsel";
    case CSET_SELECT:
    case CSET:
        return "cset";
    case MOV:
    case MOV_V:
        return "mov";
    case MOVZ:
        return "movz";
    case MOVK:
        return "movk";
    case MOVF:
        return "fmov";
    case INC:
        return "add";
    case DEC:
        return "sub";
    default:
        Err::unreachable("ARMOpC2S: hanlder this op manully");
    }
    return ""; // just to make clang happy
}

}; // namespace MIR_new

#endif