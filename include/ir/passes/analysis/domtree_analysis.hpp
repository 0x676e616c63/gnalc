#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

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
struct GraphInfo<IR::BasicBlock*> {
    using NodeT = IR::BasicBlock*;
    static std::vector<IR::BasicBlock *> getPreds(const IR::BasicBlock *bb) {
        std::vector<IR::BasicBlock *> ret;
        for (const auto &r : bb->preds())
            ret.emplace_back(r.get());
        return ret;
    }
    static std::vector<IR::BasicBlock *> getSuccs(const IR::BasicBlock *bb) {
        std::vector<IR::BasicBlock *> ret;
        for (const auto &r : bb->succs())
            ret.emplace_back(r.get());
        return ret;
    }
};
}

namespace IR {
namespace detail {
using DomTreeBuilder = Graph::GenericDomTreeBuilder<BasicBlock*, false>;
using PostDomTreeBuilder = Graph::GenericDomTreeBuilder<BasicBlock*, true>;
} // namespace detail
using DomTree = Graph::GenericDomTree<BasicBlock*, false>;
using PostDomTree = Graph::GenericDomTree<BasicBlock*, true>;

class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    using Result = DomTree;
    DomTree run(Function &f, FAM &fam);

private:
    friend AnalysisInfo<DomTreeAnalysis>;
    static PM::UniqueKey Key;
    friend class PostDomTreeAnalysis;
};

// 相对于DomTreeAnalysis而言，只需加一个虚拟出口根（若有多出口），反转一下CFG方向
class PostDomTreeAnalysis : public PM::AnalysisInfo<PostDomTreeAnalysis> {
public:
    using Result = PostDomTree;
    PostDomTree run(Function &f, FAM &fam);

private:
    std::shared_ptr<BasicBlock> exit = nullptr;
    bool is_exit_virtual = false;
    void setExit(const Function &f); // 用于在CFG中连接虚拟根和真出口节点
    void restoreCFG() const;         // 用于计算完成后清除出口块对虚拟根节点的CFG边
private:
    friend AnalysisInfo<PostDomTreeAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif