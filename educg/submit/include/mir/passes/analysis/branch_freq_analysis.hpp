// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Static Branch Probability Analysis
// Reference:
//   - "Static Branch Frequency and Program Profile Analysis"
//       https://dl.acm.org/doi/pdf/10.1145/192724.192725
#pragma once
#ifndef GNALC_MIR_PASSES_ANALYSIS_BRANCH_FREQ_ANALYSIS_HPP
#define GNALC_MIR_PASSES_ANALYSIS_BRANCH_FREQ_ANALYSIS_HPP

#include "domtree_analysis.hpp"
#include "../../../graph/domtree.hpp"
#include "loop_analysis.hpp"
#include "../pass_manager.hpp"

#include <memory>
#include <vector>

namespace MIR {
struct BranchInfo {
    struct Edge {
        MIRBlk *src;
        MIRBlk *dest;
    };
    struct EdgeHash {
        size_t operator()(const Edge &edge) const {
            size_t seed = std::hash<MIRBlk *>()(edge.src);
            Util::hashSeedCombine(seed, std::hash<MIRBlk *>()(edge.dest));
            return seed;
        }
    };
    struct EdgeEqual {
        bool operator()(const Edge &edge1, const Edge &edge2) const {
            return edge1.src == edge2.src && edge1.dest == edge2.dest;
        }
    };
    using Prob = double;
    using EdgeProbs = std::unordered_map<Edge, Prob, EdgeHash, EdgeEqual>;
    using EdgeFreqs = std::unordered_map<Edge, Prob, EdgeHash, EdgeEqual>;
    using BlockFreqs = std::unordered_map<MIRBlk *, Prob>;

    EdgeFreqs edge_freqs;

    Prob queryEdgeFreq(const Edge &edge) const {
        return edge_freqs.at(edge);
    }

    Prob queryEdgeFreq(MIRBlk *src, MIRBlk *dest) const {
        return queryEdgeFreq(Edge{src, dest});
    }
};
class BranchFreqAnalysis : public PM::AnalysisInfo<BranchFreqAnalysis> {
    static constexpr BranchInfo::Prob epsilon = std::numeric_limits<BranchInfo::Prob>::epsilon();

public:
    using Result = BranchInfo;
    BranchInfo run(MIRFunction &func, FAM &fam);

private:
    MLoopInfo *loop_info;

    // double computeLBH(const BranchInfo::Edge& edge);
    double computePH(const BranchInfo::Edge &edge) const;
    double computeCH(const BranchInfo::Edge &edge) const;
    double computeOH(const BranchInfo::Edge &edge) const;
    double computeLEH(const BranchInfo::Edge &edge) const;
    double computeRH(const BranchInfo::Edge &edge) const;
    double computeSH(const BranchInfo::Edge &edge) const;
    double computeLHH(const BranchInfo::Edge &edge) const;
    double computeGH(const BranchInfo::Edge &edge) const;

    void computeAllProbs(MIRFunction &func, BranchInfo::EdgeProbs &probs) const;
    void propagateFreqs(MIRBlk *bb, MIRBlk *head, BranchInfo::EdgeFreqs &freqs, BranchInfo::EdgeProbs &probs,
                        BranchInfo::EdgeProbs &back_edge_probs, BranchInfo::BlockFreqs &bfreqs,
                        std::unordered_set<MIRBlk *> &visited) const;

private:
    friend AnalysisInfo<BranchFreqAnalysis>;
    static PM::UniqueKey Key;
};
} // namespace MIR

#endif