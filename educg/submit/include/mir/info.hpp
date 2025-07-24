// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_INFO_HPP
#define GNALC_MIR_INFO_HPP

#include "../ir/instructions/control.hpp"
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

enum class Arch { RISCV64, ARMv8 };

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

class RegisterInfo {
public:
    virtual ~RegisterInfo() = default;

    virtual unsigned int getCoreRegisterNum() const = 0;
    virtual unsigned int getFpOrVecRegisterNum() const = 0;
    virtual std::set<int> getCoreRegisterAllocationList() const = 0;
    virtual std::set<int> getFpOrVecRegisterAllocationList() const = 0;
    virtual std::set<int> getCallerSaveCRs() const = 0;
    virtual std::set<int> getCallerSaveFpVRs() const = 0;
    virtual bool isCoreReg(unsigned int reg) const = 0;
    virtual bool isFpOrVecReg(unsigned int reg) const = 0;
    virtual unsigned int FpOrVecStart() const = 0;
    virtual uint64_t initCalleeSaveBitmap() const = 0;
    virtual void updateCalleeSaveBitmapForStackAlloc(uint64_t &bitmap, MIRFunction *mfunc) const = 0;

    virtual bool isCallerSaved(unsigned int reg) const = 0;
    virtual bool isCalleeSaved(unsigned int reg) const = 0;
};

class FrameInfo {
public:
    virtual ~FrameInfo() = default;

    virtual void handleCallEntry(IR::pCall, LoweringContext &) const = 0;
    virtual MIRGlobal_p handleLib(IR::pCall, LoweringContext &) const = 0;
    virtual void handleMemset(IR::pCall, LoweringContext &) const = 0;
    virtual void handleMemcpy(IR::pCall, LoweringContext &) const = 0;
    // virtual void handleSIMD(IR::pCall, LoweringContext&) const = 0;

    virtual void makePrologue(MIRFunction_p, LoweringContext &) const = 0;
    virtual void makeReturn(IR::pRet, LoweringContext &) const = 0;

    virtual void makePostSAPrologue(MIRBlk_p, CodeGenContext &, unsigned) const = 0;
    virtual void makePostSAEpilogue(MIRBlk_p, CodeGenContext &, unsigned) const = 0;
    virtual void insertPrologueEpilogue(MIRFunction *, CodeGenContext &) const = 0;

    virtual void appendCalleeSaveStackSize(uint64_t &allocation_base, uint64_t bitmap) const = 0;

    virtual bool isFuncCall(const MIRInst_p &) const = 0;

    constexpr size_t getStackPointerAlignment() const { return 16; }
};

struct InstLegalizeContext {
    MIRInst_p &minst;
    MIRInst_p_l &minsts;
    MIRInst_p_l::iterator &iter;
    CodeGenContext &ctx;
    MIRBlk_p &mblk;

    InstLegalizeContext(MIRInst_p &minst, MIRInst_p_l &insts, MIRInst_p_l::iterator &iter, CodeGenContext &ctx,
                        MIRBlk_p &mblk)
        : minst(minst), minsts(insts), iter(iter), ctx(ctx), mblk(mblk) {}

    InstLegalizeContext(const InstLegalizeContext &) = delete;
    InstLegalizeContext &operator=(const InstLegalizeContext &) = delete;

    InstLegalizeContext(InstLegalizeContext &&) = delete;
    InstLegalizeContext &operator=(InstLegalizeContext &&) = delete;
};

class ISelInfo {
public:
    virtual bool isLegalGenericInst(MIRInst_p) const = 0;
    virtual bool match(MIRInst_p, ISelContext &, bool allow) const = 0;
    virtual bool legalizeInst(MIRInst_p minst, ISelContext &ctx) const = 0;
    virtual void preLegalizeInst(InstLegalizeContext &) = 0;
    virtual void legalizeWithPtrLoad(MIRInst_p minst) const = 0;
    virtual void legalizeWithPtrStore(MIRInst_p minst) const = 0;
    virtual void legalizeWithStkOp(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const = 0;
    virtual void legalizeWithStkGep(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const = 0;
    virtual void legalizeWithStkPtrCast(InstLegalizeContext &ctx, MIROperand_p, const StkObj &obj) const = 0;
    virtual void legalizeCopy(InstLegalizeContext &ctx) const = 0;
    virtual void legalizeAdrp(InstLegalizeContext &ctx) const = 0;

    virtual ~ISelInfo();
};

struct CodeGenContext {
    const BkdInfos &infos;

    std::shared_ptr<RegisterInfo> registerInfo;
    std::shared_ptr<ISelInfo> iselInfo;
    std::shared_ptr<FrameInfo> frameInfo;
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

    static CodeGenContext create(const BkdInfos &infos);
};

}; // namespace MIR

#endif