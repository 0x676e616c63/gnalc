#pragma once
#ifndef GNALC_MIR_SCHEDA53_HPP
#define GNALC_MIR_SCHEDA53_HPP

#include "mir/MIR.hpp"

// source: https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/AArch64/AArch64SchedA53.td

namespace MIR {

enum ResourcesA53 {
    None = 0, // for those not supposed to be
    A53UnitALU_1 = 1,
    A53UnitALU_2 = 2,
    A53UnitALU = 4, // 从tableGen来看, a53只有ALU相关的指令能够双发射
    A53UnitMAC = 8,
    A53UnitDiv = 16,
    A53UnitLdSt = 32, // 似乎无需占用ALU
    A53UnitB = 64,
    A53UnitFPALU = 128,
    A53UnitFPMDS = 256,
};

struct InstExecInfo {
    unsigned latency;
    unsigned issueCycle;
    uint32_t resourceOccupied;
};

inline InstExecInfo schedInfoImpl(OpC opcode) {
    switch (opcode) {
    case OpC::InstAdd:
    case OpC::InstAddSP:
    case OpC::InstSub:
    case OpC::InstICmp:
        return {3, 1, A53UnitALU};
    case OpC::InstMul:
        return {4, 1, A53UnitMAC};
    case OpC::InstSDiv:
        return {4, 1, A53UnitDiv};
    case OpC::InstAnd:
    case OpC::InstOr:
    case OpC::InstXor:
        return {2, 1, A53UnitALU};
    case OpC::InstAShr:
    case OpC::InstLShr:
    case OpC::InstShl:
        return {2, 1, A53UnitALU};
    case OpC::InstF2S:
    case OpC::InstS2F:
        return {6, 1, A53UnitFPALU};
    case OpC::InstFAdd:
    case OpC::InstFSub:
    case OpC::InstFCmp:
        return {6, 1, A53UnitFPALU};
    case OpC::InstFMul:
        return {6, 1, A53UnitFPMDS};
    case OpC::InstFDiv:
        return {33, 29, A53UnitFPMDS};
    case OpC::InstFNeg:
        return {2, 1, A53UnitFPALU};
    case OpC::InstVAdd:
    case OpC::InstVSub:
        return {6, 1, A53UnitFPALU};
    case OpC::InstVMul:
        return {10, 1, A53UnitFPMDS};
    case OpC::InstVDiv:
        ///@warning 猜的, 实在没找到
        return {33, 29, A53UnitFPMDS};
    case OpC::InstVHorizontalAdd:
        return {6, 1, A53UnitFPALU};
    case OpC::InstFPVAdd:
    case OpC::InstFPVSub:
        return {6, 1, A53UnitFPALU};
    case OpC::InstFPVMul:
        return {10, 1, A53UnitFPMDS};
    case OpC::InstFPVDiv:
        return {33, 29, A53UnitFPMDS};
    case OpC::InstFPVHorizontalAdd:
        return {6, 1, A53UnitFPALU};
    case OpC::InstSelect:
        ///@warning 猜测的结果, 但实际上select几乎没有调度的空间
        return {2, 1, A53UnitALU};
    case OpC::InstBranch:
        ///@warning 同上, 也几乎没有调度空间
        return {1, 1, A53UnitB};
    default:
        // include InstLdr, InstStr
        return {0, 0, 0};
    }
}

inline InstExecInfo schedInfoImpl(ARMOpC opcode) {
    ///@warning 对于 LDx/STx 的处理相当粗略, 具体的latency和cycle和加载/存放的类型有很大关系

    switch (opcode) {
    case ARMOpC::INC:
    case ARMOpC::DEC:
        return {3, 1, A53UnitALU};
    case ARMOpC::ADRP:
        return {4, 1, A53UnitLdSt};
    case ARMOpC::BL:
        return {1, 1, A53UnitB};
    case ARMOpC::CBNZ:
        return {1, 1, A53UnitB};
    case ARMOpC::CSET:
        return {2, 1, A53UnitALU};
    case ARMOpC::FMADD:
    case ARMOpC::FMSUB:
        return {10, 1, A53UnitFPMDS};
    case ARMOpC::LDR:
    case ARMOpC::STR:
    case ARMOpC::LDUR:
    case ARMOpC::STUR:
        return {4, 1, A53UnitLdSt};
    case ARMOpC::LD1:
    case ARMOpC::ST1:
        return {4, 1, A53UnitLdSt};
    case ARMOpC::LD2:
    case ARMOpC::ST2:
        return {5, 2, A53UnitLdSt};
    case ARMOpC::LD3:
    case ARMOpC::ST3:
        return {6, 3, A53UnitLdSt};
    case ARMOpC::LD4:
    case ARMOpC::ST4:
        return {7, 4, A53UnitLdSt};
    case ARMOpC::LD5:
    case ARMOpC::ST5:
        return {8, 5, A53UnitLdSt};
    case ARMOpC::MADD:
    case ARMOpC::MSUB:
        return {4, 1, A53UnitMAC};
    case ARMOpC::MOV:
    case ARMOpC::MOVZ:
    case ARMOpC::MOVK:
        return {2, 1, A53UnitALU};
    case ARMOpC::MOV_V:
    case ARMOpC::MOVF:
    case ARMOpC::MOVI:
        return {2, 1, A53UnitFPALU};
    case ARMOpC::SMULL:
        return {4, 1, A53UnitMAC};
    default:
        return {0, 0, 0};
    }
}

inline InstExecInfo schedInfo(std::variant<MIR::OpC, MIR::ARMOpC> opcode) {

    if (opcode.index() == 0) {
        return schedInfoImpl(std::get<OpC>(opcode));
    } else {
        return schedInfoImpl(std::get<ARMOpC>(opcode));
    }
}

}; // namespace MIR_new
#endif