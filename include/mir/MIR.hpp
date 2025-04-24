#pragma once
#ifndef GNALC_ARMV8_MIR_MIR_HPP
#define GNALC_ARMV8_MIR_MIR_HPP

#include "ir/base.hpp"
#include "ir/instructions/compare.hpp"
#include "mir/Target.hpp"
#include <array>
#include <map>
#include <utility>
#include <variant>

namespace MIR_new {

// using string = std::string;

template <typename T, typename... Args> std::shared_ptr<T> make(const Args... args) {

    return std::make_shared<T>(args...);
}

template <typename T, typename... Args> std::unique_ptr<T> makeu(const Args... args) {
    return std::make_unique<T>(args...);
}

enum class OperandType {
    Bool,  // cmp/fcmp result maybe use many times
    Int32, // original int32, or extend from int8, int16
    Int64,
    Ptr = Int64,
    Intvec,
    Float32,
    Floatvec,
    special, // prob, alignment, load/store size
    High32,
    Low32,
    // Arm only now
    CondFlag, // to be very aware that many inst no long have cond exec compare to armv7
    Shift5,
    LoadStoreShamt
};

using OpT = OperandType;

enum MIRInstCond : unsigned { AL, EQ, NE, LT, GT, LE, GE };

using Cond = MIRInstCond;

enum class MIRGenericInst {
    // control-flow
    InstJump,   // reloc
    InstBranch, // cond, reloc, prob
    InstUnreachable,
    // Memory
    InstLoad,
    InstStore,
    // Arithmetic
    InstAdd,
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
    // MinMax
    InstSMin,
    InstSMax,
    // Int Unary
    InstNeg,
    InstAbs,
    // FP
    InstFAdd,
    InstFSub,
    InstFMul,
    InstFDiv,
    InstFRem,
    InstFNeg,
    InstFAbs,
    InstFFma,
    // vector, at most 4
    InstVAdd,
    InstVSub,
    InstVMul,
    InstVDiv,
    InstVHorizontalAdd,
    // Comparison
    InstICmp, // dst, lhs, rhs, op
    InstFCmp, // dst, lhs, rhs, op
    InstTst,  // ANDS WZR, Wx, ...
    // Conversion
    InstSExt,
    InstZExt,
    InstTrunc,
    InstF2U,
    InstF2S,
    InstU2F,
    InstS2F,
    InstFCast,
    // Misc
    InstCopy,   // vreg to vreg
    InstSelect, // CSEL/FSEL <Reg>, <Reg>, <Reg>, <cond>, ir `
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
    unsigned reg; // 0 ~ 30
    MIRRegStatue flag = MIRRegStatue::alive;

    explicit MIRReg(unsigned _reg) noexcept : reg(_reg) {}
    MIRReg(unsigned _reg, MIRRegStatue _flag) noexcept : reg(_reg), flag(_flag) {}

    bool operator==(const MIRReg &other) const { return reg == other.reg; }
    bool operator!=(const MIRReg &other) const { return reg != other.reg; }
    bool isAlive() const { return flag == MIRRegStatue::alive; }
};

using MIRReg_p = std::shared_ptr<MIRReg>;
using MIRReg_wp = std::weak_ptr<MIRReg>;

class MIRRelocable {
private:
    string mSym;

public:
    explicit MIRRelocable(string sym) noexcept : mSym(std::move(sym)){};

    string getmSym() const { return mSym; }

    virtual bool isFunc() const { return false; }
    virtual bool isBlk() const { return false; }

    virtual ~MIRRelocable() = default;
};

using MIRRelocable_p = std::shared_ptr<MIRRelocable>;
using MIRRelocable_wp = std::weak_ptr<MIRRelocable>;

class MIROperand;
using MIROperand_p = std::shared_ptr<MIROperand>;
using MIROperand_wp = std::weak_ptr<MIROperand>;

constexpr uint32_t VRegBegin = 0b0101U << 28;
constexpr uint32_t StkObjBegin = 0b1010U << 28;
constexpr uint32_t invalidReg = 0b1100U << 28;

constexpr inline bool isISAReg(uint32_t x) { return x < VRegBegin; }
constexpr inline bool isVirtualReg(uint32_t x) { return (x & VRegBegin) == VRegBegin; }
constexpr inline bool isStkObj(uint32_t x) { return (x & StkObjBegin) == StkObjBegin; }

class MIROperand {
private:
    std::variant<std::monostate, MIRReg_p, MIRRelocable_p, unsigned, double> mOperand{
        std::monostate{}}; // double mean prob, used by branch/jmp prediction
    OpT mType = OpT::special;

public:
    constexpr MIROperand() = default;

    template <typename mOperand_t> constexpr MIROperand(mOperand_t op, OpT type) : mOperand(op), mType(type) {}

    const auto &mOp() const { return mOperand; }
    template <typename T> const auto &mOp() const {
        Err::gassert(mOperand.index() != 0, "MIROperand: mOperand is nerver initialized");
        return std::get<T>(mOperand);
    };
    long imme() const { return std::get<long>(mOperand); }
    unsigned reg() const { return std::get<MIRReg_p>(mOperand)->reg; }
    auto regFlag() const { return std::get<MIRReg_p>(mOperand)->flag; }
    auto &regFlag() { return std::get<MIRReg_p>(mOperand)->flag; }
    double prob() const { return std::get<double>(mOperand); }

    bool isImme() const { return std::holds_alternative<long>(mOperand); }
    bool isUnused() const { return std::holds_alternative<std::monostate>(mOperand); }
    bool isReg() const { return std::holds_alternative<MIRReg_p>(mOperand); }
    bool isReloc() const { return std::holds_alternative<MIRRelocable_p>(mOperand); }
    bool isProb() const { return std::holds_alternative<double>(mOperand); }

    constexpr OpT type() const { return mType; }

    bool operator==(const MIROperand &other) const { return mOperand == other.mOperand; }
    bool operator!=(const MIROperand &other) const { return mOperand != other.mOperand; }

    template <typename T> static MIROperand_p asImme(T val, OpT type) {
        Err::gassert(std::is_integral_v<T> || std::is_floating_point_v<T>, "MIROperand::asImme: template match failed");
        unsigned encoding = *reinterpret_cast<unsigned *>(&val); // int float...
        return make<MIROperand>(encoding, type);
    }

    static MIROperand_p asISAReg(unsigned reg, OpT type) {
        Err::gassert(isISAReg(reg), "MIROperand::asISAReg: input reg doesnt match");
        return make<MIROperand>(make<MIRReg>(reg), type);
    }

    static MIROperand_p asVReg(unsigned reg, OpT type) { return make<MIROperand>(make<MIRReg>(reg + VRegBegin), type); }

    static MIROperand_p asStkObj(unsigned reg, OpT type) {
        return make<MIROperand>(make<MIRReg>(reg + StkObjBegin), type);
    }

    static MIROperand_p asReloc(const MIRRelocable_p &value) { return make<MIROperand>(value, OpT::special); }

    static MIROperand_p asProb(double prob) { return make<MIROperand>(prob, OpT::special); }

    virtual ~MIROperand() = default;
};

class MIRInst : public std::enable_shared_from_this<MIRInst> {
public:
    static constexpr unsigned maxOpCnt = 7;

private:
    OpC mOpcode;
    ///@note <0>代表def, 如果为nullptr, 代表指令没有def, 或者是需要用WZR/XZR占位
    std::array<MIROperand_p, maxOpCnt> mOperands;
    explicit MIRInst(OpC opcode) noexcept : mOpcode(opcode){};

public:
    template <typename... Args> static std::shared_ptr<MIRInst> make(Args &&...args) {
        return std::shared_ptr<MIRInst>(new MIRInst(std::forward<Args>(args)...));
    }

    OpC opcode() const { return mOpcode; }
    MIRInst &resetOpcode(OpC opcode) {
        mOpcode = opcode;
        return *this;
    }

    bool checkOp(unsigned idx) const { return !mOperands[idx]->isUnused(); }
    MIROperand_p &getOp(unsigned idx) { return mOperands[idx]; }

    template <unsigned idx> std::shared_ptr<MIRInst> setOperand(const MIROperand_p &operand) {
        Err::gassert(idx < maxOpCnt, "MIRInst: set a op out of range");
        mOperands[idx] = operand;
        return shared_from_this();
    }

    virtual ~MIRInst() = default;
};

using MIRInst_p = std::shared_ptr<MIRInst>;
using MIRInst_wp = std::weak_ptr<MIRInst>;
using MIRInst_p_l = std::list<MIRInst_p>;

enum class StkObjUsage {
    Arg, // pass to sub func
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
};

class MIRFunction;
using MIRFunction_p = std::shared_ptr<MIRFunction>;
using MIRFunction_wp = std::weak_ptr<MIRFunction>;
class MIRBlk;
using MIRBlk_p = std::shared_ptr<MIRBlk>;
using MIRBlk_wp = std::weak_ptr<MIRBlk>;
using MIRBlk_p_l = std::list<MIRBlk_p>;

class MIRFunction : public MIRRelocable {
private:
    MIRBlk_p_l mBlks;
    std::map<MIROperand_p, StkObj> mStkObjs;
    std::vector<MIROperand> mArgs;

public:
    explicit MIRFunction(const string &sym) noexcept : MIRRelocable(sym) {}
    MIROperand_p addStkObj(CodeGenContext &ctx, unsigned size, unsigned alignmant, int offset, StkObjUsage);

    auto &blks() { return mBlks; }
    auto &Args() { return mArgs; }
    auto &StkObjs() { return mStkObjs; }

    const auto &blks() const { return mBlks; }
    const auto &Args() const { return mArgs; }
    const auto &StkObjs() const { return mStkObjs; }

    bool isFunc() const override { return true; }

    ~MIRFunction() override = default;
};

class MIRBlk : public MIRRelocable {
private:
    MIRFunction_wp mFunction;
    MIRInst_p_l mInsts;
    double mTripCount = 0.0;

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

    ~MIRBlk() override = default;
};

class MIRBssStorage : public MIRRelocable {
private:
    unsigned size;
    unsigned alignment;

public:
    MIRBssStorage() = delete;
    MIRBssStorage(const string &sym, unsigned _size, unsigned _alignment) noexcept
        : MIRRelocable(sym), size(_size), alignment(_alignment) {}

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
    bool readOnly = false;

public:
    MIRDataStorage(const string &sym, const std::vector<MIRStorage> &_datas, unsigned _alignment) noexcept
        : MIRRelocable(sym), datas{_datas}, alignment(_alignment) {}
    MIRDataStorage(const string &sym, const std::vector<MIRStorage> &_datas, unsigned _alignment,
                   bool _readOnly) noexcept
        : MIRRelocable(sym), datas{_datas}, alignment(_alignment), readOnly(_readOnly) {}

    ~MIRDataStorage() override = default;
};

class MIRJmpTable : public MIRRelocable {
private:
    std::vector<MIRRelocable_wp> msyms{};

public:
    explicit MIRJmpTable(const string &sym) : MIRRelocable(sym) {}

    auto &syms() { return msyms; }
    const auto &syms() const { return msyms; }

    ~MIRJmpTable() override = default;
};

class MIRGlobal : public std::enable_shared_from_this<MIRGlobal> {
private:
    std::size_t alignment;
    MIRRelocable_p reloc; // func, blk, data, bss

public:
    MIRGlobal(std::size_t _alignment, MIRRelocable_p _reloc) noexcept
        : alignment(_alignment), reloc(std::move(_reloc)) {}

    template <typename T> std::shared_ptr<T> as() {
        Err::gassert(std::is_base_of_v<MIRGlobal, T>, "MIRGlobal::as(): Expected a derived type.");
        return std::dynamic_pointer_cast<T>(shared_from_this());
    }

    template <typename T> std::shared_ptr<const T> as() const {
        Err::gassert(std::is_base_of_v<MIRGlobal, T>, "MIRGlobal::as(): Expected a derived type.");
        return std::dynamic_pointer_cast<const T>(shared_from_this());
    }

    ~MIRGlobal() = default;
};

using MIRGlobal_p = std::shared_ptr<MIRGlobal>;

class MIRModule {
private:
    const Target &mtarget;
    std::vector<MIRGlobal_p> mglobals{};

    std::vector<MIRFunction_p> mFuncs{}; // for function pass

public:
    explicit MIRModule(const Target &target) : mtarget{target}, mglobals{} {}

    auto &globals() { return mglobals; }
    const auto &globals() const { return mglobals; }

    const Target &getTarget() const { return mtarget; }

    auto &funcs() { return mFuncs; }
    const auto &funcs() const { return mFuncs; }

    void addFunc(MIRFunction_p func) { mFuncs.emplace_back(func); }

    ~MIRModule() = default;
};

}; // namespace MIR_new

#endif