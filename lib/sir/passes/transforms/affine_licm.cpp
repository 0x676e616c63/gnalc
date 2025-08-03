// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/affine_licm.hpp"

#include "sir/passes/analysis/affine_alias_analysis.hpp"
#include "sir/utils.hpp"
#include "sir/visitor.hpp"

namespace SIR {
// A region of loop invariant instructions
// [beg, end)
struct Region {
    LInstIter beg;
    LInstIter end;
};

std::string dumpRegion(const Region &region) {
    auto name = [](const pVal &i) {
        auto name = i->getName();
        if (auto for_inst = i->as<FORInst>())
            name = "for<" + for_inst->getIndVar()->getName() + ">";
        return name;
    };
    std::string str = "{" + name(*region.beg);
    for (auto it = std::next(region.beg); it != region.end; ++it)
        str += ", " + name(*it);
    str += "}";
    return str;
}

struct LICMCandidate {
    IList *outer_ilist{};
    IList *inner_ilist{};
    LInstIter for_iter;
    Region region;
};

// If a region doesn't have any use-def or (loop-carried) memory dependency,
// it produces loop-invariant memory state, and can be hoisted out of the loop.
bool isInvariantRegion(const Region &region, FORInst *for_inst, AffineAAResult *laa_res) {
    const auto &loop_rw = laa_res->queryInstRW(for_inst);

    if (!loop_rw)
        return false;

    std::unordered_set<pVal> to_hoist;
    auto is_use_def_invariant = [&](const pInst &inst) {
        std::unordered_set<pVal> operands;
        for (const auto &operand : inst->operands()) {
            if (operand == for_inst->getIndVar())
                return false;
            if (to_hoist.count(operand))
                continue;
            operands.emplace(operand);
        }
        return !containsInLoop(operands, for_inst);
    };

    // Considering the region as a whole, collect the read/write info.
    std::vector<MemoryAccess> region_read;
    std::vector<MemoryAccess> region_write;
    for (auto it = region.beg; it != region.end; ++it) {
        if (hasNonMemorySideEffect(*it))
            return false;

        // No use-def dependency
        if (auto helper = (*it)->as<HELPERInst>()) {
            for (const auto &i : helper->nested_insts()) {
                if (!is_use_def_invariant(i))
                    return false;
                to_hoist.emplace(i);
            }
        } else if (auto inst = (*it)->as<Instruction>()) {
            if (!is_use_def_invariant(inst))
                return false;
            to_hoist.emplace(inst);
        }

        const auto &curr_rw = laa_res->queryInstRW(*it);
        if (!curr_rw)
            return false;

        for (const auto &read_ptr : curr_rw->read) {
            const auto &read_access = laa_res->queryPointer(read_ptr);
            if (!read_access)
                return false;

            // If a read is covered by a previous write in the region, ignore it
            // since we've trying to hoist the region as a whole.
            bool covered = false;
            for (const auto &prev_w : region_write) {
                if (prev_w.covers(*read_access)) {
                    covered = true;
                    break;
                }
            }
            if (!covered)
                region_read.emplace_back(*read_access);
        }

        // Collect writes in this region
        for (const auto &write_ptr : curr_rw->write) {
            const auto &write_access = laa_res->queryPointer(write_ptr);
            if (!write_access)
                return false;
            region_write.emplace_back(*write_access);
        }
    }

    // Ensure no loop-carried memory dependency
    for (const auto &read_access : region_read) {
        for (const auto &loop_write : loop_rw->write) {
            const auto &loop_waccess = laa_res->queryPointer(loop_write);
            if (!loop_waccess || loop_waccess->overlaps(read_access))
                return false;
        }
    }

    std::vector<MemoryAccess> outer_read;
    std::vector<MemoryAccess> outer_write;
    auto collect_rw = [&](LInstIter beg, LInstIter end) {
        for (auto it = beg; it != end; ++it) {
            const auto &curr_rw = laa_res->queryInstRW(*it);
            if (!curr_rw)
                return false;
            for (const auto &read_ptr : curr_rw->read) {
                const auto &read_access = laa_res->queryPointer(read_ptr);
                if (!read_access)
                    return false;
                outer_read.emplace_back(*read_access);
            }
            for (const auto &write_ptr : curr_rw->write) {
                const auto &write_access = laa_res->queryPointer(write_ptr);
                if (!write_access)
                    return false;
                outer_write.emplace_back(*write_access);
            }
        }
        return true;
    };

    if (!collect_rw(for_inst->body_begin(), region.beg) || !collect_rw(region.end, for_inst->body_end()))
        return false;

    auto has_dep = [&](const std::vector<MemoryAccess> &set1, const std::vector<MemoryAccess> &set2) {
        for (const auto &a1 : set1) {
            for (const auto &a2 : set2) {
                if (a1.overlaps(a2))
                    return true;
            }
        }
        return false;
    };

    if (has_dep(region_read, outer_write) || has_dep(region_write, outer_read) || has_dep(region_write, outer_write))
        return false;

    return true;
}

struct LICMVisitor : ContextVisitor {
    using Candidates = std::vector<LICMCandidate>;
    Candidates *candidates;
    AffineAAResult *laa_res;
    size_t licm_depth;
    bool depth_hit = false;

    LICMVisitor(Candidates *candidates_, AffineAAResult *laa_res_, size_t licm_depth_)
        : candidates(candidates_), laa_res(laa_res_), licm_depth(licm_depth_) {}

    // For each affine for, investigate if we can find an invariant region of code.
    void visit(Context ctx, FORInst &for_inst) override {
        if (ctx.depth == licm_depth) {
            depth_hit = true;

            auto head = for_inst.body_begin();
            for (auto it = head; it != for_inst.body_end(); ++it) {
                auto region = Region{head, std::next(it)};
                if (isInvariantRegion(region, &for_inst, laa_res)) {
                    candidates->emplace_back(LICMCandidate{.outer_ilist = ctx.iList(),
                                                           .inner_ilist = &for_inst.getBodyInsts(),
                                                           .for_iter = ctx.iter,
                                                           .region = region});
                    break;
                }
            }
        }

        ContextVisitor::visit(ctx, for_inst);
    }
};

PM::PreservedAnalyses AffineLICMPass::run(LinearFunction &function, LFAM &lfam) {
    bool licm_modified = false;

    auto &laa_res = lfam.getResult<AffineAliasAnalysis>(function);

    size_t searching_depth = 0;
    while (true) {
        LICMVisitor::Candidates licm_candidates;
        LICMVisitor visitor{&licm_candidates, &laa_res, ++searching_depth};
        function.accept(visitor);

        if (!visitor.depth_hit)
            break;

        for (const auto &[outer_ilist, inner_ilist, for_iter, region] : licm_candidates) {
            // Log before splice.
            // After splicing, the region.beg is moved to outer_ilist, while region.end is still
            // in inner_ilist, which makes difficult to iterate the region.
            auto for_name = (*for_iter)->as<FORInst>()->getIndVar()->getName();
            Logger::logDebug("[AffineLICM]: Hoisted ", dumpRegion(region), " out of ", for_name, ".");
            for (auto it = region.beg; it != region.end; ++it)
                (*it)->appendDbgData("affine_licm_hoisted_from_" + for_name);

            outer_ilist->splice(for_iter, *inner_ilist, region.beg, region.end);
            licm_modified = true;

            // Revisit this depth
            --searching_depth;
        }
    }

    return licm_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR