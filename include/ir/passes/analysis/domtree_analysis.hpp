#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "../../base.hpp"
#include "../pass_manager.hpp"

namespace IR {

// TODO

class DomTree {
    // todo: need to refactor
    // using DomSet = std::set<std::shared_ptr<BasicBlock>>;
    // std::unordered_map<std::shared_ptr<BasicBlock>, DomSet> domtree;
    // public:
    // DomSet& getDomSet(const std::shared_ptr<BasicBlock>& block) {
    //     return domtree.find(block)->second;
    // }
    //
    // void setDomTree(const std::shared_ptr<BasicBlock>& block, const DomSet&
    // domset) {
    //     domtree[block] = domset;
    // }
    //
    // void reset() {
    //     domtree.clear();
    // }
};

// Semi-NCA 算法
// see:
// https://oi-wiki.org/graph/dominator-tree/#lengauertarjan-%E7%AE%97%E6%B3%95
// https://blog.csdn.net/dashuniuniu/article/details/103462147
// https://zhuanlan.zhihu.com/p/586372481
// https://zhuanlan.zhihu.com/p/365912693
// todo: 注意到live分析也对基本块进行了dfs, 能否重用？
class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    DomTree run(Function &f, FAM &fpm);

private:
    struct INFO {
        int dfn;                          // 从0开始
        std::shared_ptr<BasicBlock> sdom; // semi-dom
        std::shared_ptr<BasicBlock> idom;
        std::shared_ptr<BasicBlock> dfst_parent;
        std::vector<std::shared_ptr<BasicBlock>> dfst_children;
    };
    std::unordered_map<std::shared_ptr<BasicBlock>, INFO> dt_info;
    std::vector<std::shared_ptr<BasicBlock>> idfn; // 用于通过dfn逆向查找bb
    std::shared_ptr<BasicBlock> entry;
    int SDOM(int i);
    int SDOM(const std::shared_ptr<BasicBlock> &b);
    void dfs();
    void
    calcSDOM(); // https://blog.csdn.net/Dong_HFUT/article/details/121375025#Semidominators_76
    void calcIDOM();
    void analyze(Function &f);
};

} // namespace IR

#endif