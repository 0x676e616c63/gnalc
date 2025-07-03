// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifndef GNALC_GRAPH_DOMTREE_HPP
#define GNALC_GRAPH_DOMTREE_HPP

#include <memory>
#include <ostream>
#include <stack>
#include <unordered_set>
#include <unordered_map>
#include <cmath>
#include <vector>

#include "utils/exception.hpp"
#include "utils/generic_visitor.hpp"
#include "utils/logger.hpp"
#include "graph.hpp"

namespace Graph {
struct Identity {
    template <typename T> auto operator()(T &&v) const { return std::forward<T>(v); }
};

template <typename GraphT, bool IsPostDom, typename GraphNodeProj = Identity> class GenericDomTree {
    template <typename, bool, typename> friend class GenericDomTreeBuilder;

    using GraphNodeT = typename GraphInfo<GraphT>::NodeT;
    using GraphNodeSet = std::unordered_set<GraphNodeT>;

    static auto getNextGraphNodes(GraphNodeT node) {
        if constexpr (IsPostDom)
            return GraphInfo<GraphT>::getPreds(node);
        else
            return GraphInfo<GraphT>::getSuccs(node);
    }
    static auto getPrevGraphNodes(GraphNodeT node) {
        if constexpr (IsPostDom)
            return GraphInfo<GraphT>::getSuccs(node);
        else
            return GraphInfo<GraphT>::getPreds(node);
    }

public:
    class Node;
    using pNode = std::shared_ptr<Node>;
    struct NodeChildGetter {
        auto operator()(const pNode &node) { return node->children(); }
    };
    using NodeBFVisitor = Util::GenericBFVisitor<pNode, NodeChildGetter>;
    template <Util::DFVOrder order = Util::DFVOrder::PreOrder>
    using NodeDFVisitor = Util::GenericDFVisitor<pNode, NodeChildGetter, order>;

    class Node : public std::enable_shared_from_this<Node> {
        friend class GenericDomTree;
        template <typename, bool, typename> friend class GenericDomTreeBuilder;
        GraphNodeT graph_node;
        Node *parent_node; // 就是idom
        std::vector<pNode> child_nodes;
        unsigned node_level = 0; // 节点层次，root是1
        unsigned node_bfs_num = 0;
        // DFS Timestamp
        unsigned node_dfs_in = 0;
        unsigned node_dfs_out = 0;

    public:
        explicit Node(GraphNodeT bb) : graph_node(bb), parent_node(nullptr) {}
        auto raw_parent() const { return parent_node; }
        pNode parent() const {
            if (parent_node)
                return parent_node->shared_from_this();
            return nullptr;
        }
        const auto &children() const { return child_nodes; }
        auto level() const { return node_level; }
        auto bfs_num() const { return node_bfs_num; }
        auto dfs_in() const { return node_dfs_in; }
        auto dfs_out() const { return node_dfs_out; }
        const auto &raw_block() const { return graph_node; }
        auto block() const { return GraphNodeProj()(graph_node); }
        void setBlock(GraphNodeT n) { graph_node = n; }

        auto getBFVisitor() { return NodeBFVisitor{ this->shared_from_this() }; }
        template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() {
            return NodeDFVisitor<order>{ this->shared_from_this() };
        }
    };

private:
    pNode root_node;
    std::unordered_map<GraphNodeT, pNode> nodes;
    mutable std::unordered_map<GraphNodeT, GraphNodeSet> df_cache;
public:
    auto root() const { return root_node; }

    const auto &operator[](GraphNodeT graph_node) const {
        return nodes.at(graph_node);
    }

    bool ADomB(GraphNodeT a, GraphNodeT b) const {
        if (a == b)
            return true;
        auto node_a = nodes.at(a);
        auto node_b = nodes.at(b);
        return node_a->dfs_in() <= node_b->dfs_in() && node_a->dfs_out() >= node_b->dfs_out();
    }

    bool isReachable(GraphNodeT a) const { return nodes.count(a); }

    GraphNodeSet getDomSet(GraphNodeT b) const {
        GraphNodeSet domset = {b};
        auto _b = nodes.at(b).get();
        do {
            _b = _b->parent;
            domset.insert(_b->bb);
        } while (_b != root_node.get());
        return domset;
    }

    // TODO: needs optimization
    GraphNodeSet getDomFrontier(GraphNodeT b) const {
        auto it = df_cache.find(b);
        if (it != df_cache.end())
            return it->second;

        GraphNodeSet DF;
        std::stack<Node *> STN;
        STN.push(nodes.at(b).get());

        while (!STN.empty()) {
            const auto node = STN.top();
            STN.pop();

            auto nextbbs = getNextGraphNodes(node->graph_node);
            for (const auto &next : nextbbs) {
                const auto next_node = nodes.at(next);
                if (!ADomB(b, next) || b == next)
                    DF.insert(next);
            }

            for (const auto &dom_child : node->children())
                STN.push(dom_child.get());
        }
        df_cache[b] = DF;
        return DF;
    }

    void printDomTree(std::ostream &os) const {
        os << "(Post)DomTree:" << std::endl;
        print(os, root_node, 0);
    }

    auto getBFVisitor() const { return NodeBFVisitor{root_node}; }
    template <Util::DFVOrder order = Util::DFVOrder::PreOrder> auto getDFVisitor() const {
        return NodeDFVisitor<order>{root_node};
    }

private:
    void print(std::ostream &os, const pNode &node, int level) const {
        if (node == nullptr)
            return;
        for (int i = 0; i < level; i++) {
            os << "|   ";
        }
        os << (node->graph_node ? node->graph_node->getName() : "<null>") << std::endl;
        level++;
        for (auto &n : node->children()) {
            print(os, n, level);
        }
    }

    void initDTN(std::vector<GraphNodeT> &blocks) {
        for (auto &block : blocks) {
            nodes[block] = std::make_unique<Node>(block);
        }
        root_node = nodes[blocks.front()];
    }

    void linkDTN(GraphNodeT b, GraphNodeT idom) {
        if (nodes[b] == root_node) {
            // root_node = nodes[b];
        } else if (idom == b) {
            Err::unreachable("DomTree::linkDTN: idom = self");
        } else {
            nodes[b]->parent_node = nodes[idom].get();
            nodes[idom]->child_nodes.emplace_back(nodes[b]);
        }
    }
    void updateLevel() {
        unsigned l = 0;
        unsigned i = 0;
        std::vector<pNode> cur;
        std::vector<pNode> next;
        cur.emplace_back(root_node);
        while (!cur.empty()) {
            ++l;
            for (const auto &n : cur) {
                n->node_level = l;
                n->node_bfs_num = ++i;
                for (auto &c : n->child_nodes)
                    next.emplace_back(c);
            }
            cur = next;
            next.clear();
        }
    }

    void updateDFSInOut() {
        if (!root_node) return;
        unsigned timestamp = 0;
        std::vector<std::pair<pNode, bool>> stack;
        stack.emplace_back(root_node, false);
        while (!stack.empty()) {
            auto [node, visited] = stack.back();
            stack.pop_back();

            if (!visited) {
                node->node_dfs_in = ++timestamp;
                stack.emplace_back(node, true);
                for (auto it = node->child_nodes.rbegin(); it != node->child_nodes.rend(); ++it)
                    stack.emplace_back(*it, false);
            } else
                node->node_dfs_out = ++timestamp;
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
template <typename GraphT, bool IsPostDom, typename DomTreeT = GenericDomTree<GraphT, IsPostDom>>
class GenericDomTreeBuilder {
public:
    using GraphNodeT = typename DomTreeT::GraphNodeT;

    struct DTAINFO {
        struct DFS_TREE_NODE {
            GraphNodeT bb;
            int _dfn;
            GraphNodeT dfs_parent;
            std::vector<GraphNodeT> dfs_children;
            GraphNodeT _sdom;
            GraphNodeT _idom;
            GraphNodeT _tmp_ancester; // 用于逆序求递归sdom时进行简单优化
        };
        std::unordered_map<GraphNodeT, DFS_TREE_NODE> node_map;
        std::vector<GraphNodeT> idfn;
        int index = 0;
        int dfn(const GraphNodeT &b) { return node_map[b]._dfn; }
        GraphNodeT sdom(const GraphNodeT &b) { return node_map[b]._sdom; }
        GraphNodeT idom(const GraphNodeT &b) { return node_map[b]._idom; }
        bool visited(const GraphNodeT &b) { return node_map.find(b) != node_map.end(); }
        void linkDFSTN(const GraphNodeT &parent, const GraphNodeT &child) {
            if (parent)
                node_map[parent].dfs_children.emplace_back(child);
            node_map[child].dfs_parent = parent;
        }
        void addDFSTN(const GraphNodeT &b) {
            node_map[b] = {b, index++};
            idfn.emplace_back(b);
        }
        // 仅用于dfn(cur_b) < dfn(pre_b)
        GraphNodeT recurSDOM(const GraphNodeT &cur_b, const GraphNodeT &pre_b) {
            // todo: 利用并查集优化？
            auto candidate = node_map[pre_b]._tmp_ancester;
            while (dfn(candidate) > dfn(cur_b))
                candidate = node_map[candidate]._tmp_ancester;
            node_map[pre_b]._tmp_ancester = candidate;
            return candidate;
        }
    } info;
    GraphNodeT entry = nullptr;
    DomTreeT domtree;
    void buildDFST() {
        std::stack<std::pair<GraphNodeT, GraphNodeT>> dfs_stack; // {node, parent}
        dfs_stack.emplace(entry, nullptr);
        while (!dfs_stack.empty()) {
            auto [cur, parent] = dfs_stack.top();
            dfs_stack.pop();
            if (!info.visited(cur)) {
                info.addDFSTN(cur);
                info.linkDFSTN(parent, cur);
                auto nxt_bbs = DomTreeT::getNextGraphNodes(cur);
                for (auto it = nxt_bbs.rbegin(); it != nxt_bbs.rend(); ++it)
                    dfs_stack.emplace(*it, cur);
            }
        }
    }

    // https://blog.csdn.net/Dong_HFUT/article/details/121375025#Semidominators_76
    void calcSDOM() {
        for (auto it = info.idfn.rbegin(); it != info.idfn.rend(); ++it) {
            GraphNodeT candidate = *it;
            auto prebbs = DomTreeT::getPrevGraphNodes(*it);
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
                continue;                                                  // 跳过根节点
            auto dfs_tree_node = info.node_map[key];                       // DFS SPANNING TREE'S NODE
            auto dfs_tree_parent = dfs_tree_node.dfs_parent;               // DFS SPANNING TREE'S PARENT NODE
            auto cur_dom_tree_node = domtree.nodes[dfs_tree_parent].get(); // DomTree's Node
            while (info.dfn(cur_dom_tree_node->graph_node) > info.dfn(dfs_tree_node._sdom)) {
                cur_dom_tree_node = cur_dom_tree_node->parent_node;
            }
            dfs_tree_node._idom = cur_dom_tree_node->graph_node;
            // result need to fix when idom is not equal to sdom??
            domtree.linkDTN(dfs_tree_node.bb, dfs_tree_node._idom);
        }
        domtree.updateLevel();
        domtree.updateDFSInOut();
    }
};
} // namespace Graph
#endif // DOMTREE_HPP
