#pragma once
#ifndef GNALC_MIR_INFO_HPP
#define GNALC_MIR_INFO_HPP

#include "ir/instructions/control.hpp"
#include "mir/tools.hpp"
#include <cstring>
#include <list>
#include <string>
#include <unordered_map>

namespace MIR {
using string = std::string;
class MIRInst;
using MIRInst_p = std::shared_ptr<MIRInst>;
using MIRInst_wp = std::weak_ptr<MIRInst>;
using MIRInst_p_l = std::list<MIRInst_p>;

class ISelContext;
struct CodeGenContext;

struct DataLayout {
    enum class Endian { little, big } endian;
    const unsigned builtInAlignment;
    const unsigned pointerSize;
    const unsigned codeAlignment;
    const unsigned storeAlignment;
};

enum class Arch {
    RISCV64, ARMv8
};

class BkdInfos {
public:
    const DataLayout dataLayout;
    Arch arch;
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
struct StkObj;
class MIRJmpTable;

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
    virtual bool isLegalGenericInst(MIRInst_p) const = 0;
    virtual bool match(MIRInst_p, ISelContext &, bool allow) const = 0;
    virtual bool legalizeInst(MIRInst_p minst, ISelContext &ctx) const = 0;
    virtual void preLegalizeInst(InstLegalizeContext &) = 0;
    virtual void legalizeWithStkOp(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const = 0;
    virtual void legalizeWithStkGep(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const = 0;
    virtual void legalizeWithStkPtrCast(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const = 0;
    virtual void legalizeCopy(InstLegalizeContext &ctx) const = 0;
    virtual void legalizeAdrp(InstLegalizeContext &ctx) const = 0;

    virtual ~ISelInfo();
};

struct CodeGenContext {
    const BkdInfos &infos;

    std::shared_ptr<ISelInfo> iselInfo;
    FrameInfo &frameInfo;
    // const TargetInstInfo &instInfo;

    unsigned idx = 0;
    unsigned nextId() { return ++idx; }

    bool referCntAvailable = true;
    std::unordered_map<MIROperand_p, unsigned> referCnt;

    unsigned putOp(const MIROperand_p &mop) { return --referCnt.at(mop); }

    unsigned getOp(const MIROperand_p &mop) { return ++referCnt[mop]; }

    unsigned queryOp(const MIROperand_p &mop) const { return referCnt.at(mop); }

    bool isReferCntAvailable() const { return referCntAvailable; }

    void abundantReferCntAvailable() { referCntAvailable = false; }

    bool isARMv8() const { return infos.arch == Arch::ARMv8; }
    bool isRISCV64() const { return infos.arch == Arch::RISCV64; }
};

}; // namespace MIR_new

namespace std {

template <> struct tuple_size<MIR::InstLegalizeContext> : integral_constant<std::size_t, 4> {};

template <size_t I> struct tuple_element<I, MIR::InstLegalizeContext> {
    using type = decltype((declval<MIR::InstLegalizeContext>().get<I>())); // extra brasses
};

}; // namespace std

#endif