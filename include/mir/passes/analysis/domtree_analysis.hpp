#pragma once
#ifndef GNALC_MIR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_MIR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "../../../utils/generic_visitor.hpp"
#include "../../../graph/domtree.hpp"
#include "../pass_manager.hpp"

#include <memory>
#include <stack>
#include <string>
#include <vector>
#include <queue>

namespace Graph {
template<>
struct GraphInfo<MIR::BasicBlock*> {
    using NodeT = MIR::BasicBlock*;
    static std::vector<MIR::BasicBlock *> getPreds(const MIR::BasicBlock *bb) {
        std::vector<MIR::BasicBlock *> ret;
        auto preds = bb->getPreds();
        for (const auto &r : preds)
            ret.emplace_back(r.get());
        return ret;
    }
    static std::vector<MIR::BasicBlock *> getSuccs(const MIR::BasicBlock *bb) {
        std::vector<MIR::BasicBlock *> ret;
        auto succs = bb->getSuccs();
        for (const auto &r : succs)
            ret.emplace_back(r.get());
        return ret;
    }
};
}

namespace MIR {
namespace detail {
using DomTreeBuilder = Graph::GenericDomTreeBuilder<BasicBlock*, false>;
} // namespace detail
using DomTree = Graph::GenericDomTree<BasicBlock*, false>;

class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    using Result = DomTree;
    DomTree run(Function &f, FAM &fam);

private:
    friend AnalysisInfo<DomTreeAnalysis>;
    static PM::UniqueKey Key;
    friend class PostDomTreeAnalysis;
};
} // namespace IR

#endif