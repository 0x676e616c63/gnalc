// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#include "../../utils/exception.hpp"
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <type_traits>
#ifndef GNALC_MIR_ARMV8_BASE_HPP
#define GNALC_MIR_ARMV8_BASE_HPP

#include "../tools.hpp"
#include "../../utils/enum_operator.hpp"

#include <cstring>

namespace MIR {

namespace ARMv8 {
// IMME judge begin

///@note armv8没有了armv7中通用的8位旋转立即数, 取而代之的是一大堆规则不同的立即数

inline bool isFitPairMemInst(int offset) { return offset >= -512 && offset <= 504; } //@warning 此处没有检查对齐

inline bool isFitMemInstX(int offset) { return offset >= 0 && offset <= 32760 && offset % 8 == 0; }

inline bool isFitMemInstW(int offset) { return offset >= 0 && offset <= 16380 && offset % 4 == 0; }

inline bool isFitMemInstQ(int offset) { return offset >= 0 && offset <= 65520 && offset % 16 == 0; }

inline bool isFitMemInstD(int offset) { return offset >= 0 && offset <= 32760 && offset % 8 == 0; }

inline bool isFitMemInstS(int offset) { return offset >= 0 && offset <= 16380 && offset % 4 == 0; }

inline bool isFitMemInstU(int offset) {
    ///@note ldur/stur dont need offset to be aligned
    return offset < 256 && offset > -257;
}

inline bool isFitMemInst(int offset, unsigned bitwide) {
    switch (bitwide) {
    case 16:
        return isFitMemInstQ(offset);
    case 8:
        return isFitMemInstX(offset);
    case 4:
        return isFitMemInstW(offset);
    default:
        Err::unreachable("isFitMemInst: bitwide of " + std::to_string(bitwide) + " not supported");
    }
    return false; // just to make gnalc happy
}

///@todo vectoer ld1/ld2/ld3

template <typename T> inline bool is12ImmeWithProbShift(T imm) {
    ///@warning use in ADD/SUB/CMP/CMN

    Err::gassert(!std::is_same_v<T, float>, "is12ImmeWithShift: fadd/fsub dont support a imme");

    long long imme = 0;

    if (std::is_same_v<T, unsigned>) {
        imme = static_cast<int>(imm);
    } else if (std::is_same_v<T, uint64_t>) {
        imme = static_cast<int64_t>(imm);
    } else {
        Err::unreachable("is12ImmeWithShift: cant convert to encode");
    }

    if (imme < 0) {
        int debug;
    }

    if (imme < 4096 && imme > -4095 || (imme % 0x1000 == 0 && (imme >> 12) < 4096)) {
        return true;
    } else {
        return false;
    }
}

template <typename T> inline bool isFloat8(T imm) {

    Err::gassert(sizeof(T) == 4, "isFloat8: type not fit");

    float imme = *reinterpret_cast<float *>(&imm);

    if (imme == 0.0f) {
        return false;
    }

    uint32_t bits;
    std::memcpy(&bits, &imme, sizeof(float));

    uint32_t exponent = (bits >> 23) & 0xFF;

    if (exponent == 0) {
        return false;
    }
    if (exponent == 255) {
        return false;
    }

    int e = static_cast<int>(exponent) - 127;
    if (e < -3 || e > 4) {
        return false;
    }

    uint32_t fraction = bits & 0x7FFFFF;

    if ((fraction & 0x7FFFF) != 0) {
        return false;
    }

    return true;
}

#if defined(__clang__)
template <typename T>
__attribute__((optnone)) bool isBitMaskImme(T imm)
#else
#pragma GCC push_options
#pragma GCC optimize("O0")
template <typename T>
bool isBitMaskImme(T imm)
#endif

{
    ///@warning use in AND/ORR...
    ///@warning MOV instruction is an alias of ORR (immediate).

    ///@brief reference: https://developer.arm.com/documentation/dui0802/b/A64-General-Instructions/ANDS--immediate-?lang=en

    uint64_t pattern_len_max = 0;
    if constexpr (std::is_same_v<T, int> || std::is_same_v<T, unsigned>) {
        pattern_len_max = 32;
    } else if constexpr (std::is_same_v<T, long long> || std::is_same_v<T, size_t>) {
        pattern_len_max = 64;
    } else {
        Err::unreachable("iBitMaskImme: cant convert to encode");
    }

    auto imme = static_cast<uint64_t>(imm);

    uint64_t pattern_len = 1;

    while (pattern_len < pattern_len_max) {
        pattern_len <<= 2;

        uint64_t pattern_probably = imme % (1ULL << pattern_len);

        if (!pattern_probably || pattern_probably == (1ULL << pattern_len) - 1) {
            // no 0 or no 1
            continue;
        }

        auto clz = clz_wrapper(pattern_probably) - (pattern_len_max - pattern_len);
        auto ctz = ctz_wrapper(pattern_probably);
        auto popcount = popcounter_wrapper(pattern_probably);

        if (clz + ctz + popcount != pattern_len) {
            continue;
        }

        bool pattern_match = true;
        for (int i = 1; i < pattern_len_max / pattern_len; ++i) {
            uint64_t pattern_apply_probably = (imme >> (i * pattern_len)) % (1 << pattern_len);

            if (pattern_apply_probably != pattern_probably) {
                pattern_match = false;
                break;
            }
        }

        if (pattern_match == true) {
            break;
        }
    }

    if (pattern_len < pattern_len_max) {
        return true;
    } else {
        return false;
    }
}

#if defined(__GCC__)
#pragma GCC pop_options
#endif

// IMME judge end
} // namespace ARMv8

///@note 理论上在CodeGen之前区分寄存器位宽没有价值
///@note ARMv8的V<>寄存器不能够拆成若干独立的S<>寄存器
enum class ARMReg : uint32_t {
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
    FP = X29,
    X30,
    LR = X30,
    SP, // 并非X31
    /* PC */
    V0, // 32U
    V1,
    V2,
    V3,
    V4,
    V5,
    V6,
    V7,
    V8,
    V9,
    V10,
    V11,
    V12,
    V13,
    V14,
    V15,
    V16,
    V17,
    V18,
    V19,
    V20,
    V21,
    V22,
    V23,
    V24,
    V25,
    V26,
    V27,
    V28,
    V29,
    V30,
    V31,
};

GNALC_ENUM_OPERATOR(ARMReg)

enum class ARMOpC : uint32_t {
    LDR,
    LDUR,
    LD1,
    LD2,
    LD3,
    LD4,
    LD5,
    STR,
    STUR,
    ST1,
    ST2,
    ST3,
    ST4,
    ST5,
    SMULL, // smull x<>, w<>, w<>
    MADD,
    MSUB,
    FMADD,
    FMSUB,
    CSEL,        // cond select, dont support simd
    CSET_SELECT, // down graded from csel
    FCSEL,       // cond fp select, dont support simd
    CSET,        // cond set
    CBNZ,        // compare and branch if not zero
    ADRP_LDR,    // 中间表示
    ADRP,        // load page of the value
    MOV,         // not suggested, I mean really
    MOV_V,       // use mov, but with simd regs
    MOVZ,        // mov and zero the rest bits
    MOVK,        // mov and keep the rest bits
    MOVF,        // fmov
    MOVI,        // mov imme into simd regs
    BL,          // func call, remember to mark tail call
    RET,         // ret, with link register
    PUSH,        // implement with losts of stp in codegen
    POP,         // implement with losts of ldp in codegen
    INC,         // implement with add #imme (with imme legalize)
    DEC,         // implement with sub #imme (with imme legalize)
};
} // namespace MIR

#endif
