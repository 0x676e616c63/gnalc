// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Machine Loop Analysis
#pragma once
#ifndef GNALC_MIR_PASSES_ANALYSIS_LOOP_ANALYSIS_HPP
#define GNALC_MIR_PASSES_ANALYSIS_LOOP_ANALYSIS_HPP

#include "domtree_analysis.hpp"
#include "mir/MIR.hpp"

namespace MIR {
class MachineLoopAnalysis;
class MLoopInfo;
class MLoop;
using MLoop_p = std::shared_ptr<MLoop>;
using MLoop_wp = std::weak_ptr<MLoop>;
class MLoop : public std::enable_shared_from_this<MLoop> {
    friend class MachineLoopAnalysis;
    friend class MLoopInfo;
    std::vector<MLoop_p> sub_loops;
    std::list<MIRBlk *> loop_blocks; // First is the header
    std::set<const MIRBlk *> blockset;
    MLoop_wp parent;

    void setParent(const MLoop_p &p);

public:
    struct SubLoopsGetter {
        auto operator()(const MLoop_p &node) { return node->getSubLoops(); }
    };
    using LoopBFVisitor = Util::GenericBFVisitor<MLoop_p, SubLoopsGetter>;
    template <Util::DFVOrder order> using LoopDFVisitor = Util::GenericDFVisitor<MLoop_p, SubLoopsGetter, order>;

    const auto& blocks() const { return loop_blocks; }

    auto getBFVisitor() { return LoopBFVisitor{shared_from_this()}; }

    template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() {
        return LoopDFVisitor<order>{shared_from_this()};
    }

    explicit MLoop(MIRBlk *bb);

    MLoop_p getParent() const;
    MIRFunction_p getParentFunction() const;

    const std::set<const MIRBlk *> &getBlockSet() const;
    bool contains(const MIRBlk *bb) const;
    bool contains(const MLoop *loop) const;
    bool contains(const MIRBlk_p &bb) const;
    bool contains(const MLoop_p &loop) const;
    MIRBlk_p getHeader() const;
    MIRBlk *getRawHeader() const;
    MIRBlk_p getPreHeader() const;
    MIRBlk *getRawPreHeader() const;

    bool isLatch(const MIRBlk *bb) const;
    bool isLatch(const MIRBlk_p &bb) const;

    // Note that an exiting block is a block which points to the exit block.
    // In other words, the exiting block is in the loop.
    bool isExiting(const MIRBlk *bb) const;
    bool isExiting(const MIRBlk_p &bb) const;

    // Note that the exit block is not a part of the loop.
    bool isExit(const MIRBlk *bb) const;
    bool isExit(const MIRBlk_p &bb) const;

    std::set<MIRBlk_p> getExitingBlocks() const;
    std::set<MIRBlk *> getRawExitingBlocks() const;

    std::set<MIRBlk_p> getExitBlocks() const;
    std::set<MIRBlk *> getRawExitBlocks() const;

    // Note that multiple Latches will become one after LoopSimplify
    std::vector<MIRBlk_p> getLatches() const;
    std::vector<MIRBlk *> getRawLatches() const;
    // If there is only one latch, return it.
    MIRBlk_p getLatch() const;
    MIRBlk *getRawLatch() const;

    bool isOutermost() const;
    bool isInnermost() const;
    MLoop_p getOutermostLoop();

    const std::vector<MLoop_p> &getSubLoops() const;

    const std::list<MIRBlk *> &getRawBlocks() const;
    std::vector<MIRBlk_p> getBlocks() const;

    bool hasDedicatedExits() const;
    bool isSimplifyForm() const;
    bool isRotatedForm() const;
};

class MLoopInfo {
    friend class MachineLoopAnalysis;
    std::vector<MLoop_p> top_level_loops;
    std::map<const MIRBlk *, MLoop_p> loop_map;

public:
    using iterator = decltype(top_level_loops)::iterator;
    iterator begin();
    iterator end();
    
    MLoop_p getLoopFor(const MIRBlk *bb) const;
    MLoop_p getLoopFor(const MIRBlk_p &bb) const;
    bool isLoopHeader(const MIRBlk *bb) const;
    bool isLoopHeader(const MIRBlk_p &bb) const;
    const std::vector<MLoop_p> &topLevels() const;
};

class MachineLoopAnalysis : public PM::AnalysisInfo<MachineLoopAnalysis> {
public:
    MLoopInfo run(MIRFunction &f, FAM &fpm);

public:
    using Result = MLoopInfo;

private:
    friend AnalysisInfo<MachineLoopAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace MIR

#endif