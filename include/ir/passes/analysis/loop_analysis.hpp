// Loop Analysis
// Note that this only calculate natural loop.
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_LOOP_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_LOOP_ANALYSIS_HPP

#include "../../base.hpp"
#include "../pass_manager.hpp"

#include <unordered_map>

namespace IR {
class LoopAnalysis;

class Loop : std::enable_shared_from_this<Loop> {
    friend class LoopAnalysis;
    std::vector<Loop*> sub_loops;
    std::vector<BasicBlock*> blocks;
    std::set<const BasicBlock*> blockset;
    std::weak_ptr<Loop> parent;

    void setParent(const std::shared_ptr<Loop>& p);
public:
    explicit Loop(BasicBlock* bb);

    std::shared_ptr<Loop> getParent() const;

    bool contains(const BasicBlock* bb) const;
    BasicBlock* getHeader() const;
    BasicBlock* getPreHeader() const;

    bool isLatch(const BasicBlock* bb) const;
    bool isExit(const BasicBlock* bb) const;

    std::vector<BasicBlock*> getExitBlocks() const;
    std::vector<BasicBlock*> getLatches() const;

    bool isOutermost() const;
    bool isInnermost() const;
    std::shared_ptr<Loop> getOutermostLoop();

    size_t getLoopDepth() const;
};

class LoopInfo {
    friend class LoopAnalysis;
    std::vector<std::shared_ptr<Loop>> top_level_loops;
    std::map<const BasicBlock*, std::shared_ptr<Loop>> loop_map;
public:
    std::shared_ptr<Loop> getLoopFor(const BasicBlock* bb) const;
    bool isLoopHeader(const BasicBlock* bb) const;
    const std::vector<std::shared_ptr<Loop>>& getTopLevelLoops() const;
};

class LoopAnalysis : public PM::AnalysisInfo<LoopAnalysis> {
public:
    LoopInfo run(Function &f, FAM &fpm);

public:
    using Result = LoopInfo;

private:
    friend AnalysisInfo<LoopAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif