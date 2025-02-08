#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "../pass_manager.hpp"
#include "../../../utils/generic_visitor.hpp"

namespace IR {
// 如果只需要获得DomSet就不需要树形结构了？
using DomSet = std::set<std::shared_ptr<BasicBlock>>;
struct DomTree {
    struct Node {
        std::shared_ptr<BasicBlock> bb;
        std::shared_ptr<Node> parent; // 就是idom
        std::vector<std::shared_ptr<Node>> children;
        unsigned level = 0; // 节点层次，root是1
        unsigned bfs_num = 0;

        explicit Node(const std::shared_ptr<BasicBlock> &bb) : bb(bb) {}
    };
    struct NodeChildGetter {
        std::vector<Node*> operator()(Node *node) {
            std::vector<Node*> ret;
            for (const auto &child : node->children)
                ret.emplace_back(child.get());
            return ret;
        }
    };
    using NodeBFVisitor = Util::GenericBFVisitor<Node, NodeChildGetter>;
    using NodeDFVisitor = Util::GenericDFVisitor<Node, NodeChildGetter>;


    std::shared_ptr<Node> root;
    std::unordered_map<std::shared_ptr<BasicBlock>, std::shared_ptr<Node>> nodes;
    bool ADomB(const std::shared_ptr<BasicBlock>& a, const std::shared_ptr<BasicBlock>& b);
    DomSet getDomSet(const std::shared_ptr<BasicBlock>& b);
    void printDomTree();

    auto getBFVisitor() const { return NodeBFVisitor{ root.get() }; }
    auto getDFVisitor() const { return NodeDFVisitor{ root.get() }; }
private:
    void print(const std::shared_ptr<Node> &node, int level);
    void initDTN(std::vector<std::shared_ptr<BasicBlock>> &blocks);
    void linkDTN(const std::shared_ptr<BasicBlock> &b, const std::shared_ptr<BasicBlock> &idom);
    void updateLevel();
    // void updateDFSNumber();
    friend class DomTreeAnalysis;
};

// PostDom 和 Dom 几乎一样，只是算法上前驱是后继，反之亦然。
struct PostDomTree : DomTree {};

// Semi-NCA 算法
// see:
// https://oi-wiki.org/graph/dominator-tree/#lengauertarjan-%E7%AE%97%E6%B3%95
// https://blog.csdn.net/dashuniuniu/article/details/103462147
// https://zhuanlan.zhihu.com/p/586372481
// https://zhuanlan.zhihu.com/p/365912693
// todo: 快速更新？
// todo: 注意到live分析也对基本块进行了dfs, 能否重用？
class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    DomTree run(Function &f, FAM &fam);

private:
    using pBB = std::shared_ptr<BasicBlock>;
    struct {
        struct DFS_TREE_NODE {
            pBB bb;
            int _dfn;
            pBB dfs_parent;
            std::vector<pBB> dfs_children;
            pBB _sdom;
            pBB _idom;
            pBB _tmp_ancester; // 用于逆序求递归sdom时进行简单优化；可能未被赋值
        };
        std::unordered_map<pBB, DFS_TREE_NODE> node_map;
        std::vector<pBB> idfn;
        int index = 0;
        int dfn(const pBB &b) { return node_map[b]._dfn; }
        pBB sdom(const pBB &b) { return node_map[b]._sdom; }
        pBB idom(const pBB &b) { return node_map[b]._idom; }
        bool visited(const pBB &b) { return node_map.find(b) != node_map.end(); }
        void linkDFSTN(const pBB &parent, const pBB &child) {
            if (parent)
                node_map[parent].dfs_children.emplace_back(child);
            node_map[child].dfs_parent = parent;
        }
        void addDFSTN(const pBB &b) {
            node_map[b] = {b, index++};
            idfn.emplace_back(b);
        }
        pBB recurSDOM(const pBB &cur_b, const pBB &pre_b) {
            // 仅用于dfn(cur_b) < dfn(pre_b)
            // todo: 利用并查集优化？
            if (node_map[pre_b]._tmp_ancester == nullptr) {
                node_map[pre_b]._tmp_ancester = node_map[pre_b]._sdom;
            }
            auto candidate = node_map[pre_b]._tmp_ancester;
            while (dfn(candidate) > dfn(cur_b)) {
                candidate = node_map[candidate]._tmp_ancester;
            }
            node_map[pre_b]._tmp_ancester = candidate;
            return candidate;
        }
    } info;
    pBB entry = nullptr;
    DomTree domtree;
    void buildDFST();
    // https://blog.csdn.net/Dong_HFUT/article/details/121375025#Semidominators_76
    void calcSDOM();
    // void calcIDOM();
    // https://qaqcxh.github.io/Blogs/graph%20theory/DominatorTheory.html#6-semi-nca%E7%AE%97%E6%B3%95
    void analyze(Function &f);

    // For PassManager:
public:
    using Result = DomTree;

private:
    friend AnalysisInfo<DomTreeAnalysis>;
    static PM::UniqueKey Key;
};

class PostDomTreeAnalysis : public DomTreeAnalysis {
public:
    // PostDomTree run(Function &f, FAM &fam) override;
};

} // namespace IR

#endif