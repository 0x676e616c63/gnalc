#pragma once
#ifndef GNALC_ARMV8_MIR_PASSES_ANALYSIS_LIVEANALYSIS_HPP
#define GNALC_ARMV8_MIR_PASSES_ANALYSIS_LIVEANALYSIS_HPP

#include "mir/passes/pass_builder.hpp"
#include "mir/passes/pass_manager.hpp"
#include <optional>

namespace MIR_new {

struct Liveness {
    std::map<MIRBlk_p, std::set<MIROperand_p>> liveIn;
    std::map<MIRBlk_p, std::set<MIROperand_p>> liveOut;

    enum relatedType { Use, Def };

    std::map<MIROperand_p, std::set<std::pair<MIRInst_p, relatedType>>> use_def_insts;

    std::map<MIROperand_p, size_t> intervalLengths;

    ///@todo loop cnt not impl
    std::map<MIROperand_p, size_t> loopCnts;

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
    void runOnInst(const MIRInst_p &inst, std::set<MIROperand_p> &liveIn, std::set<MIROperand_p> &liveOut);

    Liveness getInfo() const {
        Err::gassert(liveinfo.has_value(), "LiveAnalysisImpl: never got a info");
        return liveinfo.value();
    }; // pass by value

    std::list<MIROperand_p> extractUses(const MIRInst_p &minst);

    MIROperand_p extractDef(const MIRInst_p &minst);
};

}; // namespace MIR_new

#endif