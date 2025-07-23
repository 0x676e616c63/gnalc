// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#include <cstdint>
#include <optional>
#include <type_traits>
#ifndef GNALC_MIR_MIR_HPP
#define GNALC_MIR_MIR_HPP

#include "armv8/base.hpp"
#include "mir/info.hpp"
#include "mir/tools.hpp"
#include "riscv64/base.hpp"
#include "runtime/runtime.hpp"
#include "utils/exception.hpp"
#include "utils/generic_visitor.hpp"

#include <algorithm>
#include <array>
#include <cstddef>
#include <list>
#include <map>
#include <utility>
#include <variant>

namespace MIR {

// using string = std::string;

template <typename T, typename... Args> std::shared_ptr<T> make(Args &&...args) {
    return std::make_shared<T>(std::forward<Args>(args)...);
}

template <typename T, typename... Args> std::unique_ptr<T> makeu(const Args... args) {
    return std::make_unique<T>(args...);
}

enum class OperandType : uint32_t {
    Int, // X<> 默认位宽
    Int16,
    Int32, // original int32, or extend from int8, int16
    Int64,
    Ptr = Int64,
    Float, // V<> 默认位宽
    Float32,
    Intvec2,
    Intvec3, // not impl
    Intvec4,
    Int64vec2,
    Floatvec2,
    Floatvec3, // not impl
    Floatvec4,
    special, // prob, alignment, load/store size...
    High32,
    Low32,
    // Arm only now
    CondFlag, // to be very aware that many inst no long have cond exec compare to armv7
};

using OpT = OperandType;

inline unsigned getBitWide(OpT type) {
    switch (type) {
    case OpT::Int: // default length
        return 8;
    case OpT::Float:
        return 16;
    case OpT::Int16:
        return 2; // mei yong
    case OpT::High32:
    case OpT::Low32:
    case OpT::Int32:
    case OpT::Float32:
        return 4;
    case OpT::Int64:
    case OpT::Intvec2:
    case OpT::Floatvec2:
        return 8;
    case OpT::Intvec3:
    case OpT::Floatvec3:
        return 12;
    case OpT::Intvec4:
    case OpT::Int64vec2:
    case OpT::Floatvec4:
        return 16;
    default:
        Err::unreachable("getBitWide: type not support a bitwide");
    }
    return 4; // just to make gnalc happy
}

// 默认位宽寄存器向短位宽寄存器兼容
template <typename... OpT> inline unsigned getBitWideChoosen(OpT... types) {
    return (std::min({getBitWide(types)...})); //
}

// 向高位宽寄存器兼容
template <typename... OpT> inline unsigned getBitWideChoosen_L(OpT... types) {
    return (std::max({getBitWide(types)...})); //
}

enum MIRInstCond : unsigned { AL, EQ, NE, LT, GT, LE, GE };

using Cond = MIRInstCond;

enum class MIRGenericInst : uint32_t {
    // control-flow
    InstBranch,     // <nullptr>, reloc, cond, prob
    InstICmpBranch, // <nullptr>, lhs, rhs, reloc, cond (lowered from `one-use icmp + br`, RISCV only currently)
    // Memory, get by gep, no const offset
    InstLoad,  // <def> <base> <idx> <shift> <size_attr>
    InstStore, // <nullptr> <use> <base> <idx> <shift> <size_attr>
    // Arithmetic
    InstAdd,
    InstAddSP,
    InstSub,
    InstMul,
    // Bitwise
    InstAnd,
    InstOr,
    InstXor,
    InstShl,
    InstLShr,
    InstAShr,
    // Signed Div/Rem
    InstSDiv,
    InstSRem,
    // UnSigned Div/Rem
    InstUDiv,
    InstURem,
    // Int Unary
    InstNeg,
    // FP
    InstFAdd,
    InstFSub,
    InstFMul,
    InstFDiv,
    InstFRem,
    InstFNeg,
    // vector binary, at most 4
    InstVAdd,
    InstVSub,
    InstVMul,
    InstVSDiv,
    InstVUDiv,
    InstVFAdd,
    InstVFSub,
    InstVFMul,
    InstVFDiv,
    InstVSRem,
    InstVURem,
    InstVFRem,
    // vector bitwise
    InstVAnd,
    InstVOr,
    InstVXor,
    InstVShl,
    InstVLShr,
    InstVAShr,
    // vector miscs
    InstVFNeg,
    InstVNeg,
    InstVExtract,
    InstVInsert,
    InstShuffle,
    InstVLoad,
    InstVStore,
    InstVZext,
    InstVSext,
    InstVFP2SI,
    InstVSI2FP,
    InstVBitcast,
    InstVIcmp,
    InstVFcmp,
    InstVFRINTZ,
    InstVSelect,
    InstVCopy,
    // Comparison
    InstICmp, // dst, lhs, rhs, op
    InstFCmp, // dst, lhs, rhs, op
    // Conversion
    InstF2S,
    InstS2F,
    InstFRINTZ, // float-point round to zero: 3.5 -> 3, -2.3 -> -2
    // Misc
    InstCopyStkPtr,  // use in stk ptr type cast, not a real copy
    InstCopy,        ///copy: vreg to vreg
    InstCopyFromReg, ///copy: precolored to vreg
    InstCopyToReg,   ///copy: vreg to precolored
    InstSelect,
    InstLoadAddress,
    InstLoadStackObjectAddr,
    InstLoadLiteral,
    InstLoadImm,
    InstLoadImmEx,
    InstLoadFPImm,
    InstLoadImmToReg,
    // InstLoadImmExToReg,
    InstLoadFPImmToReg,
    InstLoadRegFromStack,
    InstStoreRegToStack,
};

using OpC = MIRGenericInst;

enum class MIRRegStatue { alive = 0, dead = 1 };

struct MIRReg {
    unsigned reg; // vreg id, ISAreg
    MIRRegStatue flag = MIRRegStatue::alive;

    explicit MIRReg(unsigned _reg) noexcept : reg(_reg) {}
    MIRReg(unsigned _reg, MIRRegStatue _flag) noexcept : reg(_reg), flag(_flag) {}

    bool operator==(const MIRReg &other) const { return reg == other.reg; }
    bool operator!=(const MIRReg &other) const { return reg != other.reg; }
    [[nodiscard]] bool isAlive() const { return flag == MIRRegStatue::alive; }
};

using MIRReg_p = std::shared_ptr<MIRReg>;
using MIRReg_wp = std::weak_ptr<MIRReg>;

class MIRReloc : public std::enable_shared_from_this<MIRReloc> {
private:
    string mSym;

public:
    explicit MIRReloc(string sym) noexcept : mSym(std::move(sym)) {};

    string getmSym() const { return mSym; }

    virtual bool isFunc() const { return false; }
    virtual bool isBlk() const { return false; }
    virtual bool isData() const { return false; }
    virtual bool isBss() const { return false; }

    template <typename T> std::shared_ptr<T> as() {
        Err::gassert(std::is_base_of_v<MIRReloc, T>, "MIRReloc::as(): Expected a derived type.");
        return std::dynamic_pointer_cast<T>(shared_from_this());
    }

    template <typename T> std::shared_ptr<const T> as() const {
        Err::gassert(std::is_base_of_v<MIRReloc, T>, "MIRReloc::as(): Expected a derived type.");
        return std::dynamic_pointer_cast<const T>(shared_from_this());
    }

    virtual ~MIRReloc() = default;
};

using MIRReloc_p = std::shared_ptr<MIRReloc>;
using MIRReloc_wp = std::weak_ptr<MIRReloc>;

class MIROperand;

constexpr uint32_t VRegBegin = 0x50000000;
constexpr uint32_t StkObjBegin = 0xa0000000;
constexpr uint32_t invalidReg = 0xc0000000;

constexpr inline bool isISAReg(uint32_t x) { return x < VRegBegin; }
constexpr inline bool isVirtualReg(uint32_t x) { return (x & VRegBegin) == VRegBegin; }
constexpr inline bool isStkObj(uint32_t x) { return (x & StkObjBegin) == StkObjBegin; }

class MIROperand {
public:
    static std::map<unsigned, MIROperand_p> ISApool;

private:
    std::variant<std::monostate, MIRReg_p, MIRReloc_p, unsigned, uint64_t, double, string> mOperand{std::monostate{}};
    OpT mType = OpT::special;

    unsigned recover = -1;

public:
    void setRecover(unsigned id) { recover = id; } // for constructors
    unsigned getRecover() const { return recover; }

public:
    constexpr MIROperand() = default;

    template <typename mOperand_t> constexpr MIROperand(mOperand_t op, OpT type) : mOperand(op), mType(type) {}

    [[nodiscard]] const auto &mOp() const { return mOperand; }
    template <typename T> const auto &mOp() const {
        Err::gassert(mOperand.index() != 0, "MIROperand: mOperand is nerver initialized");
        return std::get<T>(mOperand);
    };

    uint64_t imme() const {
        return std::holds_alternative<unsigned>(mOperand) ? std::get<unsigned>(mOperand) : std::get<uint64_t>(mOperand);
    }
    uint64_t immeEx() const { return std::get<uint64_t>(mOperand); }
    unsigned reg() const { return std::get<MIRReg_p>(mOperand)->reg; }
    unsigned idVReg() const {
        Err::gassert(isVirtualReg(reg()), "MIROperand::idVReg: *this is not a VReg");
        return reg();
    }
    unsigned isa() const {
        Err::gassert(isISAReg(reg()), "MIROperand::idVReg: *this is not a ISA");
        return reg();
    }
    const auto &stkobj() const {
        Err::gassert(isStkObj(reg()), "MIROperand::idVReg: *this is not a stkObj");
        return std::get<MIRReg_p>(mOperand)->reg;
    }
    auto regFlag() const { return std::get<MIRReg_p>(mOperand)->flag; }
    auto &regFlag() { return std::get<MIRReg_p>(mOperand)->flag; }
    MIRReloc_p reloc() { return std::get<MIRReloc_p>(mOperand); }
    double prob() const { return std::get<double>(mOperand); }
    const string &literal() const { return std::get<string>(mOperand); }

    ///@note int, float, condflag
    bool isImme() const {
        return std::holds_alternative<unsigned>(mOperand) || std::holds_alternative<uint64_t>(mOperand);
    }
    bool isExImme() const { return std::holds_alternative<uint64_t>(mOperand); }
    bool isUnused() const { return std::holds_alternative<std::monostate>(mOperand); }
    bool isReg() const { return std::holds_alternative<MIRReg_p>(mOperand); }
    bool isVReg() const { return isReg() && isVirtualReg(reg()); }
    bool isISA() const { return isReg() && (isISAReg(reg())); }
    // for RA
    bool isPreColored() const { return isReg() && isISA() && isISAReg(recover); }
    bool isStack() const { return isReg() && isStkObj(reg()); }
    bool isReloc() const { return std::holds_alternative<MIRReloc_p>(mOperand); }
    bool isProb() const { return std::holds_alternative<double>(mOperand); }
    bool isLiteral() const { return std::holds_alternative<string>(mOperand); }

    constexpr OpT type() const { return mType; }
    void resetType(OpT _new) { mType = _new; }

    bool operator==(const MIROperand &other) const { return mOperand == other.mOperand; }
    bool operator!=(const MIROperand &other) const { return mOperand != other.mOperand; }

    template <typename T> static MIROperand_p asImme(T val, OpT type) {

        if constexpr (std::is_same_v<T, int> || std::is_same_v<T, unsigned> || std::is_same_v<T, uint32_t> ||
                      std::is_same_v<T, Cond>) {
            auto encoding = *reinterpret_cast<unsigned *>(&val);
            return make<MIROperand>(encoding,
                                    OpT::Int64); // use Int64 to not narrow down the predicted bitwide when codegen
        } else if constexpr (std::is_same_v<T, int64_t>) {
            auto encoding = *reinterpret_cast<uint64_t *>(&val);
            return make<MIROperand>(encoding, OpT::Int64);
        } else if constexpr (std::is_same_v<T, float>) {
            auto encoding = *reinterpret_cast<unsigned *>(&val);
            return make<MIROperand>(encoding, OpT::Float32);
        } else if constexpr (std::is_same_v<T, uint64_t>) {
            return make<MIROperand>(val, type); // misc
        } else {
            Err::unreachable("MIROperand::asImme: template match failed");
        }
        return nullptr; // just to make clang happy
    }

    // builder begin

    /// @note asISAReg 和 asVReg 使用构型相同的 MIRReg, 区别在于范围不同
    /// @note VReg 的起始位置会大于 ISAReg
    /// @note asISAReg 一般直接传入 ARMReg/RVReg 的值, 构造出的 Operand 不存常量/变量池
    /// @note asVReg 一般由 ctx 传递 id
    /// @note ISA 序号, 或者 VReg id, 都由 reg() 获得, 可以考虑在此基础上进一步具象化和检查
    static MIROperand_p asISAReg(unsigned reg, OpT type) {
        Err::gassert(isISAReg(reg), "MIROperand::asISAReg: input reg doesnt match: " + std::to_string(reg));

        if (ISApool.count(reg)) {
            return ISApool[reg];
        } else {
            auto newISA =
                make<MIROperand>(make<MIRReg>(reg), inRange(type, OpT::Int, OpT::Int64) ? OpT::Int : OpT::Float);
            newISA->setRecover(reg);
            ISApool[reg] = newISA;
            return newISA;
        }
    }

    static MIROperand_p asISAReg(ARMReg reg, OpT type) { return asISAReg(static_cast<unsigned>(reg), type); }

    static MIROperand_p asISAReg(RVReg reg, OpT type) { return asISAReg(static_cast<unsigned>(reg), type); }

    static MIROperand_p asVReg(unsigned reg, OpT type) {
        auto vreg = make<MIROperand>(make<MIRReg>(reg + VRegBegin), type); // auto add VRegBegin here

        vreg->setRecover(reg + VRegBegin);
        return vreg;
    }

    static MIROperand_p asStkObj(unsigned reg, OpT type) {
        return make<MIROperand>(make<MIRReg>(reg + StkObjBegin), type);
    }

    static MIROperand_p asReloc(const MIRReloc_p &value) { return make<MIROperand>(value, OpT::special); }

    static MIROperand_p asProb(double prob) { return make<MIROperand>(prob, OpT::special); }

    static MIROperand_p asLiteral(string liter, OpT type) { return make<MIROperand>(liter, type); }

    // builder end

    // simple type verify
    constexpr bool isVRegOrISAReg() {
        return isReg() && ((isVirtualReg(std::get<MIRReg_p>(mOperand)->reg) ||
                            isISAReg(std::get<MIRReg_p>(mOperand)->reg))); // not invaild
    }

    // use in registeralloc
    ///@note we directly chang reg of MIRReg
    void assignColor(unsigned color) {
        // Err::gassert(isVReg(), "assignColor: try assign color to a non-reg");

        // FIXME: Fix this check for RV.
        // Err::gassert(color >= ARMReg::X0 && color <= ARMReg::V31,
        //              "assignColor: unknown reg color " + std::to_string(color));
        // Err::gassert(color >= ARMReg::V0 && inRange(mType, OpT::Float, OpT::Floatvec4) ||
        //                  color <= ARMReg::X29 && inRange(mType, OpT::Int, OpT::Int64),
        //              "assignColor: register bank dont match mtype");

        auto &VReg = std::get<MIRReg_p>(mOperand);

        // recover = VReg->reg;
        VReg->reg = color; // assigned here
    }

    virtual ~MIROperand() = default;

    std::string dbgDump() const {
        // std::monostate, MIRReg_p, MIRReloc_p, unsigned, uint64_t, double, string
        if (std::holds_alternative<std::monostate>(mOperand))
            return "<monostate>";
        if (std::holds_alternative<MIRReg_p>(mOperand)) {
            auto reg = std::get<MIRReg_p>(mOperand)->reg;
            std::string type;
            if (isVirtualReg(reg)) {
                type = "VReg(";
                reg -= VRegBegin;
            } else if (isISAReg(reg)) {
                type = "ISA(";
            } else if (isStkObj(reg)) {
                reg -= StkObjBegin;
                type = "StkObj(";
            }
            return type + std::to_string(reg) + ")";
        }
        if (std::holds_alternative<MIRReloc_p>(mOperand))
            return "reloc(" + std::get<MIRReloc_p>(mOperand)->getmSym() + ")";
        if (std::holds_alternative<unsigned>(mOperand))
            return "imm(" + std::to_string(std::get<unsigned>(mOperand)) + ")";
        if (std::holds_alternative<uint64_t>(mOperand))
            return "immEx(" + std::to_string(std::get<uint64_t>(mOperand)) + ")";
        if (std::holds_alternative<double>(mOperand))
            return "imm(" + std::to_string(std::get<double>(mOperand)) + ")";
        if (std::holds_alternative<string>(mOperand))
            return "literal(" + std::get<string>(mOperand) + ")";
        return "<unexpected>";
    }
};

class MIRInst : public std::enable_shared_from_this<MIRInst> {
    friend class MIRModule;

public:
    static constexpr unsigned maxOpCnt = 7;

private:
    std::variant<OpC, ARMOpC, RVOpC> mOpcode;
    ///@note <0>代表def, 如果为nullptr, 代表指令没有def, 或者是需要用WZR/XZR占位
    std::array<MIROperand_p, maxOpCnt> mOperands;
    std::vector<std::string> dbg_data;

    explicit MIRInst(std::variant<OpC, ARMOpC, RVOpC> opcode) noexcept : mOpcode(opcode) {};
    explicit MIRInst(OpC opcode) noexcept : mOpcode(opcode) {};
    explicit MIRInst(ARMOpC opcode) noexcept : mOpcode(opcode) {};
    explicit MIRInst(RVOpC opcode) noexcept : mOpcode(opcode) {};

public:
    template <typename... Args> static std::shared_ptr<MIRInst> make(Args &&...args) {
        return std::shared_ptr<MIRInst>(new MIRInst(std::forward<Args>(args)...));
    }

    template <typename T> T opcode() const {
        Err::gassert(std::is_same_v<T, OpC> || std::is_same_v<T, ARMOpC> || std::is_same_v<T, RVOpC>,
                     " MIRInst::opcode: unknown opcode type");
        return std::get<T>(mOpcode); // wrong variant idx maybe ?
    }

    auto opcode() const { return mOpcode; }

    bool isGeneric() const { return mOpcode.index() == 0; }
    bool isARM() const { return mOpcode.index() == 1; }
    bool isRV() const { return mOpcode.index() == 2; }

    MIRInst &resetOpcode(OpC opcode) {
        mOpcode = opcode;
        return *this;
    }

    MIRInst &resetOpcode(ARMOpC opcode) {
        mOpcode = opcode;
        return *this;
    }

    MIRInst &resetOpcode(RVOpC opcode) {
        mOpcode = opcode;
        return *this;
    }

    bool checkOp(unsigned idx) const { return !mOperands[idx]->isUnused(); }
    MIROperand_p &getOp(unsigned idx) { return mOperands[idx]; }
    template <unsigned idx> MIROperand_p &getOp() { return mOperands[idx]; }
    const MIROperand_p &getOp(unsigned idx) const { return mOperands[idx]; }
    template <unsigned idx> const MIROperand_p &getOp() const { return mOperands[idx]; }
    ///@note if you're sure about there is a def op, than use ensureDef not this one
    MIROperand_p &getDef() { return mOperands[0]; }
    MIROperand_p &ensureDef() {
        Err::gassert(mOperands[0] != nullptr, "MIRInst::ensureDef: def is nullptr");
        return mOperands[0];
    }
    const MIROperand_p &getDef() const { return mOperands[0]; }
    const MIROperand_p &ensureDef() const {
        Err::gassert(mOperands[0] != nullptr, "MIRInst::ensureDef: def is nullptr");
        return mOperands[0];
    }

    ///@note return the max idx of use list, so the list may be padded, and remaid to use '<='
    unsigned getUseNr() const;

    unsigned getDefNr() const;

    unsigned getOpNr() const;

    template <unsigned idx> std::shared_ptr<MIRInst> setOperand(const MIROperand_p &operand, CodeGenContext &ctx) {
        Err::gassert(idx < maxOpCnt, "MIRInst: set a op out of range");

        auto original = mOperands[idx];

        original && original->isReg() ? (void)ctx.putOp(original) : nop;
        operand && operand->isReg() ? (void)ctx.getOp(operand) : nop;

        mOperands[idx] = operand;

        return shared_from_this();
    }

    auto &operands() { return mOperands; }
    const auto &operands() const { return mOperands; }

    // to modify
    void replace(const MIROperand_p &_old, const MIROperand_p &_new, CodeGenContext &ctx) {
        auto it =
            std::find_if(mOperands.begin(), mOperands.end(), [&](const MIROperand_p &ath) { return ath == _old; });

        Err::gassert(it != mOperands.end(), "MIRInst::replace: cant find op");

        _new && _new->isReg() ? (void)ctx.getOp(_new) : nop;
        _old && _old->isReg() ? (void)ctx.putOp(_old) : nop;

        *it = _new;
    }

    // before abundant the whole inst
    void putAllOp(CodeGenContext &ctx) {

        for (auto &mop : mOperands) {
            if (mop && mop->isReg()) {
                ctx.putOp(mop);
            }
        }
    }

    virtual ~MIRInst() = default;

    std::string dbgDump() const {
        std::string ret;
        if (isGeneric())
            ret = "G::" + std::string{Util::getEnumName(opcode<OpC>())};
        else if (isARM())
            ret = "A::" + std::string{Util::getEnumName(opcode<ARMOpC>())};
        else if (isRV())
            ret = "R::" + std::string{Util::getEnumName(opcode<RVOpC>())};

        for (size_t i = 0; i < maxOpCnt; i++) {
            auto allNullptrFromThisOne = [&]() -> bool {
                for (size_t j = i; j < maxOpCnt; j++) {
                    if (mOperands[j])
                        return false;
                }
                return true;
            }();
            if (allNullptrFromThisOne)
                break;

            if (mOperands[i])
                ret += " " + mOperands[i]->dbgDump();
            else
                ret += " <null>";
        }
        return ret;
    }

    const std::vector<std::string> &getDbgData() const { return dbg_data; }
    void appendDbgData(const std::string &data) { dbg_data.emplace_back(data); }
    void clearDbgData() { dbg_data.clear(); }

    MIRInst_p clone() const {
        auto ret = make(mOpcode);
        ret->mOperands = mOperands;
        ret->dbg_data = dbg_data;
        ret->appendDbgData("dup");
        return ret;
    }
};

enum class StkObjUsage {
    Arg, // pass to the current func
    CalleeArg,
    CalleeSave,
    Local,
    Spill,
    // Padding , 补全建议直接在包含在Local里, 方便处理
};

struct StkObj {
    unsigned size;
    unsigned maxAlignment;
    int offset; // positive?
    StkObjUsage usage;
    std::variant<std::monostate, unsigned> arg_idx;

    StkObj(unsigned s, unsigned a, int o, StkObjUsage u)
        : size(s), maxAlignment(a), offset(o), usage(u), arg_idx{std::monostate{}} {}

    StkObj(unsigned s, unsigned a, int o, StkObjUsage u, unsigned sq)
        : size(s), maxAlignment(a), offset(o), usage(u), arg_idx(sq) {}

    ~StkObj() = default;
};

struct constVal {};

class MIRBlk : public MIRReloc {
    friend class MIRModule;

private:
    MIRFunction_wp mFunction;
    MIRInst_p_l mInsts;
    double mTripCount = 0.0;

    std::list<MIRBlk_p> mpreds;
    std::list<MIRBlk_p> msuccs;

    MIRBlk_wp mprv;
    MIRBlk_wp mnxt;

    std::vector<std::tuple<string, size_t, size_t, uint32_t>> literal_pool; // literal + size + align + use_cnt

public:
    MIRBlk() = delete;

    MIRBlk(const string &sym, MIRFunction_wp _mFunction, const MIRBlk_p &_prv = nullptr,
           const MIRBlk_p &_nxt = nullptr) noexcept
        : MIRReloc(sym), mFunction{std::move(_mFunction)}, mprv(_prv), mnxt(_nxt) {}

    MIRFunction_p getFunction() const {
        Err::gassert(!mFunction.expired(), "MIRBlk: function reference corrupted");
        return mFunction.lock();
    }

    MIRInst_p_l &Insts() { return mInsts; }
    const MIRInst_p_l &Insts() const { return mInsts; }

    void replaceInsts(MIRInst_p_l &new_mInsts) { std::swap(mInsts, new_mInsts); }

    double TripCount() const { return mTripCount; }
    void setTripCount(double trip) { mTripCount = trip; }

    void addPred(const MIRBlk_p &pred) { mpreds.emplace_back(pred); }
    void addSucc(const MIRBlk_p &succ) { msuccs.emplace_back(succ); }

    auto &preds() { return mpreds; }
    auto &succs() { return msuccs; }

    const auto &preds() const { return mpreds; }
    const auto &succs() const { return msuccs; }

    auto prv() { return wp2p(mprv); }
    auto nxt() { return wp2p(mnxt); }

    const auto prv() const { return wp2p(mprv); }
    const auto nxt() const { return wp2p(mnxt); }

    void resetPrv(const MIRBlk_p &_prv) { mprv = _prv; }
    void resetNxt(const MIRBlk_p &_nxt) { mnxt = _nxt; }

    void add_tail_literal(string literal, size_t _literal_size, size_t _align) {
        auto it = std::find_if(literal_pool.begin(), literal_pool.end(),
                               [&](const auto &item) { return std::get<0>(item) == literal; });

        if (it != literal_pool.end()) {
            auto &[_0, _1, _2, use_cnt] = *it;

            ++use_cnt;
        } else {
            literal_pool.emplace_back(std::move(literal), _literal_size, _align, 1);
        }
    }

    size_t getCodeSize() const {
        auto first_literal_align = getFirstAlign();

        return first_literal_align
                   ? mInsts.size() * 4
                   : getLiteralSize() + ((mInsts.size() * 4 + *first_literal_align - 1) / *first_literal_align) *
                                            (*first_literal_align);
    }

    bool useLiteral() const { return !literal_pool.empty(); }

    std::optional<size_t> getFirstAlign() const {
        if (!useLiteral()) {
            return std::nullopt;
        } else {
            return {std::get<2>(literal_pool[0])};
        }
    }

    size_t getLiteralSize() const {

        size_t cnt = 0;
        for (const auto &[_0, size, _2, _3] : literal_pool) {
            cnt += size;
        }

        return cnt;
    }

    void removeLitetal(const string &literal) {
        auto it = std::find_if(literal_pool.begin(), literal_pool.end(),
                               [&](const auto &item) { return std::get<0>(item) == literal; });

        Err::gassert(it != literal_pool.end(), "literal not found");

        auto &[_0, _1, _2, use_cnt] = *it;

        if (--use_cnt == 0) {
            literal_pool.erase(it);
        }
    }

    void brReplace(const MIRBlk_p &old_succ, const MIRBlk_p &new_succ, CodeGenContext &ctx) {
        auto it = std::find_if(mInsts.begin(), mInsts.end(), [&](const MIRInst_p &minst) {
            if (minst->isGeneric() && minst->opcode<OpC>() == OpC::InstBranch && minst->getOp(1)->reloc() == old_succ) {

                minst->setOperand<1>(MIROperand::asReloc(new_succ), ctx);
                return true;
            } else if (!minst->isGeneric() && minst->opcode<ARMOpC>() == ARMOpC::CBNZ &&
                       minst->getOp(2)->reloc() == old_succ) {
                minst->setOperand<2>(MIROperand::asReloc(new_succ), ctx);
                return true;
            }
            return false;
        });

        Err::gassert(it != mInsts.end(), "MIRBlk: cant find old succ");
    }

    void addInstBeforeBr(const MIRInst_p &to_insert) {
        auto it = mInsts.begin();
        for (; it != mInsts.end(); it++) {
            auto &minst = *it;
            if (minst->isGeneric()) {
                auto opcode = minst->opcode<OpC>();
                if (opcode == OpC::InstBranch || opcode == OpC::InstICmpBranch || opcode == OpC::InstFCmp ||
                    opcode == OpC::InstICmp)
                    break;
            }
            if (minst->isRV()) {
                auto opcode = minst->opcode<RVOpC>();
                if (opcode == RVOpC::J || inRange(opcode, RVOpC::BEQ, RVOpC::BGTZ))
                    break;
            }
            if (minst->isARM() && minst->opcode<ARMOpC>() == ARMOpC::CBNZ)
                break;
        }

        mInsts.insert(it, to_insert);
    }

    void putAllInstOp(CodeGenContext &ctx) {
        for (auto &minst : mInsts) {
            minst->putAllOp(ctx);
        }
    }

    ~MIRBlk() override = default;

    struct BBSuccGetter {
        auto operator()(const MIRBlk_p &bb) { return bb->succs(); }
    };
    using CFGBFVisitor = Util::GenericBFVisitor<MIRBlk_p, BBSuccGetter>;
    template <Util::DFVOrder order = Util::DFVOrder::PreOrder>
    using CFGDFVisitor = Util::GenericDFVisitor<MIRBlk_p, BBSuccGetter, order>;

    auto getBFVisitor() { return CFGBFVisitor(as<MIRBlk>()); }

    template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() {
        return CFGDFVisitor<order>(as<MIRBlk>());
    }
};

class MIRFunction : public MIRReloc {
    friend class MIRModule;

private:
    MIRBlk_p_l mBlks;

    MIRBlk_p mEntryBlk;
    MIRBlk_p_l mExitBlks;

    std::map<MIROperand_p, StkObj> mStkObjs;
    std::vector<MIROperand_p> mArgs;

    // infos
    bool leafFunc = true;
    uint64_t calleesaveRegisters = 0LL; // initialized by RegisterAlloc
    size_t spilled = 0LL;
    bool largeStk = false; // may use fp(X29)
    unsigned stkSize = 0LL;
    unsigned calleeSave = 0LL;
    // context
    CodeGenContext &ctx;

public:
    MIRFunction() = delete;
    MIRFunction(const string &sym, CodeGenContext &_ctx) noexcept : MIRReloc(sym), ctx(_ctx) {}

    MIROperand_p addStkObj(CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset, StkObjUsage);
    MIROperand_p addStkObj(CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset, StkObjUsage,
                           unsigned seq); // for arg on stk
    void setEntryBlk(MIRBlk_p blk) { mEntryBlk = std::move(blk); }
    void addExitBlk(const MIRBlk_p &blk) { mExitBlks.emplace_back(blk); }

    auto &blks() { return mBlks; }
    auto &EntryBlk() { return mEntryBlk; }
    auto &ExitBlks() { return mExitBlks; }
    auto &Args() { return mArgs; }
    auto &StkObjs() { return mStkObjs; }

    const auto &blks() const { return mBlks; }
    const auto &EntryBlk() const { return mEntryBlk; }
    const auto &ExitBlks() const { return mExitBlks; }
    const auto &Args() const { return mArgs; }
    const auto &StkObjs() const { return mStkObjs; }

    bool isLeafFunc() const { return leafFunc; }
    const uint64_t &calleeSaveRegs() const { return calleesaveRegisters; }
    bool isLargeStk() const { return largeStk; }

    void affirmNotLeafFunc() { leafFunc = false; }
    uint64_t &calleeSaveRegs() { return calleesaveRegisters; }
    void affirmLargeStk() { largeStk = true; }

    size_t &spill() { return spilled; }
    size_t spill() const { return spilled; }

    auto &Context() { return ctx; }
    const auto &Context() const { return ctx; }

    bool isProgramEntry() {
        return getmSym() == "main"; // 求放过
    }

    void modifyStkSize(unsigned _size) { stkSize = _size; }
    unsigned stackSize() const { return stkSize; }

    void modifyBegCalleeSave(unsigned _size) { calleeSave = _size; }
    unsigned begCalleeSave() const { return calleeSave; }

    size_t getCodeSize() {
        size_t codesize = 0;
        for (const auto &mblk : mBlks) {
            codesize += mblk->getCodeSize();
        }
        return codesize;
    }

    bool isFunc() const override { return true; }

    string getName() const { return getmSym(); }

    ~MIRFunction() override = default;

    auto getBFVisitor() const { return MIRBlk::CFGBFVisitor(mBlks.front()); }

    template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() const {
        return MIRBlk::CFGDFVisitor<order>(mBlks.front());
    }
};

class MIRBssStorage : public MIRReloc {
private:
    unsigned msize;
    unsigned alignment;

public:
    MIRBssStorage() = delete;
    MIRBssStorage(const string &sym, unsigned _size, unsigned _alignment) noexcept
        : MIRReloc(sym), msize(_size), alignment(_alignment) {}

    bool isBss() const override { return true; }
    unsigned align() const { return alignment; }
    unsigned size() const { return msize; }

    ~MIRBssStorage() override = default;
};

struct MIRStorage {
    /// @note size_t to record 0 size, to solve sparse arrays
    std::variant<std::monostate, int, float, size_t> mstore;
    const auto &store() const { return mstore; }

    template <typename T> const auto &store() const {
        Err::gassert(mstore.index() != 0, "MIRStorage: store val is never initialized");
        return std::get<T>(mstore);
    }

    bool isInt32() const { return mstore.index() == 1; }
    bool isFloat() const { return mstore.index() == 2; }
    bool isSize() const { return mstore.index() == 3; }
};

class MIRDataStorage : public MIRReloc {
public:
private:
    unsigned alignment;
    std::vector<MIRStorage> datas{}; // 没有结构体的情况下, vec内类型一致
    bool readOnly = false;           // not impl

public:
    MIRDataStorage(const string &sym, const std::vector<MIRStorage> &_datas, unsigned _alignment) noexcept
        : MIRReloc(sym), datas{_datas}, alignment(_alignment) {}
    MIRDataStorage(const string &sym, const std::vector<MIRStorage> &_datas, unsigned _alignment,
                   bool _readOnly) noexcept
        : MIRReloc(sym), datas{_datas}, alignment(_alignment), readOnly(_readOnly) {}

    bool isData() const override { return true; }

    unsigned align() const { return alignment; }
    auto &getDatas() { return datas; }
    const auto &getDatas() const { return datas; }

    ~MIRDataStorage() override = default;
};

class MIRJmpTable : public MIRReloc {
private:
    std::vector<MIRReloc_wp> msyms{};

public:
    explicit MIRJmpTable(const string &sym) : MIRReloc(sym) {}

    auto &syms() { return msyms; }
    const auto &syms() const { return msyms; }

    ~MIRJmpTable() override = default;
};

class MIRGlobal {
private:
    std::size_t alignment;
    MIRReloc_p mreloc; // func, blk, data, bss

public:
    MIRGlobal(std::size_t _alignment, MIRReloc_p _reloc) noexcept : alignment(_alignment), mreloc(std::move(_reloc)) {}

    auto &reloc() { return mreloc; }
    const auto &reloc() const { return mreloc; }

    ~MIRGlobal() = default;
};

class MIRModule {
private:
    const BkdInfos &mtarget;
    CodeGenContext &ctx;
    std::vector<MIRGlobal_p> mglobals{};

    std::vector<MIRFunction_p> mFuncs{}; // for function pass

    string name; // for MAM

    std::set<Runtime::RtType> runtime_types;

public:
    MIRModule() = delete;

    MIRModule(const BkdInfos &infos, CodeGenContext &_ctx, string _name, std::set<Runtime::RtType> _runtimes)
        : mtarget{infos}, mglobals{}, ctx(_ctx), name(std::move(_name)), runtime_types(std::move(_runtimes)) {}

    auto &globals() { return mglobals; }
    const auto &globals() const { return mglobals; }

    const BkdInfos &getTarget() const { return mtarget; }

    auto &funcs() { return mFuncs; }
    const auto &funcs() const { return mFuncs; }

    void addFunc(const MIRFunction_p &func) { mFuncs.emplace_back(func); }

    string getName() const { return name; }

    std::set<Runtime::RtType> getRuntimeTypes() const { return runtime_types; }

    ~MIRModule();
};

using MIRModule_p = std::shared_ptr<MIRModule>;

///@note use these when LoweringContent is not clear, or not in a IR lowering stage
struct ARMInstTemplate {
    static void registerInc(MIRInst_p_l, MIRInst_p_l::iterator, ARMReg, unsigned, CodeGenContext &);
    static void registerDec(MIRInst_p_l, MIRInst_p_l::iterator, ARMReg, unsigned, CodeGenContext &);
    static void registerAdjust(MIRInst_p_l, MIRInst_p_l::iterator, ARMReg, int, CodeGenContext &);
};

}; // namespace MIR

#endif