// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_MIR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_MIR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "graph/domtree.hpp"
#include "mir/passes/pass_manager.hpp"

#include <memory>
#include <vector>

namespace Graph {
template <> struct GraphInfo<MIR::MIRBlk *> {
    using NodeT = MIR::MIRBlk *;
    static std::vector<MIR::MIRBlk *> getPreds(const MIR::MIRBlk *bb) {
        std::vector<MIR::MIRBlk *> ret;
        auto preds = bb->preds();
        for (const auto &r : preds)
            ret.emplace_back(r.get());
        return ret;
    }
    static std::vector<MIR::MIRBlk *> getSuccs(const MIR::MIRBlk *bb) {
        std::vector<MIR::MIRBlk *> ret;
        auto succs = bb->succs();
        for (const auto &r : succs)
            ret.emplace_back(r.get());
        return ret;
    }
};
} // namespace Graph

namespace MIR {

namespace detail {
using DomTreeBuilder = Graph::GenericDomTreeBuilder<MIRBlk *, false>;
} // namespace detail

using DomTree = Graph::GenericDomTree<MIRBlk *, false>;

class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    using Result = DomTree;
    DomTree run(MIRFunction &f, FAM &fam);

private:
    friend AnalysisInfo<DomTreeAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace MIR_new

#endif