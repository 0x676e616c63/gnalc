#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <stack>

#include "../../../../include/utils/logger.hpp"

namespace IR {
    int DomTreeAnalysis::SDOM(const int i) {
        return dt_info[dt_info[idfn[i]].sdom].dfn;
    }

    int DomTreeAnalysis::SDOM(const std::shared_ptr<BasicBlock>& b) {
        return dt_info[dt_info[b].sdom].dfn;
    }

    void DomTreeAnalysis::dfs() {
        // todo: 构造DFS TREE
        int index = 0;
        std::stack<std::shared_ptr<BasicBlock>> dfs_stack;
        dfs_stack.push(entry);
        idfn.clear();
        while (!dfs_stack.empty()) {
            if (dt_info.find(dfs_stack.top()) == dt_info.end()) {
                dt_info[dfs_stack.top()] = {index++};
                idfn.push_back(dfs_stack.top()); // 这里保证idfn的索引与index相同
                auto nxt_bbs = dfs_stack.top()->getNextBB();
                for (auto it = nxt_bbs.rbegin(); it != nxt_bbs.rend(); ++it) {
                    dfs_stack.push(*it);
                }
            }
            dfs_stack.pop();
        }
    }

    void DomTreeAnalysis::calcSDOM() {
        for (auto it = idfn.rbegin(); it != idfn.rend(); ++it) {
            int candidate = dt_info[*it].dfn;
            for (const auto& p : (*it)->getPreBB()) {
                if (dt_info[p].dfn < dt_info[*it].dfn) {
                    if (dt_info[p].dfn < candidate) {
                        candidate = dt_info[p].dfn;
                    }
                } else {
                    // todo: 利用并查集优化？
                    int candidate2 = SDOM(p);
                    while (candidate2 >= dt_info[*it].dfn) {
                        candidate2 = SDOM(candidate2);
                    }
                    if (candidate2 < candidate) {
                        candidate = candidate2;
                    }
                }
            }
            dt_info[*it].sdom = idfn[candidate];
        }
    }

    void DomTreeAnalysis::calcIDOM() {
        // TODO
    }

    void DomTreeAnalysis::analyze(Function &f) {
        entry = f.getBlocks().front();
        dfs();
        calcSDOM();
        calcIDOM();
        // TODO 根据idom构建domtree
    }
}
