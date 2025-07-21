// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/mir/passes/analysis/domtree_analysis.hpp"

using namespace MIR;

PM::UniqueKey DomTreeAnalysis::Key;
PM::UniqueKey PostDomTreeAnalysis::Key;

DomTree DomTreeAnalysis::run(MIRFunction &f, FAM &fam) {
    detail::DomTreeBuilder builder;
    builder.entry = f.EntryBlk().get();
    builder.analyze();
    return builder.domtree;
}

PostDomTree PostDomTreeAnalysis::run(MIRFunction &f, FAM &fam) {
    detail::PostDomTreeBuilder builder;
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

void PostDomTreeAnalysis::setExit(MIRFunction &f, PDTBuildContext& ctx) {
    std::vector<MIRBlk_p> exit_bbs;
    for (const auto &b : f.blks()) {
        if (b->succs().size() == 0)
            exit_bbs.push_back(b);
    }

    if (exit_bbs.empty())
        Err::unreachable("PostDomTreeAnalysis::setExit(): no exit!");

    if (exit_bbs.size() == 1) {
        ctx.exit = exit_bbs.front();
        ctx.is_exit_virtual = false;
    } else {
        ctx.exit = std::make_shared<MIRBlk>("VIRTUAL_EXIT_NODE", f.as<MIRFunction>(), nullptr, nullptr);
        for (const auto &b : exit_bbs) {
            b->succs().emplace_back(ctx.exit);
            ctx.exit->preds().emplace_back(b);
        }
        ctx.is_exit_virtual = true;
    }
}

void PostDomTreeAnalysis::restoreCFG(PDTBuildContext& ctx) const {
    if (!ctx.is_exit_virtual)
        return;
    for (const auto &real_exit : ctx.exit->preds()) {
        real_exit->succs().clear();
    }
    ctx.exit->preds().clear();
}