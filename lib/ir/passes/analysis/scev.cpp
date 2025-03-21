#include "../../../../include/ir/passes/analysis/scev.hpp"

#include <cmath>
#include <numeric>
#include <string>

namespace IR {
PM::UniqueKey SCEVAnalysis::Key;

std::ostream &operator<<(std::ostream &os, const SCEVExpr &expr) {
    if (expr.isBinary()) {
        std::string op;
        if (expr.getOp() == SCEVExpr::Binary::Op::Add)
            op = "+";
        else if (expr.getOp() == SCEVExpr::Binary::Op::Sub)
            op = "-";
        else if (expr.getOp() == SCEVExpr::Binary::Op::Mul)
            op = "*";
        else
            Err::unreachable();
        os << "( " << *expr.getLHS() << " " << op << " " << *expr.getRHS() << " )";
    } else if (expr.isIRValue())
        os << expr.getIRValue()->getName();
    else
        Err::unreachable();
    return os;
}

std::ostream &operator<<(std::ostream &os, const TREC &trec) {
    if (trec.isExpr())
        os << *trec.getExpr();
    else if (trec.isAddRec())
        os << "{ " << *trec.getBase() << ", +, " << *trec.getStep() << " }";
    else if (trec.isUntracked())
        os << "Untracked";
    else if (trec.isUndef())
        os << "Undef";
    else
        Err::unreachable();
    return os;
}

SCEVExpr *TREC::getExpr() const {
    Err::gassert(isExpr());
    return std::get<SCEVExpr *>(value);
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

bool TREC::isExpr() const { return type == TRECType::Expr; }
bool TREC::isAddRec() const { return type == TRECType::AddRec; }
bool TREC::isUntracked() const { return type == TRECType::Untracked; }
bool TREC::isUndef() const { return type == TRECType::Undefined; }

// Input: l the current loop, n the definition of an SSA name
// Output: TREC for the variable defined by n within l
TREC *SCEVHandle::analyzeEvolution(const Loop *loop, Value *val) {
    Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form");
    // If Evolution[n] != ⊥ Then
    auto it = evolution.find(val);
    if (it != evolution.end())
        return it->second;

    TREC *res = nullptr;

    std::shared_ptr<Value> x, y;
    // Else If n matches "v = constant" Then
    if (loop->isLoopInvariant(val))
        res = getSCEVExprTREC(getSCEVExpr(val));
    // Else If n matches "v = a ⊙ b" (with ⊙ ∈ {+, −, ∗}) Then
    else if (match(val, M::Add(M::VBind(x), M::VBind(y))))
        res = getTRECAdd(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (match(val, M::Sub(M::VBind(x), M::VBind(y))))
        res = getTRECSub(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (match(val, M::Mul(M::VBind(x), M::VBind(y))))
        res = getTRECMul(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (auto phi = dynamic_cast<const PHIInst *>(val)) {
        auto phi_bb = phi->getParent().get();
        auto phi_opers = phi->getPhiOpers();
        // Else If n matches "v = loop-phi(a, b)" Then
        if (loop->getHeader() == phi_bb) {
            // Since we are in simplified form, there is a single latch. Thus, the phi has two entries.
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
                res = getAddRecTREC(loop, getSCEVExprTREC(getSCEVExpr(invariant)), update);
        }
        // Else If n matches "v = condition-phi(a, b)" Then
        else {
            std::vector<TREC *> trecs;
            for (auto &[phi_val, _bb] : phi->getPhiOpers()) {
                auto phi_val_evo = analyzeEvolution(loop, phi_val.get());
                trecs.emplace_back(phi_val_evo);
            }
            res = trecs[0];
            for (const auto &trec : trecs) {
                if (res != trec) {
                    res = getTRECUntracked();
                    break;
                }
            }
        }
    } else
        res = getTRECUntracked();

    Err::gassert(res != nullptr);
    evolution[val] = res;
    return eval(res, loop);
}

// Input: h the halting loop-phi, n the definition of an SSA name
// Output: (exist, update), exist is true if h has been reached,
// update is the reconstructed expression for the overall effect in the loop of h
std::pair<bool, TREC *> SCEVHandle::buildUpdateExpr(const PHIInst *loop_phi, Value *val, const Loop *loop_phi_loop) {
    // If (n is h) Then
    if (loop_phi == val)
        return {true, getSCEVExprTREC(getSCEVExpr(function->getConst(0).get()))};
    // Else If n is a statement in an outer loop Then
    if (loop_phi_loop->isLoopInvariant(val))
        return {false, getTRECUndef()};
    std::shared_ptr<Value> x, y;
    // Else If n matches "v = a + b" Then
    if (match(val, M::Add(M::VBind(x), M::VBind(y)))) {
        auto [exist_x, update_x] = buildUpdateExpr(loop_phi, x.get(), loop_phi_loop);
        if (exist_x)
            return {true, getTRECAdd(update_x, getSCEVExprTREC(getSCEVExpr(y.get())))};
        auto [exist_y, update_y] = buildUpdateExpr(loop_phi, y.get(), loop_phi_loop);
        if (exist_y)
            return {true, getTRECAdd(update_y, getSCEVExprTREC(getSCEVExpr(x.get())))};
        return {false, getTRECUndef()};
    }

    if (auto val_phi = dynamic_cast<const PHIInst *>(val)) {
        auto val_phi_bb = val_phi->getParent().get();
        auto val_phi_opers = val_phi->getPhiOpers();
        auto val_phi_loop = loop_info->getLoopFor(val_phi_bb).get();

        // Else If n matches "v = loop-phi(a, b)" Then
        if (val_phi_loop && val_phi_loop->getHeader() == val_phi_bb) {
            Err::gassert(val_phi_opers.size() == 2, "Expected LoopSimplified Form");
            auto val_phi_invariant = val_phi_opers[0].value.get();
            auto val_phi_variant = val_phi_opers[1].value.get();
            if (!val_phi_loop->isLoopInvariant(val_phi_invariant))
                std::swap(val_phi_invariant, val_phi_variant);
            Err::gassert(val_phi_loop->isLoopInvariant(val_phi_invariant) &&
                             !loop_phi_loop->isLoopInvariant(val_phi_variant),
                         "Expected LoopSimplified Form");

            if (loop_phi_loop->isLoopInvariant(val_phi_invariant))
                return {false, getTRECUndef()};

            auto s = apply(val_phi_loop, analyzeEvolution(val_phi_loop, val), getTripCount(val_phi_loop));
            Err::gassert(s != nullptr);
            if (!s->isExpr())
                return {false, getTRECUndef()};
            auto sexpr = s->getExpr();
            if (sexpr->isBinary() && sexpr->getOp() == SCEVExpr::Binary::Op::Add && sexpr->getLHS()->isIRValue() &&
                sexpr->getLHS()->getIRValue() == val_phi_invariant) {
                auto [exist, update] = buildUpdateExpr(loop_phi, val_phi_invariant, loop_phi_loop);
                if (exist)
                    return {true, getTRECAdd(update, getSCEVExprTREC(sexpr->getRHS()))};
            }
            return {false, getTRECUndef()};
        }

        // Else If n matches "v = condition-phi(a, b)" Then
        for (const auto &[v, b] : val_phi_opers) {
            auto [exist, update] = buildUpdateExpr(loop_phi, v.get(), loop_phi_loop);
            if (exist)
                return {true, getTRECUntracked()};
        }

        return {false, getTRECUndef()};
    }

    return {false, getTRECUndef()};
}

// Input: trec a symbolic TREC, l the instantiation loop
// Output: an instantiation of trec
TREC *SCEVHandle::instantiateEvolution(TREC *trec, const Loop *loop) {
    // If trec is a constant c Then
    if (trec->isExpr() && trec->getExpr()->isIRValue() &&
        trec->getExpr()->getIRValue()->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        return trec;

    if (trec->isExpr() && trec->getExpr()->isIRValue()) {
        // Else If trec is a variable already instantiated Then
        // TODO: resolve mixers
        if (instantiated.count(trec))
            return getTRECUntracked();
        instantiated.emplace(trec);

        // Else If trec is a variable v Then
        return analyzeEvolution(loop, trec->getExpr()->getIRValue());
    }

    if (trec->isAddRec()) {
        auto e1 = trec->getBase();
        auto e2 = trec->getStep();
        return getAddRecTREC(loop, instantiateEvolution(e1, loop), instantiateEvolution(e2, loop));
    }

    // TODO: Periodic TREC

    return getTRECUntracked();
}

TREC *SCEVHandle::eval(TREC *trec, const Loop *loop) {
    // TODO
    return trec;
}

// (n)         n!
// ( ) == ------------
// (p)     p!(n - p)!
template <typename T> constexpr T binomial_coefficient(T n, T p) {
    return std::tgamma(n + 1) / (std::tgamma(p + 1) * std::tgamma(n - p + 1));
}

TREC *SCEVHandle::apply(const Loop *loop, TREC *trec, SCEVExpr *trip_cnt) {
    // Currently we only apply the trec if the result is a compile-time constant.
    // TODO: Symbolic representation of applied TREC
    if (!trip_cnt || !trip_cnt->isIRValue())
        return trec;
    int constant_trip_cnt = -1;
    if (auto ci = dynamic_cast<ConstantInt *>(trip_cnt->getIRValue()))
        constant_trip_cnt = ci->getVal();
    else
        return trec;

    if (!trec->isAddRec())
        return trec;
    // {{ c0, c1 }, { c2 + c3 }} -> { c0, c1, c2, c3 }
    std::vector<SCEVExpr *> flatten;
    std::vector stack{trec->getStep()};
    while (!stack.empty()) {
        auto curr = stack.back();
        stack.pop_back();

        if (curr->isAddRec()) {
            stack.emplace_back(curr->getStep());
            stack.emplace_back(curr->getBase());
        } else if (curr->isExpr())
            flatten.emplace_back(curr->getExpr());
        else
            return trec;
    }

    std::vector<int> constants;
    for (const auto &e : flatten) {
        if (!e->isIRValue())
            return trec;

        if (auto ci = dynamic_cast<ConstantInt *>(e->getIRValue()))
            constants.emplace_back(ci->getVal());
        else
            return trec;
    }
    for (int p = 0; p < constants.size(); ++p)
        constants[p] = binomial_coefficient(constant_trip_cnt, p);
    auto cres = std::accumulate(constants.begin(), constants.end(), 0);
    return getAddRecTREC(loop, trec->getBase(), getSCEVExprTREC(getSCEVExpr(function->getConst(cres).get())));
}

SCEVExpr *SCEVHandle::getTripCount(const Loop *loop) {
    auto exitings = loop->getExitingBlocks();
    if (exitings.size() != 1)
        return nullptr;
    auto exiting = *exitings.begin();
    auto guard = exiting->getBRInst();
    Err::gassert(guard != nullptr && guard->isConditional());
    auto cond = guard->getCond();
    if (auto icmp = std::dynamic_pointer_cast<ICMPInst>(cond)) {
        if (int x, y; match(icmp, M::Icmp(M::I32Bind(x), M::I32Bind(y)))) {
            if (x == y)
                return nullptr;
            return getSCEVExpr(function->getConst(0).get());
        }

        auto cmpop = icmp->getCond();
        auto to_evo = icmp->getLHS();
        auto constant = icmp->getRHS();
        // If the RHS is not a constant, reverse it.
        if (constant->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
            if (to_evo->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                return nullptr;
            std::swap(to_evo, constant);
            switch (cmpop) {
            case ICMPOP::eq:
                cmpop = ICMPOP::eq;
                break;
            case ICMPOP::ne:
                cmpop = ICMPOP::ne;
                break;
            case ICMPOP::sgt:
                cmpop = ICMPOP::slt;
                break;
            case ICMPOP::sge:
                cmpop = ICMPOP::sle;
                break;
            case ICMPOP::slt:
                cmpop = ICMPOP::sgt;
                break;
            case ICMPOP::sle:
                cmpop = ICMPOP::sge;
                break;
            default:
                Err::unreachable("Invalid ICMPOP to reverse");
                break;
            }
        }

        Err::todo("GET TRIP COUNT");
        // TODO:

        Err::gassert(constant->getVTrait() == ValueTrait::CONSTANT_LITERAL);
        auto evo = analyzeEvolution(loop, to_evo.get());

        switch (cmpop) {
        case ICMPOP::eq:
        case ICMPOP::ne:
            // TODO: Is this necessary?
            return nullptr;
        case ICMPOP::sgt:
            break;
        case ICMPOP::sge:
            break;
        case ICMPOP::slt:
            break;
        case ICMPOP::sle:
            break;
        }
    }
    return nullptr;
}

TREC *SCEVHandle::getPoolTREC(const std::shared_ptr<TREC> &trec) {
    for (const auto &pool_trec : trec_pool) {
        if (*trec == *pool_trec)
            return pool_trec.get();
    }
    trec_pool.emplace_back(trec);
    return trec.get();
}

TREC *SCEVHandle::getSCEVExprTREC(SCEVExpr *expr) {
    auto trec = std::make_shared<TREC>(expr);
    return getPoolTREC(trec);
}

TREC *SCEVHandle::getAddRecTREC(const Loop *loop, TREC *base, TREC *step) {
    auto trec = std::make_shared<TREC>(TREC::AddRec{base, step, loop});
    return getPoolTREC(trec);
}
TREC *SCEVHandle::getTRECUndef() const { return trec_pool[0].get(); }
TREC *SCEVHandle::getTRECUntracked() const { return trec_pool[1].get(); }
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
    return getAddRecTREC(x->getLoop(), getTRECAdd(x->getBase(), y->getBase()), getTRECAdd(x->getStep(), y->getStep()));
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
    return getAddRecTREC(x->getLoop(), getTRECSub(x->getBase(), y->getBase()), getTRECSub(x->getStep(), y->getStep()));
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
    if ((x->isIRValue() && match(x->getIRValue(), M::Is(0))) || (y->isIRValue() && match(y->getIRValue(), M::Is(0))))
        return getSCEVExpr(function->getConst(0).get());
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Mul, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExpr(Value *x) { return getPoolSCEV(std::make_shared<SCEVExpr>(x)); }

SCEVHandle SCEVAnalysis::run(Function &func, FAM &fam) { return SCEVHandle(&func); }

} // namespace IR