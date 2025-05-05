#pragma once
#ifndef GNALC_ARMV8_MIR_HPP
#define GNALC_ARMV8_MIR_HPP

#include "ir/base.hpp"
#include "ir/instructions/compare.hpp"
#include "mir/info.hpp"
#include <algorithm>
#include <array>
#include <map>
#include <utility>
#include <variant>

namespace MIR_new {

// using string = std::string;

template <typename T, typename... Args> std::shared_ptr<T> make(Args &&...args) {
    return std::make_shared<T>(std::forward<Args>(args)...);
}

template <typename T, typename... Args> std::unique_ptr<T> makeu(const Args... args) {
    return std::make_unique<T>(args...);
}

enum class OperandType {
    Int, // when use reg adjustment
    Int16,
    Int32, // original int32, or extend from int8, int16
    Int64,
    Ptr = Int64,
    Intvec,
    Float32,
    Floatvec,
    special, // prob, alignment, load/store size...
    High32,
    Low32,
    // Arm only now
    CondFlag, // to be very aware that many inst no long have cond exec compare to armv7
    Shift5,
    LoadStoreShamt
};

using OpT = OperandType;

inline unsigned getBitWide(OpT type) {
    switch (type) {
    case OpT::Int:
        // use int when opt or legal with unclear type, extend the bitwide
        return 16;
    case OpT::Int16:
        return 2;
    case OpT::High32:
    case OpT::Low32:
    case OpT::Int32:
    case OpT::Float32:
        return 4;
    case OpT::Int64:
        return 8;
    case OpT::Intvec:
    case OpT::Floatvec:
        return 16;
    default:
        Err::unreachable("getBitWide: type not support a bitwide");
    }
    return 4; // just to make gnalc happy
}

enum MIRInstCond : unsigned { AL, EQ, NE, LT, GT, LE, GE };

using Cond = MIRInstCond;

enum class MIRGenericInst {
    // control-flow
    InstBranch, // cond, reloc, prob
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
    // Int Unary
    InstNeg,
    // FP
    InstFAdd,
    InstFSub,
    InstFMul,
    InstFDiv,
    InstFRem,
    InstFNeg,
    // vector, at most 4
    InstVAdd,
    InstVSub,
    InstVMul,
    InstVDiv,
    InstVHorizontalAdd,
    // Comparison
    InstICmp, // dst, lhs, rhs, op
    InstFCmp, // dst, lhs, rhs, op
    // Conversion
    InstF2S,
    InstS2F,
    // Misc
    InstCopy,   // vreg to vreg
    InstSelect, // CSEL/FSEL <dst_Reg>, <Reg>, <Reg>, <cond>
    InstLoadGlobalAddress,
    InstLoadImm, // const to vreg
    InstLoadStackObjectAddr,
    InstCopyFromReg,  // precolored to vreg
    InstCopyToReg,    // vreg to precolored
    InstLoadImmToReg, // const to precolored
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
    bool isAlive() const { return flag == MIRRegStatue::alive; }
};

using MIRReg_p = std::shared_ptr<MIRReg>;
using MIRReg_wp = std::weak_ptr<MIRReg>;

class MIRRelocable : public std::enable_shared_from_this<MIRRelocable> {
private:
    string mSym;

public:
    explicit MIRRelocable(string sym) noexcept : mSym(std::move(sym)){};

    string getmSym() const { return mSym; }

    virtual bool isFunc() const { return false; }
    virtual bool isBlk() const { return false; }
    virtual bool isData() const { return false; }
    virtual bool isBss() const { return false; }

    template <typename T> std::shared_ptr<T> as() {
        Err::gassert(std::is_base_of_v<MIRRelocable, T>, "MIRRelocable::as(): Expected a derived type.");
        return std::dynamic_pointer_cast<T>(shared_from_this());
    }

    template <typename T> std::shared_ptr<const T> as() const {
        Err::gassert(std::is_base_of_v<MIRRelocable, T>, "MIRRelocable::as(): Expected a derived type.");
        return std::dynamic_pointer_cast<const T>(shared_from_this());
    }

    virtual ~MIRRelocable() = default;
};

using MIRRelocable_p = std::shared_ptr<MIRRelocable>;
using MIRRelocable_wp = std::weak_ptr<MIRRelocable>;

class MIROperand;

constexpr uint32_t VRegBegin = 0b0101U << 28;
constexpr uint32_t StkObjBegin = 0b1010U << 28;
constexpr uint32_t invalidReg = 0b1100U << 28;

constexpr inline bool isISAReg(uint32_t x) { return x < VRegBegin; }
constexpr inline bool isVirtualReg(uint32_t x) { return (x & VRegBegin) == VRegBegin; }
constexpr inline bool isStkObj(uint32_t x) { return (x & StkObjBegin) == StkObjBegin; }

class MIROperand {
private:
    std::variant<std::monostate, MIRReg_p, MIRRelocable_p, unsigned, uint64_t, double> mOperand{std::monostate{}};
    OpT mType = OpT::special;

public:
    constexpr MIROperand() = default;

    template <typename mOperand_t> constexpr MIROperand(mOperand_t op, OpT type) : mOperand(op), mType(type) {}

    const auto &mOp() const { return mOperand; }
    template <typename T> const auto &mOp() const {
        Err::gassert(mOperand.index() != 0, "MIROperand: mOperand is nerver initialized");
        return std::get<T>(mOperand);
    };
    unsigned imme() const { return std::get<unsigned>(mOperand); }
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
        Err::gassert(isStkObj(reg()), "MIROperand::idVReg: *this is not a ISA");
        return std::get<MIRReg_p>(mOperand)->reg;
    }
    auto regFlag() const { return std::get<MIRReg_p>(mOperand)->flag; }
    auto &regFlag() { return std::get<MIRReg_p>(mOperand)->flag; }
    MIRRelocable_p relocable() { return std::get<MIRRelocable_p>(mOperand); }
    double prob() const { return std::get<double>(mOperand); }

    ///@note int, float, condflag
    bool isImme() const { return std::holds_alternative<unsigned>(mOperand); }
    bool isExImme() const { return std::holds_alternative<uint64_t>(mOperand); }
    bool isUnused() const { return std::holds_alternative<std::monostate>(mOperand); }
    bool isReg() const { return std::holds_alternative<MIRReg_p>(mOperand); }
    bool isVReg() const { return isReg() && isVirtualReg(reg()); }
    bool isISA() const { return isReg() && isISAReg(reg()); }
    bool isStack() const { return isReg() && isStkObj(reg()); }
    bool isReloc() const { return std::holds_alternative<MIRRelocable_p>(mOperand); }
    bool isProb() const { return std::holds_alternative<double>(mOperand); }

    constexpr OpT type() const { return mType; }

    bool operator==(const MIROperand &other) const { return mOperand == other.mOperand; }
    bool operator!=(const MIROperand &other) const { return mOperand != other.mOperand; }

    template <typename T> static MIROperand_p asImme(T val, OpT type) {
        if constexpr (std::is_same_v<T, int> || std::is_same_v<T, float> || std::is_same_v<T, unsigned> ||
                      std::is_same_v<T, Cond>) {
            unsigned encoding = *reinterpret_cast<unsigned *>(&val);
            return make<MIROperand>(encoding, type);
        } else if constexpr (std::is_same_v<T, uint64_t>) {
            return make<MIROperand>(val, type); //
        } else {
            Err::unreachable("MIROperand::asImme: template match failed");
        }
        return nullptr; // just to make gnalc happy
    }

    // builder begin

    /// @note asISAReg 和 asVReg 使用构型相同的MIRReg, 区别在于范围不同
    /// @note VReg 的起始位置会大于 ISAReg
    /// @note asISAReg 一般直接传入ARMReg的值, 构造出的Operand不存常量/变量池
    /// @note asVReg 一般由ctx传递id
    /// @note ISA序号, 或者VReg id, 都由reg()获得, 可以考虑在此基础上进一步具象化和检查
    static MIROperand_p asISAReg(unsigned reg, OpT type) {
        Err::gassert(isISAReg(reg), "MIROperand::asISAReg: input reg doesnt match");
        return make<MIROperand>(make<MIRReg>(reg), type);
    }

    static MIROperand_p asVReg(unsigned reg, OpT type) {
        return make<MIROperand>(make<MIRReg>(reg + VRegBegin), type); // auto add VRegBegin here
    }

    static MIROperand_p asStkObj(unsigned reg, OpT type) {
        return make<MIROperand>(make<MIRReg>(reg + StkObjBegin), type);
    }

    static MIROperand_p asReloc(const MIRRelocable_p &value) { return make<MIROperand>(value, OpT::special); }

    static MIROperand_p asProb(double prob) { return make<MIROperand>(prob, OpT::special); }

    // builder end

    // simple type verify
    constexpr bool isVRegOrISAReg() {
        return isReg() && (isVirtualReg(std::get<MIRReg_p>(mOperand)->reg) ||
                           isISAReg(std::get<MIRReg_p>(mOperand)->reg)); // not invaild
    }

    // use in registeralloc
    ///@note we directly chang reg of MIRReg
    void assignColor(unsigned color) {
        Err::gassert(isVReg(), "assignColor: try assign color to a non-reg");
        Err::gassert(color >= ARMReg::X0 && color <= ARMReg::V30, "assignColor: unknonw reg color");
        Err::gassert(color >= ARMReg::V0 && (mType == OpT::Float32 || mType == OpT::Floatvec || mType == OpT::Intvec) ||
                         color <= ARMReg::X29 &&
                             (mType == OpT::Int16 || mType == OpT::Int32 || mType == OpT::Int64 || mType == OpT::Int),
                     "assignColor: register bank dont match mtype");

        auto &VReg = std::get<MIRReg_p>(mOperand);

        VReg->reg = color; // assigned here
    }

    virtual ~MIROperand() = default;
};

class MIRInst : public std::enable_shared_from_this<MIRInst> {
public:
    static constexpr unsigned maxOpCnt = 7;

private:
    std::variant<OpC, ARMOpC> mOpcode;
    ///@note <0>代表def, 如果为nullptr, 代表指令没有def, 或者是需要用WZR/XZR占位
    std::array<MIROperand_p, maxOpCnt> mOperands;
    explicit MIRInst(OpC opcode) noexcept : mOpcode(opcode){};
    explicit MIRInst(ARMOpC opcode) noexcept : mOpcode(opcode){};

public:
    template <typename... Args> static std::shared_ptr<MIRInst> make(Args &&...args) {
        return std::shared_ptr<MIRInst>(new MIRInst(std::forward<Args>(args)...));
    }

    template <typename T> T opcode() const {
        Err::gassert(std::is_same_v<T, OpC> || std::is_same_v<T, ARMOpC>, " MIRInst::opcode: warning typename");
        return std::get<T>(mOpcode); // wrong variant idx maybe ?
    }

    bool isGeneric() const { return mOpcode.index() == 0; }

    MIRInst &resetOpcode(OpC opcode) {
        mOpcode = opcode;
        return *this;
    }

    MIRInst &resetOpcode(ARMOpC opcode) {
        mOpcode = opcode;
        return *this;
    }

    bool checkOp(unsigned idx) const { return !mOperands[idx]->isUnused(); }
    MIROperand_p &getOp(unsigned idx) { return mOperands[idx]; }
    template <unsigned idx> MIROperand_p &getOp() { return mOperands[idx]; }
    const MIROperand_p &getOp(unsigned idx) const { return mOperands[idx]; }
    template <unsigned idx> const MIROperand_p &getOp() const { return mOperands[idx]; }
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

    unsigned getUseNr() const;

    unsigned getDefNr() const;

    unsigned getOpNr() const;

    template <unsigned idx> std::shared_ptr<MIRInst> setOperand(const MIROperand_p &operand) {
        Err::gassert(idx < maxOpCnt, "MIRInst: set a op out of range");
        mOperands[idx] = operand;
        return shared_from_this();
    }

    auto &operands() { return mOperands; }
    const auto &operands() const { return mOperands; }

    // to modify
    void replace(MIROperand_p _old, MIROperand_p _new) {
        auto it =
            std::find_if(mOperands.begin(), mOperands.end(), [&](const MIROperand_p &ath) { return ath == _old; });

        Err::gassert(it != mOperands.end(), "MIRInst::replace: cant find op");

        *it = _new;
    }

    virtual ~MIRInst() = default;
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

class MIRFunction : public MIRRelocable {
private:
    MIRBlk_p_l mBlks;

    MIRBlk_p mEntryBlk;
    MIRBlk_p_l mExitBlks;

    std::map<MIROperand_p, StkObj> mStkObjs;
    std::vector<MIROperand_p> mArgs;

    // infos
    bool leafFunc = true;
    uint64_t calleesaveRegisters = 0ULL;
    size_t spilled = 0LL;
    bool largeStk = false; // may use fp(X29)
    unsigned stkSize = 0LL;

    // context
    CodeGenContext &ctx;

public:
    MIRFunction() = delete;
    MIRFunction(const string &sym, CodeGenContext &_ctx) noexcept : MIRRelocable(sym), ctx(_ctx) {}

    MIROperand_p addStkObj(CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset, StkObjUsage);
    MIROperand_p addStkObj(CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset, StkObjUsage,
                           unsigned seq); // for arg on stk
    void setEntryBlk(MIRBlk_p blk) { mEntryBlk = blk; }
    void addExitBlk(MIRBlk_p blk) { mExitBlks.emplace_back(blk); }

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
    uint64_t calleeSaveRegs() const { return calleesaveRegisters; }
    bool isLargeStk() const { return largeStk; }

    void affirmNotLeafFunc() { leafFunc = false; }
    uint64_t &calleeSaveRegs() { return calleesaveRegisters; }
    void affirmLargeStk() { largeStk = true; }

    size_t &spill() { return spilled; }
    size_t spill() const { return spilled; }

    auto &CodeGenContext() { return ctx; }
    const auto &CodeGenContext() const { return ctx; }

    bool isProgramEntry() {
        return getmSym() == "main"; //
    }

    void modifyStkSize(unsigned _size) { stkSize = _size; }
    unsigned stackSize() const { return stkSize; }

    bool isFunc() const override { return true; }

    string getName() const { return getmSym(); }

    ~MIRFunction() override = default;
};

class MIRBlk : public MIRRelocable {
private:
    MIRFunction_wp mFunction;
    MIRInst_p_l mInsts;
    double mTripCount = 0.0;

    std::list<MIRBlk_p> mpreds;
    std::list<MIRBlk_p> msuccs;

public:
    MIRBlk() = delete;
    MIRBlk(const string &sym, MIRFunction_wp _mFunction) noexcept
        : MIRRelocable(sym), mFunction{std::move(_mFunction)} {}

    MIRFunction_p getFunction() const {
        Err::gassert(!mFunction.expired(), "MIRBlk: function reference corrupted");
        return mFunction.lock();
    }

    MIRInst_p_l &Insts() { return mInsts; }
    const MIRInst_p_l &Insts() const { return mInsts; }

    double TripCount() const { return mTripCount; }
    void setTripCount(double trip) { mTripCount = trip; }

    void addPred(const MIRBlk_p &pred) { mpreds.emplace_back(pred); }
    void addSucc(const MIRBlk_p &succ) { msuccs.emplace_back(succ); }

    auto &preds() { return mpreds; }
    auto &succs() { return msuccs; }

    const auto &preds() const { return mpreds; }
    const auto &succs() const { return msuccs; }

    ~MIRBlk() override = default;
};

class MIRBssStorage : public MIRRelocable {
private:
    unsigned msize;
    unsigned alignment;

public:
    MIRBssStorage() = delete;
    MIRBssStorage(const string &sym, unsigned _size, unsigned _alignment) noexcept
        : MIRRelocable(sym), msize(_size), alignment(_alignment) {}

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

class MIRDataStorage : public MIRRelocable {
public:
private:
    unsigned alignment;
    std::vector<MIRStorage> datas{}; // 没有结构体的情况下, vec内类型一致
    bool readOnly = false;           // not impl

public:
    MIRDataStorage(const string &sym, const std::vector<MIRStorage> &_datas, unsigned _alignment) noexcept
        : MIRRelocable(sym), datas{_datas}, alignment(_alignment) {}
    MIRDataStorage(const string &sym, const std::vector<MIRStorage> &_datas, unsigned _alignment,
                   bool _readOnly) noexcept
        : MIRRelocable(sym), datas{_datas}, alignment(_alignment), readOnly(_readOnly) {}

    bool isData() const override { return true; }

    unsigned align() const { return alignment; }
    auto &getDatas() { return datas; }
    const auto &getDatas() const { return datas; }

    ~MIRDataStorage() override = default;
};

/// @brief 跳转表, 如swtich语句, 向量函数表等
class MIRJmpTable : public MIRRelocable {
private:
    std::vector<MIRRelocable_wp> msyms{};

public:
    explicit MIRJmpTable(const string &sym) : MIRRelocable(sym) {}

    auto &syms() { return msyms; }
    const auto &syms() const { return msyms; }

    ~MIRJmpTable() override = default;
};

class MIRGlobal { // reloc 之外包了层align
private:
    std::size_t alignment;
    MIRRelocable_p mreloc; // func, blk, data, bss

public:
    MIRGlobal(std::size_t _alignment, MIRRelocable_p _reloc) noexcept
        : alignment(_alignment), mreloc(std::move(_reloc)) {}

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

public:
    MIRModule() = delete;

    MIRModule(const BkdInfos &infos, CodeGenContext &_ctx, const string &_name)
        : mtarget{infos}, mglobals{}, ctx(_ctx), name(_name) {}

    auto &globals() { return mglobals; }
    const auto &globals() const { return mglobals; }

    const BkdInfos &getTarget() const { return mtarget; }

    auto &funcs() { return mFuncs; }
    const auto &funcs() const { return mFuncs; }

    void addFunc(MIRFunction_p func) { mFuncs.emplace_back(func); }

    string getName() const { return name; }

    ~MIRModule() = default;
};

using MIRModule_p = std::shared_ptr<MIRModule>;

}; // namespace MIR_new

#endif