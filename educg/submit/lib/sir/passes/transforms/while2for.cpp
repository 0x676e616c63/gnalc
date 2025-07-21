// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/transforms/while2for.hpp"

#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/match.hpp"
#include "../../../../include/match/match.hpp"
#include "../../../../include/sir/base.hpp"
#include "../../../../include/sir/visitor.hpp"

#include <optional>
namespace SIR {
enum class UpdateType { Affine, Unknown, Invariant };
struct Result {
    UpdateType type;
    pVal base;
    pVal step;
    std::set<pInst> iv_loads;
    std::set<pInst> update_insts;
};
Result analyzeUpdateExpr(IList &ilist, WHILEInst &wh, const pVal &ptr) {
    if (ptr->getVTrait() == ValueTrait::CONSTANT_LITERAL || ptr->getVTrait() == ValueTrait::FORMAL_PARAMETER)
        return {UpdateType::Invariant, ptr, nullptr};

    // Find the base
    auto it = std::next(IListRFind(ilist, wh.as<WHILEInst>()));
    pVal base;
    std::set<pInst> update_insts;
    auto analyzeBase = [&] {
        for (; it != ilist.rend(); ++it) {
            if (match(*it, M::Store(M::Bind(base), M::Is(ptr)))) {
                // IV init store
                update_insts.emplace(*it);
                return true;
            }

            if (auto helper = (*it)->as<HELPERInst>()) {
                for (const auto& nested : helper->nested_insts()) {
                    if (match(nested, M::Store(M::Val(), M::Is(ptr))) || match(*it, M::Load(M::Is(ptr))))
                        return false;
                }
            }

            if (ptr->is<GlobalVariable>() && (*it)->is<CALLInst>())
                return false;

            if (match(*it, M::Load(M::Is(ptr))))
                return false;
        }
        return false;
    }();

    if (!analyzeBase)
        return {UpdateType::Unknown, nullptr, nullptr};

    // Find the unique `write` in the loop
    pStore store;
    std::set<pInst> iv_loads;
    for (const auto &inst : wh.nested_insts()) {
        if (match(inst, M::Store(M::Val(), M::Is(ptr)))) {
            if (!store)
                store = inst->as<STOREInst>();
            else
                return {UpdateType::Unknown, nullptr, nullptr};
        } else if (match(inst, M::Load(M::Is(ptr))))
            iv_loads.emplace(inst);
        // Give up loop with early exit
        else if (inst->is<BREAKInst, CONTINUEInst, RETInst>())
            return {UpdateType::Unknown, nullptr, nullptr};
    }

    if (!store)
        return {UpdateType::Invariant, base, nullptr};

    // IV update store
    update_insts.emplace(store);

    if (wh.getBodyInsts().back() != store)
        return {UpdateType::Unknown, nullptr, nullptr};

    if (pVal step; match(store->getValue(), M::Add(M::Load(M::Is(ptr)), M::Bind(step))) ||
                   match(store->getValue(), M::Add(M::Bind(step), M::Load(M::Is(ptr))))) {
        auto add = store->getValue()->as<BinaryInst>();
        auto ld = add->getLHS();
        if (!ld->is<LOADInst>())
            ld = add->getRHS();

        // IV Updates
        update_insts.emplace(add);
        update_insts.emplace(ld->as<LOADInst>());
        return {UpdateType::Affine, base, step, iv_loads, update_insts};
    }

    return {UpdateType::Unknown, nullptr, nullptr};
}

struct ForInfo {
    pAlloca indvar_alloc;
    pVal base;
    pVal bound;
    pVal step;
    std::set<pInst> iv_loads;
    std::set<pInst> update_insts;
};

std::optional<ForInfo> transformWhile(IList &ilist, WHILEInst &wh, LinearFunction &lfunc) {
    pVal lhs, rhs;
    if (match(wh.getCond(), M::Icmp(M::Bind(lhs), M::Bind(rhs)))) {
        auto icmp = wh.getCond()->as<ICMPInst>();
        auto cond = icmp->getCond();
        if (auto lld = lhs->as<LOADInst>())
            lhs = lld->getPtr();
        if (auto rld = rhs->as<LOADInst>())
            rhs = rld->getPtr();
        auto l_evo = analyzeUpdateExpr(ilist, wh, lhs);
        auto r_evo = analyzeUpdateExpr(ilist, wh, rhs);

        if (l_evo.type == UpdateType::Affine && r_evo.type == UpdateType::Invariant) {
            auto ind = lhs->as<ALLOCAInst>();
            if (!ind) {
                Logger::logDebug("[While2For]: Skipped non-alloca induction variable.");
                return std::nullopt;
            }
            if (cond == ICMPOP::slt || cond == ICMPOP::sgt)
                return ForInfo{ind, l_evo.base, r_evo.base, l_evo.step, l_evo.iv_loads, l_evo.update_insts};
            if (cond == ICMPOP::sle) {
                if (int rbase_c; match(r_evo.base, M::Bind(rbase_c)))
                    return ForInfo{ind,        l_evo.base,     lfunc.getConst(rbase_c + 1),
                                   l_evo.step, l_evo.iv_loads, l_evo.update_insts};
            }
            if (cond == ICMPOP::sge) {
                if (int rbase_c; match(r_evo.base, M::Bind(rbase_c)))
                    return ForInfo{ind,        l_evo.base,     lfunc.getConst(rbase_c - 1),
                                   l_evo.step, l_evo.iv_loads, l_evo.update_insts};
            }

            Logger::logDebug("[While2For]: Skipped non-comparable condition.");
            return std::nullopt;
        }

        Logger::logDebug("[While2For]: Skipped non-comparable operands.");
        return std::nullopt;
    }
    Logger::logDebug("[While2For]: Skipped non-icmp condition.");
    return std::nullopt;
}

struct While2ForVisitor : ContextVisitor {
    using MapT = std::vector<std::tuple<IList *, pWhileInst>>;
    MapT *replace_map{};

    explicit While2ForVisitor(MapT *replace_map_) : replace_map(replace_map_) {}
    void visit(Context ctx, WHILEInst &while_inst) override {
        // Doing this in a post order can let the IList* in valid state when replacing while to for.
        ContextVisitor::visit(ctx, while_inst);

        IList *ilist = ctx.iList();
        replace_map->emplace_back(ilist, while_inst.as<WHILEInst>());
    }
};

PM::PreservedAnalyses While2ForPass::run(LinearFunction &function, LFAM &lfam) {
    bool while2for_modified = false;

    While2ForVisitor::MapT replace_map;

    While2ForVisitor visitor(&replace_map);
    function.accept(visitor);

    size_t num_transformed = 0;
    static size_t name_cnt = 0;
    for (auto &[ilist, while_inst] : replace_map) {
        if (auto for_info_opt = transformWhile(*ilist, *while_inst, function)) {
            auto info = *for_info_opt;
            auto iv =
                std::make_shared<IndVar>(info.indvar_alloc->getName() + ".ind." + std::to_string(name_cnt++),
                                                    info.indvar_alloc, info.base, info.bound, info.step);
            auto for_inst = std::make_shared<FORInst>(iv, while_inst->getBodyInsts());
            IListReplace(*ilist, while_inst, for_inst);
            // Replace all uses of info.ind with iv
            for (const auto &load : info.iv_loads)
                load->replaceSelf(iv);

            // Remove all update insts
            auto need_del = [&](const pInst &p) { return info.update_insts.count(p) || info.iv_loads.count(p); };
            IListDelIfRecursive(*ilist, need_del);
            IListDelIf(for_inst->getBodyInsts(), need_del);
            while2for_modified = true;
            ++num_transformed;
        }
    }

    if (num_transformed != 0)
        Logger::logDebug("[While2For]: Transformed ", num_transformed, " while(s) to for.");

    return while2for_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR