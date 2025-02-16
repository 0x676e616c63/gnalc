#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "../pass_manager.hpp"
#include "../../../utils/generic_visitor.hpp"

namespace IR {
// todo: 使用缓存的DFS优化
using BlockSet = std::set<BasicBlock*>;
struct DomTree {
    struct Node {
        BasicBlock* bb;
        Node* parent; // 就是idom
        std::vector<std::shared_ptr<Node>> children;
        unsigned level = 0; // 节点层次，root是1
        unsigned bfs_num = 0;

        explicit Node(BasicBlock *bb) : bb(bb), parent(nullptr) {}
    };
    struct NodeChildGetter {
        auto operator()(const std::shared_ptr<Node>& node) {
            return node->children;
        }
    };
    using NodeBFVisitor = Util::GenericBFVisitor<std::shared_ptr<Node>, NodeChildGetter>;
    using NodeDFVisitor = Util::GenericDFVisitor<std::shared_ptr<Node>, NodeChildGetter>;

    std::shared_ptr<Node> root;
    std::unordered_map<BasicBlock*, std::shared_ptr<Node>> nodes;

    bool ADomB(BasicBlock* a, BasicBlock* b);
    BlockSet getDomSet(BasicBlock* b); // todo : 建立缓存
    BlockSet getDomFrontier(BasicBlock* b); // todo : 建立缓存
    void printDomTree();

    auto getBFVisitor() const { return NodeBFVisitor{ root }; }
    auto getDFVisitor(Util::DFVOrder order = Util::DFVOrder::PreOrder) const {
        return NodeDFVisitor{ root, order };
    }
protected:
    void print(const std::shared_ptr<Node> &node, int level);
    void initDTN(std::vector<BasicBlock*> &blocks);
    void linkDTN(BasicBlock* b, BasicBlock* idom);
    void updateLevel();
    friend class DomTreeAnalysis;
};

// PostDom 和 Dom 几乎一样，只是算法上前驱是后继，反之亦然。
struct PostDomTree : DomTree {
    friend class PostDomTreeAnalysis;

    bool isVirtualRoot() const {
        return root->bb == nullptr;
    }
};

// Semi-NCA 算法
// see:
// https://oi-wiki.org/graph/dominator-tree/#lengauertarjan-%E7%AE%97%E6%B3%95
// https://blog.csdn.net/dashuniuniu/article/details/103462147
// https://zhuanlan.zhihu.com/p/586372481
// https://zhuanlan.zhihu.com/p/365912693
// todo: 快速更新
class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    DomTree run(Function &f, FAM &fam);

private:
    using pBB = BasicBlock*;
    struct DTAINFO {
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
        // 仅用于dfn(cur_b) < dfn(pre_b)
        pBB recurSDOM(const pBB &cur_b, const pBB &pre_b) {
            // todo: 利用并查集优化？
            auto candidate = node_map[pre_b]._tmp_ancester;
            while (dfn(candidate) > dfn(cur_b))
                candidate = node_map[candidate]._tmp_ancester;
            node_map[pre_b]._tmp_ancester = candidate;
            return candidate;
        }
    } info;
    pBB entry = nullptr;
    DomTree domtree;
    void buildDFST();
    void calcSDOM(); // https://blog.csdn.net/Dong_HFUT/article/details/121375025#Semidominators_76
    void analyze(); // https://qaqcxh.github.io/Blogs/graph%20theory/DominatorTheory.html#6-semi-nca%E7%AE%97%E6%B3%95

    // For PassManager:
public:
    using Result = DomTree;

private:
    friend AnalysisInfo<DomTreeAnalysis>;
    static PM::UniqueKey Key;
    friend class PostDomTreeAnalysis;
};

// 相对于DomTreeAnalysis而言，只需加一个虚拟出口根（若有多出口），反转一下CFG方向
class PostDomTreeAnalysis : public PM::AnalysisInfo<PostDomTreeAnalysis> {
public:
    PostDomTree run(Function &f, FAM &fam);

private:
    using pBB = BasicBlock*;
    DomTreeAnalysis::DTAINFO info;
    std::shared_ptr<BasicBlock> exit = nullptr;
    bool is_exit_virtual = false;
    PostDomTree post_domtree;
    void buildDFST();
    void calcSDOM();
    void analyze();

    void setExit(const Function& f); // 用于在CFG中连接虚拟根和真出口节点
    void restoreCFG(); // 用于计算完成后清除出口块对虚拟根节点的CFG边

    // For PassManager:
public:
    using Result = PostDomTree;

private:
    friend AnalysisInfo<PostDomTreeAnalysis>;
    static PM::UniqueKey Key;
};

} // namespace IR

#endif