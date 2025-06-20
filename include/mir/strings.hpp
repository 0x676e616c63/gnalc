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
    case ARMOpC::LDR:
        return "ldr";
    case ARMOpC::STR:
        return "str";
    case ARMOpC::LDUR:
        return "ldur";
    case ARMOpC::STUR:
        return "stur";
    case ARMOpC::LD1:
        return "ld1";
    case ARMOpC::LD2:
        return "ld2";
    case ARMOpC::LD3:
        return "ld3";
    case ARMOpC::LD4:
        return "ld4";
    case ARMOpC::LD5:
        return "ld5";
    case ARMOpC::ST1:
        return "st1";
    case ARMOpC::ST2:
        return "st2";
    case ARMOpC::ST3:
        return "st3";
    case ARMOpC::ST4:
        return "st4";
    case ARMOpC::ST5:
        return "st5";
    case ARMOpC::MADD:
        return "madd";
    case ARMOpC::MSUB:
        return "msub";
    case ARMOpC::FMADD:
        return "fmadd";
    case ARMOpC::FMSUB:
        return "fmsub";
    case ARMOpC::CSEL:
        return "csel";
    case ARMOpC::FCSEL:
        return "fcsel";
    case ARMOpC::CSET_SELECT:
    case ARMOpC::CSET:
        return "cset";
    case ARMOpC::MOV:
    case ARMOpC::MOV_V:
        return "mov";
    case ARMOpC::MOVZ:
        return "movz";
    case ARMOpC::MOVK:
        return "movk";
    case ARMOpC::MOVF:
        return "fmov";
    case ARMOpC::INC:
        return "add";
    case ARMOpC::DEC:
        return "sub";
    default:
        Err::unreachable("ARMOpC2S: hanlder this op manully");
    }
    return ""; // just to make clang happy
}

}; // namespace MIR_new

#endif