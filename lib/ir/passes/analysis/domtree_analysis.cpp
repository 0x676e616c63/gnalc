#include "ir/passes/analysis/domtree_analysis.hpp"
#include "utils/logger.hpp"

namespace IR {
PM::UniqueKey DomTreeAnalysis::Key;
PM::UniqueKey PostDomTreeAnalysis::Key;

DomTree DomTreeAnalysis::run(Function &f, FAM &fam) {
    DomTreeBuilder builder;
    builder.entry = f.getBlocks().front().get();
    builder.analyze();
    return builder.domtree;
}

PostDomTree PostDomTreeAnalysis::run(Function &f, FAM &fam) {
    PostDomTreeBuilder builder;
    PDTBuildContext ctx;
    setExit(f, ctx);
    builder.entry = ctx.exit.get();
    builder.analyze();
    if (ctx.is_exit_virtual) {
        // If the root is virtual, then it is linked to a virtual block that is going to destructs
        // when `exit = nullptr`
        builder.domtree.root()->setBlock(nullptr);
    }
    restoreCFG(ctx);
    ctx.exit = nullptr;
    ctx.is_exit_virtual = false;
    return builder.domtree;
}

void PostDomTreeAnalysis::setExit(const Function &f, PDTBuildContext& ctx) {
    const auto exit_bbs = f.getExitBBs();
    if (exit_bbs.empty()) {
        Err::unreachable("PostDomTreeAnalysis::setExit(): no exit!");
    }
    if (exit_bbs.size() == 1) {
        ctx.exit = exit_bbs.front();
        ctx.is_exit_virtual = false;
    } else {
        ctx.exit = std::make_shared<BasicBlock>("VIRTUAL_EXIT_NODE");
        for (const auto &b : exit_bbs) {
            b->addNextBB(ctx.exit);
            ctx.exit->addPreBB(b);
        }
        ctx.is_exit_virtual = true;
    }
}

void PostDomTreeAnalysis::restoreCFG(PDTBuildContext& ctx) const {
    if (!ctx.is_exit_virtual)
        return;
    for (const auto &real_exit : ctx.exit->preds()) {
        real_exit->next_bb.clear();
    }
    ctx.exit->pre_bb.clear();
}
} // namespace IR
