// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Loop Analysis
// Follows the loop terminology from LLVM: https://llvm.org/docs/LoopTerminology.html
// Note that this only calculate natural loop.
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_LOOP_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_LOOP_ANALYSIS_HPP

#include "domtree_analysis.hpp"
#include "ir/base.hpp"
#include "ir/passes/pass_manager.hpp"

namespace IR {
class LoopAnalysis;
class LoopInfo;
class Loop : public std::enable_shared_from_this<Loop> {
    friend class LoopAnalysis;
    friend class LoopInfo;
    std::vector<pLoop> sub_loops;
    std::list<BasicBlock *> loop_blocks; // First is the header
    std::set<const BasicBlock *> blockset;
    wpLoop parent;

    void setParent(const pLoop &p);

public:
    struct SubLoopsGetter {
        auto operator()(const pLoop &node) { return node->getSubLoops(); }
    };
    using LoopBFVisitor = Util::GenericBFVisitor<pLoop, SubLoopsGetter>;
    template <Util::DFVOrder order> using LoopDFVisitor = Util::GenericDFVisitor<pLoop, SubLoopsGetter, order>;

    using iterator = decltype(sub_loops)::iterator;
    using const_iterator = decltype(sub_loops)::const_iterator;
    using reverse_iterator = decltype(sub_loops)::reverse_iterator;
    using const_reverse_iterator = decltype(sub_loops)::const_reverse_iterator;

    using block_iterator = decltype(loop_blocks)::iterator;
    using block_const_iterator = decltype(loop_blocks)::const_iterator;
    using block_reverse_iterator = decltype(loop_blocks)::reverse_iterator;
    using block_const_reverse_iterator = decltype(loop_blocks)::const_reverse_iterator;

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

    block_const_iterator block_begin() const;
    block_const_iterator block_end() const;
    block_iterator block_begin();
    block_iterator block_end();
    block_const_iterator block_cbegin() const;
    block_const_iterator block_cend() const;

    block_const_reverse_iterator block_rbegin() const;
    block_const_reverse_iterator block_rend() const;
    block_reverse_iterator block_rbegin();
    block_reverse_iterator block_rend();
    block_const_reverse_iterator block_crbegin() const;
    block_const_reverse_iterator block_crend() const;

    auto blocks() const { return Util::make_iterator_range(block_begin(), block_end()); }

    auto reverse_blocks() const { return Util::make_iterator_range(block_rbegin(), block_rend()); }

    auto getBFVisitor() { return LoopBFVisitor{shared_from_this()}; }

    template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() {
        return LoopDFVisitor<order>{shared_from_this()};
    }

    explicit Loop(BasicBlock *bb);

    pLoop getParent() const;
    pFunc getParentFunction() const;

    const std::set<const BasicBlock *>& getBlockSet() const;
    bool contains(const BasicBlock *bb) const;
    bool contains(const Loop *loop) const;
    bool contains(const pBlock &bb) const;
    bool contains(const pLoop &loop) const;
    pBlock getHeader() const;
    BasicBlock *getRawHeader() const;
    pBlock getPreHeader() const;
    BasicBlock *getRawPreHeader() const;

    bool isLatch(const BasicBlock *bb) const;
    bool isLatch(const pBlock &bb) const;

    // Note that an exiting block is a block which points to the exit block.
    // In other words, the exiting block is in the loop.
    bool isExiting(const BasicBlock *bb) const;
    bool isExiting(const pBlock &bb) const;

    bool hasSingleExit() const;

    bool isHeaderExiting() const;

    // Note that the exit block is not a part of the loop.
    bool isExit(const BasicBlock *bb) const;
    bool isExit(const pBlock &bb) const;

    std::set<pBlock> getExitingBlocks() const;
    std::set<BasicBlock *> getRawExitingBlocks() const;

    std::set<pBlock> getExitBlocks() const;
    std::set<BasicBlock *> getRawExitBlocks() const;

    // Note that multiple Latches will become one after LoopSimplify
    std::vector<pBlock> getLatches() const;
    std::vector<BasicBlock *> getRawLatches() const;
    // If there is only one latch, return it.
    pBlock getLatch() const;
    BasicBlock *getRawLatch() const;

    bool isOutermost() const;
    bool isInnermost() const;
    pLoop getOutermostLoop();

    const std::vector<pLoop> &getSubLoops() const;

    const std::list<BasicBlock *> &getRawBlocks() const;
    std::vector<pBlock> getBlocks() const;

    size_t getLoopDepth() const;

    bool hasDedicatedExits() const;
    bool isSimplifyForm() const;
    bool isRotatedForm() const;
    bool isLCSSAForm() const;
    bool isRecursivelyLCSSAForm(const LoopInfo &loop_info) const;

    // Trivially Invariant: not in the loop
    bool isTriviallyInvariant(const Value *val) const;
    bool isTriviallyInvariant(const pVal &val) const;
    bool isAllOperandsTriviallyInvariant(const Instruction *inst) const;
    bool isAllOperandsTriviallyInvariant(const pInst &inst) const;

    void moveToHeader(const BasicBlock *bb);
    void moveToHeader(const pBlock &bb);

    size_t getInstCount() const;

private:
    // These functions won't update LoopInfo, client should call LoopInfo's addBlock/delBlock
    void addBlock(BasicBlock *bb);
    bool delBlockForCurrLoop(BasicBlock *bb);
    bool delSubLoop(const Loop* loop);
    void addSubLoop(const pLoop &loop);
};

class LoopInfo {
    friend class LoopAnalysis;
    std::vector<pLoop> top_level_loops;
    std::map<const BasicBlock *, pLoop> loop_map;

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

    pLoop getLoopFor(const BasicBlock *bb) const;
    pLoop getLoopFor(const pBlock &bb) const;
    bool isLoopHeader(const BasicBlock *bb) const;
    bool isLoopHeader(const pBlock &bb) const;
    const std::vector<pLoop> &getTopLevelLoops() const;

    bool delBlock(BasicBlock *bb);
    bool delBlock(const pBlock &bb);

    // Deletes a loop and all its blocks
    bool delLoop(Loop *loop);
    bool delLoop(const pLoop &loop);

    // Break up a loop, without deleting its blocks
    bool breakLoop(Loop *loop);
    bool breakLoop(const pLoop& loop);

    void addBlock(const pLoop &loop, BasicBlock *bb);
    void addBlock(const pLoop &loop, const pBlock &bb);
    void discoverNonHeaderBlock(BasicBlock *bb, const DomTree& domtree);
    void discoverNonHeaderBlock(const pBlock &bb, const DomTree& domtree);
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