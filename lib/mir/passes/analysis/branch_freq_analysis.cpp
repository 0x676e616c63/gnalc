// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/analysis/branch_freq_analysis.hpp"

#include "legacy_mir/operand.hpp"
#include "mir/passes/analysis/domtree_analysis.hpp"
#include "parser/basetype.hpp"

using namespace MIR;

PM::UniqueKey BranchFreqAnalysis::Key;

using Edge = BranchInfo::Edge;
using Prob = BranchInfo::Prob;

// The Ball-Larus heuristics,
// the numbers are taken from "Static Branch Frequency and Program Profile Analysis"
namespace Heuristic {
// Loop branch heuristic (LBH):
//   Predict as taken an edge back to a loop's head.
//   Predict as not taken an edge exiting a loop.
constexpr Prob LoopBranch = 0.88;

// Pointer heuristic (PH):
//   Predict that a comparison of a pointer against null or of two pointers will fail.
constexpr Prob Pointer = 0.60;

// Call heuristic (CH):
//   Predict a successor that contains a call and does not post-dominate will not be taken.
constexpr Prob Call = 0.78;

// Opcode heuristic (OH):
//   Predict that a comparison of an integer for less than zero,
//   less than or equal to zero, or equal to a constant, will fail.
constexpr Prob Opcode = 0.84;

// Loop exit heuristic (LEH):
//   Predict that a comparison in a loop in which no successor is a loop head will not exit the loop.
constexpr Prob LoopExit = 0.80;

// Return heuristic (RH):
//   Predict a successor that contains a return will not be taken.
constexpr Prob Return = 0.72;

// Store heuristic (SH):
//   Predict a successor that contains a store instruction and does not post-dominate will not be taken.
constexpr Prob Store = 0.55;

// Loop header heuristic (LHH):
//   Predict a successor that is a loop header or a loop preheader and does not post-dominate will be taken.
constexpr Prob LoopHeader = 0.75;

// Guard heuristic (GH):
//   Predict that a comparison in which a register is an operand, the register is used before
//   being defined in a successor block, and the successor block does not post-dominate
//   will reach the successor block.
constexpr Prob Guard = 0.62;
} // namespace Heuristic

#define GIVEUP_IF(cond)                                                                                                \
    if (cond)                                                                                                          \
        return 0.5;

// TODO: PH
Prob BranchFreqAnalysis::computePH(const Edge &e) const { GIVEUP_IF(true); }

Prob BranchFreqAnalysis::computeCH(const Edge &e) const {
    auto contains_call = [](MIRBlk *bb) -> bool {
        for (const auto &inst : bb->Insts()) {
            if ((inst->isARM() && inst->opcode<ARMOpC>() == ARMOpC::BL) ||
                (inst->isRV() && inst->opcode<RVOpC>() == RVOpC::CALL)) {
                return true;
            }
        }
        return false;
    };

    size_t num_succs_has_call = 0;
    for (const auto &succ : e.src->succs()) {
        if (contains_call(succ.get()))
            num_succs_has_call++;
    }

    GIVEUP_IF(num_succs_has_call == 0 || num_succs_has_call == e.src->succs().size());

    return contains_call(e.dest) ? (1 - Heuristic::Call) : Heuristic::Call;
}

Prob BranchFreqAnalysis::computeOH(const Edge &e) const {
    const auto &insts = e.src->Insts();
    for (auto it = insts.rbegin(); it != insts.rend(); ++it) {
        if ((*it)->isGeneric()) {
            if ((*it)->opcode<OpC>() == OpC::InstBranch) {
                auto reloc = (*it)->getOp(1)->reloc()->as<MIRBlk>().get();
                auto cond = (*it)->getOp(2)->imme();
                GIVEUP_IF(std::next(it) == insts.rend());
                auto icmp_it = std::next(it);
                GIVEUP_IF(!(*icmp_it)->isGeneric() || (*icmp_it)->opcode<OpC>() != OpC::InstICmp);
                auto lhs = (*icmp_it)->getOp(1);
                auto rhs = (*icmp_it)->getOp(2);
                GIVEUP_IF(!rhs->isImme() && !lhs->isImme());

                if (!rhs->isImme() && lhs->isImme()) {
                    std::swap(lhs, rhs);
                    cond = reverseCond(static_cast<Cond>(cond));
                }

                if (reloc != e.dest)
                    cond = flipCond(static_cast<Cond>(cond));

                if (cond == Cond::EQ || (rhs->imme() == 0 && (cond == Cond::LT || cond == Cond::LE)))
                    return 1 - Heuristic::Opcode;

                GIVEUP_IF(true);
            }
            if ((*it)->opcode<OpC>() == OpC::InstICmpBranch) {
                const auto &icmp_br = *it;
                auto reloc = (*it)->getOp(3)->reloc()->as<MIRBlk>().get();
                auto cond = (*it)->getOp(4)->imme();
                auto lhs = icmp_br->getOp(1);
                auto rhs = icmp_br->getOp(2);
                GIVEUP_IF(!rhs->isImme() && !lhs->isImme());

                if (!rhs->isImme() && lhs->isImme()) {
                    std::swap(lhs, rhs);
                    cond = reverseCond(static_cast<Cond>(cond));
                }

                if (reloc != e.dest)
                    cond = flipCond(static_cast<Cond>(cond));

                if (cond == Cond::EQ || (rhs->imme() == 0 && (cond == Cond::LT || cond == Cond::LE)))
                    return 1 - Heuristic::Opcode;

                GIVEUP_IF(true);
            }
        }
    }
    GIVEUP_IF(true);
}

Prob BranchFreqAnalysis::computeLEH(const Edge &e) const {
    auto loop = loop_info->getLoopFor(e.src);
    GIVEUP_IF(!loop || loop->getHeader().get() == e.dest || !loop->isExiting(e.src));
    if (loop->isExit(e.dest))
        return 1 - Heuristic::LoopExit;
    return Heuristic::LoopExit;
}

Prob BranchFreqAnalysis::computeRH(const Edge &e) const {
    auto contains_ret = [](MIRBlk *bb) -> bool { return bb->succs().empty(); };

    size_t num_succs_has_ret = 0;
    for (const auto &succ : e.src->succs()) {
        if (contains_ret(succ.get()))
            num_succs_has_ret++;
    }

    GIVEUP_IF(num_succs_has_ret == 0 || num_succs_has_ret == e.src->succs().size());

    return contains_ret(e.dest) ? (1 - Heuristic::Return) : Heuristic::Return;
}

Prob BranchFreqAnalysis::computeSH(const Edge &e) const {
    auto contains_store = [](MIRBlk *bb) -> bool {
        for (const auto &inst : bb->Insts()) {
            if (inst->isGeneric() && inst->opcode<OpC>() == OpC::InstStore)
                return true;
        }
        return false;
    };

    size_t num_succs_has_store = 0;
    for (const auto &succ : e.src->succs()) {
        if (contains_store(succ.get()))
            num_succs_has_store++;
    }

    GIVEUP_IF(num_succs_has_store == 0 || num_succs_has_store == e.src->succs().size());

    return contains_store(e.dest) ? (1 - Heuristic::Store) : Heuristic::Store;
}

Prob BranchFreqAnalysis::computeLHH(const Edge &e) const {
    auto is_ph_or_h = [this](MIRBlk *bb) -> bool {
        return loop_info->isLoopHeader(bb) || (bb->succs().size() == 1 && loop_info->isLoopHeader(bb->succs().front()));
    };

    size_t num_succs_is_ph_or_h = 0;
    for (const auto &succ : e.src->succs()) {
        if (is_ph_or_h(succ.get()))
            num_succs_is_ph_or_h++;
    }

    GIVEUP_IF(num_succs_is_ph_or_h == 0 || num_succs_is_ph_or_h == e.src->succs().size());

    return is_ph_or_h(e.dest) ? Heuristic::LoopHeader : 1 - Heuristic::LoopHeader;
}

Prob BranchFreqAnalysis::computeGH(const Edge &e) const {
    MIROperand_p lhs, rhs;
    auto find_cmp = [&]() -> bool {
        const auto &insts = e.src->Insts();
        for (auto it = insts.rbegin(); it != insts.rend(); ++it) {
            if ((*it)->isGeneric()) {
                if ((*it)->opcode<OpC>() == OpC::InstBranch) {
                    if (std::next(it) == insts.rend())
                        return false;
                    auto icmp_it = std::next(it);
                    if (!(*icmp_it)->isGeneric() || (*icmp_it)->opcode<OpC>() != OpC::InstICmp)
                        return false;
                    lhs = (*icmp_it)->getOp(1);
                    rhs = (*icmp_it)->getOp(2);
                    return true;
                }
                if ((*it)->opcode<OpC>() == OpC::InstICmpBranch) {
                    const auto &icmp_br = *it;
                    lhs = icmp_br->getOp(1);
                    rhs = icmp_br->getOp(2);
                    return true;
                }
            }
        }
        return false;
    }();
    GIVEUP_IF(!find_cmp);

    std::vector<unsigned> regs;
    for (const auto &i : {lhs, rhs}) {
        if (i->isReg())
            regs.emplace_back(i->reg());
    }

    GIVEUP_IF(regs.empty());

    auto check_block = [&](MIRBlk *bb) {
        bool used_before_def = false;
        for (unsigned target : regs) {
            for (auto &inst : bb->Insts()) {
                auto def = inst->getDef();
                if (def && def->isReg() && def->reg() == target)
                    break;
                for (size_t i = 1; i < inst->getUseNr(); ++i) {
                    if (inst->getOp(i)->isReg() && inst->getOp(i)->reg() == target) {
                        used_before_def = true;
                        break;
                    }
                }
            }
        }
        return used_before_def;
    };

    std::map<MIRBlk*, bool> used_before_defs;
    for (auto &bb : e.src->succs()) {
        if (check_block(bb.get()))
            used_before_defs[bb.get()] = true;
    }

    GIVEUP_IF(used_before_defs.empty() || used_before_defs.size() == e.src->succs().size());

    return used_before_defs[e.dest] ? Heuristic::Guard : 1 - Heuristic::Guard;
}

void BranchFreqAnalysis::computeAllProbs(MIRFunction &func, BranchInfo::EdgeProbs &probs) const {
    for (auto &bb : func.blks()) {
        // Return block
        if (bb->succs().empty())
            continue;

        // Single successor
        if (bb->succs().size() == 1) {
            probs[Edge{bb.get(), bb->succs().front().get()}] = 1;
            continue;
        }

        Err::gassert(bb->succs().size() == 2, "Bad CFG");

        auto loop = loop_info->getLoopFor(bb.get());
        if (loop && loop->isLatch(bb.get())) {
            std::vector<MIRBlk *> back_edge_succs, exit_edge_succs;
            for (const auto &succ : bb->succs()) {
                if (loop->getHeader() == succ)
                    back_edge_succs.emplace_back(succ.get());
                else if (loop->isExit(succ))
                    exit_edge_succs.emplace_back(succ.get());
            }

            // Only back edges
            if (back_edge_succs.size() == bb->succs().size()) {
                for (auto succ : back_edge_succs) {
                    auto edge = Edge{bb.get(), succ};
                    probs[edge] = 1.0 / static_cast<double>(bb->succs().size());
                }
                continue;
            }

            // Only back edges and exit edges
            if (back_edge_succs.size() + exit_edge_succs.size() == bb->succs().size()) {
                for (auto succ : back_edge_succs) {
                    auto edge = Edge{bb.get(), succ};
                    probs[edge] = Heuristic::LoopBranch / static_cast<double>(back_edge_succs.size());
                }

                for (auto succ : exit_edge_succs) {
                    auto edge = Edge{bb.get(), succ};
                    probs[edge] = (1.0 - Heuristic::LoopBranch) / static_cast<double>(exit_edge_succs.size());
                }
                continue;
            }

            // Else fall through to the general cases.
        }

        auto succ1 = bb->succs().front();
        auto succ2 = bb->succs().back();

        // Other cases
        Prob prob1 = 0.5;
        Prob prob2 = 0.5;
        auto edge1 = Edge{bb.get(), succ1.get()};
        auto edge2 = Edge{bb.get(), succ2.get()};

        std::vector<std::function<Prob(const Edge &)>> heuristics = {
            [this](const Edge &e) { return computePH(e); },  [this](const Edge &e) { return computeCH(e); },
            [this](const Edge &e) { return computeOH(e); },  [this](const Edge &e) { return computeLEH(e); },
            [this](const Edge &e) { return computeRH(e); },  [this](const Edge &e) { return computeSH(e); },
            [this](const Edge &e) { return computeLHH(e); }, [this](const Edge &e) { return computeGH(e); },
        };

        for (auto &H : heuristics) {
            // Assume H predicts (bb -> succ1) taken, and(bb -> succ2) not taken
            auto taken = H(edge1);
            auto not_taken = 1 - taken;
            auto d = prob1 * taken + prob2 * not_taken;
            prob1 = prob1 * taken / d;
            prob2 = prob2 * not_taken / d;
        }

        probs[edge1] = prob1;
        probs[edge2] = prob2;
    }
}

void BranchFreqAnalysis::propagateFreqs(MIRBlk *bb, MIRBlk *head, BranchInfo::EdgeFreqs &freqs,
                                        BranchInfo::EdgeProbs &probs, BranchInfo::EdgeProbs &back_edge_probs,
                                        BranchInfo::BlockFreqs &bfreqs, std::unordered_set<MIRBlk *> &visited) const {
    if (visited.count(bb))
        return;

    // 1. find bfreq(b)
    if (bb == head)
        bfreqs[bb] = 1;
    else {
        for (const auto &pred : bb->preds()) {
            if (!visited.count(pred.get()) && !loop_info->isLoopHeader(bb))
                return;
        }
        bfreqs[bb] = 0;
        Prob cyclic_prob = 0;
        auto bb_loop = loop_info->getLoopFor(bb);
        bool is_header = bb_loop && (bb_loop->getHeader().get() == bb);
        for (const auto &pred : bb->preds()) {
            if (is_header && bb_loop->contains(pred))
                cyclic_prob += back_edge_probs[Edge{pred.get(), bb}];
            else
                bfreqs[bb] += freqs[Edge{pred.get(), bb}];
        }
        if (cyclic_prob > 1 - epsilon)
            cyclic_prob = 1 - epsilon;
        bfreqs[bb] = bfreqs[bb] / (1 - cyclic_prob);
    }

    // 2. calculate the frequencies of bb's out edges
    visited.emplace(bb);
    for (const auto &succ : bb->succs()) {
        auto edge = Edge{bb, succ.get()};
        freqs[edge] = probs[edge] * bfreqs[bb];
        // update back_edge_prob(bb -> succ) so it can be used by outer loops to calculate
        // cyclic_probs of inner loops
        if (succ.get() == head) {
            back_edge_probs[edge] = probs[edge] * bfreqs[bb];
        }
    }

    // 3. propagate to successor blocks
    for (const auto &succ : bb->succs()) {
        auto loop = loop_info->getLoopFor(succ.get());
        if (loop && loop->getHeader() == succ && loop->contains(bb))
            continue;
        propagateFreqs(succ.get(), head, freqs, probs, back_edge_probs, bfreqs, visited);
    }
}

BranchInfo BranchFreqAnalysis::run(MIRFunction &func, FAM &fam) {
    loop_info = &fam.getResult<MachineLoopAnalysis>(func);

    BranchInfo::EdgeProbs probs;
    computeAllProbs(func, probs);

    BranchInfo::EdgeProbs back_edge_props = probs;
    BranchInfo::EdgeFreqs freqs;
    BranchInfo::BlockFreqs bfreqs;
    for (const auto &top_level : *loop_info) {
        auto pdfv = top_level->getDFVisitor<Util::DFVOrder::PostOrder>();
        for (const auto &loop : pdfv) {
            std::unordered_set<MIRBlk *> visited;
            for (const auto &bb : func.blks()) {
                if (!loop->contains(bb.get()))
                    visited.emplace(bb.get());
            }
            auto head = loop->getHeader().get();
            propagateFreqs(head, head, freqs, probs, back_edge_props, bfreqs, visited);
        }
    }

    std::unordered_set<MIRBlk *> visited_global;
    auto entry = func.blks().front().get();
    propagateFreqs(entry, entry, freqs, probs, back_edge_props, bfreqs, visited_global);

    loop_info = nullptr;

    return BranchInfo{freqs};
}