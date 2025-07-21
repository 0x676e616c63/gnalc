// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/sir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/instructions/binary.hpp"
#include "../../../../include/ir/instructions/compare.hpp"
#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/match.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"

#include "../../../../include/match/match.hpp"
#include "../../../../include/sir/base.hpp"
#include "../../../../include/sir/visitor.hpp"

#include <numeric>

namespace SIR {
PM::UniqueKey LAliasAnalysis::Key;

void removeZeroCoeffs(std::map<IndVar *, int> &expr) {
    for (auto it = expr.begin(); it != expr.end();) {
        if (it->second == 0)
            it = expr.erase(it);
        else
            ++it;
    }
}

int AffineExpr::coe(IndVar *i) const {
    auto it = coeffs.find(i);
    return it == coeffs.end() ? 0 : it->second;
}

AffineExpr AffineExpr::operator+(const AffineExpr &rhs) const {
    auto new_coeffs = coeffs;
    for (const auto &[rhs_ind, rhs_coe] : rhs.coeffs) {
        bool added = false;
        for (auto &[lhs_ind, lhs_coe] : new_coeffs) {
            if (lhs_ind == rhs_ind) {
                lhs_coe += rhs_coe;
                added = true;
            }
        }
        if (!added)
            new_coeffs[rhs_ind] = rhs_coe;
    }
    removeZeroCoeffs(new_coeffs);
    return AffineExpr{.coeffs = std::move(new_coeffs), .constant = constant + rhs.constant};
}
AffineExpr AffineExpr::operator-(const AffineExpr &rhs) const {
    auto new_coeffs = coeffs;
    for (const auto &[rhs_ind, rhs_coe] : rhs.coeffs) {
        bool added = false;
        for (auto &[lhs_ind, lhs_coe] : new_coeffs) {
            if (lhs_ind == rhs_ind) {
                lhs_coe -= rhs_coe;
                added = true;
            }
        }
        if (!added)
            new_coeffs[rhs_ind] = -rhs_coe;
    }
    removeZeroCoeffs(new_coeffs);
    return AffineExpr{.coeffs = std::move(new_coeffs), .constant = constant - rhs.constant};
}
AffineExpr AffineExpr::operator*(int rhs) const {
    auto new_coeffs = coeffs;
    for (auto &[ind, coe] : new_coeffs)
        coe *= rhs;
    removeZeroCoeffs(new_coeffs);
    return AffineExpr{.coeffs = std::move(new_coeffs), .constant = constant * rhs};
}

bool AffineExpr::operator==(const AffineExpr &rhs) const {
    return coeffs == rhs.coeffs && constant == rhs.constant;
}

bool isIsomorphic(const AffineExpr &lhs, const AffineExpr &rhs) {
    if (lhs.constant != rhs.constant || lhs.coeffs.size() != rhs.coeffs.size())
        return false;

    using Key = std::tuple<pVal, pVal, pVal, int>;
    std::vector<Key> lhs_decay, rhs_decay;

    for (const auto& [indvar, coe] : lhs.coeffs)
        lhs_decay.emplace_back(indvar->getBase(), indvar->getStep(), indvar->getBound(), coe);

    for (const auto& [indvar, coe] : rhs.coeffs)
        rhs_decay.emplace_back(indvar->getBase(), indvar->getStep(), indvar->getBound(), coe);

    std::sort(lhs_decay.begin(), lhs_decay.end());
    std::sort(rhs_decay.begin(), rhs_decay.end());

    return lhs_decay == rhs_decay;
}

std::optional<AffineExpr> analyzeAffineExpr(Value *expr) {
    if (auto ci32 = expr->as_raw<ConstantInt>())
        return AffineExpr{.coeffs = {}, .constant = ci32->getVal()};

    if (auto indvar = expr->as_raw<IndVar>())
        return AffineExpr{.coeffs = {{indvar, 1}}, .constant = 0 };

    if (auto binary = expr->as_raw<BinaryInst>()) {
        auto lhs = binary->getLHS();
        auto rhs = binary->getRHS();
        auto lhs_affine = analyzeAffineExpr(lhs.get());
        auto rhs_affine = analyzeAffineExpr(rhs.get());
        if (!lhs_affine || !rhs_affine)
            return std::nullopt;

        if (binary->getOpcode() == OP::ADD)
            return *lhs_affine + *rhs_affine;
        if (binary->getOpcode() == OP::SUB)
            return *lhs_affine - *rhs_affine;
        if (binary->getOpcode() == OP::MUL) {
            if (!lhs_affine->coeffs.empty() && !rhs_affine->coeffs.empty())
                return std::nullopt;

            // rhs -> constant
            if (!rhs_affine->coeffs.empty())
                std::swap(lhs_affine, rhs_affine);

            return *lhs_affine * rhs_affine->constant;
        }
        return std::nullopt;
    }
    return std::nullopt;
}

std::optional<MemoryAccess> LAAResult::analyzePointer(Value *ptr) const {
    auto base_ptr = ptr;
    std::vector<AffineExpr> indices;
    while (true) {
        if (auto gep = base_ptr->as_raw<GEPInst>()) {
            base_ptr = gep->getPtr().get();
            // gep ptr, 0, i --> a[i]
            pVal index;
            if (!match(gep, M::Gep(M::Val(), M::Is(0), M::Bind(index))) &&
                !match(gep, M::Gep(M::Val(), M::Bind(index))))
                return std::nullopt;

            auto affine = analyzeAffineExpr(index.get());
            if (!affine)
                return std::nullopt;
            indices.insert(indices.begin(), std::move(*affine));
        } else if (auto bitcast = base_ptr->as_raw<BITCASTInst>())
            base_ptr = bitcast->getOVal().get();
        else if (base_ptr->is<ALLOCAInst, GlobalVariable, FormalParam>())
            break;
        else
            return std::nullopt;
    }

    Err::gassert(base_ptr->getType()->is<PtrType>());
    if (!indices.empty())
        return MemoryAccess(ArrayAccess{.base = base_ptr, .indices = std::move(indices)});

    return MemoryAccess(ScalarAccess{.base = base_ptr});
}

const std::optional<MemoryAccess> &LAAResult::queryPointer(Value *ptr) const {
    auto it = access_cache.find(ptr);
    if (it != access_cache.end())
        return it->second;
    return access_cache[ptr] = analyzePointer(ptr);
}

AliasInfo LAAResult::getAliasInfo(Value *lhs, Value *rhs) const {
    auto ptr1 = getMemLocation(lhs);
    auto ptr2 = getMemLocation(rhs);

    if (ptr1 == ptr2)
        return AliasInfo::MustAlias;

    auto &info1 = queryPointer(ptr1.get());
    auto &info2 = queryPointer(ptr2.get());

    if (!info1 || !info2)
        return AliasInfo::MayAlias;

    Err::gassert((info1->isArray() && info2->isArray()) || (info1->isScalar() && info2->isScalar()), "Bad analysis");

    if (info1->isArray()) {
        auto &[base1, affine1] = info1->array();
        auto &[base2, affine2] = info2->array();

        if (base1 != base2)
            return AliasInfo::NoAlias;

        if (affine1 == affine2)
            return AliasInfo::MustAlias;

        // FIXME: More accurate dep test here
        return AliasInfo::MayAlias;
    }

    if (info1->isScalar())
        return info1->scalar().base == info2->scalar().base ? AliasInfo::MustAlias : AliasInfo::NoAlias;

    Err::unreachable("Unknown access type");

    return AliasInfo::MayAlias;
}

const std::optional<InstRW> &LAAResult::queryInstRW(Instruction *inst) const {
    auto it = inst_rw_cache.find(inst);
    if (it != inst_rw_cache.end())
        return it->second;
    return inst_rw_cache[inst] = analyzeInstRW(inst);
}

const std::optional<MemoryAccess> &LAAResult::queryPointer(const pVal & v) const {
    return queryPointer(v.get());
}
const std::optional<InstRW> &LAAResult::queryInstRW(const pInst & inst) const {
    return queryInstRW(inst.get());
}

AliasInfo LAAResult::getAliasInfo(const pVal &lhs, const pVal &rhs) const { return getAliasInfo(lhs.get(), rhs.get()); }

std::optional<InstRW> LAAResult::analyzeInstRW(Instruction *inst) const {
    if (inst->is<BinaryInst, CastInst, GEPInst, FNEGInst, ICMPInst, FCMPInst>())
        return InstRW{};

    if (auto load = inst->as_raw<LOADInst>())
        return InstRW{.read = {load->getPtr().get()}};
    if (auto store = inst->as_raw<STOREInst>())
        return InstRW{.write = {store->getPtr().get()}};

    InstRW rw;
    auto merge = [&](const InstRW &item) {
        rw.read.insert(item.read.begin(), item.read.end());
        rw.write.insert(item.write.begin(), item.write.end());
    };
    auto mergeList = [&](const std::list<pInst> &list) -> bool {
        for (const auto &inner_inst : list) {
            auto &curr_rw = queryInstRW(inner_inst.get());
            if (!curr_rw)
                return false;
            merge(*curr_rw);
        }
        return true;
    };

    if (auto if_inst = inst->as_raw<IFInst>()) {
        if (!mergeList(if_inst->getBodyInsts()) || !mergeList(if_inst->getElseInsts()))
            return std::nullopt;
        return rw;
    }
    if (auto while_inst = inst->as_raw<WHILEInst>()) {
        if (!mergeList(while_inst->getCondInsts()) || !mergeList(while_inst->getBodyInsts()))
            return std::nullopt;
        return rw;
    }
    if (auto for_inst = inst->as_raw<FORInst>()) {
        if (!mergeList(for_inst->getBodyInsts()))
            return std::nullopt;
        return rw;
    }

    // For other instructions like CALLInst, give up.
    return std::nullopt;
}

bool LAAResult::isIndependent(Instruction *lhs, Instruction *rhs) const {
    auto &rw1 = queryInstRW(lhs);
    auto &rw2 = queryInstRW(rhs);

    if (!rw1 || !rw2)
        return false;

    auto has_dep = [&](const std::set<Value *> &set1, const std::set<Value *> &set2) {
        for (const auto &s1 : set1) {
            for (const auto &s2 : set2) {
                if (getAliasInfo(s1, s2) != AliasInfo::NoAlias)
                    return true;
            }
        }
        return false;
    };

    // WR, RW, WW
    if (has_dep(rw1->write, rw1->read) || has_dep(rw2->read, rw1->write) || has_dep(rw1->write, rw2->write))
        return false;

    return true;
}

bool LAAResult::isScalarIndependent(Instruction *lhs, Instruction *rhs) const {
    auto &rw1 = queryInstRW(lhs);
    auto &rw2 = queryInstRW(rhs);

    if (!rw1 || !rw2)
        return false;

    auto has_dep = [&](const std::set<Value *> &set1, const std::set<Value *> &set2) {
        for (const auto &s1 : set1) {
            const auto& a1 = queryPointer(s1);
            // Scalar pointer's query can't fail, so s1 must be array if `a1`
            if (!a1 || !a1->isScalar())
                continue;
            for (const auto &s2 : set2) {
                const auto& a2 = queryPointer(s1);
                if (!a2 || !a2->isScalar())
                    continue;
                if (getAliasInfo(s1, s2) != AliasInfo::NoAlias)
                    return true;
            }
        }
        return false;
    };

    // WR, RW, WW
    if (has_dep(rw1->write, rw1->read) || has_dep(rw2->read, rw1->write) || has_dep(rw1->write, rw2->write))
        return false;

    return true;
}

bool LAAResult::isScalarIndependent(const pInst &lhs, const pInst &rhs) const {
    return isIndependent(lhs.get(), rhs.get());
}

bool LAAResult::isIndependent(const pInst &lhs, const pInst &rhs) const { return isIndependent(lhs.get(), rhs.get()); }

LAAResult LAliasAnalysis::run(LinearFunction &f, LFAM &fam) { return LAAResult{}; }

} // namespace SIR
