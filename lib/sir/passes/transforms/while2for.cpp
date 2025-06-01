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
enum class UpdateType { ConstantAffine, Unknown, Invariant };
struct Result {
    UpdateType type;
    int base;
    int step;
};
Result analyzeUpdateExpr(IList& ilist, WHILEInst &wh, const pVal &val) {
    if (auto ci32 = val->as<ConstantInt>())
        return {UpdateType::Invariant, ci32->getVal(), 0};

    // Find the constant base
    auto it = std::next(IListRFind(ilist, wh.as<WHILEInst>()));
    int base;
    auto analyzeBase = [&] {
        for (; it != ilist.rend(); ++it) {
            if (match(*it, M::Store(M::Bind(base), M::Is(val))))
                return true;

            if ((*it)->is<HELPERInst>())
                return false;
        }
        return false;
    }();

    if (!analyzeBase)
        return {UpdateType::Unknown, 0, 0};

    // Find the unique `write` in the loop
    pStore store;
    for (const auto &inst : wh.all_insts()) {
        if (match(inst, M::Store(M::Val(), M::Is(val)))) {
            if (!store)
                store = inst->as<STOREInst>();
            else
                return {UpdateType::Unknown, 0, 0};
        }
    }

    if (!store)
        return {UpdateType::Invariant, base, 0};

    if (wh.getBodyInsts().back() != store)
        return {UpdateType::Unknown, 0, 0};

    if (int step; match(store->getValue(), M::Add(M::Load(M::Is(val)), M::Bind(step))) ||
                  match(store->getValue(), M::Add(M::Bind(step), M::Load(M::Is(val)))))
        return {UpdateType::ConstantAffine, base, step};

    return {UpdateType::Unknown, 0, 0};
}

struct ForInfo {
    pAlloca ind;
    int base;
    int bound;
    int step;
};
std::optional<ForInfo> transformWhile(IList& ilist, WHILEInst &wh) {
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

        if (lty == UpdateType::Invariant && rty == UpdateType::ConstantAffine) {
            std::swap(lty, rty);
            std::swap(lbase, rbase);
            std::swap(lstep, rstep);
            cond = reverseCond(icmp->getCond());
        }

        if (lty == UpdateType::ConstantAffine && rty == UpdateType::Invariant) {
            auto ind = lhs->as<ALLOCAInst>();
            if (!ind) {
                Logger::logDebug("[While2For]: Skipped non-alloca induction variable.");
                return std::nullopt;
            }
            if (cond == ICMPOP::slt || cond == ICMPOP::sgt)
                return ForInfo{ind, lbase, rbase, lstep};
            if (cond == ICMPOP::sle)
                return ForInfo{ind, lbase, rbase + 1, lstep};
            if (cond == ICMPOP::sge)
                return ForInfo{ind, lbase, rbase - 1, lstep};

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

    std::unique_ptr<LookBehindVisitor> visitor = std::make_unique<While2ForVisitor>(&replace_map);
    visitor->visit(LookBehindVisitor::PrevInfo::makeInitial(), function);

    size_t num_transformed = 0;
    for (auto &[ilist, while_inst] : replace_map) {
        if (auto for_info = transformWhile(*ilist, *while_inst)) {
            auto [ind, base, bound, step] = *for_info;
            auto for_inst = std::make_shared<FORInst>(ind, base, bound, step, while_inst->getBodyInsts());
            IListReplace(*ilist, while_inst, for_inst);
            while2for_modified = true;
            ++num_transformed;
        }
    }

    Logger::logDebug("[While2For]: Transformed ", num_transformed, " while(s) to for.");

    return while2for_modified ? PreserveNone() : PreserveAll();
}
} // namespace SIR