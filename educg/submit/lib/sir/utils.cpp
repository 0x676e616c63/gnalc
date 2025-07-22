// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../include/sir/utils.hpp"
#include "../../include/ir/instructions/memory.hpp"

namespace SIR {
bool IListHasWriteToScalarMemory(Value* ptr, IList* ilist) {
    for (auto& inst : *ilist) {
        if (auto store = inst->as<STOREInst>()) {
            if (store->getPtr().get() == ptr)
                return true;
        }
    }
    return false;
}

bool isMemoryLoopInvariant(Value* val, HELPERInst* loop) {
    if (getElm(val->getType())->is<ArrayType>() || val->is<GlobalVariable>())
        return false;

    if (auto while_inst = loop->as<WHILEInst>()) {
        if (IListHasWriteToScalarMemory(val, &while_inst->getCondInsts()))
            return false;
        if (IListHasWriteToScalarMemory(val, &while_inst->getBodyInsts()))
            return false;
    } else if (auto for_inst = loop->as<FORInst>()) {
        if (IListHasWriteToScalarMemory(val, &for_inst->getBodyInsts()))
            return false;
    }

    return true;
}
bool isLoopInvariant(Value* val, HELPERInst* loop) {
    if (val->getType()->is<PtrType>())
        return false;

    auto inst = val->as<Instruction>();
    if (!inst)
        return true;

    if (auto indvar = inst->as<IndVar>()) {
        auto for_inst = loop->as<FORInst>();
        if (!for_inst || for_inst->getIndVar() == indvar)
            return false;
        if (for_inst->getIndVar()->getDepth() < indvar->getDepth())
            return true;
        return false;
    }

    auto operands = collectOperands(inst);
    for (auto& operand : operands)
        if (!isLoopInvariant(operand.get(), loop))
            return false;

    return true;
}

bool isMemoryLoopInvariant(const pVal& val, const pHelper& loop) {
    return isMemoryLoopInvariant(val.get(), loop.get());
}

bool isLoopInvariant(const pVal& val, const pHelper& loop) {
    return isLoopInvariant(val.get(), loop.get());
}

} // namespace SIR