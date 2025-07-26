// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_PASSES_ANALYSIS_LIVEANALYSIS_HPP
#define GNALC_MIR_PASSES_ANALYSIS_LIVEANALYSIS_HPP

#include "mir/passes/pass_manager.hpp"
#include <optional>

namespace MIR {

struct Liveness {
    std::unordered_map<MIRBlk_p, std::unordered_set<MIROperand_p>> liveIn;
    std::unordered_map<MIRBlk_p, std::unordered_set<MIROperand_p>> liveOut;

    std::unordered_map<MIRInst_p, std::unordered_set<MIROperand_p>> instLiveOut;
    std::unordered_map<MIRInst_p, std::unordered_set<MIROperand_p>> instLiveIn;

    enum relatedType { Use, Def };

    std::unordered_map<MIROperand_p, std::unordered_set<std::pair<MIRInst_p, relatedType>, Util::PairHash>>
        use_def_insts;

    std::unordered_map<MIROperand_p, size_t> intervalLengths;

    ///@todo loop cnt not impl
    std::unordered_map<MIROperand_p, size_t> loopCnts;

    void clear() {
        liveIn.clear();
        liveOut.clear();
        use_def_insts.clear();
        intervalLengths.clear();
        loopCnts.clear();
    }
};

class LiveAnalysis : public PM::AnalysisInfo<LiveAnalysis> {
public:
    LiveAnalysis() = default;

    Liveness run(MIRFunction &f, FAM &fam);

    ~LiveAnalysis() = default;

public:
    using Result = Liveness;

private:
    friend PM::AnalysisInfo<LiveAnalysis>;
    static PM::UniqueKey Key;
};

class LiveAnalysisImpl {
private:
    MIRFunction *mfunc{};
    std::optional<Liveness> liveinfo = std::nullopt;

public:
    LiveAnalysisImpl() = default;

    Liveness runImpl(MIRFunction &);

    void runOnFunc(MIRFunction &);
    bool runOnBlk(const MIRBlk_p &);
    void runOnInst(const MIRInst_p &inst, std::unordered_set<MIROperand_p> &liveIn,
                   std::unordered_set<MIROperand_p> &liveOut);

    Liveness getInfo() const {
        Err::gassert(liveinfo.has_value(), "LiveAnalysisImpl: never got a info");
        return liveinfo.value();
    }; // pass by value

    std::vector<MIROperand_p> extractUses(const MIRInst_p &minst);

    MIROperand_p extractDef(const MIRInst_p &minst);
};

}; // namespace MIR

#endif