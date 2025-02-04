#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <stack>

#include "../../../../include/utils/logger.hpp"

namespace IR {
PM::UniqueKey DomTreeAnalysis::Key;

    bool DomTree::ADomB(const std::shared_ptr<BasicBlock> &a, const std::shared_ptr<BasicBlock> &b) {
        if (nodes[a] == root) return true;
        if (a == b) return true;
        auto _b = nodes[b];
        while (_b != root) {
            _b = _b->parent;
            if (nodes[a] == _b) return true;
        }
        return false;
    }

    DomSet DomTree::getDomSet(const std::shared_ptr<BasicBlock> &b) {
        DomSet domset = {b};
        auto _b = nodes[b];
        do {
            _b = _b->parent;
            domset.insert(_b->bb);
        } while (_b != root);
        return domset;
    }

    void DomTree::printDomTree() {
        std::cout << "DomTree:" << std::endl;
        print(root, 0);
    }

    void DomTree::print(const std::shared_ptr<Node> &node, int level) {
        if (node == nullptr) return;
        for (int i = 0; i < level; i++) {
            std::cout << "|   ";
        }
        std::cout << node->bb->getName()  << std::endl;
        level++;
        for (auto & n : node->children) {
            print(n, level);
        }
    }

    void DomTree::initDTN(std::vector<std::shared_ptr<BasicBlock>> &blocks) {
        for (auto &block : blocks) {
            nodes[block] = std::make_shared<Node>(block);
        }
        root = nodes[blocks.front()];
    }

    void DomTree::linkDTN(const std::shared_ptr<BasicBlock> &b, const std::shared_ptr<BasicBlock> &idom) {
        if (nodes[b] == root) {
            // root = nodes[b];
        } else if (idom == b) {
            Err::unreachable("DomTree::linkDTN");
        } else {
            nodes[b]->parent = nodes[idom];
            nodes[idom]->children.emplace_back(nodes[b]);
        }
    }

    DomTree DomTreeAnalysis::run(Function &f, FAM &fam) {
        analyze(f);
        return domtree;
    }

    void DomTreeAnalysis::buildDFST() {
    std::stack<std::pair<pBB, pBB>> dfs_stack; // {node, parent}
    dfs_stack.push({entry, nullptr});
    while (!dfs_stack.empty()) {
        auto [cur, parent] = dfs_stack.top();
        if (!info.visited(cur)) {
            info.addDFSTN(cur);
            info.linkDFSTN(parent, cur);
            auto nxt_bbs = cur->getNextBB();
            for (auto it = nxt_bbs.rbegin(); it != nxt_bbs.rend(); ++it) {
                dfs_stack.push({*it, cur});
            }
        }
        dfs_stack.pop();
    }
}

void DomTreeAnalysis::calcSDOM() {
    for (auto it = info.idfn.rbegin(); it != info.idfn.rend(); ++it) {
        pBB candidate = *it;
        for (const auto &p : (*it)->getPreBB()) {
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
    }
}

// void DomTreeAnalysis::calcIDOM() {
//     // Semi-NCA 直接在构建DT过程计算 IDOM
// }

void DomTreeAnalysis::analyze(Function &f) {
    entry = f.getBlocks().front();
    buildDFST();
    calcSDOM();
    // calcIDOM();
    domtree.initDTN(info.idfn);
    for (auto key : info.idfn) {
        // 3个树图MD越看越迷...
        auto dfs_tree_node = info.node_map[key]; // DFS SPANNING TREE'S NODE
        auto dfs_tree_parent = dfs_tree_node.dfs_parent; // DFS SPANNING TREE'S PARENT NODE
        auto cur_dom_tree_node = domtree.nodes[dfs_tree_parent]; // DomTree's Node
        while (info.dfn(cur_dom_tree_node->bb) > info.dfn(dfs_tree_node._sdom)) {
            cur_dom_tree_node = cur_dom_tree_node->parent;
        }
        dfs_tree_node._idom = cur_dom_tree_node->bb;
        // result need to fix when idom is not equal to sdom??
        domtree.linkDTN(dfs_tree_node.bb, dfs_tree_node._idom);
    }
}
} // namespace IR
