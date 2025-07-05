// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/basic_block.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/visitor.hpp"

namespace IR {
PHIInst::PHIInst(NameRef name, const pType &_type) : Instruction(OP::PHI, name, _type) {}

PHIInst::PhiOperIterator::PhiOperIterator(InnerIterT iter_) : iter(iter_) {}

PHIInst::PhiOperIterator &PHIInst::PhiOperIterator::operator++() {
    ++iter;
    ++iter;
    return *this;
}
PHIInst::PhiOperIterator PHIInst::PhiOperIterator::operator++(int) {
    auto ret = PhiOperIterator{iter};
    ++iter;
    ++iter;
    return ret;
}

PHIInst::PhiOperIterator &PHIInst::PhiOperIterator::operator--() {
    --iter;
    --iter;
    return *this;
}

PHIInst::PhiOperIterator PHIInst::PhiOperIterator::operator--(int) {
    auto ret = PhiOperIterator{iter};
    --iter;
    --iter;
    return ret;
}

bool PHIInst::PhiOperIterator::operator==(PhiOperIterator other) const { return iter == other.iter; }
bool PHIInst::PhiOperIterator::operator!=(PhiOperIterator other) const { return iter != other.iter; }

PHIInst::PhiOper PHIInst::PhiOperIterator::operator*() const {
    auto val = *iter;
    auto block = (*std::next(iter))->as<BasicBlock>();
    Err::gassert(val != nullptr && block != nullptr, "PhiOperIterator: invalid operand");
    return PhiOper{val, block};
}

pVal PHIInst::getValueForBlock(const pBlock &block) const {
    Err::gassert(block != nullptr, "PHIInst::getValueForBlock(): block is null.");
    for (auto it = operand_begin(); it != operand_end(); ++it) {
        ++it;
        if (*it == block)
            return *--it;
    }
    Err::unreachable("Not a pred block.");
    return nullptr;
}

pBlock PHIInst::getBlockForValue(Use *use) const {
    Err::gassert(use->getValue()->getVTrait() != ValueTrait::BASIC_BLOCK);
    const auto &operands = getOperands();
    for (auto it = operands.begin(); it != operands.end(); ++it) {
        if (it->get() == use)
            return (*(it + 1))->getValue()->as<BasicBlock>();
    }
    return nullptr;
}

void PHIInst::setValueForBlock(const pBlock & block, const pVal &val) const {
    Err::gassert(block != nullptr, "PHIInst::setValueForBlock(): block is null.");
    for (auto it = operand_begin(); it != operand_end(); ++it) {
        ++it;
        if (*it == block) {
            (*--it) = val;
            return;
        }
    }
    Err::unreachable("Not a pred block.");
}

void PHIInst::addPhiOper(const pVal &val, const pBlock &blk) {
    Err::gassert(isSameType(getType(), val->getType()), "PHIInst::addPhiOper(): type mismatched");
    addOperand(val);
    addOperand(blk);
}

void PHIInst::addPhiOperNoCheck(const pVal &val, const pBlock &blk) {
    addOperand(val);
    addOperand(blk);
}


std::vector<PHIInst::PhiOper> PHIInst::getPhiOpers() const {
    std::vector<PhiOper> ret;
    for (auto it = operand_begin(); it != operand_end(); ++it) {
        auto v = *it;
        auto b = (*++it)->as<BasicBlock>();
        ret.emplace_back(v, b);
    }
    return ret;
}

bool PHIInst::delPhiOperByBlock(const pBlock &target) {
    for (size_t i = 1; i < getOperands().size(); i += 2) {
        if (getOperand(i)->getValue() == target) {
            delOperand(i);
            delOperand(i - 1);
            return true;
        }
    }
    return false;
}

bool PHIInst::hasBlock(const pBlock &target) {
    for (size_t i = 1; i < getOperands().size(); i += 2) {
        if (getOperand(i)->getValue() == target)
            return true;
    }
    return false;
}

size_t PHIInst::getNumIncomings() const {
    return getNumOperands() / 2;
}

void PHIInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

} // namespace IR
