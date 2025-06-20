#pragma once
#ifndef GNALC_MIR_TRANSFORMS_CFGSIMPLIFY_HPP
#define GNALC_MIR_TRANSFORMS_CFGSIMPLIFY_HPP

#include "mir/passes/pass_manager.hpp"

///@note 寄存器分配前的简化: 模式匹配简化条件判断

///@note 分配后的简化: 计算跳转闭包, 再次将条件位反转消除一次跳转(有条件时)

namespace MIR {

class CFGsimplifyBeforeRA : public PM::PassInfo<CFGsimplifyBeforeRA> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class CFGsimplifyAfterRA : public PM::PassInfo<CFGsimplifyAfterRA> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class CFGsimplifyBeforeRAImpl {

private:
    MIRFunction &mfunc;
    FAM &fam;

public:
    CFGsimplifyBeforeRAImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam) {}

    ~CFGsimplifyBeforeRAImpl() = default;

public:
    inline void impl();
    void i1Eli();
    bool deadBlkEli();

public:
    void i1EliDetect(MIRBlk_p &);
    void i1UseConsolidate(MIRInst_p_l &, MIRInst_p_l::iterator &);
};

class CFGsimplifyAfterRAImpl {

private:
    MIRFunction &mfunc;
    FAM &fam;

public:
    CFGsimplifyAfterRAImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam) {}

    ~CFGsimplifyAfterRAImpl() = default;

public:
    inline void impl();
    void brColsure();
    void uselessCmpEli();
    void brSeqRev();
    void brEli();

public:
    MIRInst_p_l::iterator SeqRevPatternDetect(MIRBlk_p); // ret the it of the cmp, if not , return .end()
    MIROperand_p mkReverse(MIROperand_p);
};

}; // namespace MIR_new

#endif