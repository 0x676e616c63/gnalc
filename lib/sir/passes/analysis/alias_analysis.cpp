// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/memory.hpp"

#include "match/match.hpp"
#include "sir/base.hpp"
#include "sir/visitor.hpp"

#include <numeric>

namespace SIR {
PM::UniqueKey LAliasAnalysis::Key;

LAAResult::PtrInfo LAAResult::analyzePointer(Value * ptr) const {
    auto base_ptr = ptr;
    while (true) {
        if (auto base_gep = base_ptr->as_raw<GEPInst>())
            base_ptr = base_gep->getPtr().get();
        else if (auto bitcast = base_ptr->as_raw<BITCASTInst>())
            base_ptr = bitcast->getOVal().get();
        else if (base_ptr->is<ALLOCAInst, GlobalVariable, FormalParam>())
            break;
        else
            return { .untracked = true };
    }
    return { .base = base_ptr, .untracked = false };
}

const LAAResult::PtrInfo &LAAResult::queryPointer(Value * ptr) const {
    auto it = ptr_cache.find(ptr);
    if (it != ptr_cache.end())
        return it->second;
    return ptr_cache[ptr] = analyzePointer(ptr);
}

AliasInfo LAAResult::getAliasInfo(Value *lhs, Value *rhs) const {
    auto ptr1 = getMemLocation(lhs);
    auto ptr2 = getMemLocation(rhs);

    if (ptr1 == ptr2)
        return AliasInfo::MustAlias;

    auto &info1 = queryPointer(ptr1.get());
    auto &info2 = queryPointer(ptr2.get());

    if (info1.untracked || info2.untracked)
        return AliasInfo::MayAlias;

    if (info1.base != info2.base)
        return AliasInfo::NoAlias;

    // Now we know those pointers share the same base.
    // Scalar pointers must overlap.
    if (getElm(info1.base->getType())->is<BType>())
        return AliasInfo::MustAlias;

    // Array access
    // FIXME: More accurate for array
    return AliasInfo::MayAlias;
}

const LAAResult::InstRW &LAAResult::queryInstRW(Instruction * inst) const {
    auto it = inst_rw_cache.find(inst);
    if (it != inst_rw_cache.end())
        return it->second;
    return inst_rw_cache[inst] = analyzeInstRW(inst);
}

AliasInfo LAAResult::getAliasInfo(const pVal &lhs, const pVal &rhs) const {
    return getAliasInfo(lhs.get(), rhs.get());
}

LAAResult::InstRW LAAResult::analyzeInstRW(Instruction * inst) const {
    if (inst->is<BinaryInst, CastInst, GEPInst, FNEGInst, ICMPInst, FCMPInst>())
        return {.untracked = false};

    if (auto load = inst->as_raw<LOADInst>()) {
        auto& info = queryPointer(load->getPtr().get());
        if (info.untracked)
            return {.untracked = true};
        return {.read = {info.base}, .untracked = false};
    }
    if (auto store = inst->as_raw<STOREInst>()) {
        auto& info = queryPointer(store->getPtr().get());
        if (info.untracked)
            return {.untracked = true};
        return {.write = {info.base}, .untracked = false};
    }

    InstRW rw;
    auto merge = [&](const InstRW& item) {
        rw.read.insert(item.read.begin(), item.read.end());
        rw.write.insert(item.write.begin(), item.write.end());
        rw.untracked |= item.untracked;
    };
    auto mergeList = [&](const std::list<pInst>& list) {
        for (const auto& inner_inst : list)
            merge(queryInstRW(inner_inst.get()));
    };
    if (auto if_inst = inst->as_raw<IFInst>()) {
        mergeList(if_inst->getBodyInsts());
        mergeList(if_inst->getElseInsts());
        return rw;
    }
    if (auto while_inst = inst->as_raw<WHILEInst>()) {
        mergeList(while_inst->getCondInsts());
        mergeList(while_inst->getBodyInsts());
        return rw;
    }
    if (auto for_inst = inst->as_raw<FORInst>()) {
        mergeList(for_inst->getBodyInsts());
        return rw;
    }

    // For other instructions like CALLInst, give up.
    return { .untracked = true };
}

bool LAAResult::isIndependent(Instruction *lhs, Instruction *rhs) const {
    auto& rw1 = queryInstRW(lhs);
    auto& rw2 = queryInstRW(rhs);

    if (rw1.untracked || rw2.untracked)
        return false;

    for (const auto& w1 : rw1.write) {
        if (rw2.read.count(w1) || rw2.write.count(w1))
            return false;
    }

    for (const auto& w2 : rw2.write) {
        if (rw1.read.count(w2)) // We've handled RW1's write above
            return false;
    }

    return true;
}

bool LAAResult::isIndependent(const pInst &lhs, const pInst &rhs) const {
    return isIndependent(lhs.get(), rhs.get());
}

LAAResult LAliasAnalysis::run(LinearFunction &f, LFAM &fam) {
    return LAAResult{};
}

} // namespace IR
