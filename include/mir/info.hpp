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

template <typename T> bool is12ImmeWithProbShift(T imm) {
    ///@warning use in ADD/SUB/CMP/CMN

    Err::gassert(!std::is_same_v<T, float>, "is12ImmeWithShift: fadd/fsub dont support a imme");
    Err::gassert(std::is_same_v<T, int> || std::is_same_v<T, unsigned> || std::is_same_v<T, long>,
                 "is12ImmeWithShift: cant convert to encode");

    unsigned imme = static_cast<unsigned>(imm);

    if (imme < 4096 || (imme % 0x1000 == 0 && (imme >> 12) < 4096)) {
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

    auto imme = static_cast<size_t>(imm);

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

enum ARMOpC : uint32_t {
    LDR,
    STR,
    LDUR,
    STUR,
    LD1,
    LD2,
    LD3,
    ST1,
    ST2,
    ST3,
    CSET,     // cond set
    CBNZ,     // compare and branch if not zero
    ADRP_LDR, // load page of address then load address
    MOV,      // not suggested, I mean really
    MOVZ,     // mov and zero the rest bits
    MOVK,     // mov and keep the rest bits
    MOVF,     // fmov
    BL,       // func call, remember to mark tail call
    RET,      // ret, with link register
    PUSH,     // implement with losts of stp in codegen
    POP,      // implement with losts of ldp in codegen
    INC,      // implement with add #imme (with imme legalize)
    DEC,      // implement with sub #imme (with imme legalize)
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

class BkdInfos {
public:
    const DataLayOut dataLayOut;
};

class LoweringContext; // defined in lowering.hpp
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
class MIRGlobal;
using MIRGlobal_p = std::shared_ptr<MIRGlobal>;
class StkObj;
class MIRJmpTable;

class ISelContext;
struct CodeGenContext;

class FrameInfo { // armv8(A64)
public:
    FrameInfo() = default;
    ~FrameInfo() = default;

    void handleCallEntry(IR::pCall, LoweringContext &) const;
    MIRGlobal_p handleLib(IR::pCall, LoweringContext &) const;
    void handleMemset(IR::pCall, LoweringContext &) const;
    void handleMemcpy(IR::pCall, LoweringContext &) const;
    // void handleSIMD(IR::pCall, LoweringContext&) const;

    void makePrologue(MIRFunction_p, LoweringContext &) const;
    void makeReturn(IR::pRet, LoweringContext &) const;

    void makePostSAPrologue(MIRBlk_p, CodeGenContext &, unsigned) const;
    void makePostSAEpilogue(MIRBlk_p, CodeGenContext &, unsigned) const;
    void insertPrologueEpilogue(MIRFunction *, CodeGenContext &) const;

    ///@note not used
    bool isCallerSaved(const MIROperand &op) const;
    bool isCalleeSaved(const MIROperand &op) const;

    constexpr size_t getStackPointerAlignment() const { return 16; };
};

struct InstLegalizeContext {
    MIRInst_p &minst;
    MIRInst_p_l &minsts;
    MIRInst_p_l::iterator &iter;
    CodeGenContext &ctx;

    InstLegalizeContext(MIRInst_p &minst, MIRInst_p_l &insts, MIRInst_p_l::iterator &iter, CodeGenContext &ctx)
        : minst(minst), minsts(insts), iter(iter), ctx(ctx) {}

    InstLegalizeContext(const InstLegalizeContext &) = delete;
    InstLegalizeContext &operator=(const InstLegalizeContext &) = delete;

    InstLegalizeContext(InstLegalizeContext &&) = delete;
    InstLegalizeContext &operator=(InstLegalizeContext &&) = delete;

    template <size_t I> auto &get() {
        if constexpr (I == 0) {
            return minst;
        } else if constexpr (I == 1) {
            return minsts;
        } else if constexpr (I == 2) {
            return iter;
        } else if constexpr (I == 3) {
            return ctx;
        }
    }

    template <size_t I> const auto &get() const {
        if constexpr (I == 0) {
            return minst;
        } else if constexpr (I == 1) {
            return minsts;
        } else if constexpr (I == 2) {
            return iter;
        } else if constexpr (I == 3) {
            return ctx;
        }
    }
};

class ISelInfo {
public:
    ISelInfo() = default;

    bool isLegalGenericInst(MIRInst_p) const;
    bool match(MIRInst_p, ISelContext &, bool allow) const;
    bool legalizeInst(MIRInst_p minst, ISelContext &ctx) const;
    bool matchImpl(MIRInst_p minst, ISelContext &ctx) const;
    void postLegalizeInst(InstLegalizeContext &);
    void postLegalizeInst(InstLegalizeContext &, MIRInst_p_l &);
    void preLegalizeInst(InstLegalizeContext &);
    void legalizeWithStkOp(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const;
    void legalizeWithStkGep(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const;
    void legalizeWithStkPtrCast(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const;

    ~ISelInfo() = default;
};

struct CodeGenContext {
    const BkdInfos &infos;

    ISelInfo &iselInfo;
    FrameInfo &frameInfo;
    // const TargetInstInfo &instInfo;

    unsigned idx = 0;
    unsigned nextId() { return ++idx; }

    // unsigned idx_l = 0; // label
    // string nextBlkLable(const string &func_name) {
    //     return func_name + "_blk_" + std::to_string(idx_l++); // rename
    // }
};

}; // namespace MIR_new

namespace std {

template <> struct tuple_size<MIR_new::InstLegalizeContext> : integral_constant<std::size_t, 4> {};

template <size_t I> struct tuple_element<I, MIR_new::InstLegalizeContext> {
    using type = decltype((declval<MIR_new::InstLegalizeContext>().get<I>())); // extra brasses
};

}; // namespace std

#endif