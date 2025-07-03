// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/instructions/helper.hpp"
#include "ir/visitor.hpp"
namespace IR {
void IFInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void WHILEInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void BREAKInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void CONTINUEInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void FORInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

std::vector<const std::list<pInst> *> getNestedInsts(const pInst& inst) {
    if (auto if_inst = inst->as<IFInst>()) {
        return {&if_inst->getBodyInsts(), &if_inst->getElseInsts()};
    } else if (auto while_inst = inst->as<WHILEInst>()) {
        return {&while_inst->getBodyInsts()};
    } else if (auto for_inst = inst->as<FORInst>()) {
        return {&for_inst->getBodyInsts()};
    }
    return {};
}

void NestedInstIterator::pushNestedInstructions(const std::vector<const std::list<pInst> *> &lists) {
    for (auto li : lists) {
        for (auto it = li->rbegin(); it != li->rend(); ++it)
            stack.push_front(*it);
    }
}
NestedInstIterator::NestedInstIterator(const pInst& helper) {
    if (helper) {
        auto nested_vectors = getNestedInsts(helper);
        pushNestedInstructions(nested_vectors);
    }
}

pInst NestedInstIterator::operator*() const {
    return stack.front();
}

NestedInstIterator& NestedInstIterator::operator++() {
    if (!stack.empty()) {
        pInst current = stack.front();
        stack.pop_front();
        if (current->is<HELPERInst>()) {
            auto nested_vectors = getNestedInsts(current);
            pushNestedInstructions(nested_vectors);
        }
    }
    return *this;
}

NestedInstIterator NestedInstIterator::operator++(int) {
    NestedInstIterator tmp = *this;
    ++(*this);
    return tmp;
}

bool NestedInstIterator::operator==(const NestedInstIterator& other) const {
    return stack == other.stack;
}

bool NestedInstIterator::operator!=(const NestedInstIterator& other) const {
    return !(*this == other);
}
} // namespace IR