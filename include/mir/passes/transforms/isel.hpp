#pragma once
#ifndef GNALC_ARMV8_MIR_BUILDER_ISEL_HPP
#define GNALC_ARMV8_MIR_BUILDER_ISEL_HPP

#include "mir/MIR.hpp"
#include <set>

namespace MIR_new {

OpC chooseCopyOpC(const MIROperand_p &dst, const MIROperand_p &src);

class ISelContext {
private:
    CodeGenContext &mCodeGenCtx;
    std::map<MIROperand_p, MIRInst_p> mInstMap, mConstantMap; // mInstMap: to map def
    MIRBlk_p mCurrentBlk;
    MIRInst_p_l::iterator mInstInsertPos; // insert before this it

    std::map<MIROperand_p, MIROperand_p> mReplaceMap;
    std::set<MIRInst_p> mDelWorkList, mReplaceBlkWorkList;
    std::map<MIROperand, unsigned> mUseCnt; // 使用计数, 安全取代...

public:
    explicit ISelContext(CodeGenContext &codeGenCtx);
    void impl(MIRFunction_p);

    MIRInst_p newInst(OpC);

    bool singleUsed(const MIROperand_p &) const;
    ///@note 即使是在PhiEli之后, 除phiOper之外的op依然能够保持SSA
    MIRInst_p lookforDef(const MIROperand_p &) const;
    MIROperand_p getDef(const MIRInst_p &) const;
    MIRInst_p_l getInsts() const;
    MIRInst_p_l::iterator getCurrentPos() const;
    void delInst(MIRInst_p);
    void replaceOperand(const MIROperand_p &_old, const MIROperand_p &_new);
    void replaceJmp2Blk(MIRInst_p);

    CodeGenContext &codeGenCtx() const { return mCodeGenCtx; }
    MIRBlk_p currentBlk() const { return mCurrentBlk; }

    ~ISelContext() = default;
};

}; // namespace MIR_new

#endif