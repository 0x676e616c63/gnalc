// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/reshape_fold.hpp"

#include "ir/instructions/binary.hpp"
#include "ir/instructions/memory.hpp"
#include "sir/base.hpp"
#include "sir/passes/analysis/alias_analysis.hpp"
#include "sir/visitor.hpp"

namespace SIR {
// Determine if `src` and `dest` index sequences represent a one-to-one mapping
// between array accesses.
std::optional<std::vector<int>> calculateMask(const std::vector<AffineExpr> &src, const std::vector<AffineExpr> &dest) {
    if (src.size() != dest.size())
        return std::nullopt;

    // Each expression to be purely linear (no constants).
    // TODO: relax this restriction to handle more general reshapes.
    for (const auto &expr : src)
        if (!expr.isLinear())
            return std::nullopt;
    for (const auto &expr : dest)
        if (!expr.isLinear())
            return std::nullopt;

    auto dim = src.size();

    // Calculate the shuffle mask. It is similar to shuffle mask used in vectorization.
    std::vector<int> mask;
    std::unordered_set<int> used;
    for (int i = 0; i < dim; ++i) {
        bool found_i = false;
        for (int j = 0; j < dim; ++j) {
            if (used.count(j))
                continue;
            if (isIsomorphic(src[i], dest[j])) {
                mask.emplace_back(j);
                used.insert(j);
                found_i = true;
                break;
            }
        }
        if (!found_i)
            return std::nullopt;
    }
    return mask;
}

// Apply mask to make accesses of `dest` directly to `src`
std::vector<AffineExpr> applyMask(const std::vector<AffineExpr> &dest, const std::vector<int> &mask) {
    Err::gassert(mask.size() == dest.size(), "Mask size does not equal to dest size?");
    std::vector<AffineExpr> ret;
    for (auto i : mask)
        ret.emplace_back(dest[i]);
    return ret;
}

struct MemoryInfo {
    struct StoreInfo {
        pStore store;
        IList *ilist;
        LInstIter iter;
    };
    struct LoadInfo {
        pLoad load;
        IList *ilist;
        LInstIter iter;
    };
    bool untracked = false;
    size_t store_cnt{};
    StoreInfo single_store;
    std::vector<LoadInfo> loads;
};
using FoldCandidates = std::unordered_map<Value *, MemoryInfo>;
struct FoldVisitor : ContextVisitor {
    FoldCandidates *candidates;
    LAAResult *laa_res;
    bool analyze_failed = false;

    void visit(Context ctx, Instruction &inst) override {
        if (analyze_failed)
            return;

        if (auto store = inst.as<STOREInst>()) {
            const auto &aa = laa_res->queryPointer(store->getPtr());
            if (!aa) {
                analyze_failed = true;
                return;
            }
            if (aa->isArray()) {
                auto &candidate = (*candidates)[aa->array().base];
                candidate.single_store.store = store;
                candidate.single_store.iter = ctx.iter;
                candidate.single_store.ilist = ctx.iList();
                ++candidate.store_cnt;
            }
        }
        // If there are untracked LOADInst, give up. Since we need to rewrite every load to apply mask.
        else if (auto load = inst.as<LOADInst>()) {
            const auto &aa = laa_res->queryPointer(load->getPtr());
            if (!aa) {
                analyze_failed = true;
                return;
            }
            if (aa->isArray()) {
                (*candidates)[aa->array().base].loads.emplace_back(MemoryInfo::LoadInfo{load, ctx.iList(), ctx.iter});
            }
        } else if (auto call = inst.as<CALLInst>()) {
            auto call_args = call->getArgs();
            if (!call->getFunc()->hasAttr(FuncAttr::builtinMemReadOnly)) {
                for (auto &arg : call_args) {
                    if (arg->getType()->is<PtrType>()) {
                        auto aa = laa_res->queryPointer(arg);
                        if (!aa) {
                            analyze_failed = true;
                            return;
                        }
                        if (aa->isArray())
                            (*candidates)[aa->array().base].untracked = true;
                    }
                }
            }
        }

        ContextVisitor::visit(ctx, inst);
    }

    FoldVisitor(FoldCandidates *candidates_, LAAResult *laa_res_) : candidates(candidates_), laa_res(laa_res_) {}
};

PM::PreservedAnalyses ReshapeFoldPass::run(LinearFunction &function, LFAM &lfam) {
    auto &laa_res = lfam.getResult<LAliasAnalysis>(function);

    FoldCandidates candidates;
    FoldVisitor visitor(&candidates, &laa_res);
    function.accept(visitor);

    if (visitor.analyze_failed || candidates.empty())
        return PreserveAll();

    bool exec_once = function.hasAttr(FuncAttr::ExecuteExactlyOnce);
    for (const auto &[dest_mem, mem_info] : candidates) {
        if (!exec_once && dest_mem->is<GlobalVariable>())
            continue;

        if (dest_mem->is<FormalParam>())
            continue;

        const auto &[untracked, store_cnt, single_store, loads] = mem_info;
        const auto &store = single_store.store;
        if (untracked)
            continue;

        if (dest_mem->is<ALLOCAInst>() && store_cnt == 0) {
            Logger::logWarning("[ReshapeFold]: Uninitialized local array '", dest_mem->getName(), "'");
            continue;
        }
        // There can only be one store in Copy/Shuffle.
        if (store_cnt != 1)
            continue;

        auto src_load = store->getValue()->as<LOADInst>();
        if (!src_load)
            continue;
        auto src_ptr = src_load->getPtr();
        const auto &src_aa_res = laa_res.queryPointer(src_ptr);

        // Only array accesses are considered as Copy/Shuffle.
        if (!src_aa_res || !src_aa_res->isArray())
            continue;

        const auto &src_access = src_aa_res->array();
        auto src_mem = src_access.base;
        // We've ensured dest access is an array.
        const auto &dest_access = laa_res.queryPointer(store->getPtr())->array();

        // When a single store transfers data from one array access to another,
        // the destination view is simply a reshaped version of
        // the source.
        // Here we compute a shuffle mask and try to replace subsequent destination accesses
        // with direct source accesses, thus eliminating the temporary reshaped.
        auto mask = calculateMask(src_access.indices, dest_access.indices);
        if (!mask)
            continue;

        std::vector<std::pair<MemoryInfo::LoadInfo, std::vector<AffineExpr>>> masked_loads;
        for (const auto &info : loads) {
            const auto &ld_aa_res = laa_res.queryPointer(info.load->getPtr());
            Err::gassert(ld_aa_res && ld_aa_res->isArray(), "Bad MemoryInfo.");
            const auto &ld_access = ld_aa_res->array();
            // Skip untracked load
            if (ld_access.indices.size() != dest_access.indices.size())
                return PreserveAll();
            auto masked_ld_access = applyMask(ld_access.indices, *mask);
            masked_loads.emplace_back(info, masked_ld_access);
        }

        {
            std::string mask_str = std::to_string((*mask)[0]);
            for (size_t i = 1; i < mask->size(); i++)
                mask_str += ", " + std::to_string((*mask)[i]);
            Logger::logDebug("[ReshapeFold]: Applied mask {", mask_str, "} to '", dest_mem->getName(), "'.");
        }

        // At this point, we've ensured the dest is a reshape of the source array,
        // Now apply the mask.
        static size_t name_cnt = 0;
        auto i32_zero = function.getConst(0);
        for (const auto &[info, access] : masked_loads) {
            auto base = src_mem->as<Value>();
            for (const auto &expr : access) {
                auto [coe, iv] = expr.getLinear();
                pVal subscript = iv->as<Value>();
                if (coe != 1) {
                    auto bin = std::make_shared<BinaryInst>("%reshape." + std::to_string(name_cnt++), OP::MUL, subscript,
                                                            function.getConst(coe));
                    info.ilist->insert(info.iter, bin);
                    subscript = bin;
                }
                auto gep =
                    std::make_shared<GEPInst>("%reshape." + std::to_string(name_cnt++), base, i32_zero, subscript);
                info.ilist->insert(info.iter, gep);
                base = gep;
            }
            info.load->replaceAllOperands(info.load->getPtr(), base);
            Logger::logDebug("[ReshapeFold]: Masked load '", info.load->getName(), "'.");
        }

        single_store.ilist->erase(single_store.iter);
    }

    return PreserveNone();
}
} // namespace SIR