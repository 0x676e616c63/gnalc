/**
 * @brief live varable analysis
 * @brief 对instruction分析，记录livein, liveout.
 * @brief basicblock对其包含的instruction.begin->livein, end->liveout做转发
 */

#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP

#include "../../base.hpp"
#include "../pass_manager.hpp"

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