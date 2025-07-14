// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_TRANSFORMS_ISEL_HPP
#define GNALC_MIR_TRANSFORMS_ISEL_HPP

#include "mir/passes/pass_manager.hpp"
#include <set>

namespace MIR {

OpC chooseCopyOpC(const MIROperand_p &dst, const MIROperand_p &src);

class ISel : public PM::PassInfo<ISel> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class ISelContext {
private:
    CodeGenContext &mCodeGenCtx;
    std::map<MIROperand_p, MIRInst_p> mConstantMap; // mInstMap: to map def
    std::map<MIROperand_p, MIRInst_p_l> mInstMap;
    MIRBlk_p mCurrentBlk;
    MIRInst_p_l::iterator mInstInsertPos; // insert before this it

    std::map<MIROperand_p, MIROperand_p> mReplaceMap;
    std::set<MIRInst_p> mDelWorkList;
    // std::set<MIRInst_p> mReplaceBlkWorkList; // 如果没有expandcmp, 可以不用这个
public:
    explicit ISelContext(CodeGenContext &codeGenCtx) : mCodeGenCtx(codeGenCtx) {}

    void impl(MIRFunction *mfunc);

    ///@note just a new inst insert somewhere, set ops yourself
    template <typename T>
    MIRInst_p newInst(T mopcode) {
        static_assert(std::is_same_v<T, OpC> || std::is_same_v<T, ARMOpC> || std::is_same_v<T, RVOpC>);
        auto minst = MIRInst::make(mopcode);

        mCurrentBlk->Insts().insert(mInstInsertPos, minst);

        return minst;
    }

    ///@note used in matchAndSelectimpl
    bool notUsed(const MIROperand_p &) const;
    bool singleUsed(const MIROperand_p &) const;
    bool notMultiUsed(const MIROperand_p &) const;
    MIRInst_p_l lookforDef(const MIROperand_p &) const;
    MIRInst_p_l getInsts() const;
    MIRInst_p_l::iterator getCurrentPos() const;
    void delInst(MIRInst_p);
    void replaceOperand(const MIROperand_p &_old, const MIROperand_p &_new);
    // void replaceJmp2Blk(MIRInst_p);

    // bool isDefinedAfter(const MIROperand_p &) const;
    // bool isSafeToUse(const MIROperand_p &, const MIROperand_p& ) const;
    // ... getRegRef...

    auto instInsertPos() { return mInstInsertPos; }
    auto &currentInsts() { return mCurrentBlk->Insts(); }

    CodeGenContext &codeGenCtx() const { return mCodeGenCtx; }
    MIRBlk_p currentBlk() const { return mCurrentBlk; }

    ~ISelContext() = default;
};

}; // namespace MIR_new

#endif