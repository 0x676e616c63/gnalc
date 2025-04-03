#include "ir/passes/analysis/domtree_analysis.hpp"
#include "utils/logger.hpp"

namespace IR {
PM::UniqueKey DomTreeAnalysis::Key;
PM::UniqueKey PostDomTreeAnalysis::Key;

DomTree DomTreeAnalysis::run(Function &f, FAM &fam) {
    detail::DomTreeBuilder builder;
    builder.entry = f.getBlocks().front().get();
    builder.analyze();
    return builder.domtree;
}

PostDomTree PostDomTreeAnalysis::run(Function &f, FAM &fam) {
    detail::PostDomTreeBuilder builder;
    setExit(f);
    builder.entry = exit.get();
    builder.analyze();
    if (is_exit_virtual) {
        // If the root is virtual, then it is linked to a virtual block that is going to destructs
        // when `exit = nullptr`
        builder.domtree.root()->setBlock(nullptr);
    }
    restoreCFG();
    exit = nullptr;
    is_exit_virtual = false;
    return builder.domtree;
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

void PostDomTreeAnalysis::restoreCFG() const {
    if (!is_exit_virtual)
        return;
    for (const auto &real_exit : exit->preds()) {
        real_exit->next_bb.clear();
    }
    exit->pre_bb.clear();
}
} // namespace IR
