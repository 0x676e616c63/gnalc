#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "../../../utils/generic_visitor.hpp"
#include "../pass_manager.hpp"

#include <memory>
#include <stack>
#include <string>
#include <vector>

namespace IR {
namespace detail {
struct DTBasicBlockHandle {
    static std::vector<BasicBlock *> prev(const BasicBlock *bb) {
        auto raw = bb->getPreBB();
        std::vector<BasicBlock *> ret;
        for (const auto &r : raw)
            ret.emplace_back(r.get());
        return ret;
    }
    static std::vector<BasicBlock *> next(const BasicBlock *bb) {
        auto raw = bb->getNextBB();
        std::vector<BasicBlock *> ret;
        for (const auto &r : raw)
            ret.emplace_back(r.get());
        return ret;
    }
};

struct PostDTBasicBlockHandle {
    static std::vector<BasicBlock *> prev(const BasicBlock *bb) {
        auto raw = bb->getNextBB();
        std::vector<BasicBlock *> ret;
        for (const auto &r : raw)
            ret.emplace_back(r.get());
        return ret;
    }
    static std::vector<BasicBlock *> next(const BasicBlock *bb) {
        auto raw = bb->getPreBB();
        std::vector<BasicBlock *> ret;
        for (const auto &r : raw)
            ret.emplace_back(r.get());
        return ret;
    }
};

template <typename BBHandle>
struct GenericDomTreeBuilder;

// todo: 使用缓存的DFS优化
using BlockSet = std::set<BasicBlock *>;
template <typename BBHandle>
struct GenericDomTree {
    friend struct GenericDomTreeBuilder<BBHandle>;

    struct Node {
        BasicBlock *bb;
        Node *parent; // 就是idom
        std::vector<std::shared_ptr<Node>> children;
        unsigned level = 0; // 节点层次，root是1
        unsigned bfs_num = 0;

        explicit Node(BasicBlock *bb) : bb(bb), parent(nullptr) {}
    };
    struct NodeChildGetter {
        auto operator()(const std::shared_ptr<Node> &node) {
            return node->children;
        }
    };
    using NodeBFVisitor = Util::GenericBFVisitor<std::shared_ptr<Node>, NodeChildGetter>;
    using NodeDFVisitor = Util::GenericDFVisitor<std::shared_ptr<Node>, NodeChildGetter>;

    std::shared_ptr<Node> root;
    std::unordered_map<BasicBlock *, std::shared_ptr<Node>> nodes;

    // todo: 在构造支配树时预计算DFS进入/离开时间戳可将支配关系判断优化为O(1)时间操作
    bool ADomB(BasicBlock *a, BasicBlock *b) {
        if (nodes[a] == root)
            return true;
        if (a == b)
            return true;
        auto _b = nodes[b].get();
        while (_b != root.get()) {
            _b = _b->parent;
            if (nodes[a].get() == _b)
                return true;
        }
        return false;
    }
    BlockSet getDomSet(BasicBlock *b) {
        BlockSet domset = {b};
        auto _b = nodes[b].get();
        do {
            _b = _b->parent;
            domset.insert(_b->bb);
        } while (_b != root.get());
        return domset;
    }

    BlockSet getDomFrontier(BasicBlock *b) {
        BlockSet DF;
        std::stack<Node *> STN;
        STN.push(nodes[b].get());

        while (!STN.empty()) {
            const auto node = STN.top();
            STN.pop();

            auto nextbbs = BBHandle::next(node->bb);
            for (const auto &next : nextbbs) {
                const auto next_node = nodes[next];

                if (next_node->parent == node)
                    continue;

                // Level过滤剪枝
                if (next_node->level > nodes[b]->level)
                    continue;

                DF.insert(next);
            }

            for (const auto &dom_child : node->children)
                // DON'T NEED BECAUSE NO CONTEST OF 'visited_stn'
                // if (visited_stn.insert(dom_child.get()).second)
                STN.push(dom_child.get());
        }
        return DF;
    }
    void printDomTree() {
        std::cout << "(Post)DomTree:" << std::endl;
        print(root, 0);
    }

    NodeBFVisitor getBFVisitor() const {
        return NodeBFVisitor{root};
    }
    NodeDFVisitor getDFVisitor(Util::DFVOrder order = Util::DFVOrder::PreOrder) const {
        return NodeDFVisitor{root, order};
    }

private:
    void print(const std::shared_ptr<Node> &node, int level) {
        if (node == nullptr)
            return;
        for (int i = 0; i < level; i++) {
            std::cout << "|   ";
        }
        std::cout << node->bb->getName() << std::endl;
        level++;
        for (auto &n : node->children) {
            print(n, level);
        }
    }

    void initDTN(std::vector<BasicBlock *> &blocks) {
        for (auto &block : blocks) {
            nodes[block] = std::make_unique<Node>(block);
        }
        root = nodes[blocks.front()];
    }

    void linkDTN(BasicBlock *b, BasicBlock *idom) {
        if (nodes[b] == root) {
            // root = nodes[b];
        } else if (idom == b) {
            Err::unreachable("DomTree::linkDTN: idom = self");
        } else {
            nodes[b]->parent = nodes[idom].get();
            nodes[idom]->children.emplace_back(nodes[b]);
        }
    }
    void updateLevel() {
        unsigned l = 0;
        unsigned i = 0;
        std::vector<std::shared_ptr<Node>> cur;
        std::vector<std::shared_ptr<Node>> next;
        cur.emplace_back(root);
        while (!cur.empty()) {
            ++l;
            for (const auto &n : cur) {
                n->level = l;
                n->bfs_num = ++i;
                for (auto &c : n->children) {
                    next.emplace_back(c);
                }
            }
            cur = next;
            next.clear();
        }
    }
};

// Semi-NCA 算法
// see:
// https://oi-wiki.org/graph/dominator-tree/#lengauertarjan-%E7%AE%97%E6%B3%95
// https://blog.csdn.net/dashuniuniu/article/details/103462147
// https://zhuanlan.zhihu.com/p/586372481
// https://zhuanlan.zhihu.com/p/365912693
// todo: 快速更新
template <typename BBHandle>
struct GenericDomTreeBuilder {
    using pBB = BasicBlock *;
    struct DTAINFO {
        struct DFS_TREE_NODE {
            pBB bb;
            int _dfn;
            pBB dfs_parent;
            std::vector<pBB> dfs_children;
            pBB _sdom;
            pBB _idom;
            pBB _tmp_ancester; // 用于逆序求递归sdom时进行简单优化
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
    GenericDomTree<BBHandle> domtree;
    void buildDFST() {
        std::stack<std::pair<pBB, pBB>> dfs_stack; // {node, parent}
        dfs_stack.emplace(entry, nullptr);
        while (!dfs_stack.empty()) {
            auto [cur, parent] = dfs_stack.top();
            dfs_stack.pop();
            if (!info.visited(cur)) {
                info.addDFSTN(cur);
                info.linkDFSTN(parent, cur);
                auto nxt_bbs = BBHandle::next(cur);
                for (auto it = nxt_bbs.rbegin(); it != nxt_bbs.rend(); ++it) {
                    dfs_stack.emplace(*it, cur);
                }
            }
        }
    }

    // https://blog.csdn.net/Dong_HFUT/article/details/121375025#Semidominators_76
    void calcSDOM() {
        for (auto it = info.idfn.rbegin(); it != info.idfn.rend(); ++it) {
            pBB candidate = *it;
            auto prebbs = BBHandle::prev(*it);
            for (const auto &p : prebbs) {
                if (info.dfn(p) <= info.dfn(*it)) {
                    if (info.dfn(p) < info.dfn(candidate)) {
                        candidate = p;
                    }
                } else {
                    auto candidate2 = info.recurSDOM(*it, p);
                    if (info.dfn(candidate2) < info.dfn(candidate)) {
                        candidate = candidate2;
                    }
                }
            }
            info.node_map[*it]._sdom = candidate;
            info.node_map[*it]._tmp_ancester = candidate;
        }
    }

    // https://qaqcxh.github.io/Blogs/graph%20theory/DominatorTheory.html#6-semi-nca%E7%AE%97%E6%B3%95
    void analyze() {
        buildDFST();
        calcSDOM();
        domtree.initDTN(info.idfn);
        for (const auto &key : info.idfn) {
            // 3个树图MD越看越迷...
            if (key == entry)
                continue;                            // 跳过根节点
            auto dfs_tree_node = info.node_map[key]; // DFS SPANNING TREE'S NODE
            auto dfs_tree_parent =
                dfs_tree_node.dfs_parent; // DFS SPANNING TREE'S PARENT NODE
            auto cur_dom_tree_node =
                domtree.nodes[dfs_tree_parent].get(); // DomTree's Node
            while (info.dfn(cur_dom_tree_node->bb) >
                   info.dfn(dfs_tree_node._sdom)) {
                cur_dom_tree_node = cur_dom_tree_node->parent;
            }
            dfs_tree_node._idom = cur_dom_tree_node->bb;
            // result need to fix when idom is not equal to sdom??
            domtree.linkDTN(dfs_tree_node.bb, dfs_tree_node._idom);
        }
        domtree.updateLevel();
    }
};

using DomTreeBuilder = GenericDomTreeBuilder<DTBasicBlockHandle>;
using PostDomTreeBuilder = GenericDomTreeBuilder<PostDTBasicBlockHandle>;
} // namespace detail
using DomTree = detail::GenericDomTree<detail::DTBasicBlockHandle>;
using PostDomTree = detail::GenericDomTree<detail::PostDTBasicBlockHandle>;

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