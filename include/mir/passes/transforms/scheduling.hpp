#pragma once
#ifndef GNALC_ARMV8_MIR_TRANSFORMS_SCHEDULING_HPP
#define GNALC_ARMV8_MIR_TRANSFORMS_SCHEDULING_HPP

#include "mir/passes/pass_manager.hpp"
#include "mir/schedA53.hpp"

///@note 指令重排分为两部分
///@note 寄存器分配前的重排需要减少寄存器压力
///@note 寄存器分配后的重排需要指令的stall和cycles
///@note 重排的范围为一个基本块内, 所以在此之前, 需要做CFG简化和基本块的内联, 以扩大重排的范围
///@warning 对于语句少的基本块, 重排的效果并不理想

namespace MIR_new {

template <typename T> using US = std::unordered_set<T>;
template <typename Tx, typename Ty> using UM = std::unordered_map<Tx, Ty>;

class PreRaScheduling : public PM::PassInfo<PreRaScheduling> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

struct SchedulingModule {
    MIRBlk_p mblk;
    UM<MIRInst_p, unsigned> degrees;
    UM<MIRInst_p, US<MIRInst_p>> antideps;
    UM<MIRInst_p, int> rank;

    /// @brief available resources
    unsigned multipleIssue = 2; // 实际上只有ALU是多发射的
    UM<ResourcesA53, unsigned> MachineResources;
    UM<ARMReg, unsigned> RegisterResources;

    MIRInst_p_l scheduling();
    bool instScheduling(const MIRInst_p &, unsigned);
};

class PreRaSchedulingImpl {
private:
    MIRFunction &mfunc;
    FAM &fam;
    SchedulingModule Module;
    MIRBlk_p cur_mblk;

public:
    PreRaSchedulingImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam) {}
    void Impl();

private:
    void MkDAG();
    void Scheduling();
};

class PostRaScheduling : public PM::PassInfo<PostRaScheduling> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class PostRaSchedulingImpl {
private:
    MIRFunction &mfunc;
    FAM &fam;
    MIRBlk_p cur_mblk;

public:
    PostRaSchedulingImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam) {}
    void Impl();

private:
    void MkDAG(SchedulingModule &);
    void Scheduling(SchedulingModule &);
};

}; // namespace MIR_new

#endif