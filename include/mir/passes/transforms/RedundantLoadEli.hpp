// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_PASSES_TRANSFORMS_REDUNDANTLOADELI
#define GNALC_MIR_PASSES_TRANSFORMS_REDUNDANTLOADELI

#include "mir/passes/pass_manager.hpp"
#include "utils/fast_set.hpp"

namespace MIR {

class RedundantLoadEli : public PM::PassInfo<RedundantLoadEli> {
public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class RedundantLoadEliImpl {
private:
    struct loadInfo {
        unsigned loadedValue; // uint32 & float
        Util::FastSet<MIRBlk_p> mblks;

        std::map<MIRBlk *, std::vector<std::pair<MIROperand_p, MIRInst_p_l::iterator>>>
            const_uses; // 不知道起什么名字好

        MIRBlk *lca = nullptr;

        bool operator==(const loadInfo &other) { return other.loadedValue == loadedValue; };
    };

    struct infoHash {
        std::size_t operator()(const std::pair<unsigned, bool> &constVal) const {
            std::size_t h1 = std::hash<unsigned>{}(constVal.first);
            std::size_t h2 = std::hash<bool>{}(constVal.second);
            return h1 ^ (h2 << 1);
        }
    };

private:
    MIRFunction &mfunc;
    FAM &fam;
    std::unordered_map<std::pair<unsigned, bool>, loadInfo, infoHash> infos;

public:
    RedundantLoadEliImpl(MIRFunction &_mfunc, FAM &_fam) : mfunc(_mfunc), fam(_fam) {}
    void Impl();
    void MkInfo();
    void CulculateLCA();
    void ApplyCopys();
};

}; // namespace MIR

#endif