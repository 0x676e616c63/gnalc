#include "sir/passes/transforms/while2for.hpp"

#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/pattern_match.hpp"
#include "pattern_match/pattern_match.hpp"
#include "sir/base.hpp"
#include "sir/visitor.hpp"

#include <optional>
using namespace PatternMatch;
namespace SIR {
enum class UpdateType { Affine, Unknown, Invariant };
struct Result {
    UpdateType type;
    pVal base;
    pVal step;
};
Result analyzeUpdateExpr(IList& ilist, WHILEInst &wh, const pVal &val) {
    if (val->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        return {UpdateType::Invariant, val, nullptr};

    // Find the base
    auto it = std::next(IListRFind(ilist, wh.as<WHILEInst>()));
    pVal base;
    auto analyzeBase = [&] {
        for (; it != ilist.rend(); ++it) {
            if (match(*it, M::Store(M::Bind(base), M::Is(val))))
                return true;

            if ((*it)->is<HELPERInst>())
                return false;

            if (val->is<GlobalVariable>() && (*it)->is<CALLInst>())
                return false;
        }
        return false;
    }();

    if (!analyzeBase)
        return {UpdateType::Unknown, nullptr, nullptr};

    // Find the unique `write` in the loop
    pStore store;
    for (const auto &inst : wh.all_insts()) {
        if (match(inst, M::Store(M::Val(), M::Is(val)))) {
            if (!store)
                store = inst->as<STOREInst>();
            else
                return {UpdateType::Unknown, nullptr, nullptr};
        }
    }

    if (!store)
        return {UpdateType::Invariant, base, nullptr};

    if (wh.getBodyInsts().back() != store)
        return {UpdateType::Unknown, nullptr, nullptr};

    if (pVal step; match(store->getValue(), M::Add(M::Load(M::Is(val)), M::Bind(step))) ||
                  match(store->getValue(), M::Add(M::Bind(step), M::Load(M::Is(val)))))
        return {UpdateType::Affine, base, step};

    return {UpdateType::Unknown, nullptr, nullptr};
}

struct ForInfo {
    pAlloca ind;
    pVal base;
    pVal bound;
    pVal step;
};

std::optional<ForInfo> transformWhile(IList& ilist, WHILEInst &wh, LinearFunction& lfunc) {
    pVal lhs, rhs;
    if (match(wh.getCond(), M::Icmp(M::Bind(lhs), M::Bind(rhs)))) {
        auto icmp = wh.getCond()->as<ICMPInst>();
        auto cond = icmp->getCond();
        if (auto lld = lhs->as<LOADInst>())
            lhs = lld->getPtr();
        if (auto rld = rhs->as<LOADInst>())
            rhs = rld->getPtr();
        auto [lty, lbase, lstep] = analyzeUpdateExpr(ilist, wh, lhs);
        auto [rty, rbase, rstep] = analyzeUpdateExpr(ilist, wh, rhs);

        if (lty == UpdateType::Invariant && rty == UpdateType::Affine) {
            std::swap(lty, rty);
            std::swap(lbase, rbase);
            std::swap(lstep, rstep);
            cond = reverseCond(icmp->getCond());
        }

        if (lty == UpdateType::Affine && rty == UpdateType::Invariant) {
            auto ind = lhs->as<ALLOCAInst>();
            if (!ind) {
                Logger::logDebug("[While2For]: Skipped non-alloca induction variable.");
                return std::nullopt;
            }
            if (cond == ICMPOP::slt || cond == ICMPOP::sgt)
                return ForInfo{ind, lbase, rbase, lstep};
            if (cond == ICMPOP::sle) {
                if (int rbase_c; match(rbase, M::Bind(rbase_c)))
                    return ForInfo{ind, lbase, lfunc.getConst(rbase_c + 1), lstep};
            }
            if (cond == ICMPOP::sge) {
                if (int rbase_c; match(rbase, M::Bind(rbase_c)))
                    return ForInfo{ind, lbase, lfunc.getConst(rbase_c - 1), lstep};
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

struct While2ForVisitor : LookBehindVisitor {
    using MapT = std::vector<std::tuple<IList*, pWhileInst>>;
    MapT* replace_map{};

    explicit While2ForVisitor(MapT* replace_map_) : replace_map(replace_map_) {}
    void visit(PrevInfo prev, WHILEInst &while_inst) override {
        // Doing this in a post order can let the IList* in valid state when replacing while to for.
        LookBehindVisitor::visit(prev, while_inst);

        IList* ilist = prev.iList();
        replace_map->emplace_back(ilist, while_inst.as<WHILEInst>());
    }
};

PM::PreservedAnalyses While2ForPass::run(LinearFunction &function, LFAM &manager) {
    bool while2for_modified = false;

    While2ForVisitor::MapT replace_map;

    While2ForVisitor visitor(&replace_map);
    function.accept(visitor);

    size_t num_transformed = 0;
    for (auto &[ilist, while_inst] : replace_map) {
        if (auto for_info = transformWhile(*ilist, *while_inst, function)) {
            auto [ind, base, bound, step] = *for_info;
            auto for_inst = std::make_shared<FORInst>(ind, base, bound, step, while_inst->getBodyInsts());
            IListReplace(*ilist, while_inst, for_inst);
            while2for_modified = true;
            ++num_transformed;
            // Logger::logDebug("[While2For]: Transformed loop.");
        }
    }

    if (num_transformed != 0)
        Logger::logDebug("[While2For]: Transformed ", num_transformed, " while(s) to for.");

    return while2for_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR