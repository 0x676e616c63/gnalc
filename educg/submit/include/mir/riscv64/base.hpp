// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_RISCV64_BASE_HPP
#define GNALC_MIR_RISCV64_BASE_HPP

#include "../../utils/enum_operator.hpp"
#include "../../ir/instructions/compare.hpp"
#include <cstdint>

namespace MIR {

namespace RV64 {
// Immediate that can be encoded directly in an instruction is 12 bits wide.
// But in RISCV64, immediate loaded by `li` is sign-extended to 64 bits.
// Thus, `li x6, -1` and `li x6, 4294967295 (which is 0xffffffff)` is not the same.
// However, 32-bit -1 is encoded to an unsigned int in MIROperand. But when getting it from `imme()`,
// we got one uint64_t with that value.
// Therefore, a width must be specified to distinguish values like `-1` and `4294967295`.
// FIXME: Refactor immediate encoding in MIROperand.
inline bool is12BitImm(uint64_t imm, bool is_mir_ext) {
    if (is_mir_ext) {
        auto signed_val = static_cast<int64_t>(imm);
        return signed_val >= -2048 && signed_val < 2048;
    }

    auto signed_val = static_cast<int32_t>(imm);
    return signed_val >= -2048 && signed_val < 2048;
}

inline bool isNonZero12BitImm(uint64_t imm, bool is_mir_ext) {
    return imm != 0 && is12BitImm(imm, is_mir_ext);
}
} // namespace RV64

enum class RVReg : uint32_t {
    X0,
    ZERO = X0,
    X1,
    RA = X1,
    X2,
    SP = X2,
    X3,
    GP = X3,
    X4,
    TP = X4,
    X5,
    X6,
    X7,
    X8,
    FP = X8,
    X9,
    X10,
    X11,
    X12,
    X13,
    X14,
    X15,
    X16,
    X17,
    X18,
    X19,
    X20,
    X21,
    X22,
    X23,
    X24,
    X25,
    X26,
    X27,
    X28,
    X29,
    X30,
    X31,
    F0,
    F1,
    F2,
    F3,
    F4,
    F5,
    F6,
    F7,
    F8,
    F9,
    F10,
    F11,
    F12,
    F13,
    F14,
    F15,
    F16,
    F17,
    F18,
    F19,
    F20,
    F21,
    F22,
    F23,
    F24,
    F25,
    F26,
    F27,
    F28,
    F29,
    F30,
    F31,
};

GNALC_ENUM_OPERATOR(RVReg)

enum class RVOpC : uint32_t {
    SLT,
    SLTI,
    SLTU,
    SEQZ,
    SNEZ,
    SLTZ,
    SGTZ,

    FEQ,
    FLT,
    FLE,

    BEQ,
    BNE,
    BGE,
    BLT,
    BGT,
    BLE,
    BGTU,
    BLEU,
    BEQZ,
    BNEZ,
    BLEZ,
    BGEZ,
    BLTZ,
    BGTZ,

    MV,
    FMV_S,
    FMV_W_X,
    FMV_X_W,

    FSW,
    FLW,
    FSD,
    FLD,

    LUI,
    LI,
    LB,
    LH,
    LW,
    LD,
    SB,
    SH,
    SW,
    SD,

    J,
    JAL,
    JALR,
    JR,

    CALL,

    LA,
    AUIPC,

    RET
};

RVOpC RVIRCondConvert(IR::ICMPOP cond);
} // namespace MIR

#endif
