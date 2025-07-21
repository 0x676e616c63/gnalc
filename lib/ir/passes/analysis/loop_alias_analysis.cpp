// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/analysis/loop_alias_analysis.hpp"

#include "ir/block_utils.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "match/match.hpp"

#include <numeric>

namespace IR {
PM::UniqueKey LoopAliasAnalysis::Key;

bool AccessSet::AccessPair::operator==(const AccessPair &other) const {
    return trip_count == other.trip_count && stride == other.stride && loop_header == other.loop_header;
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

    const AccessPair *last_access = nullptr;
    for (const auto &access : accesses) {
        if (access.trip_count == Inf)
            return std::nullopt;

        if (last_access && access.stride * access.trip_count != last_access->stride)
            return std::nullopt;

        last_access = &access;
    }

    return accesses[0].trip_count * accesses[0].stride;
}

template <typename T> T gcd_many(const std::vector<T> &v) {
    if (v.empty())
        return 0;
    return std::accumulate(v.begin() + 1, v.end(), v[0], [](T a, T b) { return std::gcd(a, b); });
}

std::tuple<size_t, size_t, size_t> analyzeAccessSet(const AccessSet &set) {
    size_t max_offset = 0;
    size_t stride_gcd = 0;

    size_t span = 0;
    std::vector<size_t> strides;
    for (auto &ap : set.accesses) {
        if (ap.trip_count == AccessSet::Inf)
            span = AccessSet::Inf;
        else if (span != AccessSet::Inf)
            span += (ap.trip_count - 1) * ap.stride;
        strides.emplace_back(ap.stride);
    }
    max_offset = (span == AccessSet::Inf ? AccessSet::Inf : set.offset + span);
    stride_gcd = gcd_many(strides);

    return {set.offset, max_offset, stride_gcd};
}

// Simple GCD test
bool overlap(const AccessSet &set1, const AccessSet &set2) {
    auto [min_offset1, max_offset1, stride_gcd1] = analyzeAccessSet(set1);
    auto [min_offset2, max_offset2, stride_gcd2] = analyzeAccessSet(set2);

    if (max_offset1 != AccessSet::Inf && max_offset2 != AccessSet::Inf) {
        if (max_offset1 + set1.element_size <= min_offset2 || max_offset2 + set2.element_size <= min_offset1)
            return false;
    }

    size_t delta = (min_offset1 > min_offset2 ? min_offset1 - min_offset2 : min_offset2 - min_offset1);
    size_t g = std::gcd(stride_gcd1, stride_gcd2);
    if (g == 0)
        return !(min_offset1 + set1.element_size <= min_offset2 || min_offset2 + set2.element_size <= min_offset1);

    size_t r = delta % g;
    if (r < (std::max)(set1.element_size, set2.element_size))
        return true;

    return false;
}
AliasInfo LoopAAResult::getAliasInfo(Value *v1, Value *v2) const {
    if (v1 == v2)
        return AliasInfo::MustAlias;

    const auto &loc1 = queryPointer(v1);
    const auto &loc2 = queryPointer(v2);

    if (loc1.untracked || loc2.untracked)
        return AliasInfo::MayAlias;

    if (loc1.base != loc2.base)
        return AliasInfo::NoAlias;

    if (loc1 == loc2)
        return AliasInfo::MustAlias;

    // For pointers with same base, see if they can overlap.
    if (overlap(loc1, loc2))
        return AliasInfo::MayAlias;

    return AliasInfo::NoAlias;
}

AliasInfo LoopAAResult::getAliasInfo(const pVal &v1, const pVal &v2) const { return getAliasInfo(v1.get(), v2.get()); }

ModRefInfo LoopAAResult::getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const {
    const auto &loc = queryPointer(location);
    switch (inst->getOpcode()) {
    case OP::LOAD: {
        auto load = inst->as_raw<LOADInst>();
        auto load_loc = queryPointer(load->getPtr().get());
        if (overlap(loc, load_loc))
            return ModRefInfo::Ref;
        return ModRefInfo::NoModRef;
    } break;
    case OP::STORE: {
        auto store = inst->as_raw<STOREInst>();
        auto store_loc = queryPointer(store->getPtr().get());
        if (overlap(loc, store_loc))
            return ModRefInfo::Mod;
        return ModRefInfo::NoModRef;
    } break;
    case OP::CALL: {
        // Currently this LoopAA is intra-procedural, so we use BasicAA here.
        // FIXME: It's time-consuming.
        auto &basic_aa = fam.getResult<BasicAliasAnalysis>(*inst->getParent()->getParent());
        return basic_aa.getInstModRefInfo(inst, location, fam);
    } break;
    default:
        return ModRefInfo::NoModRef;
    }

    return ModRefInfo::ModRef;
}

ModRefInfo LoopAAResult::getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const {
    return getInstModRefInfo(inst.get(), location.get(), fam);
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

bool LoopAAResult::isConsecutiveAccess(Value *inst1, Value *inst2) const {
    auto ptr1 = getMemLocation(inst1);
    auto ptr2 = getMemLocation(inst2);
    return isV2NextToV1(ptr1, ptr2);
}
bool LoopAAResult::isConsecutiveAccess(const pVal &inst1, const pVal &inst2) const {
    return isConsecutiveAccess(inst1.get(), inst2.get());
}

int LoopAAResult::getAlignOnBase(Value *value) const {
    const auto &loc = queryPointer(value);
    int align = -1;
    int pow = 1;
    if (loc.offset != 0) {
        while (true) {
            if (loc.offset % pow != 0) {
                align = pow / 2;
                break;
            }
            pow *= 2;
        }
        Err::gassert(align != -1, "Invalid offset alignment.");
    } else
        align = 64;

    if (loc.accesses.empty())
        return align;

    for (const auto &access : loc.accesses)
        align = std::gcd(align, access.stride);

    return align;
}

int LoopAAResult::getAlignOnBase(const pVal &value) const { return getAlignOnBase(value.get()); }

std::optional<std::tuple<Value *, size_t>> LoopAAResult::getBaseAndOffset(Value *value) const {
    const auto &loc = queryPointer(value);
    if (loc.untracked)
        return std::nullopt;

    if (loc.accesses.empty())
        return std::make_tuple(loc.base, loc.offset);

    return std::nullopt;
}
std::optional<std::tuple<Value *, size_t>> LoopAAResult::getBaseAndOffset(const pVal &value) const {
    return getBaseAndOffset(value.get());
}

const AccessSet &LoopAAResult::getAccessSet(Value *value) const { return queryPointer(value); }
const AccessSet &LoopAAResult::getAccessSet(const pVal &value) const { return queryPointer(value.get()); }

const AccessSet &LoopAAResult::queryPointer(Value *v) const {
    auto it = access_cache.find(v);
    if (it != access_cache.end())
        return it->second;
    return access_cache[v] = analyzePointer(v);
}

AccessSet LoopAAResult::analyzePointer(Value *ptr) const {
    AccessSet set{
        .base = nullptr,
        .offset = 0,
        .element_size = getElm(ptr->getType())->getBytes(),
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
                                access_insert_point = set.accesses.insert(
                                    access_insert_point, AccessSet::AccessPair{
                                                             .trip_count = idx_trip_count,
                                                             .stride = step * curr_type->getBytes(),
                                                             .loop_header = idx_scev->getLoop()->getRawHeader(),
                                                         });
                                ++access_insert_point; // restore the insert point
                            } else if (int idx_ci32; idx_scev->isExpr() && idx_scev->getExpr()->isIRValue() &&
                                                     match(idx_scev->getExpr()->getIRValue(), M::Bind(idx_ci32))) {
                                set.offset += idx_ci32 * curr_type->getBytes();
                            } else {
                                set.untracked = true;
                                return set;
                            }
                        } else {
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
        // Don't bother with function before mem2reg, or gep flattened program.
        else if (ptr->is<LOADInst, INTTOPTRInst, PTRTOINTInst>()) {
            set.untracked = true;
            return set;
        } else
            Err::unreachable();
    }
}

void LoopAAResult::invalidateCache() { access_cache.clear(); }

LoopAAResult LoopAliasAnalysis::run(Function &function, FAM &fam) {
    auto scev = &fam.getResult<SCEVAnalysis>(function);
    auto loop_info = &fam.getResult<LoopAnalysis>(function);
    auto func = &function;

    return LoopAAResult(func, scev, loop_info);
}
} // namespace IR
