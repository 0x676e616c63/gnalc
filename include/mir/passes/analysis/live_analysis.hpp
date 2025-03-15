#pragma once
#ifndef GNALC_MIR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP
#define GNALC_MIR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP

#include "../../base.hpp"
#include "../../function.hpp"
#include "../pass_manager.hpp"
#include <map>

namespace MIR {

///@note 存储live info & 填写映射表 & 计算interval ranges & 算loop counts
struct Liveness {
    std::map<BlkP, std::unordered_set<OperP>> liveIn;
    std::map<BlkP, std::unordered_set<OperP>> liveOut;

    enum class relatedType { Use, Def };

    struct tempHash {
        std::size_t operator()(const OperP &ptr) const { return std::hash<size_t>()((size_t)(ptr.get())); }

        std::size_t operator()(const InstP &ptr) const { return std::hash<size_t>()((size_t)(ptr.get())); }
    };

    std::map<OperP, std::unordered_set<std::pair<InstP, relatedType>, tempHash>, tempHash> use_def_Insts;

    std::map<OperP, size_t> intervalLengths;

    std::map<OperP, size_t> loopCounts;

    void clear() {
        liveIn.clear();
        liveOut.clear();
        use_def_Insts.clear();
        intervalLengths.clear();
        loopCounts.clear();
    }
};

class LiveAnalysis : public PM::AnalysisInfo<LiveAnalysis> { // 仅在RA时, 供给给单个function使用
private:
    Function *func{};
    Liveness liveinfo;

public:
    LiveAnalysis() = default;
    // explicit LiveAnalysis(Function &_func) noexcept : func(&_func) {}

    void runOnFunc(Function *_func);
    void runOnBlk(const BlkP &);
    void runOnInst(const InstP &inst, std::unordered_set<OperP> &livein, std::unordered_set<OperP> &liveout);

    Liveness run(Function &f, FAM &fam);

    ~LiveAnalysis() = default;

public:
    using Result = Liveness;

private:
    friend AnalysisInfo<LiveAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace MIR

#endif