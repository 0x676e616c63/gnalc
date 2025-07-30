// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/utils.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "sir/visitor.hpp"

namespace SIR {
struct GenericMemoryInvariantVisitor : Visitor {
    bool is_invariant = true;
    Value* base;

    void visit(IFInst &if_inst) override {
        if (!is_invariant)
            return;
        Visitor::visit(if_inst);
    }

    void visit(Value &value) override {
        if (!is_invariant)
            return;
        Visitor::visit(value);
    }

    void visit(WHILEInst &while_inst) override {
        if (!is_invariant)
            return;
        Visitor::visit(while_inst);
    }

    void visit(FORInst &for_inst) override {
        if (!is_invariant)
            return;
        Visitor::visit(for_inst);
    }

    void visit(CONDValue &cond) override {
        if (!is_invariant)
            return;
        Visitor::visit(cond);
    }
};

struct ScalarMemoryVisitor : GenericMemoryInvariantVisitor {
    void visit(Instruction &inst) override {
        if (!is_invariant)
            return;

        if (auto store = inst.as<STOREInst>()) {
            if (store->getPtr().get() == base)
                is_invariant = false;
        }
    }
};

struct ArrayMemoryVisitor : GenericMemoryInvariantVisitor {
    void visit(Instruction &inst) override {
        if (!is_invariant)
            return;

        if (auto store = inst.as<STOREInst>()) {
            if (getPtrBase(store->getPtr().get()) == base)
                is_invariant = false;
        } else if (auto call = inst.as<CALLInst>()) {
            if (call->getFunc()->hasFnAttr(FuncAttr::builtinMemReadOnly))
                return;

            auto args = call->getArgs();
            for (const auto& arg : args) {
                if (arg->getType()->is<PtrType>() && getPtrBase(arg).get() == base) {
                    is_invariant = false;
                    return;
                }
            }
        }
    }
};

void visit_helper(Value* item, GenericMemoryInvariantVisitor& visitor) {
    if (auto helper = item->as_raw<HELPERInst>())
        helper->accept(visitor);
    else if (auto lfunc = item->as_raw<LinearFunction>())
        lfunc->accept(visitor);
    else {
        Err::unreachable("Invariant to what?");
    }
}

bool isMemoryInvariantTo(Value* val, Value* item) {
    if (val->is<GlobalVariable>())
        return false;

    if (getElm(val->getType())->is<ArrayType>()) {
        ScalarMemoryVisitor smv;
        smv.base = val;
        visit_helper(item, smv);
        return smv.is_invariant;
    }

    ArrayMemoryVisitor amv;
    amv.base = getPtrBase(val);
    visit_helper(item, amv);
    return amv.is_invariant;
}

bool isMemoryInvariantTo(const pVal& val, const pVal& item) {
    return isMemoryInvariantTo(val.get(), item.get());
}

enum class InvariantType {
    Must, MustNot, DontKnow
};
InvariantType analyzeValInvariant(Value* val, HELPERInst* loop) {
    if (val->is<LOADInst, STOREInst>())
        return InvariantType::MustNot;

    auto inst = val->as<Instruction>();
    if (!inst)
        return InvariantType::Must;

    if (auto indvar = inst->as<IndVar>()) {
        auto for_inst = loop->as<FORInst>();
        if (!for_inst || for_inst->getIndVar() == indvar)
            return InvariantType::MustNot;
        if (for_inst->getIndVar()->getDepth() < indvar->getDepth())
            return InvariantType::Must;
        return InvariantType::MustNot;
    }

    return InvariantType::DontKnow;
}

bool isLoopInvariant(Value* val, HELPERInst* loop) {
    Err::gassert(!val->getType()->is<PtrType>());

    auto inst_info = analyzeValInvariant(val, loop);
    if (inst_info == InvariantType::Must)
        return true;

    if (inst_info == InvariantType::MustNot)
        return false;

    auto operands = collectOperands(val->as<Instruction>());

    for (auto it = operands.begin(); it != operands.end();) {
        auto oper_info = analyzeValInvariant(it->get(), loop);
        if (oper_info == InvariantType::Must)
            it = operands.erase(it);
        else if (oper_info == InvariantType::MustNot)
            return false;
        else
            ++it;
    }

    auto set = std::unordered_set<pVal>{operands.begin(), operands.end()};

    if (auto for_loop = loop->as<FORInst>())
        return !IListContainsRecursive(for_loop->getBodyInsts(), set);
    if (auto while_loop = loop->as<WHILEInst>())
        return !IListContainsRecursive(while_loop->getBodyInsts(), set) &&
            !IListContainsRecursive(while_loop->getCondInsts(), set);

    return true;
}
bool isLoopInvariant(const pVal& val, const pHelper& loop) {
    return isLoopInvariant(val.get(), loop.get());
}

// SIR has no phi, so a simple recursive search is enough.
bool isTriviallyIdentical(const pVal &lhs, const pVal &rhs) {
    if (lhs == rhs)
        return true;
    auto lhs_i = lhs->as<Instruction>();
    auto rhs_i = rhs->as<Instruction>();
    if (!lhs_i || !rhs_i)
        return false;
    if (lhs_i->getOpcode() != rhs_i->getOpcode())
        return false;

    if (lhs_i->getNumOperands() != rhs_i->getNumOperands())
        return false;

    auto isSameOperands = [&]() -> bool {
        for (size_t i = 0; i < lhs_i->getNumOperands(); ++i) {
            if (!isTriviallyIdentical(lhs_i->getOperand(i)->getValue(), rhs_i->getOperand(i)->getValue()))
                return false;
        }
        return true;
    }();

    if (isSameOperands)
        return true;

    if (!lhs_i->isCommutative())
        return false;

    Err::gassert(lhs_i->getNumOperands() == 2);
    return (isTriviallyIdentical(lhs_i->getOperand(0)->getValue(), rhs_i->getOperand(1)->getValue()) &&
            isTriviallyIdentical(lhs_i->getOperand(1)->getValue(), rhs_i->getOperand(0)->getValue()));
}
} // namespace SIR