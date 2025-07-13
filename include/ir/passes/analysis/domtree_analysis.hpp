// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// DomTree
// This is a wrapper pass for Graph::GenericDomTreeBuilder
#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "graph/domtree.hpp"
#include "ir/passes/pass_manager.hpp"

#include <memory>
#include <vector>

namespace Graph {
template <> struct GraphInfo<IR::BasicBlock *> {
    using NodeT = IR::BasicBlock *;
    static std::vector<IR::BasicBlock *> getPreds(const IR::BasicBlock *bb) {
        std::vector<IR::BasicBlock *> ret;
        ret.reserve(bb->getNumPreds());
        for (const auto &r : bb->preds())
            ret.emplace_back(r.get());
        return ret;
    }
    static std::vector<IR::BasicBlock *> getSuccs(const IR::BasicBlock *bb) {
        std::vector<IR::BasicBlock *> ret;
        ret.reserve(bb->getNumSuccs());
        for (const auto &r : bb->succs())
            ret.emplace_back(r.get());
        return ret;
    }
};
} // namespace Graph

namespace IR {
namespace detail {
struct SharedProj {
    pBlock operator()(BasicBlock *bb) const {
        if (bb)
            return bb->as<BasicBlock>();
        return nullptr;
    }
};
template <bool IsPostDom> class IRGenericDomTree : public Graph::GenericDomTree<BasicBlock *, IsPostDom, SharedProj> {
    using Base = Graph::GenericDomTree<BasicBlock *, IsPostDom, SharedProj>;

public:
    const auto &operator[](const BasicBlock *block) const { return Base::operator[](const_cast<BasicBlock *>(block)); }

    bool ADomB(const BasicBlock *a, const BasicBlock *b) const {
        return Base::ADomB(const_cast<BasicBlock *>(a), const_cast<BasicBlock *>(b));
    }

    std::set<BasicBlock *> getDomSet(const BasicBlock *b) const { return Base::getDomSet(const_cast<BasicBlock *>(b)); }
    // TODO: needs optimization
    std::set<BasicBlock *> getDomFrontier(const BasicBlock *b) const {
        return Base::getDomFrontier(const_cast<BasicBlock *>(b));
    }

    const auto &operator[](const pBlock &block) const { return Base::operator[](block.get()); }

    bool ADomB(const pBlock &a, const pBlock &b) const { return Base::ADomB(a.get(), b.get()); }

    bool isReachableFromEntry(const pBlock &a) const { return Base::isReachableFromEntry(a.get()); }

    std::set<pBlock> getDomSet(const pBlock &b) const {
        auto res = Base::getDomSet(b.get());
        std::set<pBlock> ret;
        for (const auto &r : res)
            ret.emplace(r->template as<BasicBlock>());
        return ret;
    }
    // TODO: needs optimization
    std::set<pBlock> getDomFrontier(const pBlock &b) const {
        auto res = Base::getDomFrontier(b.get());
        std::set<pBlock> ret;
        for (const auto &r : res)
            ret.emplace(r->template as<BasicBlock>());
        return ret;
    }
};
} // namespace detail
using DomTreeBuilder = Graph::GenericDomTreeBuilder<BasicBlock *, false, detail::IRGenericDomTree<false>>;
using PostDomTreeBuilder = Graph::GenericDomTreeBuilder<BasicBlock *, true, detail::IRGenericDomTree<true>>;
using DomTree = detail::IRGenericDomTree<false>;
using PostDomTree = detail::IRGenericDomTree<true>;

class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    using Result = DomTree;
    DomTree run(Function &f, FAM &fam);

private:
    friend AnalysisInfo<DomTreeAnalysis>;
    static PM::UniqueKey Key;
    friend class PostDomTreeAnalysis;
};

struct PDTBuildContext {
    pBlock exit = nullptr;
    bool is_exit_virtual = false;
};

// 相对于DomTreeAnalysis而言，只需加一个虚拟出口根（若有多出口），反转一下CFG方向
class PostDomTreeAnalysis : public PM::AnalysisInfo<PostDomTreeAnalysis> {
public:
    using Result = PostDomTree;
    PostDomTree run(Function &f, FAM &fam);

private:
    void setExit(const Function &f, PDTBuildContext& ctx); // 用于在CFG中连接虚拟根和真出口节点
    void restoreCFG(PDTBuildContext& ctx) const;         // 用于计算完成后清除出口块对虚拟根节点的CFG边
private:
    friend AnalysisInfo<PostDomTreeAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif