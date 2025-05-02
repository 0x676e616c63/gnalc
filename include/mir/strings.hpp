#pragma once
#ifndef GNALC_ARMV8_MIR_STRINGS_HPP
#define GNALC_ARMV8_MIR_STRINGS_HPP

#include "mir/MIR.hpp"

namespace MIR_new {

string Cond2S(Cond cond) {
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

string Reg2S(uint32_t isa, unsigned bitWide) {
    Err::gassert(isISAReg(isa), "Reg2S: not a isa reg");
    string str;

    auto reg = static_cast<ARMReg>(isa);

    if (inRange(reg, ARMReg::X0, ARMReg::X29)) {
        if (bitWide <= 4) {
            str += 'w';
        } else {
            str += 'x';
        }

        str += std::to_string(isa);
    } else if (reg == ARMReg::LR) {
        str += "lr";
    } else if (reg == ARMReg::SP) {
        str += "sp";
    } else if (inRange(reg, ARMReg::V0, ARMReg::V31)) {
        if (bitWide <= 4) {
            str += 's';
        } else if (bitWide == 8) {
            str += 'd';
        } else {
            str += 'q';
        }

        str += std::to_string(isa - 33);
    }

    return str;
}

string OpC2S(OpC op) {
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
        return "oor";
    case OpC::InstXor:
        return "eor";
    case OpC::InstShl:
        return "lsl";
    case OpC::InstLShr:
        return "lsr";
    case OpC::InstAShr:
        return "asr";
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
    default:
        ///@todo vectorize
        Err::unreachable("OpC2S: op not support");
    }
    return ""; // just to make clang happy
}

string ARMOpC2S(ARMOpC op) {
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
    case ST1:
        return "st1";
    case ST2:
        return "st2";
    case ST3:
        return "st3";
    case MOV:
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