// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#include "mir/info.hpp"
#include "utils/exception.hpp"
#ifndef GNALC_MIR_STRINGS_HPP
#define GNALC_MIR_STRINGS_HPP

#include "mir/MIR.hpp"

namespace MIR {
namespace ARMv8 {
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
    if (mop->isImme() && mop->imme() == 0) {
        return bitWide < 8 ? "wzr" : "xzr";
    }

    auto isa = mop->isa();

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
    if (mop->isImme() && mop->imme() == 0) {
        return bitWide < 8 ? "wzr" : "xzr";
    }

    auto isa = mop->isa();

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
    case OpC::InstVAdd:
        return "add";
    case OpC::InstSub:
    case OpC::InstVSub:
        return "sub";
    case OpC::InstMul:
    case OpC::InstVMul:
        return "mul";
    case OpC::InstAnd:
    case OpC::InstVAnd:
        return "and";
    case OpC::InstOr:
    case OpC::InstVOr:
        return "orr";
    case OpC::InstXor:
    case OpC::InstVXor:
        return "eor";
    case OpC::InstShl:
    case OpC::InstVShl:
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
    case OpC::InstVNeg:
        return "neg";
    case OpC::InstFAdd:
    case OpC::InstVFAdd:
        return "fadd";
    case OpC::InstFSub:
    case OpC::InstVFSub:
        return "fsub";
    case OpC::InstFMul:
    case OpC::InstVFMul:
        return "fmul";
    case OpC::InstFDiv:
    case OpC::InstVFDiv:
        return "fdiv";
    case OpC::InstFNeg:
    case OpC::InstVFNeg:
        return "fneg";
    case OpC::InstICmp:
        return "cmp";
    case OpC::InstVIcmp:
        return "cm";
    case OpC::InstFCmp:
        return "fcmp";
    case OpC::InstVFcmp:
        return "fcm";
    case OpC::InstF2S:
    case OpC::InstVFP2SI:
        return "fcvtzs";
    case OpC::InstS2F:
    case OpC::InstVSI2FP:
        return "scvtf";
    case OpC::InstFRINTZ:
    case OpC::InstVFRINTZ:
        return "frintz";
    case OpC::InstVExtract:
    case OpC::InstVInsert:
        return "mov";
    case OpC::InstVSelect:
        return "bsl";
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
    case ARMOpC::MLA_V:
        return "mla";
    case ARMOpC::MLS_V:
        return "mls";
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
} // namespace ARMv8
namespace RV64 {
inline string RVOpC2S(RVOpC op) {
    switch (op) {
    case RVOpC::SLT:
        return "slt";
    case RVOpC::SLTI:
        return "slti";
    case RVOpC::SLTU:
        return "sltu";
    case RVOpC::SEQZ:
        return "seqz";
    case RVOpC::SNEZ:
        return "snez";
    case RVOpC::SLTZ:
        return "sltz";
    case RVOpC::SGTZ:
        return "sgtz";
    case RVOpC::FEQ:
        return "feq.s";
    case RVOpC::FLT:
        return "flt.s";
    case RVOpC::FLE:
        return "fle.s";
    case RVOpC::BEQ:
        return "beq";
    case RVOpC::BNE:
        return "bne";
    case RVOpC::BGE:
        return "bge";
    case RVOpC::BLT:
        return "blt";
    case RVOpC::BGT:
        return "bgt";
    case RVOpC::BLE:
        return "ble";
    case RVOpC::BGTU:
        return "bgtu";
    case RVOpC::BLEU:
        return "bleu";
    case RVOpC::BEQZ:
        return "beqz";
    case RVOpC::BNEZ:
        return "bnez";
    case RVOpC::BLEZ:
        return "blez";
    case RVOpC::BGEZ:
        return "bgez";
    case RVOpC::BLTZ:
        return "bltz";
    case RVOpC::BGTZ:
        return "bgtz";
    case RVOpC::MV:
        return "mv";
    case RVOpC::FMV_S:
        return "fmv.s";
    case RVOpC::FMV_W_X:
        return "fmv.w.x";
    case RVOpC::FMV_X_W:
        return "fmv.x.w";
    case RVOpC::LUI:
        return "lui";
    case RVOpC::LI:
        return "li";
    case RVOpC::LB:
        return "lb";
    case RVOpC::LH:
        return "lh";
    case RVOpC::LW:
        return "lw";
    case RVOpC::LD:
        return "ld";
    case RVOpC::SB:
        return "sb";
    case RVOpC::SH:
        return "sh";
    case RVOpC::SW:
        return "sw";
    case RVOpC::SD:
        return "sd";
    case RVOpC::FLW:
        return "flw";
    case RVOpC::FSW:
        return "fsw";
    case RVOpC::FLD:
        return "fld";
    case RVOpC::FSD:
        return "fsd";
    case RVOpC::J:
        return "j";
    case RVOpC::JAL:
        return "jal";
    case RVOpC::JALR:
        return "jalr";
    case RVOpC::JR:
        return "jr";
    case RVOpC::LA:
        return "la";
    case RVOpC::AUIPC:
        return "auipc";
    case RVOpC::RET:
        return "ret";
    default:
        Err::unreachable("RVOpC2S: unrecognized op");
    }
    return ""; // just to make clang happy
}
} // namespace RV64
}; // namespace MIR

#endif