// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_LEGACY_MIR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "../../../graph/domtree.hpp"
#include "../pass_manager.hpp"

#include <memory>
#include <vector>

namespace Graph {
template <> struct GraphInfo<LegacyMIR::BasicBlock *> {
    using NodeT = LegacyMIR::BasicBlock *;
    static std::vector<LegacyMIR::BasicBlock *> getPreds(const LegacyMIR::BasicBlock *bb) {
        std::vector<LegacyMIR::BasicBlock *> ret;
        auto preds = bb->getPreds();
        for (const auto &r : preds)
            ret.emplace_back(r.get());
        return ret;
    }
    static std::vector<LegacyMIR::BasicBlock *> getSuccs(const LegacyMIR::BasicBlock *bb) {
        std::vector<LegacyMIR::BasicBlock *> ret;
        auto succs = bb->getSuccs();
        for (const auto &r : succs)
            ret.emplace_back(r.get());
        return ret;
    }
};
} // namespace Graph

namespace LegacyMIR {
namespace detail {
using DomTreeBuilder = Graph::GenericDomTreeBuilder<BasicBlock *, false>;
} // namespace detail
using DomTree = Graph::GenericDomTree<BasicBlock *, false>;

class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    using Result = DomTree;
    DomTree run(Function &f, FAM &fam);

private:
    friend AnalysisInfo<DomTreeAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace MIR

#endif
#endif