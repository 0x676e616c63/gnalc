#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <stack>

#include "../../../../include/utils/logger.hpp"

#include <queue>

namespace IR {
PM::UniqueKey DomTreeAnalysis::Key;
PM::UniqueKey PostDomTreeAnalysis::Key;

bool DomTree::ADomB(const std::shared_ptr<BasicBlock> &a,
                    const std::shared_ptr<BasicBlock> &b) {
    if (nodes[a] == root)
        return true;
    if (a == b)
        return true;
    auto _b = nodes[b];
    while (_b != root) {
        _b = _b->parent;
        if (nodes[a] == _b)
            return true;
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
    std::cout << "(Post)DomTree:" << std::endl;
    print(root, 0);
}

void DomTree::print(const std::shared_ptr<Node> &node, int level) {
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

void DomTree::initDTN(std::vector<std::shared_ptr<BasicBlock>> &blocks) {
    for (auto &block : blocks) {
        nodes[block] = std::make_shared<Node>(block);
    }
    root = nodes[blocks.front()];
}

void DomTree::linkDTN(const std::shared_ptr<BasicBlock> &b,
                      const std::shared_ptr<BasicBlock> &idom) {
    if (nodes[b] == root) {
        // root = nodes[b];
    } else if (idom == b) {
        Err::unreachable("DomTree::linkDTN: idom = self");
    } else {
        nodes[b]->parent = nodes[idom];
        nodes[idom]->children.emplace_back(nodes[b]);
    }
}

void DomTree::updateLevel() {
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
    // return l; // height
}

// void DomTree::updateDFSNumber() {
//     std::stack<std::shared_ptr<Node>> stack;
//     stack.emplace(root);
//     unsigned id = 0;
//     while (!stack.empty()) {
//         const auto node = stack.top();
//         stack.pop();
//         node->dfs_num = ++id;
//         for (auto it = node->children.rbegin(); it != node->children.rend(); ++it) {
//             stack.emplace(*it);
//         }
//     }
// }

DomTree DomTreeAnalysis::run(Function &f, FAM &fam) {
    entry = f.getBlocks().front();
    analyze();
    info = {};
    return domtree;
}

void DomTreeAnalysis::buildDFST() {
    std::stack<std::pair<pBB, pBB>> dfs_stack; // {node, parent}
    dfs_stack.emplace(entry, nullptr);
    while (!dfs_stack.empty()) {
        auto [cur, parent] = dfs_stack.top();
        dfs_stack.pop();
        if (!info.visited(cur)) {
            info.addDFSTN(cur);
            info.linkDFSTN(parent, cur);
            auto nxt_bbs = cur->getNextBB();
            for (auto it = nxt_bbs.rbegin(); it != nxt_bbs.rend(); ++it) {
                dfs_stack.emplace(*it, cur);
            }
        }
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
        info.node_map[*it]._tmp_ancester = candidate;
    }
}

// void DomTreeAnalysis::calcIDOM() {
//     // Semi-NCA 直接在构建DT过程计算 IDOM
// }

void DomTreeAnalysis::analyze() {
    buildDFST();
    calcSDOM();
    // calcIDOM();
    domtree.initDTN(info.idfn);
    for (const auto &key : info.idfn) {
        // 3个树图MD越看越迷...
        if (key == entry) continue; // 跳过根节点
        auto dfs_tree_node = info.node_map[key]; // DFS SPANNING TREE'S NODE
        auto dfs_tree_parent =
            dfs_tree_node.dfs_parent; // DFS SPANNING TREE'S PARENT NODE
        auto cur_dom_tree_node =
            domtree.nodes[dfs_tree_parent]; // DomTree's Node
        // if (dfs_tree_node._sdom == nullptr) {
        //     Err::error("DomTreeAnalysis::analyze: sdom does not exist");
        // }
        while (info.dfn(cur_dom_tree_node->bb) >
               info.dfn(dfs_tree_node._sdom)) {
            cur_dom_tree_node = cur_dom_tree_node->parent;
        }
        dfs_tree_node._idom = cur_dom_tree_node->bb;
        // result need to fix when idom is not equal to sdom??
        domtree.linkDTN(dfs_tree_node.bb, dfs_tree_node._idom);
    }
    domtree.updateLevel();
    // domtree.updateDFSNumber();
}

PostDomTree PostDomTreeAnalysis::run(Function &f, FAM &fam) {
    setExit(f);
    analyze();
    post_domtree.is_root_virtual = is_exit_virtual;
    info = {};
    return post_domtree;
}

void PostDomTreeAnalysis::buildDFST() {
    std::stack<std::pair<pBB, pBB>> dfs_stack; // {node, parent}
    dfs_stack.emplace(exit, nullptr);
    while (!dfs_stack.empty()) {
        auto [cur, parent] = dfs_stack.top();
        dfs_stack.pop();
        if (!info.visited(cur)) {
            info.addDFSTN(cur);
            info.linkDFSTN(parent, cur);
            auto pre_bbs = cur->getPreBB();
            for (auto it = pre_bbs.rbegin(); it != pre_bbs.rend(); ++it) {
                dfs_stack.emplace(*it, cur);
            }
        }
    }
}

void PostDomTreeAnalysis::calcSDOM() {
    for (auto it = info.idfn.rbegin(); it != info.idfn.rend(); ++it) {
        pBB candidate = *it;
        for (const auto &n : (*it)->getNextBB()) {
            if (info.dfn(n) <= info.dfn(*it)) {
                if (info.dfn(n) < info.dfn(candidate)) {
                    candidate = n;
                }
            } else {
                auto candidate2 = info.recurSDOM(*it, n);
                if (info.dfn(candidate2) < info.dfn(candidate)) {
                    candidate = candidate2;
                }
            }
        }
        info.node_map[*it]._sdom = candidate;
        info.node_map[*it]._tmp_ancester = candidate;
    }
}

void PostDomTreeAnalysis::analyze() {
    buildDFST();
    calcSDOM();
    post_domtree.initDTN(info.idfn);
    for (const auto &key : info.idfn) {
        // 3个树图MD越看越迷...
        if (key == exit) continue; // 跳过根节点
        auto dfs_tree_node = info.node_map[key]; // DFS SPANNING TREE'S NODE
        auto dfs_tree_parent =
            dfs_tree_node.dfs_parent; // DFS SPANNING TREE'S PARENT NODE
        auto cur_dom_tree_node =
            post_domtree.nodes[dfs_tree_parent]; // DomTree's Node
        while (info.dfn(cur_dom_tree_node->bb) >
               info.dfn(dfs_tree_node._sdom)) {
            cur_dom_tree_node = cur_dom_tree_node->parent;
               }
        dfs_tree_node._idom = cur_dom_tree_node->bb;
        // result need to fix when idom is not equal to sdom??
        post_domtree.linkDTN(dfs_tree_node.bb, dfs_tree_node._idom);
    }
    post_domtree.updateLevel();
}

void PostDomTreeAnalysis::setExit(const Function &f) {
    const auto exit_bbs = f.getExitBBs();
    if (exit_bbs.empty()) {
        Err::unreachable("PostDomTreeAnalysis::setExit(): no exit!");
    }
    if (exit_bbs.size() == 1) {
        exit = exit_bbs.front();
        is_exit_virtual = false;
    } else {
        exit = std::make_shared<BasicBlock>("VIRTUAL_EXIT_NODE");
        for (const auto &b : exit_bbs) {
            b->addNextBB(exit);
            exit->addPreBB(b);
        }
        is_exit_virtual = true;
    }
}

void PostDomTreeAnalysis::restoreCFG() {
    if (!is_exit_virtual) return;
    for (const auto &real_exit : exit->getPreBB()) {
        real_exit->next_bb.clear();
    }
    exit->pre_bb.clear();
}
} // namespace IR
