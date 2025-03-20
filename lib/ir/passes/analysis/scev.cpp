#include "../../../../include/ir/passes/analysis/scev.hpp"

#include <string>

namespace IR {
PM::UniqueKey SCEVAnalysis::Key;

SCEVExpr *TREC::getExpr() const {
    Err::gassert(isExpr());
    return std::get<SCEVExpr*>(value);
}

TREC *TREC::getBase() const {
    Err::gassert(isAddRec());
    return std::get<AddRec>(value).base;
}
TREC *TREC::getStep() const {
    Err::gassert(isAddRec());
    return std::get<AddRec>(value).step;
}
const Loop *TREC::getLoop() const {
    Err::gassert(isAddRec());
    return std::get<AddRec>(value).loop;
}

bool TREC::isExpr() const {
    return type == TRECType::Expr;
}
bool TREC::isAddRec() const {
    return type == TRECType::AddRec;
}
bool TREC::isUntracked() const {
    return type == TRECType::Untracked;
}
bool TREC::isUndef() const { return type == TRECType::Undefined; }

    TREC* SCEVHandle::analyzeEvolution(const Loop* loop, Value* val) {
    Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form");
    auto it = evolution.find(val);
    if (it != evolution.end())
        return it->second;

    TREC* res = nullptr;

    std::shared_ptr<Value> x, y;
    if (loop->isLoopInvariant(val))
        res = getSCEVExprTREC(getSCEVExpr(val));
    else if (match(val, M::Add(M::VBind(x), M::VBind(y))))
        res = getTRECAdd(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (match(val, M::Sub(M::VBind(x), M::VBind(y))))
        res = getTRECSub(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (match(val, M::Mul(M::VBind(x), M::VBind(y))))
        res = getTRECMul(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (auto phi = dynamic_cast<const PHIInst*>(val)) {
        auto phi_bb = phi->getParent().get();
        auto phi_opers = phi->getPhiOpers();
        if (loop->getHeader() == phi_bb) {
            Err::gassert(phi_opers.size() == 2, "Expected LoopSimplified Form");
            auto invariant = phi_opers[0].value.get();
            auto variant = phi_opers[1].value.get();
            if (!loop->isLoopInvariant(invariant))
                std::swap(invariant, variant);
            Err::gassert(loop->isLoopInvariant(invariant) && !loop->isLoopInvariant(variant),
                "Expected LoopSimplified Form");

            auto [exist, update] = buildUpdateExpr(phi, variant, loop);
            // TODO: peeled TREC
            if (!exist || update->isUntracked())
                res = getTRECUntracked();
            else
                res = getTRECAdd(getSCEVExprTREC(getSCEVExpr(invariant)), update);
        }
        else {
            std::vector<TREC*> trecs;
            for (auto& [phi_val, _bb] : phi->getPhiOpers()) {
                auto phi_val_evo = analyzeEvolution(loop, phi_val.get());
                trecs.emplace_back(phi_val_evo);
            }
            res = trecs[0];
            for (const auto& trec : trecs) {
                if (res != trec) {
                    res = getTRECUntracked();
                    break;
                }
            }
        }
    }
    else res = getTRECUntracked();

    Err::gassert(res != nullptr);
    evolution[val] = res;
    return eval(res, loop);
}

std::pair<bool, TREC *> SCEVHandle::buildUpdateExpr(const PHIInst *loop_phi, Value *val, const Loop *loop_phi_loop) {
    if (loop_phi == val)
        return { true, getSCEVExprTREC(getSCEVExpr(function->getConst(0).get())) };
    if (loop_phi_loop->isLoopInvariant(val))
        return { false, getTRECUndef() };
    std::shared_ptr<Value> x, y;
    if (match(val, M::Add(M::VBind(x), M::VBind(y)))) {
        auto [exist_x, update_x] = buildUpdateExpr(loop_phi, x.get(), loop_phi_loop);
        if (exist_x)
            return { true, getTRECAdd(update_x, getSCEVExprTREC(getSCEVExpr(y.get()))) };
        auto [exist_y, update_y] = buildUpdateExpr(loop_phi, y.get(), loop_phi_loop);
        if (exist_y)
            return { true, getTRECAdd(update_y, getSCEVExprTREC(getSCEVExpr(x.get()))) };
        return { false, getTRECUndef() };
    }

    if (auto val_phi = dynamic_cast<const PHIInst*>(val)) {
        auto val_phi_bb = val_phi->getParent().get();
        auto val_phi_opers = val_phi->getPhiOpers();
        auto val_phi_loop = loop_info->getLoopFor(val_phi_bb).get();

        if (val_phi_loop && val_phi_loop->getHeader() == val_phi_bb) {
            Err::gassert(val_phi_opers.size() == 2, "Expected LoopSimplified Form");
            auto val_phi_invariant = val_phi_opers[0].value.get();
            auto val_phi_variant = val_phi_opers[1].value.get();
            if (!val_phi_loop->isLoopInvariant(val_phi_invariant))
                std::swap(val_phi_invariant, val_phi_variant);
            Err::gassert(val_phi_loop->isLoopInvariant(val_phi_invariant)
                && !loop_phi_loop->isLoopInvariant(val_phi_variant),
                "Expected LoopSimplified Form");

            if (loop_phi_loop->isLoopInvariant(val_phi_invariant))
                return { false, getTRECUndef() };

            auto s = apply(val_phi_loop,
                analyzeEvolution(val_phi_loop, val),
                getTripCount(val_phi_loop));
            if (s->isBinary() && s->getOp() == SCEVExpr::Binary::Op::Add &&
                s->getLHS()->isIRValue() && s->getLHS()->getIRValue() == val_phi_invariant) {
                auto [exist, update] = buildUpdateExpr(loop_phi, val_phi_invariant, loop_phi_loop);
                if (exist)
                    return { true, getTRECAdd(update, getSCEVExprTREC(s->getRHS())) };
                }
            return { false, getTRECUndef() };
        }

        for (const auto& [v, b] : val_phi_opers) {
            auto [exist, update] = buildUpdateExpr(loop_phi, v.get(), loop_phi_loop);
            if (exist)
                return { true, getTRECUntracked() };
        }

        return { false, getTRECUndef() };
    }

    return { false, getTRECUndef() };
}


SCEVExpr *SCEVHandle::instantiateEvolution(TREC *trec, const Loop *loop) {
    // TODO
    return nullptr;
}

TREC *SCEVHandle::eval(TREC *trec, const Loop *loop) {
    // TODO
    return nullptr;
}

SCEVExpr *SCEVHandle::apply(const Loop *loop, TREC *trec, size_t trip_cnt) {
    // TODO
    return nullptr;
}

size_t SCEVHandle::getTripCount(const Loop *loop) const {
    // TODO
    return 0;
}

TREC *SCEVHandle::getPoolTREC(const std::shared_ptr<TREC> &trec) {
    for (const auto &pool_trec : trec_pool) {
        if (*trec == *pool_trec)
            return pool_trec.get();
    }
    trec_pool.emplace_back(trec);
    return trec.get();
}

TREC* SCEVHandle::getSCEVExprTREC(SCEVExpr* expr) {
    auto trec = std::make_shared<TREC>(expr);
    return getPoolTREC(trec);
}

TREC *SCEVHandle::getAddRecTREC(const Loop *loop, TREC *base, TREC *step) {
    auto trec = std::make_shared<TREC>(TREC::AddRec{base, step, loop});
    return getPoolTREC(trec);
}
TREC *SCEVHandle::getTRECUndef() const {
    return trec_pool[0].get();
}
TREC *SCEVHandle::getTRECUntracked() const {
    return trec_pool[1].get();
}
TREC *SCEVHandle::getTRECAdd(TREC *x, TREC *y) {
    Err::gassert(!x->isUndef() && !y->isUndef());
    if (x->isUntracked() || y->isUntracked())
        return getTRECUntracked();
    if (x->isExpr() && y->isExpr())
        return getPoolTREC(std::make_shared<TREC>(getSCEVExprAdd(x->getExpr(), y->getExpr())));
    if (x->isAddRec() && y->isExpr())
        return getAddRecTREC(x->getLoop(), getTRECAdd(x->getBase(), y), x->getStep());
    if (x->isExpr() && y->isAddRec())
        return getAddRecTREC(x->getLoop(), getTRECAdd(y->getBase(), x), y->getStep());
    Err::gassert(x->isAddRec() && y->isAddRec());
    Err::gassert(x->getLoop() == y->getLoop(), "Cannot add AddRecs with different loops");
    return getAddRecTREC(
        x->getLoop(),
        getTRECAdd(x->getBase(), y->getBase()),
        getTRECAdd(x->getStep(), y->getStep()));
}
TREC *SCEVHandle::getTRECSub(TREC *x, TREC *y) {
    Err::gassert(!x->isUndef() && !y->isUndef());
    if (x->isUntracked() || y->isUntracked())
        return getTRECUntracked();
    if (x->isExpr() && y->isExpr())
        return getPoolTREC(std::make_shared<TREC>(getSCEVExprSub(x->getExpr(), y->getExpr())));
    if (x->isAddRec() && y->isExpr())
        return getAddRecTREC(x->getLoop(), getTRECSub(x->getBase(), y), x->getStep());
    if (x->isExpr() && y->isAddRec())
        return getAddRecTREC(x->getLoop(), getTRECSub(x, y->getBase()), y->getStep());
    Err::gassert(x->isAddRec() && y->isAddRec());
    Err::gassert(x->getLoop() == y->getLoop(), "Cannot add AddRecs with different loops");
    return getAddRecTREC(
        x->getLoop(),
        getTRECSub(x->getBase(), y->getBase()),
        getTRECSub(x->getStep(), y->getStep()));
}
TREC *SCEVHandle::getTRECMul(TREC *x, TREC *y) {
    Err::gassert(!x->isUndef() && !y->isUndef());
    if (x->isUntracked() || y->isUntracked())
        return getTRECUntracked();
    if (x->isExpr() && y->isExpr())
        return getPoolTREC(std::make_shared<TREC>(getSCEVExprMul(x->getExpr(), y->getExpr())));
    if (x->isAddRec() && y->isExpr())
        return getAddRecTREC(x->getLoop(), getTRECMul(x->getBase(), y), getTRECMul(x->getStep(), y));
    if (x->isExpr() && y->isAddRec())
        return getAddRecTREC(x->getLoop(), getTRECMul(y->getBase(), x), getTRECMul(y->getStep(), x));
    Err::gassert(x->isAddRec() && y->isAddRec());
    Err::gassert(x->getLoop() == y->getLoop(), "Cannot multiply AddRecs with different loops");
    auto new_base = getTRECMul(x->getBase(), y->getBase());
    auto new_step = getTRECAdd(getTRECAdd(getTRECMul(x, y->getStep()), getTRECMul(y, x->getStep())),
                               getTRECMul(x->getStep(), y->getStep()));
    return getAddRecTREC(x->getLoop(), new_base, new_step);
}

SCEVExpr *SCEVHandle::getPoolSCEV(const std::shared_ptr<SCEVExpr> &expr) {
    for (const auto &pool_expr : expr_pool) {
        if (*expr == *pool_expr)
            return pool_expr.get();
    }
    expr_pool.emplace_back(expr);
    return expr.get();
}

SCEVExpr *SCEVHandle::getSCEVExprAdd(SCEVExpr *x, SCEVExpr *y) {
    if (x->isIRValue() && match(x->getIRValue(), M::Is(0)))
        return y;
    if (y->isIRValue() && match(y->getIRValue(), M::Is(0)))
        return x;
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Add, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprSub(SCEVExpr *x, SCEVExpr *y) {
    if (y->isIRValue() && match(y->getIRValue(), M::Is(0)))
        return x;
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Sub, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprMul(SCEVExpr *x, SCEVExpr *y) {
    if ((x->isIRValue() && match(x->getIRValue(), M::Is(0))) ||
        (y->isIRValue() && match(y->getIRValue(), M::Is(0))))
        return getSCEVExpr(function->getConst(0).get());
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Mul, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExpr(Value *x) {
    return getPoolSCEV(std::make_shared<SCEVExpr>(x));
}

SCEVHandle SCEVAnalysis::run(Function &func, FAM &fam) {
    return SCEVHandle(&func);
}

} // namespace IR