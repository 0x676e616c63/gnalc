// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/while2for.hpp"

#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/match.hpp"
#include "match/match.hpp"
#include "sir/base.hpp"
#include "sir/utils.hpp"
#include "sir/visitor.hpp"

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

Result analyzeUpdateExpr(IList &ilist, WHILEInst &wh, const pVal &val) {
    auto ptr = val;
    if (auto ld = val->as<LOADInst>())
        ptr = ld->getPtr();

    // For pointers, see if they are invariant first.
    if (ptr->getType()->is<PtrType>()) {
        if (isMemoryInvariantTo(ptr.get(), &wh))
            return {UpdateType::Invariant, val, nullptr};
        // fall through to affine cases
    }
    // For scalars, they must not be in loop, which is always invariant.
    else
        return {UpdateType::Invariant, val, nullptr};

    // Find the base
    auto base_it = std::next(IListRFind(ilist, wh.as<WHILEInst>()));
    pVal base;
    std::set<pInst> update_insts;
    auto analyzeBase = [&] {
        for (; base_it != ilist.rend(); ++base_it) {
            if (match(*base_it, M::Store(M::Bind(base), M::Is(ptr)))) {
                // IV init store
                update_insts.emplace(*base_it);
                return true;
            }

            if (auto helper = (*base_it)->as<HELPERInst>()) {
                for (const auto &nested : helper->nested_insts()) {
                    if (match(nested, M::Store(M::Val(), M::Is(ptr))) || match(*base_it, M::Load(M::Is(ptr))))
                        return false;
                }
            }

            if (ptr->is<GlobalVariable>() && (*base_it)->is<CALLInst>())
                return false;

            if (match(*base_it, M::Load(M::Is(ptr))))
                return false;
        }
        return false;
    }();

    if (!analyzeBase) {
        Logger::logDebug("[While2For]: Failed to analyze base.");
        return {UpdateType::Unknown, nullptr, nullptr};
    }

    // Find the iv update in the loop
    pStore iv_update;
    std::set<pInst> iv_loads;
    std::vector<pInst> nested_insts{wh.nested_insts_begin(), wh.nested_insts_end()};
    for (auto it = nested_insts.rbegin(); it != nested_insts.rend(); ++it) {
        auto inst = *it;
        if (match(inst, M::Store(M::Val(), M::Is(ptr)))) {
            if (!iv_update)
                iv_update = inst->as<STOREInst>();
            else {
                if (!isTriviallyIdentical(inst->as<STOREInst>()->getValue(), iv_update->getValue())) {
                    Logger::logDebug("[While2For]: Skip non-consistent iv update.");
                    return {UpdateType::Unknown, nullptr, nullptr};
                }
                update_insts.emplace(inst);
            }
        } else if (match(inst, M::Load(M::Is(ptr)))) {
            // Use after iv update
            if (!iv_update)
                return {UpdateType::Unknown, nullptr, nullptr};
            iv_loads.emplace(inst);
        } else if (auto cont = inst->as<CONTINUEInst>()) {
            if (iv_update == nullptr)
                continue;

            if (cont->getLoop().get() == &wh) {
                if (it == std::prev(nested_insts.rend())) {
                    // while (...)
                    //   continue
                    // It's dead loop actually
                    Logger::logDebug("[While2For]: Skip weird continue.");
                    return {UpdateType::Unknown, nullptr, nullptr};
                }

                auto str = (*std::next(it))->as<STOREInst>();
                if (!str || str->getPtr() != ptr || !isTriviallyIdentical(str->getValue(), iv_update->getValue())) {
                    Logger::logDebug("[While2For]: Skip non-consistent iv update. (cont)");
                    return {UpdateType::Unknown, nullptr, nullptr};
                }
            }
        }
    }

    if (!iv_update)
        return {UpdateType::Invariant, base, nullptr};

    // IV update store
    update_insts.emplace(iv_update);

    if (pVal step; match(iv_update->getValue(), M::Add(M::Load(M::Is(ptr)), M::Bind(step)),
                         M::Add(M::Bind(step), M::Load(M::Is(ptr))))) {
        auto add = iv_update->getValue()->as<BinaryInst>();
        auto ld = add->getLHS();
        if (!ld->is<LOADInst>())
            ld = add->getRHS();

        // IV Updates
        update_insts.emplace(add);
        update_insts.emplace(ld->as<LOADInst>());
        return {UpdateType::Affine, base, step, iv_loads, update_insts};
    }

    Logger::logDebug("[While2For]: Skip non-iv-updates-last loop.(not iv update store)");
    return {UpdateType::Unknown, nullptr, nullptr};
}

struct ForInfo {
    pVal indvar_mem;
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
        auto l_evo = analyzeUpdateExpr(ilist, wh, lhs);
        auto r_evo = analyzeUpdateExpr(ilist, wh, rhs);

        if (l_evo.type == UpdateType::Affine && r_evo.type == UpdateType::Invariant) {
            auto ind = lhs;
            if (auto ld = ind->as<LOADInst>())
                ind = ld->getPtr();
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

            Logger::logDebug("[While2For]: Skipped non-comparable condition (ICMPOP::", Util::getEnumName(cond), ")");
            return std::nullopt;
        }

        Logger::logDebug("[While2For]: Skipped non-comparable operands. {lhs: '", lhs->getName(), "' (",
                         Util::getEnumName(l_evo.type), "), rhs: '", rhs->getName(), "' (",
                         Util::getEnumName(r_evo.type), ")}");
        return std::nullopt;
    }
    Logger::logDebug("[While2For]: Skipped non-icmp condition.");
    return std::nullopt;
}

struct While2ForVisitor : ContextVisitor {
    using MapT = std::vector<std::tuple<IList *, LInstIter, pWhileInst, size_t>>;
    MapT *replace_map{};

    explicit While2ForVisitor(MapT *replace_map_) : replace_map(replace_map_) {}
    void visit(Context ctx, WHILEInst &while_inst) override {
        // Doing this in a post order can let the IList* in valid state when replacing while to for.
        ContextVisitor::visit(ctx, while_inst);

        replace_map->emplace_back(ctx.iList(), ctx.iter, while_inst.as<WHILEInst>(), ctx.depth);
    }
};

PM::PreservedAnalyses While2ForPass::run(LinearFunction &function, LFAM &lfam) {
    bool while2for_modified = false;

    While2ForVisitor::MapT replace_map;

    While2ForVisitor visitor(&replace_map);
    function.accept(visitor);

    size_t num_transformed = 0;
    static size_t name_cnt = 0;
    for (auto &[ilist, iter, while_inst, depth] : replace_map) {
        if (auto for_info_opt = transformWhile(*ilist, *while_inst, function)) {
            auto info = *for_info_opt;
            auto iv = std::make_shared<IndVar>(info.indvar_mem->getName() + ".iv." + std::to_string(name_cnt++),
                                               info.indvar_mem, info.base, info.bound, info.step, depth);
            auto for_inst = std::make_shared<FORInst>(iv, while_inst->getBodyInsts());
            Err::gassert(while_inst->getCondInsts().back()->is<ICMPInst>());
            ilist->insert(iter, while_inst->getCondInsts().begin(), std::prev(while_inst->getCondInsts().end()));
            ilist->insert(iter, for_inst);
            ilist->erase(iter);
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