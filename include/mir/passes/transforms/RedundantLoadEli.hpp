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
        unsigned loadedValue; // uint32 & float
        bool isFP;
        std::set<MIRBlk_p> mblks;

        std::map<MIRBlk *, std::vector<std::pair<MIROperand_p, MIRInst_p_l::iterator>>>
            const_uses; // 不知道起什么名字好

        MIRBlk *lca = nullptr;

        bool operator==(const loadInfo &other) { return other.loadedValue == loadedValue; };
    };

    struct infoHash {
        std::size_t operator()(const unsigned &constVal) const { return std::hash<unsigned>{}(constVal); }
    };

private:
    MIRFunction &mfunc;
    FAM &fam;
    std::unordered_map<unsigned, loadInfo, infoHash> infos;

public:
    RedundantLoadEliImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam) {}
    void Impl();
    void MkInfo();
    void CulculateLCA();
    void ApplyCopys();
};

}; // namespace MIR_new

#endif