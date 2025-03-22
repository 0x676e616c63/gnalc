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

std::optional<std::tuple<SCEVExpr *, SCEVExpr *>> TREC::getAffineAddRec() const {
    if (!isAddRec())
        return std::nullopt;
    if (!getBase()->isExpr() || !getStep()->isExpr())
        return std::nullopt;
    auto base_expr = getBase()->getExpr();
    auto step_expr = getStep()->getExpr();
    return std::make_tuple(base_expr, step_expr);
}

std::optional<std::tuple<int, int>> TREC::getConstantAffineAddRec() const {
    if (auto affine = getAffineAddRec()) {
        auto [base_expr, step_expr] = *affine;
        if (!base_expr->isIRValue() || !step_expr->isIRValue())
            return std::nullopt;
        auto base = base_expr->getIRValue();
        auto step = step_expr->getIRValue();
        if (base->getVTrait() == ValueTrait::CONSTANT_LITERAL && step->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            return std::make_tuple(dynamic_cast<ConstantInt *>(base)->getVal(),
                                   dynamic_cast<ConstantInt *>(step)->getVal());
    }
    return std::nullopt;
}

TREC *SCEVHandle::getSCEVAtBlock(Value *val, const BasicBlock *block) {
    // consistency check for debugging
    if (dynamic_cast<Instruction *>(val)) {
        auto def_block = dynamic_cast<Instruction *>(val)->getParent().get();
        if (!domtree->ADomB(def_block, const_cast<BasicBlock *>(block)))
            return nullptr;
    }
    auto scope = loop_info->getLoopFor(block).get();
    auto it = scoped_evolution[scope].find(val);
    if (it != scoped_evolution[scope].end())
        return it->second;
    auto res = getSCEVAtScope(val, scope);
    scoped_evolution[scope][val] = res;
    return res;
}

TREC *SCEVHandle::getSCEVAtScope(Value *val, const Loop *loop) {
    if (loop != nullptr)
        return instantiateEvolution(analyzeEvolution(loop, val), loop);

    if (auto inst = dynamic_cast<Instruction *>(val)) {
        TREC *t = nullptr;
        if (auto l = loop_info->getLoopFor(inst->getParent().get()))
            t = instantiateEvolution(analyzeEvolution(l.get(), val), l.get());
        if (!t)
            return getTRECUntracked();
        return eval(t, nullptr);
    }

    std::shared_ptr<Value> x, y;
    if (match(val, M::Add(M::VBind(x), M::VBind(y))) || match(val, M::Sub(M::VBind(x), M::VBind(y))) ||
        match(val, M::Mul(M::VBind(x), M::VBind(y)))) {
        TREC *tx = nullptr, *ty = nullptr;
        if (auto inst = std::dynamic_pointer_cast<Instruction>(x)) {
            if (auto lx = loop_info->getLoopFor(inst->getParent().get()))
                tx = instantiateEvolution(analyzeEvolution(lx.get(), x.get()), lx.get());
        }
        if (auto inst = std::dynamic_pointer_cast<Instruction>(y)) {
            if (auto ly = loop_info->getLoopFor(inst->getParent().get()))
                ty = instantiateEvolution(analyzeEvolution(ly.get(), y.get()), ly.get());
        }
        if (!tx)
            tx = getSCEVAtScope(x.get(), nullptr);
        if (!ty)
            ty = getSCEVAtScope(y.get(), nullptr);
        auto opcode = dynamic_cast<BinaryInst *>(val)->getOpcode();
        if (opcode == OP::ADD)
            return eval(getTRECAdd(tx, ty), nullptr);
        if (opcode == OP::SUB)
            return eval(getTRECSub(tx, ty), nullptr);
        if (opcode == OP::MUL)
            return eval(getTRECMul(tx, ty), nullptr);
        return getTRECUntracked();
    }
    if (auto phi = dynamic_cast<PHIInst *>(val)) {
        std::vector<TREC *> trecs;
        for (auto &[phi_val, _bb] : phi->getPhiOpers()) {
            auto phi_val_evo = getSCEVAtScope(phi_val.get(), nullptr);
            trecs.emplace_back(phi_val_evo);
        }
        auto res = trecs[0];
        for (const auto &trec : trecs) {
            if (res != trec)
                return getTRECUntracked();
        }
        return eval(res, nullptr);
    }
    return getTRECUntracked();
}

// Input: l the current loop, n the definition of an SSA name
// Output: TREC for the variable defined by n within l
TREC *SCEVHandle::analyzeEvolution(const Loop *loop, Value *val) {
    Err::gassert(loop != nullptr);
    Err::gassert(loop->isSimplifyForm(), "Expected LoopSimplified Form");
    // If Evolution[n] != ⊥ Then
    auto it = evolution.find(val);
    if (it != evolution.end())
        return eval(it->second, loop);

    auto inst_val = dynamic_cast<Instruction *>(val);
    if (!inst_val)
        return getSCEVExprTREC(getSCEVExpr(val));

    auto val_loop = loop_info->getLoopFor(inst_val->getParent().get()).get();

    TREC *res = nullptr;

    std::shared_ptr<Value> x, y;
    // Else If n matches "v = constant" Then
    if (val_loop == nullptr || loop->isLoopInvariant(val))
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
        if (val_loop->getHeader() == phi_bb) {
            // Since we are in simplified form, there is a single latch. Thus, the phi has two entries.
            Err::gassert(phi_opers.size() == 2, "Expected LoopSimplified Form");
            auto invariant = phi_opers[0].value.get();
            auto variant = phi_opers[1].value.get();
            if (!val_loop->isLoopInvariant(invariant))
                std::swap(invariant, variant);
            Err::gassert(val_loop->isLoopInvariant(invariant) && !val_loop->isLoopInvariant(variant),
                         "Expected LoopSimplified Form");

            auto [exist, update] = buildUpdateExpr(phi, variant, val_loop);
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
                auto phi_val_evo = instantiateEvolution(analyzeEvolution(loop, phi_val.get()), val_loop);
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
    } else if (match(val, M::Sub(M::VBind(x), M::VBind(y)))) {
        auto [exist_x, update_x] = buildUpdateExpr(loop_phi, x.get(), loop_phi_loop);
        if (exist_x) {
            auto neg = getSCEVExprNeg(getSCEVExpr(y.get()));
            return {true, getTRECAdd(update_x, getSCEVExprTREC(neg))};
        }
        auto [exist_y, update_y] = buildUpdateExpr(loop_phi, y.get(), loop_phi_loop);
        if (exist_y) {
            auto neg = getTRECNeg(update_y);
            return {true, getTRECAdd(neg, getSCEVExprTREC(getSCEVExpr(x.get())))};
        }
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

            auto s = apply(analyzeEvolution(val_phi_loop, val), getNumberOfLatchExecutions(val_phi_loop));
            if (!s)
                return {false, getTRECUndef()};
            if (s->isBinary() && s->getOp() == SCEVExpr::Binary::Op::Add && s->getLHS()->isIRValue() &&
                s->getLHS()->getIRValue() == val_phi_invariant) {
                auto [exist, update] = buildUpdateExpr(loop_phi, val_phi_invariant, loop_phi_loop);
                if (exist)
                    return {true, getTRECAdd(update, getSCEVExprTREC(s->getRHS()))};
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
    std::unordered_set<TREC *> temp;
    return instantiateEvolutionImpl(trec, loop, temp);
}

TREC *SCEVHandle::instantiateEvolutionImpl(TREC *trec, const Loop *loop, std::unordered_set<TREC *> &instantiated) {
    // If trec is a constant c Then
    if (trec->isExpr() && trec->getExpr()->isIRValue() &&
        trec->getExpr()->getIRValue()->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        return trec;

    if (trec->isExpr()) {
        // Else If trec is a variable already instantiated Then
        // TODO: resolve mixers
        if (instantiated.count(trec))
            return getTRECUntracked();
        instantiated.emplace(trec);

        // Else If trec is a variable v Then
        auto expr = trec->getExpr();
        std::function<TREC *(SCEVExpr *)> analyzeExprEvo;
        analyzeExprEvo = [this, &loop, &analyzeExprEvo](SCEVExpr *expr) -> TREC * {
            if (expr->isBinary()) {
                auto lhs = analyzeExprEvo(expr->getLHS());
                auto rhs = analyzeExprEvo(expr->getRHS());
                return getTRECAdd(lhs, rhs);
            }
            Err::gassert(expr->isIRValue());
            return analyzeEvolution(loop, expr->getIRValue());
        };
        return analyzeExprEvo(trec->getExpr());
    }

    if (trec->isAddRec()) {
        auto e1 = trec->getBase();
        auto e2 = trec->getStep();
        return getAddRecTREC(loop, instantiateEvolutionImpl(e1, loop, instantiated),
                             instantiateEvolutionImpl(e2, loop, instantiated));
    }

    // TODO: Periodic TREC

    return getTRECUntracked();
}

void SCEVHandle::foldSCEVExpr(SCEVExpr *expr) const {
    if (expr->isBinary()) {
        auto lhs = expr->getLHS();
        auto rhs = expr->getRHS();
        foldSCEVExpr(lhs);
        foldSCEVExpr(rhs);
        if (lhs->isIRValue() && rhs->isIRValue()) {
            int x, y;
            if (match(lhs->getIRValue(), M::I32Bind(x)) && match(rhs->getIRValue(), M::I32Bind(y))) {
                switch (expr->getOp()) {
                case SCEVExpr::Binary::Op::Add:
                    expr->setIRValue(function->getConst(x + y).get());
                    break;
                case SCEVExpr::Binary::Op::Sub:
                    expr->setIRValue(function->getConst(x - y).get());
                    break;
                case SCEVExpr::Binary::Op::Mul:
                    expr->setIRValue(function->getConst(x * y).get());
                    break;
                default:
                    Err::unreachable();
                }
            }
        }
    }
}

TREC *SCEVHandle::eval(TREC *trec, const Loop *loop) {
    if (trec->isExpr()) {
        foldSCEVExpr(trec->getExpr());
        return trec;
    }
    if (!trec->isAddRec())
        return trec;

    // First fold it.
    std::vector stack{trec};
    while (!stack.empty()) {
        auto curr = stack.back();
        stack.pop_back();

        if (curr->isAddRec()) {
            stack.emplace_back(curr->getStep());
            stack.emplace_back(curr->getBase());
        } else if (curr->isExpr())
            foldSCEVExpr(curr->getExpr());
        else if (curr->isUntracked())
            return getTRECUntracked();
        else
            return trec;
    }

    if (trec->getLoop() == loop)
        return trec;

    if (!trec->getLoop()->contains(loop)) {
        auto e = apply(trec, getNumberOfLatchExecutions(trec->getLoop()));
        if (!e)
            return trec;
        return getSCEVExprTREC(e);
    }

    return trec;
}

// (n)         n!
// ( ) == ------------
// (p)     p!(n - p)!
template <typename T> constexpr T binomial_coefficient(T n, T p) {
    return std::tgamma(n + 1) / (std::tgamma(p + 1) * std::tgamma(n - p + 1));
}

// { c0, +, c1, +, c2, +, ..., +, cn }_x(l_x)
//   == c0 * binomial_coe(trip_cnt, 0) + c1 * binomial_coe(trip_cnt, 1) + ...
// Note that we reserve c0 as its original expression.
// For example:
// trec: { a, +, 7 } trip_cnt: 5
// Output: (a + 35)
// TODO: Currently we only support constant trip count and constant TREC (except the first item).
//       Support for symbolic representation of the applied TREC should be set up in the future.
SCEVExpr *SCEVHandle::apply(TREC *trec, SCEVExpr *trip_cnt) {
    if (!trip_cnt)
        return nullptr;
    if (!trec->isAddRec())
        return nullptr;

    // Currently we only apply the trec if the result is a compile-time constant.
    // TODO: Symbolic representation of applied TREC
    if (trip_cnt->isIRValue() && trip_cnt->getIRValue()->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
        int constant_trip_cnt = -1;
        if (!match(trip_cnt->getIRValue(), M::I32Bind(constant_trip_cnt)))
            return nullptr;
        // Avoid too big trip count
        if (constant_trip_cnt > 1024)
            return nullptr;
        // {{ c0, c1 }, +, { c2 + c3 }} -> { c0, c1, c2, c3 }
        std::vector<SCEVExpr *> flatten;
        std::vector stack{trec};
        while (!stack.empty()) {
            auto curr = stack.back();
            stack.pop_back();

            if (curr->isAddRec()) {
                stack.emplace_back(curr->getStep());
                stack.emplace_back(curr->getBase());
            } else if (curr->isExpr())
                flatten.emplace_back(curr->getExpr());
            else
                return nullptr;
        }

        std::vector<int> constants;
        for (size_t i = 1; i < flatten.size(); ++i) {
            int ci;
            if (!flatten[i]->isIRValue() || !match(flatten[i]->getIRValue(), M::I32Bind(ci)))
                return nullptr;
            constants.emplace_back(ci);
        }
        for (int p = 0; p < constants.size(); ++p)
            constants[p] *= binomial_coefficient(constant_trip_cnt, p + 1);
        auto cres = std::accumulate(constants.begin(), constants.end(), 0);
        return getSCEVExprAdd(flatten[0], getSCEVExpr(function->getConst(cres).get()));
    }
    return nullptr;
}

// TODO: Symbolic trip count
SCEVExpr *SCEVHandle::getNumberOfLatchExecutions(const Loop *loop) {
    auto latch = loop->getLatch();
    Err::gassert(latch != nullptr, "Expected LoopSimplified Form.");

    auto exitings = loop->getExitingBlocks();
    if (exitings.size() != 1)
        return nullptr;
    auto exiting = *exitings.begin();

    bool latch_exiting = exiting == latch;

    auto guard = exiting->getBRInst();
    Err::gassert(guard != nullptr && guard->isConditional());
    auto cond_inst = guard->getCond();
    if (auto icmp = std::dynamic_pointer_cast<ICMPInst>(cond_inst)) {
        if (int x, y; match(icmp, M::Icmp(M::I32Bind(x), M::I32Bind(y)))) {
            if (x == y)
                return nullptr;
            return getSCEVExpr(function->getConst(0).get());
        }

        auto cmpop = icmp->getCond();
        if (!loop->contains(guard->getTrueDest().get()))
            cmpop = flipCond(cmpop);
        auto to_evo = icmp->getLHS().get();
        auto invariant = icmp->getRHS().get();
        // If the RHS is not an invariant, reverse it.
        if (!loop->isLoopInvariant(invariant)) {
            // Give up if there is no invariant in the cmp.
            if (!loop->isLoopInvariant(to_evo))
                return nullptr;
            std::swap(to_evo, invariant);
            cmpop = reverseCond(cmpop);
        }

        if (cmpop == ICMPOP::eq || cmpop == ICMPOP::ne)
            return nullptr;

        auto evo = analyzeEvolution(loop, to_evo);
        auto cond = getSCEVExpr(invariant);
        // If this is a constant affine, the number of iterations can be precisely calculated.
        // { 0, +, 1 } < x ---> (x - 0) / 1 ---> x iterations
        auto constant_cond = dynamic_cast<ConstantInt *>(invariant);
        auto constant_affine = evo->getConstantAffineAddRec();
        if (constant_affine && constant_cond) {
            auto [base, step] = *constant_affine;
            auto cond_val = constant_cond->getVal();

            // Trivial cases
            if ((cmpop == ICMPOP::sgt && step <= 0 && base <= cond_val) ||
                (cmpop == ICMPOP::slt && step >= 0 && base >= cond_val) ||
                (cmpop == ICMPOP::sge && step <= 0 && base < cond_val) ||
                (cmpop == ICMPOP::sle && step >= 0 && base > cond_val))
                return getSCEVExpr(function->getConst(0).get());

            // Infinite
            if ((cmpop == ICMPOP::sgt && step >= 0 && base > cond_val) ||
                (cmpop == ICMPOP::slt && step <= 0 && base < cond_val) ||
                (cmpop == ICMPOP::sge && step >= 0 && base >= cond_val) ||
                (cmpop == ICMPOP::sle && step <= 0 && base <= cond_val))
                return nullptr;

            // {base, +, step} <=> cond_val
            // base + n * step <=> cond_val
            // n <=> (cond_val - base) / step
            int path_taken_times = (cond_val - base) / step;

            // We've handled trivial cases above, there should always be a non-negative count.
            Err::gassert(path_taken_times >= 0);

            if (cmpop == ICMPOP::sge || cmpop == ICMPOP::sle)
                ++path_taken_times;

            // Do while loop executes at least once
            if (latch_exiting)
                ++path_taken_times;
            return getSCEVExpr(function->getConst(path_taken_times).get());
        }
        // Not a constant affine + constant cond
        // { a, +, b } < x ---> ( x - a ) / b
        if (auto affine = evo->getAffineAddRec()) {
            // Currently we only handle the cases where the step is constant 1,
            // where the trip count is simply x - a.
            auto [base, step] = *affine;
            if (!step->isIRValue() || !match(step->getIRValue(), M::Is(1)))
                return nullptr;
            return getSCEVExprSub(cond, base);
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
        return getAddRecTREC(y->getLoop(), getTRECAdd(y->getBase(), x), y->getStep());
    Err::gassert(x->isAddRec() && y->isAddRec());
    if (x->getLoop() != y->getLoop())
        return getTRECUntracked();
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
        return getAddRecTREC(y->getLoop(), getTRECSub(x, y->getBase()), y->getStep());
    Err::gassert(x->isAddRec() && y->isAddRec());
    if (x->getLoop() != y->getLoop())
        return getTRECUntracked();
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
        return getAddRecTREC(y->getLoop(), getTRECMul(y->getBase(), x), getTRECMul(y->getStep(), x));
    Err::gassert(x->isAddRec() && y->isAddRec());
    if (x->getLoop() != y->getLoop())
        return getTRECUntracked();
    auto new_base = getTRECMul(x->getBase(), y->getBase());
    auto new_step = getTRECAdd(getTRECAdd(getTRECMul(x, y->getStep()), getTRECMul(y, x->getStep())),
                               getTRECMul(x->getStep(), y->getStep()));
    return getAddRecTREC(x->getLoop(), new_base, new_step);
}
TREC *SCEVHandle::getTRECNeg(TREC *x) {
    return getTRECSub(getSCEVExprTREC(getSCEVExpr(function->getConst(0).get())), x);
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
    if (x->isIRValue() && y->isIRValue()) {
        int a, b;
        if (match(x->getIRValue(), M::I32Bind(a)) && match(y->getIRValue(), M::I32Bind(b)))
            return getSCEVExpr(function->getConst(a + b).get());
    }
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Add, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprSub(SCEVExpr *x, SCEVExpr *y) {
    if (y->isIRValue() && match(y->getIRValue(), M::Is(0)))
        return x;
    if (x->isIRValue() && y->isIRValue()) {
        int a, b;
        if (match(x->getIRValue(), M::I32Bind(a)) && match(y->getIRValue(), M::I32Bind(b)))
            return getSCEVExpr(function->getConst(a - b).get());
    }
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Sub, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprMul(SCEVExpr *x, SCEVExpr *y) {
    if ((x->isIRValue() && match(x->getIRValue(), M::Is(0))) || (y->isIRValue() && match(y->getIRValue(), M::Is(0))))
        return getSCEVExpr(function->getConst(0).get());
    if (x->isIRValue() && y->isIRValue()) {
        int a, b;
        if (match(x->getIRValue(), M::I32Bind(a)) && match(y->getIRValue(), M::I32Bind(b)))
            return getSCEVExpr(function->getConst(a * b).get());
    }
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Mul, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprNeg(SCEVExpr *x) {
    if (int a; x->isIRValue() && match(x->getIRValue(), M::I32Bind(a)))
        return getSCEVExpr(function->getConst(-a).get());
    return getSCEVExprSub(getSCEVExpr(function->getConst(0).get()), x);
}
SCEVExpr *SCEVHandle::getSCEVExpr(Value *x) { return getPoolSCEV(std::make_shared<SCEVExpr>(x)); }

SCEVHandle SCEVAnalysis::run(Function &func, FAM &fam) {
    return SCEVHandle(&func, &fam.getResult<LoopAnalysis>(func), &fam.getResult<DomTreeAnalysis>(func));
}

} // namespace IR