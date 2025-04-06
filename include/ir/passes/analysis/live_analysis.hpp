/**
 * @brief live variable analysis
 * @brief 对 instruction 分析，记录 livein, liveout
 * @brief basicblock 对其包含的 instruction.begin->livein, end->liveout 做转发
 *
 * (这个针对 IR 的 analysis 似乎没用？目前没有 pass 需要这个 analysis. 后端有针对 MIR 的 LiveAnalysis.)
 */

#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP

#include "ir/base.hpp"
#include "ir/passes/pass_manager.hpp"

#include <unordered_map>

namespace IR {
class Liveness {
    using LiveSet = std::set<Value *>;
    std::unordered_map<const Value *, LiveSet> livein;
    std::unordered_map<const Value *, LiveSet> liveout;

public:
    LiveSet &getLiveIn(const Value *v) { return livein[v]; }
    LiveSet &getLiveOut(const Value *v) { return liveout[v]; }

    void setLiveIn(const Value *v, const LiveSet &live) { livein[v] = live; }

    void setLiveOut(const Value *v, const LiveSet &live) { liveout[v] = live; }

    void reset() {
        livein.clear();
        liveout.clear();
    }
};

class LiveAnalysis : public PM::AnalysisInfo<LiveAnalysis> {
public:
    Liveness run(Function &f, FAM &fpm);

private:
    Liveness liveness;
    bool processFunc(const Function *func);    // 处理单个func
    bool processBB(const BasicBlock *bb);      // 处理单个BB
    bool processInst(const Instruction *inst); // 处理单个inst

    // For PassManager
public:
    using Result = Liveness;

private:
    friend AnalysisInfo<LiveAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif