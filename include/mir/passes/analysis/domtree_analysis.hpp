#pragma once
#ifndef GNALC_ARMV8_MIR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_ARMV8_MIR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "graph/domtree.hpp"
#include "mir/passes/pass_manager.hpp"

#include <memory>
#include <vector>

namespace Graph {
template <> struct GraphInfo<MIR_new::MIRBlk *> {
    using NodeT = MIR_new::MIRBlk *;
    static std::vector<MIR_new::MIRBlk *> getPreds(const MIR_new::MIRBlk *bb) {
        std::vector<MIR_new::MIRBlk *> ret;
        auto preds = bb->preds();
        for (const auto &r : preds)
            ret.emplace_back(r.get());
        return ret;
    }
    static std::vector<MIR_new::MIRBlk *> getSuccs(const MIR_new::MIRBlk *bb) {
        std::vector<MIR_new::MIRBlk *> ret;
        auto succs = bb->succs();
        for (const auto &r : succs)
            ret.emplace_back(r.get());
        return ret;
    }
};
} // namespace Graph

namespace MIR_new {

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