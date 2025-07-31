// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/codelayout.hpp"
#include "mir/passes/analysis/branch_freq_analysis.hpp"

#include <queue>

using namespace MIR;

size_t dbg_count_edges(MIRFunction &func) {
    size_t count = 0;
    for (const auto& blk : func.blks())
        count += blk->as<MIRBlk>()->succs().size();
    return count;
}

std::string dumpLayout(const std::list<MIRBlk_p>& blks) {
    std::string ret = blks.front()->getmSym();
    for (auto it = std::next(blks.begin()); it != blks.end(); ++it)
        ret += " -> " + (*it)->getmSym();
    return ret;
}

PM::PreservedAnalyses CodeLayoutPass::run(MIRFunction &func, FAM &fam) {
    auto &freq = fam.getResult<BranchFreqAnalysis>(func);

    struct Chain {
        unsigned priority{};
        std::list<MIRBlk_p> blocks;
    };
    std::unordered_map<MIRBlk_p, MIRBlk_p> head_map;
    std::unordered_map<MIRBlk_p, Chain> chains;
    for (const auto &blk : func.blks()) {
        head_map[blk] = blk;
        chains[blk].priority = std::numeric_limits<unsigned>::max();
        chains[blk].blocks = {blk};
    }

    struct EdgeInfo {
        MIRBlk_p src;
        MIRBlk_p dest;
        BranchInfo::Prob freq;
    };
    std::vector<EdgeInfo> edges;
    for (auto &[raw_edge, freq] : freq.edge_freqs)
        edges.push_back({raw_edge.src->as<MIRBlk>(), raw_edge.dest->as<MIRBlk>(), freq});

    Err::gassert(dbg_count_edges(func) == edges.size(), "Missing edges.");

    std::sort(edges.begin(), edges.end(), [](auto &a, auto &b) { return a.freq > b.freq; });

    unsigned priority_cnt = 0;
    for (const auto &[src, dest, freq] : edges) {
        if (src == dest)
            continue;
        auto src_head = head_map[src];
        auto dest_head = head_map[dest];
        if (src_head == dest_head)
            continue;

        auto &src_chain = chains[src_head];
        auto &dest_chain = chains[dest_head];
        if (src_chain.blocks.back() != src || dest_chain.blocks.front() != dest)
            continue;

        for (auto blk : dest_chain.blocks)
            head_map[blk] = src_head;
        src_chain.blocks.splice(src_chain.blocks.end(), dest_chain.blocks);
        src_chain.priority = std::min({src_chain.priority, dest_chain.priority, ++priority_cnt});
    }

    std::unordered_map<MIRBlk_p, std::list<MIRBlk_p>> chain_graph;
    for (const auto &[src, dest, freq] : edges) {
        auto head = head_map[src];
        auto tail = head_map[dest];
        if (head != tail)
            chain_graph[head].emplace_back(tail);
    }

    auto cmp = [&](const auto &a, const auto &b) { return chains[a].priority > chains[b].priority; };
    std::priority_queue<MIRBlk_p, std::vector<MIRBlk_p>, decltype(cmp)> queue(cmp);
    std::unordered_set<MIRBlk_p> in_queue;
    std::unordered_set<MIRBlk_p> placed;
    std::list<MIRBlk_p> new_order;

    auto entry = func.blks().front();
    queue.push(head_map[entry]);
    in_queue.insert(head_map[entry]);

    while (!queue.empty()) {
        auto c = queue.top();
        queue.pop();
        for (auto blk : chains[c].blocks) {
            if (placed.insert(blk).second)
                new_order.push_back(blk);
        }
        for (auto succ_chain : chain_graph[c]) {
            if (placed.count(succ_chain))
                continue;
            if (in_queue.insert(succ_chain).second)
                queue.push(succ_chain);
        }
    }

    Err::gassert(new_order.size() == func.blks().size(), "Not all blocks placed.");

    if (func.blks() != new_order)
        Logger::logDebug("[CodeLayout]: From '", dumpLayout(func.blks()), "' to '", dumpLayout(new_order), "'.");
    else
        Logger::logDebug("[CodeLayout]: No changes.");

    func.blks() = std::move(new_order);
    for (auto it = func.blks().begin(); it != func.blks().end(); ++it) {
        if (it == func.blks().begin())
            (*it)->resetPrv(nullptr);
        else
            (*it)->resetPrv(*std::prev(it));

        if (std::next(it) == func.blks().end())
            (*it)->resetNxt(nullptr);
        else
            (*it)->resetNxt(*std::next(it));
    }
    return PM::PreservedAnalyses::none();
}
