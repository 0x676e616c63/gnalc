// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/analysis/scev.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/match.hpp"
#include "../../../../include/ir/block_utils.hpp"

#include <algorithm>
#include <cmath>
#include <numeric>
#include <string>

namespace IR {
PM::UniqueKey SCEVAnalysis::Key;

std::ostream &operator<<(std::ostream &os, const SCEVExpr &expr) {
    using Op = SCEVExpr::Binary::Op;
    if (expr.isBinary()) {
        std::string op;
        if (expr.getOp() == Op::Add)
            op = "+";
        else if (expr.getOp() == Op::Sub)
            op = "-";
        else if (expr.getOp() == Op::Mul)
            op = "*";
        else if (expr.getOp() == Op::Div)
            op = "/";
        else
            Err::unreachable();
        os << "( " << *expr.getLHS() << " " << op << " " << *expr.getRHS() << " )";
    } else if (expr.isIRValue())
        os << expr.getRawIRValue()->getName();
    else
        Err::unreachable();
    return os;
}

std::ostream &operator<<(std::ostream &os, const TREC &trec) {
    if (trec.isExpr())
        os << *trec.getExpr();
    else if (trec.isAddRec())
        os << "{ " << *trec.getBase() << ", +, " << *trec.getStep() << " }_" << trec.getLoop()->getHeader()->getName();
    else if (trec.isPeeled())
        os << "( " << *trec.getFirst() << ", " << *trec.getRest() << " )_" << trec.getLoop()->getHeader()->getName();
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

SCEVExpr *TREC::getFirst() const {
    Err::gassert(isPeeled());
    return std::get<Peeled>(value).first;
}
TREC *TREC::getRest() const {
    Err::gassert(isPeeled());
    return std::get<Peeled>(value).rest;
}

const Loop *TREC::getLoop() const {
    Err::gassert(isAddRec() || isPeeled());
    if (isAddRec())
        return std::get<AddRec>(value).loop;
    return std::get<Peeled>(value).loop;
}

bool TREC::isExpr() const { return type == TRECType::Expr; }
bool TREC::isAddRec() const { return type == TRECType::AddRec; }
bool TREC::isPeeled() const { return type == TRECType::Peeled; }
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
        auto base = base_expr->getRawIRValue();
        auto step = step_expr->getRawIRValue();
        if (base->getVTrait() == ValueTrait::CONSTANT_LITERAL && step->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            return std::make_tuple(base->as_raw<ConstantInt>()->getVal(),
                                   step->as_raw<ConstantInt>()->getVal());
    }
    return std::nullopt;
}

TREC *SCEVHandle::getSCEVAtBlock(Value *val, const BasicBlock *block) {
    if (val->is<Instruction>()) {
        auto def_block = val->as_raw<Instruction>()->getParent().get();
        if (!domtree->ADomB(def_block, block))
            return nullptr;
    }
    auto scope = loop_info->getLoopFor(block).get();
    return getSCEVAtScope(val, scope);
}

TREC *SCEVHandle::getSCEVAtBlock(const pVal &val, const pBlock &block) {
    return getSCEVAtBlock(val.get(), block.get());
}

TREC *SCEVHandle::getSCEVAtScope(Value *val, const Loop *loop) {
    auto it = scoped_evolution[loop].find(val);
    if (it != scoped_evolution[loop].end() && !it->second->isUntracked())
        return it->second;
    auto res = getSCEVAtScopeImpl(val, loop);
    scoped_evolution[loop][val] = res;
    return res;
}
TREC *SCEVHandle::getSCEVAtScope(const pVal& val, const pLoop &loop) {
    return getSCEVAtScope(val.get(), loop.get());
}
SCEVExpr *SCEVHandle::getBackEdgeTakenCount(const pLoop &loop, RangeResult *ranges) {
    return getBackEdgeTakenCount(loop.get(), ranges);
}

SCEVExpr *SCEVHandle::getTripCount(const pLoop &loop, RangeResult *ranges) {
    return getTripCount(loop.get(), ranges);
}

pVal SCEVHandle::expandSCEVExpr(SCEVExpr *expr, const pBlock &block, BasicBlock::iterator insert_before) const {
    std::map<SCEVExpr *, pVal> inserted;
    auto ret = expandSCEVExprImpl(expr, block, insert_before, inserted);
    if (ret == nullptr) {
        for (const auto &[k, v] : inserted) {
            auto inst = v->as<Instruction>();
            block->delFirstOfInst(inst);
        }
    }
    return ret;
}

pVal SCEVHandle::expandSCEVExpr(SCEVExpr *expr, const pBlock &block) const {
    return expandSCEVExpr(expr, block, block->getTerminator()->iter());
}

pVal SCEVHandle::expandSCEVExprImpl(SCEVExpr *expr, const pBlock &block, BasicBlock::iterator insert_before,
                                    std::map<SCEVExpr *, pVal> &inserted) const {
    static size_t name_cnt = 0;

    // We only reuse IR Value that is inserted by expandSCEVExprImpl, they are always safe to
    // reuse at this point. Redundancy will be eliminated by GVN-PRE later.
    // Besides, reusing IR Value in loops can leave a no side effect Loop can not be eliminated.
    auto it = inserted.find(expr);
    if (it != inserted.end())
        return it->second;

    if (expr->isIRValue()) {
        auto ir_val = expr->getIRValue();
        if (auto inst = ir_val->as<Instruction>()) {
            if (!domtree->ADomB(inst->getParent(), block))
                return nullptr;
        }
        return ir_val;
    }
    if (expr->isBinary()) {
        auto lhs = expandSCEVExprImpl(expr->getLHS(), block, insert_before, inserted);
        if (!lhs)
            return nullptr;
        auto rhs = expandSCEVExprImpl(expr->getRHS(), block, insert_before, inserted);
        if (!rhs)
            return nullptr;
        OP ir_op = OP::ADD;
        switch (expr->getOp()) {
        case SCEVExpr::Binary::Op::Add:
            ir_op = OP::ADD;
            break;
        case SCEVExpr::Binary::Op::Sub:
            ir_op = OP::SUB;
            break;
        case SCEVExpr::Binary::Op::Mul:
            ir_op = OP::MUL;
            break;
        case SCEVExpr::Binary::Op::Div:
            ir_op = OP::DIV;
            break;
        default:
            Err::unreachable();
        }
        auto inst = std::make_shared<BinaryInst>("%scev.e" + std::to_string(name_cnt++), ir_op, lhs, rhs);
        inserted[expr] = inst;
        block->addInst(insert_before, inst);
        return inst;
    }
    Err::unreachable();
    return nullptr;
}

pPhi SCEVHandle::expandAddRec(TREC *addrec) {
    static size_t name_cnt = 0;
    auto loop = addrec->getLoop();

    if (!loop->getRawPreHeader() || !loop->getRawLatch())
        return nullptr;

    if (!addrec->isAddRec())
        return nullptr;

    // Only handle single exit
    if (loop->getExitBlocks().size() != 1)
        return nullptr;

    auto preheader = loop->getPreHeader();
    auto header = loop->getHeader();
    auto latch = loop->getLatch();
    auto base = addrec->getBase();
    auto step = addrec->getStep();

    if (!step->isExpr())
        return nullptr;
    auto step_expr = step->getExpr();

    auto base_expr = eval(base, loop_info->getLoopFor(preheader).get());
    if (!base_expr->isExpr())
        return nullptr;
    auto base_val = expandSCEVExpr(base_expr->getExpr(), preheader);
    if (!base_val)
        return nullptr;

    auto step_val = expandSCEVExpr(step_expr, latch);
    if (!step_val && base_val->is<Instruction>()) {
        eliminateDeadInsts(base_val->as<Instruction>());
        return nullptr;
    }

    auto indvar = std::make_shared<PHIInst>("%scev.p" + std::to_string(name_cnt++), base_val->getType());
    auto update = std::make_shared<BinaryInst>("%scev.a" + std::to_string(name_cnt++), OP::ADD, indvar, step_val);

    indvar->addPhiOper(base_val, preheader);
    indvar->addPhiOper(update, latch);
    header->addPhiInst(indvar);

    latch->addInst(latch->getEndInsertPoint(), update);

    return indvar;
}

std::optional<size_t> SCEVHandle::estimateExpansionCost(SCEVExpr *expr, const pBlock &block) const {
    std::set<SCEVExpr *> visited;
    return estimateExpansionCostImpl(expr, block, visited);
}

std::optional<size_t> SCEVHandle::estimateExpansionCostImpl(SCEVExpr *expr, const pBlock &block,
                                                            std::set<SCEVExpr *> &visited) const {
    auto it = visited.find(expr);
    if (it != visited.end())
        return 0;

    if (expr->isIRValue()) {
        auto ir_val = expr->getIRValue();
        if (auto inst = ir_val->as<Instruction>()) {
            if (!domtree->ADomB(inst->getParent(), block))
                return std::nullopt;
        }
        return 0;
    }
    if (expr->isBinary()) {
        auto lhs = estimateExpansionCostImpl(expr->getLHS(), block, visited);
        if (!lhs)
            return std::nullopt;
        auto rhs = estimateExpansionCostImpl(expr->getRHS(), block, visited);
        if (!rhs)
            return std::nullopt;
        visited.emplace(expr);
        return *lhs + *rhs + 1;
    }
    return std::nullopt;
}


pVal SCEVHandle::expandSCEVExprUnchecked(SCEVExpr *expr, const pBlock &block,
                                         BasicBlock::iterator insert_before) const {
    std::map<SCEVExpr *, pVal> inserted;
    return expandSCEVExprUncheckedImpl(expr, block, insert_before, inserted);
}

pVal SCEVHandle::expandSCEVExprUncheckedImpl(SCEVExpr *expr, const pBlock &block, BasicBlock::iterator insert_before,
                                             std::map<SCEVExpr *, pVal> &inserted) const {
    static size_t name_cnt = 0;

    // We only reuse IR Value that is inserted by expandSCEVExprUncheckedImpl, they are always safe to
    // reuse at this point. Redundancy will be eliminated by GVN-PRE later.
    // Besides, reusing IR Value in loops can leave a no side effect Loop can not be eliminated.
    auto it = inserted.find(expr);
    if (it != inserted.end())
        return it->second;

    if (expr->isIRValue())
        return expr->getIRValue();
    if (expr->isBinary()) {
        auto lhs = expandSCEVExprUncheckedImpl(expr->getLHS(), block, insert_before, inserted);
        auto rhs = expandSCEVExprUncheckedImpl(expr->getRHS(), block, insert_before, inserted);
        OP ir_op = OP::ADD;
        switch (expr->getOp()) {
        case SCEVExpr::Binary::Op::Add:
            ir_op = OP::ADD;
            break;
        case SCEVExpr::Binary::Op::Sub:
            ir_op = OP::SUB;
            break;
        case SCEVExpr::Binary::Op::Mul:
            ir_op = OP::MUL;
            break;
        case SCEVExpr::Binary::Op::Div:
            ir_op = OP::DIV;
            break;
        default:
            Err::unreachable();
        }
        auto inst = std::make_shared<BinaryInst>("%scev.e" + std::to_string(name_cnt++), ir_op, lhs, rhs);
        inserted[expr] = inst;
        block->addInst(insert_before, inst);
        return inst;
    }
    Err::unreachable();
    return nullptr;
}

size_t SCEVHandle::estimateExpansionCostUnchecked(SCEVExpr *expr, const pBlock &block) const {
    std::set<SCEVExpr *> visited;
    return estimateExpansionCostUncheckedImpl(expr, block, visited);
}

size_t SCEVHandle::estimateExpansionCostUncheckedImpl(SCEVExpr *expr, const pBlock &block,
                                                                     std::set<SCEVExpr *> &visited) const {
    auto it = visited.find(expr);
    if (it != visited.end())
        return 0;

    if (expr->isIRValue())
        return 0;
    if (expr->isBinary()) {
        auto lhs = estimateExpansionCostUncheckedImpl(expr->getLHS(), block, visited);
        auto rhs = estimateExpansionCostUncheckedImpl(expr->getRHS(), block, visited);
        visited.emplace(expr);
        return lhs + rhs + 1;
    }

    Err::unreachable();
    return 0;
}

std::optional<size_t> SCEVHandle::estimateExpansionCost(TREC *addrec) {
    auto loop = addrec->getLoop();

    if (!loop->getRawPreHeader() || !loop->getRawLatch())
        return std::nullopt;

    if (!addrec->isAddRec())
        return std::nullopt;

    // Only handle single exit
    if (loop->getExitBlocks().size() != 1)
        return std::nullopt;

    auto preheader = loop->getPreHeader();
    auto header = loop->getHeader();
    auto latch = loop->getLatch();
    auto base = addrec->getBase();
    auto step = addrec->getStep();

    if (!step->isExpr())
        return std::nullopt;
    auto step_expr = step->getExpr();

    auto base_expr = eval(base, loop_info->getLoopFor(preheader).get());
    if (!base_expr->isExpr())
        return std::nullopt;
    auto base_val = estimateExpansionCost(base_expr->getExpr(), preheader);
    if (!base_val)
        return std::nullopt;

    auto step_val = estimateExpansionCost(step_expr, latch);
    if (!step_val)
        return std::nullopt;

    // Base + Step + Update + Phi
    return *base_val + *step_val + 2;
}

void SCEVHandle::forgetAll() {
    evolution.clear();
    scoped_evolution.clear();
}

TREC *SCEVHandle::getSCEVAtScopeImpl(Value *val, const Loop *loop) {
    if (loop != nullptr)
        return instantiateEvolution(analyzeEvolution(loop, val), loop);

    auto inst = val->as_raw<Instruction>();
    if (!inst)
        return getIRValTREC(val);
    if (auto l = loop_info->getLoopFor(inst->getParent().get())) {
        auto t = instantiateEvolution(analyzeEvolution(l.get(), val), l.get());
        if (!t)
            return getTRECUntracked();
        return eval(t, nullptr);
    }

    pVal x, y;
    if (match(val, M::Add(M::Bind(x), M::Bind(y))) ||
        match(val, M::Sub(M::Bind(x), M::Bind(y))) ||
        match(val, M::Mul(M::Bind(x), M::Bind(y)))) {
        TREC *tx = nullptr, *ty = nullptr;
        if (auto inst_x = x->as<Instruction>()) {
            if (auto lx = loop_info->getLoopFor(inst_x->getParent().get()))
                tx = instantiateEvolution(analyzeEvolution(lx.get(), x.get()), lx.get());
        }
        if (auto inst_y = y->as<Instruction>()) {
            if (auto ly = loop_info->getLoopFor(inst_y->getParent().get()))
                ty = instantiateEvolution(analyzeEvolution(ly.get(), y.get()), ly.get());
        }
        if (!tx)
            tx = getSCEVAtScope(x.get(), nullptr);
        if (!ty)
            ty = getSCEVAtScope(y.get(), nullptr);
        auto opcode = val->as_raw<BinaryInst>()->getOpcode();
        if (opcode == OP::ADD)
            return eval(getTRECAdd(tx, ty), nullptr);
        if (opcode == OP::SUB)
            return eval(getTRECSub(tx, ty), nullptr);
        if (opcode == OP::MUL)
            return eval(getTRECMul(tx, ty), nullptr);
        return getTRECUntracked();
    }
    if (auto phi = val->as_raw<PHIInst>()) {
        std::vector<TREC *> trecs;
        for (const auto &[phi_val, _bb] : phi->incomings()) {
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
    if (!loop->getRawPreHeader() || !loop->getRawLatch())
        return getTRECUntracked();

    // If n matches "v = constant" Then
    auto inst_val = val->as_raw<Instruction>();
    if (!inst_val)
        return getIRValTREC(val);

    // Handle LCSSA phi
    if (auto phi = val->as<PHIInst>())
        if (isLCSSAPhi(phi))
            return analyzeEvolution(loop, phi->getPhiOpers().front().value.get());

    auto val_loop = loop_info->getLoopFor(inst_val->getParent().get()).get();
    if (val_loop == nullptr)
        return getIRValTREC(val);

    // If Evolution[n] != ⊥ Then
    auto it = evolution.find(val);
    if (it != evolution.end()) {
        auto eval_res = eval(it->second, loop);
        // For a loop invariant, if its value can not be calculated statically,
        // consider it as a runtime constant (or loop invariant, IRValTREC).
        if (loop->isTriviallyInvariant(val) && !eval_res->isExpr()) {
            if (!loop->isOutermost()) {
                // See if it has already been figured out a constant by parent loop.
                auto parent_evo = getSCEVAtScope(val, loop->getParent().get());
                if (parent_evo->isExpr())
                    return parent_evo;
            }
            return getIRValTREC(val);
        }
        return eval_res;
    }

    TREC *res = nullptr;
    pVal x, y;
    // If n matches "v = a ⊙ b" (with ⊙ ∈ {+, −, ∗}) Then
    if (match(val, M::Add(M::Bind(x), M::Bind(y))))
        res = getTRECAdd(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (match(val, M::Sub(M::Bind(x), M::Bind(y))))
        res = getTRECSub(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (match(val, M::Mul(M::Bind(x), M::Bind(y))))
        res = getTRECMul(analyzeEvolution(loop, x.get()), analyzeEvolution(loop, y.get()));
    else if (auto phi = val->as_raw<PHIInst>()) {
        auto phi_bb = phi->getParent();
        // Else If n matches "v = loop-phi(a, b)" Then
        bool is_loop_phi = loop->getHeader() == phi_bb && analyzeHeaderPhi(val_loop, phi).has_value();
        if (is_loop_phi) {
            // Since loop->header == phi_bb ---> loop == phi_loop
            Err::gassert(val_loop == loop);
            auto [invariant, variant] = *analyzeHeaderPhi(val_loop, phi);

            auto [exist, update] = buildUpdateExpr(phi, variant, val_loop);
            if (!exist)
                res = getPeeledTREC(loop, getSCEVExpr(invariant), getIRValTREC(variant));
            else if (update->isUntracked())
                res = getTRECUntracked();
            else if (update->isUndef()) {
                Err::unreachable();
                res = getTRECUntracked();
            } else
                res = getAddRecTREC(loop, getIRValTREC(invariant), update);
        }
        // Else If n matches "v = condition-phi(a, b)" Then
        else if (val_loop->getHeader() != phi_bb) {
            std::vector<TREC *> trecs;
            for (const auto &[phi_val, _bb] : phi->incomings()) {
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
        else
            res = getTRECUntracked();
    } else if (auto select = val->as_raw<SELECTInst>()) {
        auto tevo = instantiateEvolution(analyzeEvolution(loop, select->getTrueVal().get()), val_loop);
        auto fevo = instantiateEvolution(analyzeEvolution(loop, select->getFalseVal().get()), val_loop);
        if (tevo == fevo)
            res = tevo;
        else
            res = getTRECUntracked();
    } else
        res = getTRECUntracked();

    Err::gassert(res != nullptr);
    // FIXME: Will `val->is<PHIInst>()` degrade accuracy?
    //        Though it can speed up the analysis significantly
    if (val->is<PHIInst>() || (!res->isUntracked() && !res->isUndef()))
        evolution[val] = res;

    auto eval_res = eval(res, loop);
    if (loop->isTriviallyInvariant(val) && !eval_res->isExpr())
        return getIRValTREC(val);
    return eval_res;
}

// Input: h the halting loop-phi, n the definition of an SSA name
// Output: (exist, update), exist is true if h has been reached,
// update is the reconstructed expression for the overall effect in the loop of h
std::pair<bool, TREC *> SCEVHandle::buildUpdateExpr(const PHIInst *loop_phi, Value *val, const Loop *loop_phi_loop) {
    // If (n is h) Then
    if (loop_phi == val)
        return {true, getIRValTREC(function->getConst(0).get())};
    // Else If n is a statement in an outer loop Then
    if (loop_phi_loop->isTriviallyInvariant(val))
        return {false, getTRECUndef()};
    pVal x, y;
    // Else If n matches "v = a + b" Then
    if (match(val, M::Add(M::Bind(x), M::Bind(y)))) {
        auto [exist_x, update_x] = buildUpdateExpr(loop_phi, x.get(), loop_phi_loop);
        auto [exist_y, update_y] = buildUpdateExpr(loop_phi, y.get(), loop_phi_loop);
        if (exist_x && exist_y)
            return {false, getTRECUndef()};
        if (exist_x)
            return {true, getTRECAdd(update_x, getIRValTREC(y.get()))};
        if (exist_y)
            return {true, getTRECAdd(update_y, getIRValTREC(x.get()))};
        return {false, getTRECUndef()};
    }
    if (match(val, M::Sub(M::Bind(x), M::Bind(y)))) {
        auto [exist_x, update_x] = buildUpdateExpr(loop_phi, x.get(), loop_phi_loop);
        auto [exist_y, update_y] = buildUpdateExpr(loop_phi, y.get(), loop_phi_loop);
        if (exist_x && exist_y)
            return {false, getTRECUndef()};
        if (exist_x) {
            auto neg = getSCEVExprNeg(getSCEVExpr(y.get()));
            return {true, getTRECAdd(update_x, getExprTREC(neg))};
        }
        if (exist_y) {
            auto neg = getTRECNeg(update_y);
            return {true, getTRECAdd(neg, getIRValTREC(x.get()))};
        }
        return {false, getTRECUndef()};
    }

    if (auto val_phi = val->as_raw<PHIInst>()) {
        auto val_phi_bb = val_phi->getParent();
        auto val_phi_loop = loop_info->getLoopFor(val_phi_bb).get();

        // Else If n matches "v = loop-phi(a, b)" Then
        bool is_loop_phi = val_phi_loop && val_phi_loop->getHeader() == val_phi_bb &&
            analyzeHeaderPhi(val_phi_loop, val_phi).has_value();
        if (is_loop_phi) {
            auto [val_phi_invariant, val_phi_variant] = *analyzeHeaderPhi(val_phi_loop, val_phi);

            if (loop_phi_loop->isTriviallyInvariant(val_phi_invariant))
                return {false, getTRECUndef()};

            auto s = apply(analyzeEvolution(val_phi_loop, val), getTripCount(val_phi_loop));
            if (!s)
                return {false, getTRECUndef()};
            if (s->isBinary() && s->getLHS()->isIRValue() && s->getLHS()->getRawIRValue() == val_phi_variant) {
                auto [exist, update] = buildUpdateExpr(loop_phi, val_phi_invariant, loop_phi_loop);
                if (exist) {
                    if (s->getOp() == SCEVExpr::Binary::Op::Add)
                        return {true, getTRECAdd(update, getExprTREC(s->getRHS()))};
                    if (s->getOp() == SCEVExpr::Binary::Op::Sub)
                        return {true, getTRECAdd(update, getExprTREC(getSCEVExprNeg(s->getRHS())))};
                }
            }
            return {false, getTRECUndef()};
        }

        // Else If n matches "v = condition-phi(a, b)" Then
        for (const auto &[v, b] : val_phi->incomings()) {
            auto [exist, update] = buildUpdateExpr(loop_phi, v.get(), loop_phi_loop);
            if (exist)
                return {true, getTRECUntracked()};
        }

        return {false, getTRECUndef()};
    }

    if (auto select = val->as_raw<SELECTInst>()) {
        auto [t_exist, t_update] = buildUpdateExpr(loop_phi, select->getTrueVal().get(), loop_phi_loop);
        if (t_exist)
            return {true, getTRECUntracked()};
        auto [f_exist, f_update] = buildUpdateExpr(loop_phi, select->getFalseVal().get(), loop_phi_loop);
        if (f_exist)
            return {true, getTRECUntracked()};

        return {false, getTRECUndef()};
    }

    return {false, getTRECUndef()};
}

// Input: trec a symbolic TREC, l the instantiation loop
// Output: an instantiation of trec
TREC *SCEVHandle::instantiateEvolution(TREC *trec, const Loop *loop) {
    static std::vector<std::unordered_set<TREC *>> temp;
    temp.emplace_back();
    auto ret = instantiateEvolutionImpl(trec, loop, temp);
    temp.pop_back();
    return ret;
}

TREC *SCEVHandle::instantiateEvolutionImpl(TREC *trec, const Loop *loop, std::vector<std::unordered_set<TREC *>> &instantiated) {
    // If trec is a constant c Then
    if (trec->isExpr() && trec->getExpr()->isIRValue() &&
        trec->getExpr()->getRawIRValue()->getVTrait() == ValueTrait::CONSTANT_LITERAL)
        return trec;

    if (trec->isExpr()) {
        // Else If trec is a variable already instantiated Then
        // TODO: resolve mixers
        if (std::any_of(instantiated.begin(), instantiated.end(),
            [trec](const auto &set) { return set.count(trec); }))
            return getTRECUntracked();
        instantiated.back().emplace(trec);

        // Else If trec is a variable v Then
        std::function<TREC *(SCEVExpr *)> analyzeExprEvo;
        analyzeExprEvo = [this, &loop, &analyzeExprEvo](SCEVExpr *expr) -> TREC * {
            if (expr->isBinary()) {
                auto lhs = analyzeExprEvo(expr->getLHS());
                auto rhs = analyzeExprEvo(expr->getRHS());
                switch (expr->getOp()) {
                    case SCEVExpr::Binary::Op::Add:
                        return getTRECAdd(lhs, rhs);
                    case SCEVExpr::Binary::Op::Sub:
                        return getTRECSub(lhs, rhs);
                    case SCEVExpr::Binary::Op::Mul:
                        return getTRECMul(lhs, rhs);
                    case SCEVExpr::Binary::Op::Div:
                        return getTRECUntracked();
                default:
                        Err::unreachable();
                }
                return getTRECUntracked();
            }
            Err::gassert(expr->isIRValue());
            return analyzeEvolution(loop, expr->getRawIRValue());
        };
        return analyzeExprEvo(trec->getExpr());
    }

    if (trec->isAddRec()) {
        auto i1 = instantiateEvolutionImpl(trec->getBase(), loop, instantiated);
        auto i2 = instantiateEvolutionImpl(trec->getStep(), loop, instantiated);
        return getAddRecTREC(trec->getLoop(), i1, i2);
    }

    if (trec->isPeeled()) {
        auto i1 = instantiateEvolutionImpl(getExprTREC(trec->getFirst()), loop, instantiated);
        auto i2 = instantiateEvolutionImpl(trec->getRest(), loop, instantiated);
        if (!i1->isExpr())
            return getTRECUntracked();
        return unifyPeeledTREC(getPeeledTREC(trec->getLoop(), i1->getExpr(), i2));
    }

    return getTRECUntracked();
}

SCEVExpr* SCEVHandle::swapOperands(SCEVExpr *x) {
    Err::gassert(x->isBinary());
    switch (x->getOp()) {
        case SCEVExpr::Binary::Op::Add:
            return getSCEVExprAdd(x->getRHS(), x->getLHS());
        case SCEVExpr::Binary::Op::Sub:
            return getSCEVExprSub(x->getRHS(), x->getLHS());
        case SCEVExpr::Binary::Op::Mul:
            return getSCEVExprMul(x->getRHS(), x->getLHS());
        case SCEVExpr::Binary::Op::Div:
            return getSCEVExprDiv(x->getRHS(), x->getLHS());
    }
    Err::unreachable();
    return nullptr;
}


SCEVExpr* SCEVHandle::foldSCEVExpr(SCEVExpr *expr) {
    using Op = SCEVExpr::Binary::Op;
    if (expr->isBinary()) {
        auto lhs = expr->getLHS();
        auto rhs = expr->getRHS();
        auto op = expr->getOp();

        // Do this in a post order
        lhs = foldSCEVExpr(lhs);
        rhs = foldSCEVExpr(rhs);

        // Peephole
        if (lhs == rhs) {
            if (op == Op::Sub)
                return getSCEVExpr(0);
            if (op == Op::Div)
                return getSCEVExpr(1);
        }

        pConstI32 lhs_ci, rhs_ci;
        if (lhs->isIRValue())
            lhs_ci = lhs->getRawIRValue()->as<ConstantInt>();
        if (rhs->isIRValue())
            rhs_ci = rhs->getRawIRValue()->as<ConstantInt>();

        // Constant folding
        if (lhs_ci && rhs_ci) {
            int x = lhs_ci->getVal();
            int y = rhs_ci->getVal();
            switch (op) {
            case Op::Add:
                return getSCEVExpr(x + y);
            case Op::Sub:
                return getSCEVExpr(x - y);
            case Op::Mul:
                return getSCEVExpr(x * y);
            case Op::Div:
                return getSCEVExpr(x / y);
            default:
                Err::unreachable();
            }
            return nullptr;
        }

        if (lhs_ci) {
            if (lhs_ci->getVal() == 0) {
                if (op == Op::Add)
                    return foldSCEVExpr(rhs);
                if (op == Op::Mul || op == Op::Div)
                    return getSCEVExpr(0);
            }
            if (lhs_ci->getVal() == 1) {
                if (op == Op::Mul)
                    return foldSCEVExpr(rhs);
            }
        }
        else if (rhs_ci) {
            if (rhs_ci->getVal() == 0) {
                if (op == Op::Add || op == Op::Sub)
                    return foldSCEVExpr(lhs);
                if (op == Op::Mul)
                    return getSCEVExpr(0);
            }
            if (rhs_ci->getVal() == 1) {
                if (op == Op::Mul || op == Op::Div)
                    return foldSCEVExpr(lhs);
            }

            // Don't swap operands, we've done this in getSCEVExprAdd
            // // t +/* c ---> c +/* t
            // if (op == Op::Add || op == Op::Mul)
            //     return foldSCEVExpr(swapOperands(expr));
        }

        // Transform the tree.
        // Adapted from Muchnick's "Advanced Compiler Design & Implementation", Fig 12.6
        if (op == Op::Add || op == Op::Mul) {
            // R7, R8
            if (lhs->isIRValue() && rhs->isBinary() && rhs->getOp() == op) {
                expr = swapOperands(expr);
                std::swap(lhs, rhs);
                std::swap(lhs_ci, rhs_ci);
            }

            // R9, R10
            if (lhs->isBinary() && lhs->getOp() == op && lhs->getLHS()->isIRValue()) {
                auto lhs_lhs_ci = lhs->getLHS()->getRawIRValue()->as<ConstantInt>();
                if (lhs_lhs_ci && rhs_ci) {
                    auto x = lhs_lhs_ci->getVal();
                    auto y = rhs_ci->getVal();
                    if (op == Op::Add)
                        return getSCEVExprAdd(getSCEVExpr(x + y), lhs->getRHS());
                    return getSCEVExprMul(getSCEVExpr(x * y), lhs->getRHS());
                }
            }
        }

        // R11, R12
        if (op == Op::Mul) {
            if (lhs->isBinary() && lhs->getOp() == Op::Add && lhs->getLHS()->isIRValue()) {
                auto lhs_lhs_ci = lhs->getLHS()->getRawIRValue()->as<ConstantInt>();
                if (lhs_lhs_ci && rhs_ci) {
                    auto x = lhs_lhs_ci->getVal();
                    auto y = rhs_ci->getVal();
                    return getSCEVExprAdd(getSCEVExpr(x * y),
                        getSCEVExprMul(getSCEVExpr(y),  lhs->getRHS()));
                }
            }
        }

        // x + (c - x) -->  c
        if (op == Op::Add && rhs->isBinary() && rhs->getOp() == Op::Sub) {
            auto rhs_lhs = rhs->getLHS(), rhs_rhs = rhs->getRHS();
            if (rhs_rhs == lhs)
                return rhs_lhs;
        }
        // (c - x) + x --> c
        if (op == Op::Add && lhs->isBinary() && lhs->getOp() == Op::Sub) {
            auto lhs_lhs = lhs->getLHS(), lhs_rhs = lhs->getRHS();
            if (lhs_rhs == rhs)
                return lhs_lhs;
        }
    }

    return expr;
}

TREC *SCEVHandle::eval(TREC *trec, const Loop *loop) {
    if (trec->isExpr())
        return getExprTREC(foldSCEVExpr(trec->getExpr()));

    if (!trec->isAddRec() && !trec->isPeeled())
        return getTRECUntracked();

    trec = foldTREC(trec);

    if (trec->getLoop() == loop)
        return trec;

    if (!trec->getLoop()->contains(loop)) {
        auto e = apply(trec, getBackEdgeTakenCount(trec->getLoop()));
        if (!e)
            return getTRECUntracked();
        return getExprTREC(e);
    }

    return trec;
}

// (n)         n!
// ( ) == ------------
// (p)     p!(n - p)!
// https://stackoverflow.com/questions/44718971/calculate-binomial-coffeficient-very-reliably
template <typename T> constexpr T binomial_coefficient(T n, T p) noexcept {
    // out of range
    if (p > n)
        return 0;

    // edge
    if (p == 0 || p == n)
        return 1;

    // first
    if (p == 1 || p == n - 1)
        return n;

    // path to p == 1 is faster
    if (p + p < n)
        return binomial_coefficient(n - 1, p - 1) * n / p;

    // path to k=n-1 is faster
    return binomial_coefficient(n - 1, p) * n / (n - p);
}

// Compute the Symbolic Representation of the Binomial Coefficient
// binomial_coefficient(n, p) = (n * (n - 1) * ... * (n - p + 1)) / p!
// TODO: Needs optimization.
SCEVExpr *SCEVHandle::computeSymbolicBinomialCoefficient(SCEVExpr *n, int p) {
    if (p > 1024)
        return nullptr;

    if (p == 1)
        return n;

    if (int n_val; n->isIRValue() && match(n->getRawIRValue(), M::Bind(n_val)))
        return getSCEVExpr(binomial_coefficient(n_val, p));

    SCEVExpr *numerator = n;
    for (int i = 1; i < p; ++i)
        numerator = getSCEVExprMul(numerator, getSCEVExprSub(n, getSCEVExpr(i)));

    int denominator = 1;
    for (int i = 2; i <= p; ++i)
        denominator *= i;

    return getSCEVExprDiv(numerator, getSCEVExpr(denominator));
}

// { c0, +, c1, +, c2, +, ..., +, cn }_x(l_x)
//   == c0 * binomial_coe(trip_cnt, 0) + c1 * binomial_coe(trip_cnt, 1) + ...
// Note that we reserve c0 as its original expression.
// For example:
// trec: { a, +, 7 } trip_cnt: 5
// Output: (a + 35)
SCEVExpr *SCEVHandle::apply(TREC *trec, SCEVExpr *trip_cnt) {
    if (!trip_cnt)
        return nullptr;

    if (trec->isPeeled()) {
        if (!trip_cnt->isIRValue())
            return nullptr;
        int trip_cnt_val;
        if (!match(trip_cnt->getRawIRValue(), M::Bind(trip_cnt_val)))
            return nullptr;
        // Before the first iteration, the value is `first`
        if (trip_cnt_val == 0)
            return trec->getFirst();
        return apply(trec->getRest(), getSCEVExpr(trip_cnt_val - 1));
    }

    if (!trec->isAddRec())
        return nullptr;

    // First flatten the TREC
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
        // TODO: Support Peeled TREC here.
        else
            return nullptr;
    }

    // If the result is a compile-time constant, calculate it.
    auto constant_res = [&]() -> SCEVExpr * {
        if (!trip_cnt->isIRValue())
            return nullptr;

        int trip_cnt_val;
        if (!match(trip_cnt->getRawIRValue(), M::Bind(trip_cnt_val)))
            return nullptr;
        // Avoid too big trip count
        if (trip_cnt_val > 1024)
            return nullptr;

        std::vector<int> worklist;
        // Note that we skipped flatten[0]
        for (size_t i = 1; i < flatten.size(); ++i) {
            int ci;
            if (!flatten[i]->isIRValue() ||
                !match(flatten[i]->getRawIRValue(), M::Bind(ci)))
                return nullptr;
            worklist.emplace_back(ci);
        }

        for (int p = 0; p < worklist.size(); ++p)
            worklist[p] *= binomial_coefficient(trip_cnt_val, p + 1);
        auto cres = std::accumulate(worklist.begin(), worklist.end(), 0);
        return getSCEVExprAdd(flatten[0], getSCEVExpr(cres));
    }();

    // The result is not constants
    // Get the symbolic representation of the applied TREC
    if (constant_res != nullptr)
        return constant_res;

    std::vector<SCEVExpr *> worklist;
    for (int p = 1; p < flatten.size(); ++p) {
        auto coe = computeSymbolicBinomialCoefficient(trip_cnt, p);
        if (!coe)
            return nullptr;
        worklist.emplace_back(getSCEVExprMul(coe, flatten[p]));
    }

    SCEVExpr *res = worklist[0];
    for (size_t i = 1; i < worklist.size(); ++i)
        res = getSCEVExprAdd(res, worklist[i]);
    auto ret = getSCEVExprAdd(flatten[0], res);
    return foldSCEVExpr(ret);
}

// FIXME: See if there is overflow
SCEVExpr *SCEVHandle::getBackEdgeTakenCount(const Loop *loop, RangeResult *ranges) {
    auto latch = loop->getLatch();
    Err::gassert(latch != nullptr, "Expected a latch.");

    auto exitings = loop->getExitingBlocks();
    if (exitings.size() != 1)
        return nullptr;
    auto exiting = *exitings.begin();

    if (!domtree->ADomB(exiting, latch))
        return nullptr;

    auto guard = exiting->getBRInst();
    Err::gassert(guard != nullptr && guard->isConditional());
    auto cond_inst = guard->getCond();
    if (auto icmp = cond_inst->as<ICMPInst>()) {
        auto cmpop = icmp->getCond();
        if (!loop->contains(guard->getTrueDest().get()))
            cmpop = flipCond(cmpop);
        auto to_evo = icmp->getLHS().get();
        auto invariant = icmp->getRHS().get();
        // If the RHS is not an invariant, reverse it.
        if (!loop->isTriviallyInvariant(invariant)) {
            // Give up if there is no invariant in the cmp.
            // TODO: Don't give up
            if (!loop->isTriviallyInvariant(to_evo))
                return nullptr;
            std::swap(to_evo, invariant);
            cmpop = reverseCond(cmpop);
        }

        auto evo = analyzeEvolution(loop, to_evo);
        auto cond = getSCEVExpr(invariant);
        // If this is a constant affine, the number of iterations can be precisely calculated.
        // { 0, +, 1 } < x ---> (x - 0) / 1 ---> x iterations
        auto constant_cond = invariant->as_raw<ConstantInt>();
        auto constant_affine = evo->getConstantAffineAddRec();
        if (constant_affine && constant_cond) {
            auto [base, step] = *constant_affine;
            auto cond_val = constant_cond->getVal();

            if (cmpop == ICMPOP::eq) {
                if (base != cond_val || (base == cond_val && step != 0))
                    return getSCEVExpr(0);
                return nullptr;
            }

            if (cmpop == ICMPOP::sge) {
                cmpop = ICMPOP::sgt;
                cond_val -= 1;
            } else if (cmpop == ICMPOP::sle) {
                cmpop = ICMPOP::slt;
                cond_val += 1;
            }

            // Trivial cases
            if ((cmpop == ICMPOP::sgt && step <= 0 && base <= cond_val) ||
                (cmpop == ICMPOP::slt && step >= 0 && base >= cond_val) ||
                (cmpop == ICMPOP::ne && base == cond_val))
                return getSCEVExpr(0);

            // Infinite
            if ((cmpop == ICMPOP::sgt && step >= 0 && base > cond_val) ||
                (cmpop == ICMPOP::slt && step <= 0 && base < cond_val) ||
                (cmpop == ICMPOP::ne && (step <= 0 && base < cond_val) ||
                (step >= 0 && base > cond_val)))
                return nullptr;

            // {base, +, step} <=> cond_val
            // base + n * step <=> cond_val
            // n <=> (cond_val - base) / step
            auto divres = std::div(cond_val - base, step);
            int path_taken_cnt = divres.quot;
            int remainder = divres.rem;

            // We've handled trivial cases above, there should always be a non-negative count.
            Err::gassert(path_taken_cnt >= 0);

            if (remainder != 0) {
                if (cmpop == ICMPOP::ne)
                    return nullptr;
                ++path_taken_cnt;
            }

            return getSCEVExpr(path_taken_cnt);
        }
        // Not a constant affine + constant cond
        // { a, +, b } < x ---> ( x - a ) / b
        if (auto affine = evo->getAffineAddRec()) {
            auto [base, step] = *affine;

            if (!step->isIRValue())
                return nullptr;

            auto step_ir_val = step->getRawIRValue();

            if (cmpop == ICMPOP::sge) {
                cmpop = ICMPOP::sgt;
                cond = getSCEVExprSub(cond, getSCEVExpr(1));
            } else if (cmpop == ICMPOP::sle) {
                cmpop = ICMPOP::slt;
                cond = getSCEVExprAdd(cond, getSCEVExpr(1));
            }
            else if (cmpop == ICMPOP::eq) {
                if (base == cond && !match(step_ir_val, M::Is(0)))
                    return getSCEVExpr(1);
                // If base != cond, we are not sure whether base equals cond or not at runtime.
                // if (base != cond)
                //     return getSCEVExpr(0);
                return nullptr;
            }

            // If the step is a constant
            if (int step_val; match(step_ir_val, M::Bind(step_val))) {
                // See if the step is constant 1/-1, where the trip count is simply (x - a)/(a - x).
                if (step_val == 1)
                    return getSCEVExprSub(cond, base);
                if (step_val == -1)
                    return getSCEVExprSub(base, cond);

                // If the step can be negative or zero, give up
                if (step_val == 0 || step_val < 0)
                    return nullptr;
            }
            // Here we only consider positive step.
            else if (!ranges || !ranges->knownNonNegative(step_ir_val))
                return nullptr;

            // Compute a symbolic trip count.
            // Avoid `!=`, since there can be remainders.
            if (cmpop == ICMPOP::ne)
                return nullptr;

            // Since step > 0,
            // ceil ((cond - base) / step) == floor((cond - base + (step - 1)) / step)
            auto delta = getSCEVExprSub(cond, base);
            auto step_minus_1 = getSCEVExprSub(step, getSCEVExpr(1));
            auto ret = getSCEVExprDiv(getSCEVExprAdd(delta, step_minus_1), step);
            ret = foldSCEVExpr(ret);

            if (step->getRawIRValue()->getVTrait() != ValueTrait::CONSTANT_LITERAL)
                Logger::logDebug("[SCEV]: The step is known non-positive by RangeAnalysis.");

            return ret;
        }
        return nullptr;
    }
    return nullptr;
}

SCEVExpr *SCEVHandle::getTripCount(const Loop *loop, RangeResult *ranges) {
    if (auto be = getBackEdgeTakenCount(loop)) {
        if (loop->isExiting(loop->getLatch())) {
            auto ret = getSCEVExprAdd(be, getSCEVExpr(1));
            return foldSCEVExpr(ret);
        }
        return be;
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

TREC *SCEVHandle::getExprTREC(SCEVExpr *expr) {
    auto trec = std::make_shared<TREC>(expr);
    return getPoolTREC(trec);
}

TREC *SCEVHandle::getIRValTREC(Value *x) { return getExprTREC(getSCEVExpr(x)); }

TREC *SCEVHandle::getAddRecTREC(const Loop *loop, TREC *base, TREC *step) {
    Err::gassert(!base->isUndef() && !step->isUndef());
    if (base->isUntracked() || step->isUntracked())
        return getTRECUntracked();
    auto trec = std::make_shared<TREC>(TREC::AddRec{base, step, loop});
    return getPoolTREC(trec);
}

TREC *SCEVHandle::getPeeledTREC(const Loop *loop, SCEVExpr *first, TREC *rest) {
    Err::gassert(!rest->isUndef());
    if (rest->isUntracked())
        return getTRECUntracked();
    auto trec = std::make_shared<TREC>(TREC::Peeled{first, rest, loop});
    return getPoolTREC(trec);
}

TREC *SCEVHandle::getTRECUndef() const { return trec_pool[0].get(); }
TREC *SCEVHandle::getTRECUntracked() const { return trec_pool[1].get(); }
TREC *SCEVHandle::getTRECAdd(TREC *x, TREC *y) {
    if (x > y)
        std::swap(x, y);
    Err::gassert(!x->isUndef() && !y->isUndef());
    if (x->isUntracked() || y->isUntracked())
        return getTRECUntracked();
    if (x->isExpr() && y->isExpr())
        return getPoolTREC(std::make_shared<TREC>(getSCEVExprAdd(x->getExpr(), y->getExpr())));
    if (x->isAddRec() && y->isExpr())
        return getAddRecTREC(x->getLoop(), getTRECAdd(x->getBase(), y), x->getStep());
    if (x->isExpr() && y->isAddRec())
        return getAddRecTREC(y->getLoop(), getTRECAdd(y->getBase(), x), y->getStep());
    if (x->isExpr() && y->isPeeled())
        return getPeeledTREC(y->getLoop(), getSCEVExprAdd(y->getFirst(), x->getExpr()), getTRECAdd(y->getRest(), x));
    if (x->isPeeled() && y->isExpr())
        return getPeeledTREC(x->getLoop(), getSCEVExprAdd(x->getFirst(), y->getExpr()), getTRECAdd(x->getRest(), y));

    if(!x->isAddRec() || !y->isAddRec())
        return getTRECUntracked();

    if (x->getLoop() != y->getLoop()) {
        if (x->getLoop()->contains(y->getLoop()))
            return getAddRecTREC(y->getLoop(), getTRECAdd(y->getBase(), x), y->getStep());
        if (y->getLoop()->contains(x->getLoop()))
            return getAddRecTREC(x->getLoop(), getTRECAdd(x->getBase(), y), x->getStep());
        return getTRECUntracked();
    }
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
        return getAddRecTREC(y->getLoop(), getTRECSub(x, y->getBase()), getTRECNeg(y->getStep()));
    if (x->isExpr() && y->isPeeled())
        return getPeeledTREC(y->getLoop(), getSCEVExprSub(x->getExpr(), y->getFirst()), getTRECSub(x, y->getRest()));
    if (x->isPeeled() && y->isExpr())
        return getPeeledTREC(x->getLoop(), getSCEVExprSub(x->getFirst(), y->getExpr()), getTRECSub(x->getRest(), y));

    if(!x->isAddRec() || !y->isAddRec())
        return getTRECUntracked();

    if (x->getLoop() != y->getLoop()) {
        if (x->getLoop()->contains(y->getLoop()))
            return getAddRecTREC(y->getLoop(), getTRECSub(x, y->getBase()), getTRECNeg(y->getStep()));
        if (y->getLoop()->contains(x->getLoop()))
            return getAddRecTREC(x->getLoop(), getTRECSub(x->getBase(), y), x->getStep());
        return getTRECUntracked();
    }

    return getAddRecTREC(x->getLoop(), getTRECSub(x->getBase(), y->getBase()), getTRECSub(x->getStep(), y->getStep()));
}
TREC *SCEVHandle::getTRECMul(TREC *x, TREC *y) {
    if (x > y)
        std::swap(x, y);
    Err::gassert(!x->isUndef() && !y->isUndef());
    if (x->isUntracked() || y->isUntracked())
        return getTRECUntracked();
    if (x->isExpr() && y->isExpr())
        return getPoolTREC(std::make_shared<TREC>(getSCEVExprMul(x->getExpr(), y->getExpr())));
    if (x->isAddRec() && y->isExpr())
        return getAddRecTREC(x->getLoop(), getTRECMul(x->getBase(), y), getTRECMul(x->getStep(), y));
    if (x->isExpr() && y->isAddRec())
        return getAddRecTREC(y->getLoop(), getTRECMul(y->getBase(), x), getTRECMul(y->getStep(), x));
    if (x->isExpr() && y->isPeeled())
        return getPeeledTREC(y->getLoop(), getSCEVExprMul(y->getFirst(), x->getExpr()), getTRECMul(y->getRest(), x));
    if (x->isPeeled() && y->isExpr())
        return getPeeledTREC(x->getLoop(), getSCEVExprMul(x->getFirst(), y->getExpr()), getTRECMul(x->getRest(), y));

    if(!x->isAddRec() || !y->isAddRec())
        return getTRECUntracked();

    if (x->getLoop() != y->getLoop()) {
        if (x->getLoop()->contains(y->getLoop()))
            return getAddRecTREC(y->getLoop(), getTRECMul(y->getBase(), x), getTRECMul(y->getStep(), x));
        if (y->getLoop()->contains(x->getLoop()))
            return getAddRecTREC(x->getLoop(), getTRECMul(x->getBase(), y), getTRECMul(x->getStep(), y));
        return getTRECUntracked();
    }
    auto new_base = getTRECMul(x->getBase(), y->getBase());
    auto new_step = getTRECAdd(getTRECAdd(getTRECMul(x, y->getStep()), getTRECMul(y, x->getStep())),
                               getTRECMul(x->getStep(), y->getStep()));
    return getAddRecTREC(x->getLoop(), new_base, new_step);
}
TREC *SCEVHandle::getTRECNeg(TREC *x) { return getTRECSub(getExprTREC(getSCEVExpr(0)), x); }

// Note that this function is called in a post order depth-first order. Thus, we don't
// bother with recursive unification here.
TREC *SCEVHandle::unifyPeeledTREC(TREC *peeled) {
    if (!peeled->isPeeled())
        return peeled;

    // Trivial cases where both of them is SCEVExpr.
    if (peeled->getRest()->isExpr() && peeled->getFirst() == peeled->getRest()->getExpr())
        return peeled->getRest();

    if (peeled->getRest()->isAddRec()) {
        auto base = peeled->getRest()->getBase();
        auto step = peeled->getRest()->getStep();
        if (getTRECAdd(getExprTREC(peeled->getFirst()), step) == base)
            return getAddRecTREC(peeled->getLoop(), getExprTREC(peeled->getFirst()), step);
    }

    return peeled;
}

TREC* SCEVHandle::foldTREC(TREC *trec) {
    if (trec->isExpr())
        return getExprTREC(foldSCEVExpr(trec->getExpr()));

    if (trec->isAddRec())
        return getAddRecTREC(trec->getLoop(), foldTREC(trec->getBase()), foldTREC(trec->getStep()));

    if (trec->isPeeled()) {
        auto first = foldSCEVExpr(trec->getFirst());
        auto rest = foldTREC(trec->getRest());
        return unifyPeeledTREC(getPeeledTREC(trec->getLoop(), first, rest));
    }
    Err::unreachable();
    return nullptr;
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
    if (x > y)
        std::swap(x, y);
    if (x->isIRValue() && match(x->getRawIRValue(), M::Is(0)))
        return y;
    if (y->isIRValue() && match(y->getRawIRValue(), M::Is(0)))
        return x;
    if (x->isIRValue() && y->isIRValue()) {
        int a, b;
        if (match(x->getRawIRValue(), M::Bind(a)) &&
            match(y->getRawIRValue(), M::Bind(b)))
            return getSCEVExpr(a + b);
    }
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Add, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprSub(SCEVExpr *x, SCEVExpr *y) {
    if (x == y)
        return getSCEVExpr(0);
    if (y->isIRValue() && match(y->getRawIRValue(), M::Is(0)))
        return x;
    if (x->isIRValue() && y->isIRValue()) {
        int a, b;
        if (match(x->getRawIRValue(), M::Bind(a)) &&
            match(y->getRawIRValue(), M::Bind(b)))
            return getSCEVExpr(a - b);
    }
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Sub, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprMul(SCEVExpr *x, SCEVExpr *y) {
    if (x > y)
        std::swap(x, y);
    if ((x->isIRValue() && match(x->getRawIRValue(), M::Is(0))) ||
        (y->isIRValue() && match(y->getRawIRValue(), M::Is(0))))
        return getSCEVExpr(0);
    if (x->isIRValue() && match(x->getRawIRValue(), M::Is(1)))
        return y;
    if (y->isIRValue() && match(y->getRawIRValue(), M::Is(1)))
        return x;

    if (x->isIRValue() && y->isIRValue()) {
        int a, b;
        if (match(x->getRawIRValue(), M::Bind(a)) &&
            match(y->getRawIRValue(), M::Bind(b)))
            return getSCEVExpr(a * b);
    }
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Mul, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprDiv(SCEVExpr *x, SCEVExpr *y) {
    if (x == y)
        return getSCEVExpr(1);
    if (x->isIRValue() && match(x->getRawIRValue(), M::Is(0)))
        return getSCEVExpr(0);
    if (y->isIRValue() && match(y->getRawIRValue(), M::Is(1)))
        return x;
    if (x->isIRValue() && y->isIRValue()) {
        int a, b;
        if (match(x->getRawIRValue(), M::Bind(a)) &&
            match(y->getRawIRValue(), M::Bind(b)))
            return getSCEVExpr(a / b);
    }
    return getPoolSCEV(std::make_shared<SCEVExpr>(SCEVExpr::Binary::Op::Div, x, y));
}
SCEVExpr *SCEVHandle::getSCEVExprNeg(SCEVExpr *x) {
    if (int a; x->isIRValue() && match(x->getRawIRValue(), M::Bind(a)))
        return getSCEVExpr(-a);
    return getSCEVExprSub(getSCEVExpr(0), x);
}

SCEVExpr *SCEVHandle::getSCEVExpr(int x) { return getSCEVExpr(function->getConst(x).get()); }
SCEVExpr *SCEVHandle::getSCEVExpr(Value *x) { return getPoolSCEV(std::make_shared<SCEVExpr>(x)); }

SCEVHandle SCEVAnalysis::run(Function &func, FAM &fam) {
    auto& loop_info = fam.getResult<LoopAnalysis>(func);
    auto& domtree = fam.getResult<DomTreeAnalysis>(func);
    return SCEVHandle(&func, &loop_info, &domtree);
}

} // namespace IR
