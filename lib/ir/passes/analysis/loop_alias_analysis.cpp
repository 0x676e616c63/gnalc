// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/analysis/loop_alias_analysis.hpp"

#include "ir/block_utils.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/match.hpp"
#include "match/match.hpp"

#include <numeric>

namespace IR {
PM::UniqueKey LoopAliasAnalysis::Key;

bool AccessSet::AccessPair::operator==(const AccessPair &other) const {
    return trip_count == other.trip_count && stride == other.stride;
}

bool AccessSet::operator==(const AccessSet &set) const {
    if (untracked && set.untracked)
        return true;

    return (base == set.base && offset == set.offset && accesses == set.accesses);
}

bool AccessSet::operator!=(const AccessSet &set) const { return !(*this == set); }

std::optional<size_t> AccessSet::getFullAccessRange() const {
    if (untracked)
        return std::nullopt;

    const AccessPair* last_access = nullptr;
    for (const auto &access : accesses) {
        if (access.trip_count == Inf)
            return std::nullopt;

        if (last_access && access.stride * access.trip_count != last_access->stride)
            return std::nullopt;

        last_access = &access;
    }

    return accesses[0].trip_count * accesses[0].stride;
}

bool LoopAAResult::overlap(const AccessSet &lhs, const AccessSet &rhs) const {
    Err::todo("LoopAA: overlap");
    return true;
}

AliasInfo LoopAAResult::getAliasInfo(Value *v1, Value *v2) const {
    Err::todo("LoopAA: getAliasInfo");
    return AliasInfo::MayAlias;
}

AliasInfo LoopAAResult::getAliasInfo(const pVal &v1, const pVal &v2) const {
    Err::todo("LoopAA: getAliasInfo");
    return AliasInfo::MayAlias;
}

ModRefInfo LoopAAResult::getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const {
    Err::todo("LoopAA: getInstModRefInfo");
    return ModRefInfo::ModRef;
}

ModRefInfo LoopAAResult::getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const {
    Err::todo("LoopAA: getInstModRefInfo");
    return ModRefInfo::ModRef;
}

bool LoopAAResult::isV2NextToV1(Value *v1, Value *v2) const {
    if (v1 == v2)
        return false;

    const auto &loc1 = queryPointer(v1);
    const auto &loc2 = queryPointer(v2);

    if (loc1.untracked || loc2.untracked)
        return false;

    return loc1.base == loc2.base && loc2.offset > loc1.offset &&
           loc2.offset - loc1.offset == getElm(v1->getType())->getBytes() && loc1.accesses == loc2.accesses;
}

bool LoopAAResult::isV2NextToV1(const pVal &v1, const pVal &v2) const { return isV2NextToV1(v1.get(), v2.get()); }

int LoopAAResult::getAlignOnBase(Value *value) const {
    const auto& loc = queryPointer(value);
    int align = -1;
    int pow = 1;
    if (loc.offset != 0) {
        while (true) {
            if (loc.offset % pow != 0) {
                align =  pow / 2;
                break;
            }
            pow *= 2;
        }
        Err::gassert(align != -1, "Invalid offset alignment.");
    }
    else
        align = 64;

    if (loc.accesses.empty())
        return align;

    for (const auto &access : loc.accesses)
        align = std::gcd(align, access.stride);

    return align;
}

int LoopAAResult::getAlignOnBase(const pVal &value) const { return getAlignOnBase(value.get()); }

std::optional<std::tuple<Value *, size_t>> LoopAAResult::getBaseAndOffset(Value *value) const {
    const auto& loc = queryPointer(value);
    if (loc.untracked)
        return std::nullopt;

    if (loc.accesses.empty())
        return std::make_tuple(loc.base, loc.offset);

    return std::nullopt;
}
std::optional<std::tuple<Value *, size_t>> LoopAAResult::getBaseAndOffset(const pVal &value) const {
    return getBaseAndOffset(value.get());
}

const AccessSet &LoopAAResult::getAccessSet(Value *value) const {
    return queryPointer(value);
}
const AccessSet &LoopAAResult::getAccessSet(const pVal &value) const {
    return queryPointer(value.get());
}

const AccessSet &LoopAAResult::queryPointer(Value *v) const {
    auto it = access_cache.find(v);
    if (it != access_cache.end())
        return it->second;
    return access_cache[v] = analyzePointer(v);
}

AccessSet LoopAAResult::analyzePointer(Value *ptr) const {
    AccessSet set {
        .base = nullptr,
        .offset = 0,
        .untracked = false,
    };
    while (true) {
        if (auto bitcast = ptr->as_raw<BITCASTInst>())
            ptr = bitcast->getOVal().get();
        else if (auto gep = ptr->as_raw<GEPInst>()) {
            ptr = gep->getPtr().get();
            // Note that we are iterating backwards through the use-def chain.
            // Pay attention to the insert point.
            auto access_insert_point = set.accesses.begin();

            if (gep->isConstantOffset())
                set.offset += gep->getConstantOffset();
            else {
                auto indices = gep->getIdxs();
                pType curr_type = gep->getBaseType();
                for (const auto &i : indices) {
                    Err::gassert(curr_type != nullptr, "Invalid GEPInst.");
                    if (auto ci32 = i->as<ConstantInt>())
                        set.offset += ci32->getVal() * curr_type->getBytes();
                    else if (auto index_inst = i->as_raw<Instruction>()) {
                        size_t idx_trip_count;
                        const auto &idx_loop = loop_info->getLoopFor(index_inst->getParent());
                        if (idx_loop == nullptr)
                            idx_trip_count = 1;
                        else {
                            auto trip_count_scev = scev->getTripCount(idx_loop);
                            int trip_ci32;
                            if (trip_count_scev && trip_count_scev->isIRValue() &&
                                match(trip_count_scev->getIRValue(), M::Bind(trip_ci32)))
                                idx_trip_count = trip_ci32;
                            else
                                idx_trip_count = AccessSet::Inf;
                        }

                        // Get the evolution at the index def block, since we want to
                        // figure out how the pointer evolves in the whole loop.
                        // Otherwise, (evolution at gep block), we'll get a IRValue SCEVExpr since it is an
                        // invariant at that scope.
                        auto idx_scev = scev->getSCEVAtBlock(i, index_inst->getParent());
                        if (idx_scev) {
                            auto opt = idx_scev->getConstantAffineAddRec();
                            if (opt) {
                                auto [base, step] = opt.value();
                                set.offset += base * curr_type->getBytes();
                                access_insert_point = set.accesses.insert(access_insert_point, AccessSet::AccessPair{
                                    .trip_count = idx_trip_count,
                                    .stride = step * curr_type->getBytes()
                                });
                                ++access_insert_point; // restore the insert point
                            }
                            else {
                                set.untracked = true;
                                return set;
                            }
                        }
                        else {
                            set.untracked = true;
                            return set;
                        }
                    }
                    curr_type = getElm(curr_type);
                }
            }
        } else if (auto phi = ptr->as<PHIInst>()) {
            if (!isLCSSAPhi(phi)) {
                set.untracked = true;
                return set;
            }
            ptr = (*phi->incoming_begin()).value.get();
        } else if (ptr->is<ALLOCAInst, GlobalVariable, FormalParam>()) {
            set.base = ptr;
            return set;
        }
        // Don't bother with function before mem2reg
        else if (ptr->is<LOADInst>()) {
            set.untracked = true;
            return set;
        }
        else Err::unreachable();
    }
}

void LoopAAResult::invalidateCache() {
    access_cache.clear();
}

LoopAAResult LoopAliasAnalysis::run(Function &function, FAM &fam) {
    auto scev = &fam.getResult<SCEVAnalysis>(function);
    auto loop_info = &fam.getResult<LoopAnalysis>(function);
    auto func = &function;

    return LoopAAResult(func, scev, loop_info);
}
} // namespace IR
