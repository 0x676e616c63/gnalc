// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_RISCV64_BASE_HPP
#define GNALC_MIR_RISCV64_BASE_HPP

#include "utils/enum_operator.hpp"
#include <cstdint>

namespace MIR {

namespace RV64 {
template <typename T> bool isFitMemOffset(T offset) { return offset >= -2048 && offset < 2048; }

template <typename T> bool is12BitImm(T imm) { return imm >= -2048 && imm < 2048; }
} // namespace RV64

enum class RVReg : uint32_t {
    X0,
    X1,
    X2,
    X3,
    X4,
    X5,
    X6,
    X7,
    X8,
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

    J,
    JAL,
    JALR,
    JR,
};

} // namespace MIR

#endif
