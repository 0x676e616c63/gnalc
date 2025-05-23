#pragma once
#ifndef GNALC_ARMV8_MIR_PASSES_TRANSFORMS_REDUNDANTLOADELI
#define GNALC_ARMV8_MIR_PASSES_TRANSFORMS_REDUNDANTLOADELI

#include "mir/passes/pass_manager.hpp"

namespace MIR_new {

class RedundantLoadEli : public PM::PassInfo<RedundantLoadEli> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class RedundantLoadEliImpl {
private:
    struct loadInfo {
        unsigned loadedValue; // int & float
        std::set<MIRBlk_p> mblks;
        std::set<MIRBlk_p, std::vector<std::pair<MIROperand, MIRInst_p_l::iterator>>> usedValue;
        MIRBlk_p lca = nullptr;
    };

private:
    MIRFunction &mfunc;
    FAM &fam;
    std::list<loadInfo> infos;

public:
    RedundantLoadEliImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam) {}
    void Impl();
    void MkInfo();
    void CulculateLCA();
    void ApplyCopys();
};

}; // namespace MIR_new

#endif