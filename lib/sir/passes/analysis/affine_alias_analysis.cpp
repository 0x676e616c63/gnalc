// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/analysis/affine_alias_analysis.hpp"

#include "constraint/omega_test.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"

#include "match/match.hpp"
#include "parser/irgen.hpp"
#include "sir/base.hpp"
#include "sir/utils.hpp"
#include "sir/visitor.hpp"

#include <numeric>

namespace SIR {
PM::UniqueKey AffineAliasAnalysis::Key;

std::ostream &operator<<(std::ostream &os, const AffineExpr &expr) {
    bool first = true;

    for (const auto &coeff : expr.coeffs) {
        if (!first)
            os << " + ";
        first = false;

        if (coeff.second == -1)
            os << "-";
        else if (coeff.second != 1)
            os << coeff.second << " * ";
        os << coeff.first->getName().substr(1);
    }

    if (expr.constant != 0) {
        if (!first)
            os << " + ";
        os << expr.constant;
        first = false;
    }

    if (expr.invariant != nullptr) {
        if (!first)
            os << " + ";
        os << expr.invariant->getName().substr(1);
        first = false;
    }

    if (first)
        os << "0";

    return os;
}

std::ostream &operator<<(std::ostream &os, const IterRange &r) {
    os << "[" << r.base << ", " << r.bound << ") step " << r.step;
    return os;
}

std::ostream &operator<<(std::ostream &os, const ArrayAccess &access) {
    os << access.base->getName();

    for (const auto &indice : access.indices)
        os << "[" << indice << "]";

    if (!access.domain.empty()) {
        os << " where { ";
        bool first = true;
        for (const auto &kv : access.domain) {
            if (!first)
                os << "; ";
            os << kv.first->getName().substr(1) << " in " << kv.second;
            first = false;
        }
        os << " }";
    }

    return os;
}

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

int AffineExpr::coe(const pIndVar &i) const { return coe(i.get()); }

bool AffineExpr::isLinear() const { return coeffs.size() == 1 && constant == 0 && invariant == nullptr; }

std::pair<int, IndVar *> AffineExpr::getLinear() const {
    Err::gassert(isLinear(), "AffineExpr is not linear");
    return std::make_pair(coeffs.begin()->second, coeffs.begin()->first);
}

bool AffineExpr::isConstant() const { return coeffs.empty() && invariant == nullptr; }
int AffineExpr::getConstant() const {
    Err::gassert(isConstant(), "AffineExpr is not constant");
    return constant;
}

AffineExpr AffineExpr::operator+(const AffineExpr &rhs) const {
    Err::gassert(!invariant && !rhs.invariant);
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
    Err::gassert(!invariant && !rhs.invariant);
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
    Err::gassert(!invariant);
    auto new_coeffs = coeffs;
    for (auto &[ind, coe] : new_coeffs)
        coe *= rhs;
    removeZeroCoeffs(new_coeffs);
    return AffineExpr{.coeffs = std::move(new_coeffs), .constant = constant * rhs};
}

bool AffineExpr::operator==(const AffineExpr &rhs) const {
    return coeffs == rhs.coeffs && constant == rhs.constant && rhs.invariant == invariant;
}

bool isIndVarIsomorphic(IndVar *lhs, IndVar *rhs) {
    return isTriviallyIdentical(lhs->getBase(), rhs->getBase()) &&
           isTriviallyIdentical(lhs->getStep(), rhs->getStep()) &&
           isTriviallyIdentical(lhs->getBound(), rhs->getBound()) && lhs->getDepth() == rhs->getDepth();
}

bool isAffineExprIsomorphic(const AffineExpr &lhs, const AffineExpr &rhs) {
    if (lhs.constant != rhs.constant || lhs.coeffs.size() != rhs.coeffs.size())
        return false;

    if ((lhs.invariant && !rhs.invariant) || (!lhs.invariant && rhs.invariant))
        return false;

    if (lhs.invariant && rhs.invariant && !isTriviallyIdentical(lhs.invariant, rhs.invariant))
        return false;

    using Key = std::tuple<pVal, pVal, pVal, size_t, int>;
    std::vector<Key> lhs_decay, rhs_decay;

    for (const auto &[indvar, coe] : lhs.coeffs)
        lhs_decay.emplace_back(indvar->getBase(), indvar->getStep(), indvar->getBound(), indvar->getDepth(), coe);

    for (const auto &[indvar, coe] : rhs.coeffs)
        rhs_decay.emplace_back(indvar->getBase(), indvar->getStep(), indvar->getBound(), indvar->getDepth(), coe);

    std::sort(lhs_decay.begin(), lhs_decay.end());
    std::sort(rhs_decay.begin(), rhs_decay.end());

    return lhs_decay == rhs_decay;
}

bool AffineExpr::isIsomorphic(const AffineExpr &rhs) const { return isAffineExprIsomorphic(*this, rhs); }

bool AffineExpr::knownNonNegative() const {
    if (isConstant())
        return constant >= 0;

    if (invariant)
        return false;

    for (const auto &[lhs_var, lhs_coe] : coeffs) {
        auto base_ci = lhs_var->getBase()->as<ConstantInt>();
        auto step_ci = lhs_var->getStep()->as<ConstantInt>();

        if (!base_ci || !step_ci)
            return false;

        // (base + i * step) * coe
        if (!(base_ci->getVal() >= 0 && step_ci->getVal() >= 0 && lhs_coe >= 0) &&
            !(base_ci->getVal() <= 0 && step_ci->getVal() <= 0 && lhs_coe <= 0))
            return false;
    }

    return true;
}

bool AffineExpr::knownLessOrEqual(const AffineExpr &rhs) const {
    // Quick path for two constants
    if (isConstant() && rhs.isConstant())
        return constant <= rhs.constant;

    // If lhs is zero, see if rhs is non-negative
    if (isConstant() && constant <= 0 && rhs.knownNonNegative())
        return true;

    if (invariant != rhs.invariant)
        return false;

    for (const auto &[lhs_var, lhs_coe] : coeffs) {
        int rhs_coe = 0;
        for (const auto &[rhs_var, coe] : rhs.coeffs) {
            if (isIndVarIsomorphic(lhs_var, rhs_var)) {
                rhs_coe = coe;
                break;
            }
        }
        if (lhs_coe > rhs_coe)
            return false;
    }

    return constant <= rhs.constant;
}

bool AffineExpr::knownGreaterOrEqual(const AffineExpr &rhs) const {
    // Quick path for two constants
    if (isConstant() && rhs.isConstant())
        return constant >= rhs.constant;

    if (rhs.isConstant() && rhs.constant <= 0 && knownNonNegative())
        return true;

    if (invariant != rhs.invariant)
        return false;

    for (const auto &[lhs_var, lhs_coe] : coeffs) {
        int rhs_coe = 0;
        for (const auto &[rhs_var, coe] : rhs.coeffs) {
            if (isIndVarIsomorphic(lhs_var, rhs_var)) {
                rhs_coe = coe;
                break;
            }
        }
        if (lhs_coe < rhs_coe)
            return false;
    }

    return constant >= rhs.constant;
}

bool IterRange::covers(const IterRange &other) const {
    if (!base.knownLessOrEqual(other.base))
        return false;
    if (!bound.knownGreaterOrEqual(other.bound))
        return false;

    if (step == other.step)
        return true;

    int step_coe1 = 0;
    int step_coe2 = 0;

    if (step.isLinear() && other.step.isLinear()) {
        auto [c1, iv1] = step.getLinear();
        auto [c2, iv2] = other.step.getLinear();
        if (iv1 != iv2)
            return false;
        step_coe1 = c1;
        step_coe2 = c2;
    } else if (step.isConstant() && other.step.isConstant()) {
        step_coe1 = step.constant;
        step_coe2 = other.step.constant;
    }

    if (step_coe1 > step_coe2 || step_coe2 % step_coe1 != 0)
        return false;

    // Ensure (base2 - base1) % step1 == 0
    auto delta = other.base - base;
    if (!delta.isConstant())
        return false;

    int d = delta.getConstant();
    if (d % step_coe1 != 0)
        return false;

    return true;
}

bool IterRange::overlaps(const IterRange &other) const {
    return !base.knownGreaterOrEqual(other.bound) && !bound.knownLessOrEqual(other.base);
}

bool IterRange::equals(const IterRange &other) const {
    return base.isIsomorphic(other.base) && bound.isIsomorphic(other.bound) && step.isIsomorphic(other.step);
}
bool IterRange::operator==(const IterRange &other) const { return equals(other); }

bool ArrayAccess::covers(const ArrayAccess &other) const {
    if (base != other.base)
        return false;

    if (indices.size() != other.indices.size())
        return false;

    for (size_t i = 0; i < indices.size(); i++) {
        if (!indices[i].isLinear() || !other.indices[i].isLinear())
            return false;

        if (isAffineExprIsomorphic(indices[i], other.indices[i]))
            continue;

        auto [c1, iv1] = indices[i].getLinear();
        auto [c2, iv2] = other.indices[i].getLinear();

        if (c1 != c2 || !domain.at(iv1).covers(other.domain.at(iv2)))
            return false;
    }

    return true;
}

bool ArrayAccess::overlaps(const ArrayAccess &other) const {
    if (base != other.base)
        return false;

    if (indices.size() != other.indices.size())
        return true;

    for (size_t i = 0; i < indices.size(); i++) {
        if (indices[i].isConstant() && other.indices[i].isConstant()) {
            if (indices[i].getConstant() == other.indices[i].getConstant())
                return true;
            continue;
        }

        if (!indices[i].isLinear() || !other.indices[i].isLinear())
            return true;

        if (isAffineExprIsomorphic(indices[i], other.indices[i]))
            return true;

        auto [c1, iv1] = indices[i].getLinear();
        auto [c2, iv2] = other.indices[i].getLinear();

        if (c1 != c2 || domain.at(iv1).overlaps(other.domain.at(iv2)))
            return true;
    }

    return false;
}

bool ArrayAccess::isLoopInvariant() const {
    return std::all_of(indices.begin(), indices.end(), [](const AffineExpr &expr) {
        // Only constant or loop-invariant indices
        return expr.coeffs.empty();
    });
}

bool ArrayAccess::operator==(const ArrayAccess &other) const {
    return base == other.base && indices == other.indices && domain == other.domain;
}

bool MemoryAccess::covers(const MemoryAccess &other) const {
    if (type() != other.type())
        return false;

    if (isArray())
        return array().covers(other.array());

    return scalar().base == other.scalar().base;
}

bool MemoryAccess::overlaps(const MemoryAccess &other) const {
    if (type() != other.type())
        return false;

    if (isArray())
        return array().overlaps(other.array());

    return scalar().base == other.scalar().base;
}

std::optional<AffineExpr> analyzeAffineExpr(Value *expr, LinearFunction *func) {
    if (auto ci32 = expr->as_raw<ConstantInt>())
        return AffineExpr{.coeffs = {}, .constant = ci32->getVal()};

    if (auto indvar = expr->as_raw<IndVar>())
        return AffineExpr{.coeffs = {{indvar, 1}}, .constant = 0};

    if (auto binary = expr->as_raw<BinaryInst>()) {
        auto lhs = binary->getLHS();
        auto rhs = binary->getRHS();
        auto lhs_affine = analyzeAffineExpr(lhs.get(), func);
        auto rhs_affine = analyzeAffineExpr(rhs.get(), func);
        if (!lhs_affine || !rhs_affine)
            return std::nullopt;

        if (binary->getOpcode() == OP::ADD) {
            if (lhs_affine->invariant || rhs_affine->invariant)
                return std::nullopt;
            return *lhs_affine + *rhs_affine;
        }
        if (binary->getOpcode() == OP::SUB) {
            if (lhs_affine->invariant || rhs_affine->invariant) {
                if (lhs_affine->invariant == rhs_affine->invariant) {
                    lhs_affine->invariant = nullptr;
                    rhs_affine->invariant = nullptr;
                } else
                    return std::nullopt;
            }
            return *lhs_affine - *rhs_affine;
        }
        if (binary->getOpcode() == OP::MUL) {
            if (lhs_affine->invariant || rhs_affine->invariant)
                return std::nullopt;

            if (!lhs_affine->coeffs.empty() && !rhs_affine->coeffs.empty())
                return std::nullopt;

            // rhs -> constant
            if (!rhs_affine->coeffs.empty())
                std::swap(lhs_affine, rhs_affine);

            return *lhs_affine * rhs_affine->constant;
        }
        return std::nullopt;
    }

    if (auto load = expr->as_raw<LOADInst>()) {
        if (isMemoryInvariantTo(load->getPtr().get(), func))
            return AffineExpr{.coeffs = {}, .constant = 0, .invariant = load};
    }

    return AffineExpr{.coeffs = {}, .constant = 0, .invariant = expr->as_raw<Value>()};
}

std::optional<MemoryAccess> AffineAAResult::analyzePointer(Value *ptr) const {
    auto base_ptr = ptr;
    std::vector<AffineExpr> indices;
    std::map<IndVar *, IterRange> domain;
    while (true) {
        if (auto gep = base_ptr->as_raw<GEPInst>()) {
            base_ptr = gep->getPtr().get();

            if (auto attr = gep->attr().get<Parser::IRGenAttrs>(); attr && attr->has(Parser::IRGenAttr::DecayGep))
                continue;

            // gep ptr, i --> a[i]
            // gep ptr, 0, i --> a[i]
            pVal index;
            if (!match(gep, M::Gep(M::Val(), M::Is(0), M::Bind(index))) &&
                !match(gep, M::Gep(M::Val(), M::Bind(index))))
                return std::nullopt;

            auto affine = analyzeAffineExpr(index.get(), func);
            if (!affine)
                return std::nullopt;

            for (const auto &[iv, coe] : affine->coeffs) {
                auto base = analyzeAffineExpr(iv->getBase().get(), func);
                auto step = analyzeAffineExpr(iv->getStep().get(), func);
                auto bound = analyzeAffineExpr(iv->getBound().get(), func);
                if (!base || !step || !bound) {
                    Logger::logDebug("[LAA]: Not Affine Domain?");
                    return std::nullopt;
                }
                domain.emplace(iv, IterRange{.base = *base, .step = *step, .bound = *bound});
            }
            indices.insert(indices.begin(), std::move(*affine));
        } else if (auto bitcast = base_ptr->as_raw<BITCASTInst>())
            base_ptr = bitcast->getOVal().get();
        else if (base_ptr->is<ALLOCAInst, GlobalVariable, FormalParam>())
            break;
        else
            return std::nullopt;
    }

    Err::gassert(base_ptr->getType()->is<PtrType>());
    if (!indices.empty() || getElm(ptr->getType())->is<ArrayType>())
        return MemoryAccess(ArrayAccess{.base = base_ptr, .indices = std::move(indices), .domain = std::move(domain)});

    return MemoryAccess(ScalarAccess{.base = base_ptr});
}

const std::optional<MemoryAccess> &AffineAAResult::queryPointer(Value *ptr) const {
    auto it = access_cache.find(ptr);
    if (it != access_cache.end())
        return it->second;
    return access_cache[ptr] = analyzePointer(ptr);
}

AliasInfo AffineAAResult::getAliasInfo(Value *ptr1, Value *ptr2) const {
    if (ptr1 == ptr2)
        return AliasInfo::MustAlias;

    auto &info1 = queryPointer(ptr1);
    auto &info2 = queryPointer(ptr2);

    if (!info1 || !info2)
        return AliasInfo::MayAlias;

    if (info1->type() != info2->type())
        return AliasInfo::NoAlias;

    Err::gassert((info1->isArray() && info2->isArray()) || (info1->isScalar() && info2->isScalar()), "Bad analysis");

    if (info1->isArray()) {
        auto &[base1, affine1, domain1] = info1->array();
        auto &[base2, affine2, domain2] = info2->array();

        if (base1 != base2)
            return AliasInfo::NoAlias;

        if (affine1 == affine2)
            return AliasInfo::MustAlias;

        // FIXME: More accurate dep test here
        // TODO: Use the domain
        return AliasInfo::MayAlias;
    }

    if (info1->isScalar())
        return info1->scalar().base == info2->scalar().base ? AliasInfo::MustAlias : AliasInfo::NoAlias;

    Err::unreachable("Unknown access type");

    return AliasInfo::MayAlias;
}

const std::optional<InstRW> &AffineAAResult::queryInstRW(Instruction *inst) const {
    auto it = inst_rw_cache.find(inst);
    if (it != inst_rw_cache.end())
        return it->second;
    return inst_rw_cache[inst] = analyzeInstRW(inst);
}

const std::optional<MemoryAccess> &AffineAAResult::queryPointer(const pVal &v) const { return queryPointer(v.get()); }
const std::optional<InstRW> &AffineAAResult::queryInstRW(const pInst &inst) const { return queryInstRW(inst.get()); }

AliasInfo AffineAAResult::getAliasInfo(const pVal &lhs, const pVal &rhs) const {
    return getAliasInfo(lhs.get(), rhs.get());
}

std::optional<InstRW> AffineAAResult::analyzeInstRW(Instruction *inst) const {
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

    if (auto call = inst->as_raw<CALLInst>()) {
        auto callee_decl = call->getFunc();
        auto callee_def = callee_decl->as<LinearFunction>();

        // TODO: Inter-procedural analysis
        if (callee_def)
            return std::nullopt;

        if (callee_decl->hasFnAttr(FuncAttr::builtinMemWriteOnly)) {
            auto actual_args = call->getArgs();
            for (const auto &actual : actual_args) {
                if (actual->getType()->getTrait() == IRCTYPE::PTR)
                    rw.write.insert(actual.get());
            }
        } else if (callee_decl->hasFnAttr(FuncAttr::builtinMemReadOnly)) {
            auto actual_args = call->getArgs();
            for (const auto &actual : actual_args) {
                if (actual->getType()->getTrait() == IRCTYPE::PTR)
                    rw.read.insert(actual.get());
            }
        } else if (callee_decl->hasFnAttr(FuncAttr::builtinMemNoReadWrite))
            return InstRW{};
        else
            return std::nullopt;

        return rw;
    }

    // For other instructions, they don't have any read/write.
    return InstRW{};
}

bool AffineAAResult::isIndependent(Instruction *lhs, Instruction *rhs) const {
    auto &rw1 = queryInstRW(lhs);
    auto &rw2 = queryInstRW(rhs);

    if (rw1 && rw1->read.empty() && rw1->write.empty())
        return true;

    if (rw2 && rw2->read.empty() && rw2->write.empty())
        return true;

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
    if (has_dep(rw1->write, rw2->read) || has_dep(rw2->write, rw1->read) || has_dep(rw1->write, rw2->write))
        return false;

    return true;
}

bool AffineAAResult::isScalarIndependent(Instruction *lhs, Instruction *rhs) const {
    auto &rw1 = queryInstRW(lhs);
    auto &rw2 = queryInstRW(rhs);

    if (!rw1 || !rw2)
        return false;

    auto has_dep = [&](const std::set<Value *> &set1, const std::set<Value *> &set2) {
        for (const auto &s1 : set1) {
            const auto &a1 = queryPointer(s1);
            // Scalar pointer's query can't fail, so s1 must be array if `a1`
            if (!a1 || !a1->isScalar())
                continue;
            for (const auto &s2 : set2) {
                const auto &a2 = queryPointer(s2);
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

bool AffineAAResult::isScalarIndependent(const pInst &lhs, const pInst &rhs) const {
    return isIndependent(lhs.get(), rhs.get());
}

bool AffineAAResult::isIndependent(const pInst &lhs, const pInst &rhs) const {
    return isIndependent(lhs.get(), rhs.get());
}

AffineAAResult AffineAliasAnalysis::run(LinearFunction &f, LFAM &fam) { return AffineAAResult(&f, &fam); }

using namespace CSTR;

VarID getIDFrom(std::map<Value *, VarID> &map, VarHandle &VH, Value *val) {
    auto it = map.find(val);
    if (it != map.end())
        return it->second;
    return map[val] = VH.newVar(val->getName().substr(1));
}

Expr buildConstraintExpr(const AffineExpr &ae, const std::map<IndVar *, VarID> &iv_map, VarHandle &VH,
                         std::map<Value *, VarID> &invariant_map) {
    Expr e;
    e.constant = ae.constant;
    for (auto &[iv, c] : ae.coeffs) {
        auto it = iv_map.find(iv);
        if (it != iv_map.end())
            e.coeffs[it->second] = c;
        else {
            // This can happen when an iv occurs in another iv's base/bound,
            // and it should be treated as an invariant.
            auto var = getIDFrom(invariant_map, VH, iv);
            e.coeffs[var] = c;
        }
    }

    if (ae.invariant != nullptr) {
        VarID var = getIDFrom(invariant_map, VH, ae.invariant);
        e.coeffs[var] = 1;
    }
    return e;
}

Expr buildConstraintExpr(VarID id) { return Expr{.coeffs = {{id, 1}}, .constant = 0}; }

bool AffineAAResult::hasLoopCarriedDependence(FORInst *affine_for) {
    const auto &rw = queryInstRW(affine_for);
    if (!rw)
        return true;

    OmegaSolver solver;
    // solver.enableDebugDump(std::cerr);

    auto has_deps = [&](const std::set<Value *> &set1, const std::set<Value *> &set2) {
        for (const auto &v1 : set1) {
            const auto &a1 = queryPointer(v1);
            if (!a1)
                return true;
            if (a1->isScalar())
                continue;

            auto acc1 = a1->array();

            for (const auto &v2 : set2) {
                if (v1 == v2)
                    continue;

                const auto &a2 = queryPointer(v2);
                if (!a2)
                    return true;
                if (a2->isScalar())
                    continue;

                auto acc2 = a2->array();

                // Skip same access, not same base or different dimensions
                if (acc1 == acc2 || acc1.base != acc2.base || acc1.indices.size() != acc2.indices.size())
                    continue;

                solver.reset();

                // Build constraints for existence of two iterations.
                // iv map -> VarID for each iteration
                std::map<IndVar *, VarID> iv1_map;
                std::map<IndVar *, VarID> iv2_map;
                std::map<Value *, VarID> invariant_map;

                std::set<IndVar *> iv_in_expr;
                for (auto &[iv, rng] : acc1.domain)
                    iv_in_expr.insert(iv);
                for (auto &[iv, rng] : acc2.domain)
                    iv_in_expr.insert(iv);

                for (IndVar *iv : iv_in_expr) {
                    auto id = iv->getName().substr(1);
                    iv1_map[iv] = solver.VH.newVar(id + "_1");
                    iv2_map[iv] = solver.VH.newVar(id + "_2");
                }

                // For all iv outer than curr iv, ensure v1 == v2.
                auto curr_iv = affine_for->getIndVar().get();
                for (auto iv : iv_in_expr) {
                    if (iv->getDepth() >= curr_iv->getDepth())
                        continue;
                    auto iv1 = buildConstraintExpr(iv1_map.at(iv));
                    auto iv2 = buildConstraintExpr(iv2_map.at(iv));
                    solver.addConstraint(Constraint::newEqual(iv1, iv2));
                }

                // Ensure indices are equal
                // We've ensured the dims are equal above.
                size_t dims = acc1.indices.size();
                for (size_t d = 0; d < dims; ++d) {
                    auto e1 = buildConstraintExpr(acc1.indices[d], iv1_map, solver.VH, invariant_map);
                    auto e2 = buildConstraintExpr(acc2.indices[d], iv2_map, solver.VH, invariant_map);
                    solver.addConstraint(Constraint::newEqual(e1, e2));
                }

                // Add iteration domain constraints for each iv
                // TODO: When step != 1, there can be more accurate result.
                for (IndVar *iv : iv_in_expr) {
                    auto it1 = acc1.domain.find(iv);
                    if (it1 != acc1.domain.end()) {
                        auto base = buildConstraintExpr(it1->second.base, iv1_map, solver.VH, invariant_map);
                        auto bound = buildConstraintExpr(it1->second.bound, iv1_map, solver.VH, invariant_map);
                        auto iv_var = buildConstraintExpr(iv1_map.at(iv));
                        solver.addConstraint(Constraint::newGreaterEqual(iv_var, base));
                        solver.addConstraint(Constraint::newLessThan(iv_var, bound));
                    }

                    auto it2 = acc2.domain.find(iv);
                    if (it2 != acc2.domain.end()) {
                        auto base = buildConstraintExpr(it2->second.base, iv2_map, solver.VH, invariant_map);
                        auto bound = buildConstraintExpr(it2->second.bound, iv2_map, solver.VH, invariant_map);
                        auto iv_var = buildConstraintExpr(iv2_map.at(iv));
                        solver.addConstraint(Constraint::newGreaterEqual(iv_var, base));
                        solver.addConstraint(Constraint::newLessThan(iv_var, bound));
                    }
                }

                // Add invariant iv range
                // Don't introduce more parameters here, they are not related to current problem.
                for (const auto &[invariant, var] : invariant_map) {
                    auto iv = invariant->as<IndVar>();
                    if (!iv)
                        continue;

                    auto expr = buildConstraintExpr(var);
                    if (auto base_ci = iv->getBase()->as<ConstantInt>())
                        solver.addConstraint(Constraint::newGreaterEqual(expr, {.constant = base_ci->getVal()}));
                    else if (auto it = invariant_map.find(iv->getBase().get()); it != invariant_map.end())
                        solver.addConstraint(Constraint::newGreaterEqual(expr, buildConstraintExpr(it->second)));

                    if (auto bound_ci = iv->getBound()->as<ConstantInt>())
                        solver.addConstraint(Constraint::newLessThan(expr, {.constant = bound_ci->getVal()}));
                    else if (auto it = invariant_map.find(iv->getBound().get()); it != invariant_map.end())
                        solver.addConstraint(Constraint::newLessThan(expr, buildConstraintExpr(it->second)));
                }

                // std::cerr << "Candidate: " << v1->getName() << " and " << v2->getName() << std::endl;

                if (iv_in_expr.count(curr_iv)) {
                    // Ensure 'iv1 != iv2'
                    auto curr_iv1 = iv1_map.at(curr_iv);
                    auto curr_iv2 = iv2_map.at(curr_iv);
                    auto curr_iv1_expr = buildConstraintExpr(curr_iv1);
                    auto curr_iv2_expr = buildConstraintExpr(curr_iv2);

                    // iv1 > iv2
                    {
                        OmegaSolver s = solver;
                        s.addConstraint(Constraint::newGreaterThan(curr_iv1_expr, curr_iv2_expr));
                        if (s.mayHasIntSolutions())
                            return true;
                    }

                    //
                    // or
                    //

                    // iv1 < iv2
                    {
                        OmegaSolver s = solver;
                        s.addConstraint(Constraint::newLessThan(curr_iv1_expr, curr_iv2_expr));
                        if (s.mayHasIntSolutions())
                            return true;
                    }
                }
                // curr_iv is invariant, no need to add constraints for it.
                else {
                    if (solver.mayHasIntSolutions())
                        return true;
                }
            }
        }
        return false;
    };

    if (has_deps(rw->read, rw->write) || has_deps(rw->write, rw->write))
        return true;

    return false;
}
bool AffineAAResult::hasLoopCarriedDependence(const pForInst &affine_for) {
    return hasLoopCarriedDependence(affine_for.get());
}

pVal AccessSynthesizer::synthesize(const MemoryAccess &access) const {
    if (access.isScalar())
        return synthesize(access.scalar());

    return synthesize(access.array());
}

pVal AccessSynthesizer::synthesize(const pVal &base, const std::vector<AffineExpr> &indices) const {
    static size_t name_cnt = 0;
    pVal curr = base->as<Value>();
    for (const auto &index : indices) {
        auto index_val = synthesize(index);
        pGep gep;
        if (curr->is<FormalParam>()) {
            gep = std::make_shared<GEPInst>("%acsyn.a" + std::to_string(name_cnt++), curr, index_val);
        } else {
            gep =
                std::make_shared<GEPInst>("%acsyn.a" + std::to_string(name_cnt++), curr, pool->getConst(0), index_val);
        }
        ilist->insert(iter, gep);
        curr = gep;
    }
    return curr;
}

pVal AccessSynthesizer::synthesize(const ArrayAccess &access) const {
    return synthesize(access.base->as<Value>(), access.indices);
}

pVal AccessSynthesizer::synthesize(const ScalarAccess &access) const { return access.base->as<Value>(); }
pVal AccessSynthesizer::synthesize(const AffineExpr &expr) const {
    static size_t name_cnt = 0;
    pVal curr;
    if (expr.invariant == nullptr)
        curr = pool->getConst(expr.constant);
    else if (expr.constant == 0)
        curr = expr.invariant->as<Value>();
    else {
        auto bin = std::make_shared<BinaryInst>("%acsyn.e" + std::to_string(name_cnt++), OP::ADD,
                                                pool->getConst(expr.constant), expr.invariant->as<Value>());
        ilist->insert(iter, bin);
        curr = bin;
    }

    for (const auto &[iv, coe] : expr.coeffs) {
        pVal iv_expr = iv->as<Value>();
        if (coe != 1) {
            auto bin = std::make_shared<BinaryInst>("%acsyn.e" + std::to_string(name_cnt++), OP::MUL,
                                                    pool->getConst(coe), iv->as<Value>());
            ilist->insert(iter, bin);
            iv_expr = bin;
        }
        auto bin = std::make_shared<BinaryInst>("%acsyn.e" + std::to_string(name_cnt++), OP::ADD, curr, iv_expr);
        ilist->insert(iter, bin);
        curr = bin;
    }

    return curr;
}
} // namespace SIR
