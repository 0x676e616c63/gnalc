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

class Loop : public std::enable_shared_from_this<Loop> {
    friend class LoopAnalysis;
    std::vector<std::shared_ptr<Loop>> sub_loops;
    std::vector<BasicBlock*> blocks; // First is the header
    std::set<const BasicBlock*> blockset;
    std::weak_ptr<Loop> parent;

    void setParent(const std::shared_ptr<Loop>& p);
public:
    struct SubLoopsGetter {
        auto operator()(const std::shared_ptr<Loop> &node) {
            return node->getSubLoops();
        }
    };
    using LoopBFVisitor = Util::GenericBFVisitor<std::shared_ptr<Loop>, SubLoopsGetter>;
    template<Util::DFVOrder order>
    using LoopDFVisitor = Util::GenericDFVisitor<std::shared_ptr<Loop>, SubLoopsGetter, order>;

    using iterator = decltype(sub_loops)::iterator;
    using const_iterator = decltype(sub_loops)::const_iterator;
    using reverse_iterator = decltype(sub_loops)::reverse_iterator;
    using const_reverse_iterator = decltype(sub_loops)::const_reverse_iterator;

    const_iterator begin() const;
    const_iterator end() const;
    iterator begin();
    iterator end();
    const_iterator cbegin() const;
    const_iterator cend() const;

    const_reverse_iterator rbegin() const;
    const_reverse_iterator rend() const;
    reverse_iterator rbegin();
    reverse_iterator rend();
    const_reverse_iterator crbegin() const;
    const_reverse_iterator crend() const;

    auto getBFVisitor() {
        return LoopBFVisitor{ shared_from_this() };
    }

    template<Util::DFVOrder order = Util::DFVOrder::PreOrder>
    auto getDFVisitor() {
        return LoopDFVisitor<order>{ shared_from_this() };
    }

    explicit Loop(BasicBlock* bb);

    std::shared_ptr<Loop> getParent() const;

    bool contains(const BasicBlock* bb) const;
    BasicBlock* getHeader() const;
    BasicBlock* getPreHeader() const;

    bool isLatch(const BasicBlock* bb) const;

    // Note that an exiting block is a block which points to the exit block.
    // In other words, the exiting block is in the loop.
    bool isExiting(const BasicBlock* bb) const;

    std::vector<BasicBlock*> getExitBlocks() const;

    // Note that multiple Latches will become one after LoopSimplify
    std::vector<BasicBlock*> getLatches() const;
    // If there is only one latch, return it.
    BasicBlock* getLatch() const;

    bool isOutermost() const;
    bool isInnermost() const;
    std::shared_ptr<Loop> getOutermostLoop();

    const std::vector<std::shared_ptr<Loop>>& getSubLoops() const;

    const std::vector<BasicBlock*>& getBlocks() const;

    size_t getLoopDepth() const;

    bool hasDedicatedExits() const;
    bool isSimplifiedForm() const;
    bool isRotatedForm() const;

    bool delBlock(const BasicBlock* bb);
    void addBlock(BasicBlock* bb);
};

class LoopInfo {
    friend class LoopAnalysis;
    std::vector<std::shared_ptr<Loop>> top_level_loops;
    std::map<const BasicBlock*, std::shared_ptr<Loop>> loop_map;
public:
    using iterator = decltype(top_level_loops)::iterator;
    using const_iterator = decltype(top_level_loops)::const_iterator;
    using reverse_iterator = decltype(top_level_loops)::reverse_iterator;
    using const_reverse_iterator = decltype(top_level_loops)::const_reverse_iterator;

    const_iterator begin() const;
    const_iterator end() const;
    iterator begin();
    iterator end();
    const_iterator cbegin() const;
    const_iterator cend() const;

    const_reverse_iterator rbegin() const;
    const_reverse_iterator rend() const;
    reverse_iterator rbegin();
    reverse_iterator rend();
    const_reverse_iterator crbegin() const;
    const_reverse_iterator crend() const;

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