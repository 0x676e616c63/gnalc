// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Alias Analysis for SIR
// TODO: Maybe we should preserve these info in IRGen
//       rather than analyzing it afterwards.
#pragma once
#ifndef GNALC_SIR_PASSES_ANALYSIS_INSTDOM_ANALYSIS_HPP
#define GNALC_SIR_PASSES_ANALYSIS_INSTDOM_ANALYSIS_HPP

#include "graph/domtree.hpp"
#include "sir/base.hpp"
#include "sir/passes/pass_manager.hpp"

namespace SIR {
struct PseudoBlock {
    std::vector<PseudoBlock *> preds;
    std::vector<PseudoBlock *> succs;
    size_t curr_idx = 0;
    std::unordered_map<Instruction *, size_t> inst_idx;
    void addInst(Instruction *inst) { inst_idx[inst] = curr_idx++; }

    PseudoBlock() = default;
};

struct PseudoCFG {
    std::vector<std::unique_ptr<PseudoBlock>> blocks;
    std::unordered_map<Instruction *, PseudoBlock *> inst_map;

    PseudoCFG() = default;
    PseudoCFG(const PseudoCFG&) = delete;
    PseudoCFG& operator=(const PseudoCFG&) = delete;
    PseudoCFG(PseudoCFG&&) = default;
    PseudoCFG& operator=(PseudoCFG&&) = default;

    PseudoBlock *newBlock() {
        return blocks.emplace_back(new PseudoBlock()).get();
    }
    void addInst(PseudoBlock *block, Instruction *inst) {
        inst_map.emplace(inst, block);
        block->addInst(inst);
    }
    PseudoBlock *getBlock(Instruction *inst) const { return inst_map.at(inst); }
};
} // namespace SIR

namespace Graph {
template <> struct GraphInfo<SIR::PseudoBlock *> {
    using NodeT = SIR::PseudoBlock *;
    static std::vector<SIR::PseudoBlock *> getPreds(const SIR::PseudoBlock *bb) { return bb->preds; }
    static std::vector<SIR::PseudoBlock *> getSuccs(const SIR::PseudoBlock *bb) { return bb->succs; }
};
} // namespace Graph
namespace SIR {
using PseudoDomTreeBuilder = Graph::GenericDomTreeBuilder<PseudoBlock *, false>;
using PseudoDomTree = Graph::GenericDomTree<PseudoBlock *, false>;

class InstDomTree {
    friend struct InstDomAnalysis;
    PseudoCFG cfg;
    PseudoDomTree domtree;

    InstDomTree(PseudoCFG cfg, PseudoDomTree dom_tree) : cfg(std::move(cfg)), domtree(std::move(dom_tree)) {}

public:
    bool ADomB(Instruction *a, Instruction *b) const;
    bool ADomB(const pInst &a, const pInst &b) const;
    bool isReachableFromEntry(Instruction *a) const;
    bool isReachableFromEntry(const pInst &a) const;
};

class InstDomAnalysis : public PM::AnalysisInfo<InstDomAnalysis> {
public:
    InstDomTree run(LinearFunction &f, LFAM &fam);

    // For PassManager
public:
    using Result = InstDomTree;

private:
    friend AnalysisInfo<InstDomAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace SIR
#endif