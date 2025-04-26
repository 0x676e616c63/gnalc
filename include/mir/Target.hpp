#pragma once
#ifndef GNALC_ARMV8_MIR_TARGET_HPP
#define GNALC_ARMV8_MIR_TARGET_HPP

#include "ir/instructions/control.hpp"
#include "mir/tools.hpp"
#include <string>

namespace MIR_new {
using string = std::string;

// IMME judge begin

///@note armv8没有了armv7中通用的8位旋转立即数, 取而代之的是一大堆规则不同的立即数

template <typename T> bool is12ImmeWithProbShift(T imm) {
    ///@warning use in ADD/SUB/CMP/CMN

    Err::gassert(!std::is_same_v<T, float>, "is12ImmeWithShift: fadd/fsub dont support a imme");
    Err::gassert(std::is_same_v<T, int> || std::is_same_v<T, unsigned>, "is12ImmeWithShift: cant convert to encode");

    unsigned imme = static_cast<unsigned>(imm);

    if (imme < 4096 || (imme >> 12) < 4096) {
        return true;
    } else {
        return false;
    }
}

template <typename T> bool isBitMaskImme(T imm) {
    ///@warning use in AND/ORR...
    ///@warning MOV instruction is an alias of ORR (immediate).

    ///@brief reference: https://developer.arm.com/documentation/dui0802/b/A64-General-Instructions/ANDS--immediate-?lang=en
    ///@note imm is the bitmask immediate. Such an immediate is a 32-bit or 64-bit
    ///@note pattern viewed as a vector of identical elements of size e = 2, 4, 8,
    ///@note 16, 32, or 64 bits. Each element contains the same sub-pattern: a
    ///@note single run of 1 to e-1 non-zero bits, rotated by 0 to e-1 bits. This
    ///@note mechanism can generate 5,334 unique 64-bit patterns (as 2,667 pairs of
    ///@note pattern and their bitwise inverse). Because the all-zeros and all-ones
    ///@note values cannot be described in this way, the assembler generates an error message.

    ///@note pattern一共有5334个(包括64位的), 可能存在不同位宽的pattern表述出的imme却是一致的
    unsigned pattern_len_max;
    if constexpr (std::is_same_v<T, int> || std::is_same_v<T, unsigned>) {
        pattern_len_max = 32;
    } else if constexpr (std::is_same_v<T, long long> || std::is_same_v<T, size_t>) {
        pattern_len_max = 64;
    } else {
        Err::unreachable("iBitMaskImme: cant convert to encode");
    }

    auto imme = static_case<size_t>(imm);

    unsigned pattern_len = 1;

    while (pattern_len < pattern_len_max) {
        pattern_len *= 2;

        unsigned pattern_probably = imme % (1 << pattern_len);

        if (!pattern_probably || pattern_probably == (1 << pattern_len) - 1) {
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
            unsigned pattern_apply_probably = (imme >> (i * pattern_len)) % (1 << pattern_len);

            if (pattern_apply_probably != pattern_probably) {
                pattern_match = false;
                break;
            }
        }

        if (pattern_match == true) {
            break;
        }
    }

    if (pattern_len <= pattern_len_max) {
        return true;
    } else {
        return false;
    }
}

// IMME judge end

///@note 理论上在CodeGen之前区分寄存器位宽没有价值
///@note ARMv8的V<>寄存器不能够拆成若干独立的S<>寄存器
enum ARMReg : uint32_t {
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
    PC, // 并非X32
    V0, // 33U
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
};

enum ARMOpC : uint32_t {
    BL,   // call
    RET,  // ret
    PUSH, // implement with losts of stp in codegen
    POP,  // implement with losts of ldp in codegen
    INC,  // implement with add #imme (with imme legalize)
    DEC,  // implement with sub #imme (with imme legalize)
};

class MIRInst;
using MIRInst_p = std::shared_ptr<MIRInst>;
using MIRInst_wp = std::weak_ptr<MIRInst>;
using MIRInst_p_l = std::list<MIRInst_p>;

///@note use these when LoweringContent is not clear, or not in a IR lowering stage
struct ARMInstTemplate {
    static void registerInc(MIRInst_p_l, MIRInst_p_l::iterator, ARMReg, unsigned);
    static void registerDec(MIRInst_p_l, MIRInst_p_l::iterator, ARMReg, unsigned);
    static void registerAdjust(MIRInst_p_l, MIRInst_p_l::iterator, ARMReg, int);
};

struct DataLayOut {
    enum class Endian { little, big } endian;
    const unsigned builtInAlignment;
    const unsigned pointerSize;
    const unsigned codeAlignment;
    const unsigned storeAlignment;
};

class Target {
public:
    const DataLayOut dataLayOut;
};

class LoweringContext; // defined in lowering.hpp
class MIRFunction;
class MIROperand;
using MIROperand_p = std::shared_ptr<MIROperand>;
using MIROperand_wp = std::weak_ptr<MIROperand>;
class MIRFunction;
using MIRFunction_p = std::shared_ptr<MIRFunction>;
using MIRFunction_wp = std::weak_ptr<MIRFunction>;
class MIRBlk;
using MIRBlk_p = std::shared_ptr<MIRBlk>;
using MIRBlk_wp = std::weak_ptr<MIRBlk>;
using MIRBlk_p_l = std::list<MIRBlk_p>;

class TargetFrameInfo { // armv8(A64)
public:
    TargetFrameInfo() = default;
    ~TargetFrameInfo() = default;

    void emitCall(IR::pCall, LoweringContext &) const;
    void emitPrologue(MIRFunction_p, LoweringContext &) const;
    void emitReturn(IR::pRet, LoweringContext &) const;

    void emitPostSAPrologue(MIRBlk_p, LoweringContext &, unsigned) const;
    void emitPostSAEpilogue(MIRBlk_p, LoweringContext &, unsigned) const;
    void insertPrologueEpilogue(MIRFunction_p, std::set<MIROperand_p>, LoweringContext &) const;

    bool isCallerSaved(const MIROperand &op) const;
    bool isCalleeSaved(const MIROperand &op) const;

    constexpr size_t getStackPointerAlignment() const { return 16; };
};

struct CodeGenContext {
    const Target &target;

    const TargetFrameInfo &frameInfo;

    unsigned idx = 0;
    unsigned nextId() { return ++idx; }

    unsigned idx_l = 0;
    string nextBlkLable(const string &func_name) {
        return func_name + "_blk_" + std::to_string(idx_l++); // rename
    }
};
}; // namespace MIR_new

#endif