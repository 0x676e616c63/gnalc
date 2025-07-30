// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/analysis/basic_alias_analysis.hpp"

#include "config/config.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "ir/passes/transforms/memoization.hpp"
#include "utils/logger.hpp"

#include <algorithm>
#include <optional>

namespace IR {
PM::UniqueKey BasicAliasAnalysis::Key;

bool BasicAAResult::insertPotentialAlias(Value *target, Value *alias) {
    Err::gassert(target->getType()->getTrait() == IRCTYPE::PTR);

    auto &info = ptr_info[target];
    if (alias->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
        info.global_var = true;
        return info.potential_alias.insert(alias).second;
    } else if (alias->getVTrait() == ValueTrait::FORMAL_PARAMETER) {
        info.foreign_array = true;
        return info.potential_alias.insert(alias).second;
    } else {
        const auto &alias_info = ptr_info[alias];
        bool changed = false;
        for (const auto &r : alias_info.potential_alias)
            changed |= info.potential_alias.insert(r).second;
        info.foreign_array |= alias_info.foreign_array;
        info.global_var |= alias_info.global_var;
        info.untracked |= alias_info.untracked;
        return changed;
    }
    return false;
}

bool BasicAAResult::setUntracked(Value *ptr) {
    if (!ptr_info[ptr].untracked) {
        ptr_info[ptr].untracked = true;
        return true;
    }
    return false;
}

BasicAAResult::PtrInfo BasicAAResult::getPtrInfo(Value *ptr) const {
    Err::gassert(ptr->getType()->getTrait() == IRCTYPE::PTR);
    if (ptr->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
        return PtrInfo{.foreign_array = false, .global_var = true, .untracked = false, .potential_alias = {ptr}};
    }

    auto it = ptr_info.find(ptr);
    Err::gassert(it != ptr_info.end(), "No such pointer registered.");
    return it->second;
}

// Returns the ALLOCA/GlobalVariable/FormalParameter and offset about it.
std::optional<std::tuple<const Value *, size_t>> getGepTotalOffsetImpl(const GEPInst *gep, std::unordered_set<const Value*>& visited) {
    size_t offset = 0;
    while (gep) {
        if (!gep->isConstantOffset())
            return std::nullopt;
        offset += gep->getConstantOffset();

        auto base_ptr = gep->getPtr().get();
        if (auto bitcast = base_ptr->as_raw<BITCASTInst>())
            base_ptr = bitcast->getOVal().get();

        if (auto base_gep = base_ptr->as_raw<GEPInst>())
            gep = base_gep;
        else if (auto alloca = base_ptr->as_raw<ALLOCAInst>())
            return std::make_tuple(alloca, offset);
        else if (auto gv = base_ptr->as_raw<GlobalVariable>())
            return std::make_tuple(gv, offset);
        else if (auto fp = base_ptr->as_raw<FormalParam>())
            return std::make_tuple(fp, offset);
        else if (auto phi = base_ptr->as_raw<PHIInst>()) {
            if (!visited.emplace(phi).second)
                return std::nullopt;

            const Value *common_base = nullptr;
            size_t common_offset = 0;

            for (const auto &[phi_gep, bb] : phi->incomings()) {
                if (!phi_gep->is<GEPInst>())
                    return std::nullopt;

                auto opt = getGepTotalOffsetImpl(phi_gep->as_raw<GEPInst>(), visited);
                if (!opt.has_value())
                    return std::nullopt;
                auto [phi_base, phi_offset] = *opt;
                if (common_base == nullptr) { // first
                    common_base = phi_base;
                    common_offset = phi_offset;
                } else {
                    if (phi_base != common_base || phi_offset != common_offset)
                        return std::nullopt;
                }
            }
            return std::make_tuple(common_base, common_offset);
        } else if (auto select = base_ptr->as_raw<SELECTInst>()) {
            auto true_val = select->getTrueVal().get();
            auto false_val = select->getFalseVal().get();
            if (!true_val->is<GEPInst>() || !false_val->is<GEPInst>())
                return std::nullopt;

            auto true_opt = getGepTotalOffsetImpl(true_val->as_raw<GEPInst>(), visited);
            if (!true_opt)
                return std::nullopt;

            auto false_opt = getGepTotalOffsetImpl(false_val->as_raw<GEPInst>(), visited);
            if (!false_opt)
                return std::nullopt;

            auto [true_base, true_offset] = *true_opt;
            auto [false_base, false_offset] = *false_opt;

            if (true_base != false_base || true_offset != false_offset)
                return std::nullopt;

            return std::make_tuple(true_base, true_offset);
        } else
            Err::unreachable();
    }
    return std::nullopt;
}

std::optional<std::tuple<const Value *, size_t>> getGepTotalOffset(const GEPInst *gep) {
    std::unordered_set<const Value*> visited;
    return getGepTotalOffsetImpl(gep, visited);
}

AliasInfo BasicAAResult::getAliasInfo(Value *v1, Value *v2) const {
    // Err::gassert(v1->getType()->getTrait() == IRCTYPE::PTR && v2->getType()->getTrait() == IRCTYPE::PTR);

    if (v1 == v2)
        return AliasInfo::MustAlias;

    auto cache_key = std::make_tuple(v1, v2);
    if (auto it = alias_cache.find(cache_key); it != alias_cache.end())
        return it->second;
    if (auto it = alias_cache.find(std::make_tuple(v2, v1)); it != alias_cache.end())
        return it->second;

    auto info1 = getPtrInfo(v1);
    auto info2 = getPtrInfo(v2);

    if (info1.untracked || info2.untracked)
        return alias_cache[cache_key] = AliasInfo::MayAlias;

    if (info1.foreign_array && info2.foreign_array)
        return alias_cache[cache_key] = AliasInfo::MayAlias;

    auto gep1 = v1->as_raw<GEPInst>();
    auto gep2 = v2->as_raw<GEPInst>();
    // If all gep and no phi involve
    if (gep1 && gep2 && info1.potential_alias.size() == 1 && info2.potential_alias.size() == 1) {
        auto opt1 = getGepTotalOffset(gep1);
        auto opt2 = getGepTotalOffset(gep2);
        if (opt1.has_value() && opt2.has_value()) {
            auto [base1, offset1] = opt1.value();
            auto [base2, offset2] = opt2.value();
            // They are all constant offset, and all based on ALLOCAInst or GlobalVariable
            // If the base and offset are identical, the gep must alias.
            if (base1 == base2 && offset1 == offset2)
                return alias_cache[cache_key] = AliasInfo::MustAlias;
            return alias_cache[cache_key] = AliasInfo::NoAlias;
        }
    }

    const auto &set1 = info1.potential_alias;
    const auto &set2 = info2.potential_alias;

    const auto &smaller = set1.size() <= set2.size() ? set1 : set2;
    const auto &larger = set1.size() > set2.size() ? set1 : set2;

    for (auto val : smaller) {
        if (larger.find(val) != larger.end())
            return alias_cache[cache_key] = AliasInfo::MayAlias;
    }

    return alias_cache[cache_key] = AliasInfo::NoAlias;
}
bool BasicAAResult::isLocal(Value *v) const {
    auto info = getPtrInfo(v);
    return !info.global_var && !info.foreign_array && !info.untracked;
}

ModRefInfo BasicAAResult::getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const {
    // It's a hot path, even `gassert` can produce cost.
    // Err::gassert(location->getType()->getTrait() == IRCTYPE::PTR);

    switch (inst->getOpcode()) {
    case OP::LOAD: {
        auto load = inst->as_raw<LOADInst>();
        auto aa = getAliasInfo(load->getPtr().get(), location);
        if (aa == AliasInfo::NoAlias)
            return ModRefInfo::NoModRef;
        else
            return ModRefInfo::Ref;
    } break;
    case OP::STORE: {
        auto store = inst->as_raw<STOREInst>();
        auto aa = getAliasInfo(store->getPtr().get(), location);
        if (aa == AliasInfo::NoAlias)
            return ModRefInfo::NoModRef;
        else
            return ModRefInfo::Mod;
    } break;
    case OP::CALL: {
        auto call = inst->as_raw<CALLInst>();
        auto rwinfo = getCallRWInfo(fam, call);
        if (rwinfo.untracked)
            return ModRefInfo::ModRef;

        bool mod = false;
        bool ref = false;
        // Note that the callee can access the whole array through a gep 0, 0.
        // So we need to check the actual argument's all potential alias,
        // since all of them can be accessed through that argument in the callee.
        for (auto actual_write : rwinfo.write) {
            auto actual_alias = getPtrInfo(actual_write).potential_alias;
            for (const auto &mayalias : actual_alias) {
                auto alias = getAliasInfo(mayalias, location);
                mod |= (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias);
            }
            if (mod)
                break;
        }
        for (auto actual_read : rwinfo.read) {
            auto actual_alias = getPtrInfo(actual_read).potential_alias;
            for (const auto &mayalias : actual_alias) {
                auto alias = getAliasInfo(mayalias, location);
                ref |= (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias);
            }
            if (ref)
                break;
        }

        if (mod && ref)
            return ModRefInfo::ModRef;
        if (mod)
            return ModRefInfo::Mod;
        if (ref)
            return ModRefInfo::Ref;
    } break;
    default:
        return ModRefInfo::NoModRef;
    }
    return ModRefInfo::NoModRef;
}

ModRefInfo BasicAAResult::getFunctionModRefInfo() const {
    if (has_untracked_call)
        return ModRefInfo::ModRef;

    size_t real_read = std::count_if(read.begin(), read.end(), [](auto &p) {
        if (auto memo = p->attr().template get<MemoAttrs>(); memo && memo->has(MemoAttr::LUT))
            return false;
        return true;
    });

    size_t real_write = std::count_if(write.begin(), write.end(), [](auto &p) {
        if (auto memo = p->attr().template get<MemoAttrs>(); memo && memo->has(MemoAttr::LUT))
            return false;
        return true;
    });

    if (real_read == 0 && real_write == 0)
        return ModRefInfo::NoModRef;

    if (real_read == 0 && real_write > 0)
        return ModRefInfo::Mod;

    if (real_read > 0 && real_write == 0)
        return ModRefInfo::Ref;

    return ModRefInfo::ModRef;
}
bool BasicAAResult::hasUntrackedCall() const { return has_untracked_call; }
bool BasicAAResult::hasSylibCall() const { return has_sylib_call; }

void BasicAAResult::addClonedPointer(Value *raw, Value *cloned) {
    Err::gassert(ptr_info.count(raw), "No such instruction registered.");
    ptr_info[cloned] = ptr_info[raw];
}

AliasInfo BasicAAResult::getAliasInfo(const pVal &v1, const pVal &v2) const { return getAliasInfo(v1.get(), v2.get()); }
bool BasicAAResult::isLocal(const pVal &v) const { return isLocal(v.get()); }
ModRefInfo BasicAAResult::getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const {
    return getInstModRefInfo(inst.get(), location.get(), fam);
}
void BasicAAResult::addClonedPointer(const pVal &raw, const pVal &cloned) { addClonedPointer(raw.get(), cloned.get()); }

BasicAAResult BasicAliasAnalysis::run(Function &func, FAM &fam) {
    BasicAAResult res;
    res.func = &func;

    // Array arguments
    for (const auto &curr : func.getParams()) {
        auto curr_trait = curr->getType()->getTrait();
        if (curr_trait == IRCTYPE::PTR) {
            res.ptr_info[curr.get()] =
                BasicAAResult::PtrInfo{.foreign_array = true, .global_var = false, .untracked = false, .potential_alias = {curr.get()}};
        }
    }

    auto entry = func.getBlocks().front().get();

    // Local Alloca
    for (const auto &inst : *entry) {
        if (auto alloca = inst->as<ALLOCAInst>()) {
            if (alloca->getBaseType()->getTrait() == IRCTYPE::ARRAY) {
                res.ptr_info[alloca.get()] = BasicAAResult::PtrInfo{
                    .foreign_array = false, .global_var = false, .untracked = false, .potential_alias = {alloca.get()}};
            }
        }
    }

    // Alias
    bool changed = true;
    while (changed) {
        changed = false;
        auto dfv = func.getDFVisitor();
        for (const auto &curr : dfv) {
            for (const auto &phi : curr->phis()) {
                if (phi->getType()->getTrait() == IRCTYPE::PTR) {
                    for (const auto &oper : phi->incomings())
                        changed |= res.insertPotentialAlias(phi.get(), oper.value.get());
                }
            }
            for (const auto &inst : *curr) {
                if (inst->getType()->getTrait() == IRCTYPE::PTR) {
                    if (auto alloca = inst->as<ALLOCAInst>()) {
                        // We've handled it above
                        continue;
                    }
                    if (auto gep = inst->as<GEPInst>()) {
                        changed |= res.insertPotentialAlias(gep.get(), gep->getPtr().get());
                    } else if (auto bitcast = inst->as<BITCASTInst>()) {
                        Err::gassert(bitcast->getOVal()->getType()->getTrait() == IRCTYPE::PTR);
                        changed |= res.insertPotentialAlias(bitcast.get(), bitcast->getOVal().get());
                    } else if (auto select = inst->as<SELECTInst>()) {
                        changed |= res.insertPotentialAlias(select.get(), select->getTrueVal().get());
                        changed |= res.insertPotentialAlias(select.get(), select->getFalseVal().get());
                    } else {
                        changed |= res.setUntracked(inst.get());
                    }
                }
            }
        }
    }

    // ModRef
    for (const auto &bb : func) {
        for (const auto &inst : *bb) {
            if (auto load = inst->as<LOADInst>()) {
                auto ptralias = res.getPtrInfo(load->getPtr().get()).potential_alias;
                for (const auto &mayalias : ptralias) {
                    if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                        mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                        res.read.insert(mayalias);
                }
            } else if (auto store = inst->as<STOREInst>()) {
                auto ptralias = res.getPtrInfo(store->getPtr().get()).potential_alias;
                for (const auto &mayalias : ptralias) {
                    if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                        mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                        res.write.insert(mayalias);
                }
            } else if (auto call = inst->as<CALLInst>()) {
                auto callee = call->getFunc().get();
                if (auto callee_def = callee->as_raw<Function>()) {
                    // SysY 2022 enforces strict definition-before-use for functions,
                    // but with no support for function declarations.
                    // This implies that mutual recursion (fn0 -> fn1 -> fn0) is impossible.
                    // For example, without function declarations,
                    // the following can't compile.
                    // int fn0() { return fn1(); }
                    // int fn1() { return fn0(); }
                    // Given that, we only check if the `call` refers to
                    // the current function to see if it is in a recursive chain.
                    if (callee_def != &func) {
                        const auto &callee_aa = fam.getResult<BasicAliasAnalysis>(*callee_def);

                        for (auto write : callee_aa.write) {
                            if (callee_aa.getPtrInfo(write).global_var)
                                res.write.insert(write);
                            else if (callee_aa.getPtrInfo(write).foreign_array) {
                                auto fp = write->as_raw<FormalParam>();
                                auto actual = call->getArgs()[fp->getIndex()].get();
                                auto actual_alias = res.getPtrInfo(actual).potential_alias;
                                for (const auto &mayalias : actual_alias) {
                                    if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                                        mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                                        res.write.insert(mayalias);
                                }
                            }
                        }

                        for (auto read : callee_aa.read) {
                            if (callee_aa.getPtrInfo(read).global_var)
                                res.read.insert(read);
                            else if (callee_aa.getPtrInfo(read).foreign_array) {
                                auto fp = read->as_raw<FormalParam>();
                                auto actual = call->getArgs()[fp->getIndex()].get();
                                auto actual_alias = res.getPtrInfo(actual).potential_alias;
                                for (const auto &mayalias : actual_alias) {
                                    if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                                        mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                                        res.read.insert(mayalias);
                                }
                            }
                        }

                        res.has_untracked_call |= callee_aa.has_untracked_call;
                        res.has_sylib_call |= callee_aa.has_sylib_call;
                    }
                } else {
                    Err::gassert(!callee->hasFnAttr(FuncAttr::NotBuiltin), "Not builtin but has no definition");

                    if (callee->hasFnAttr(FuncAttr::isSylib))
                        res.has_sylib_call = true;

                    if (!callee->hasFnAttr(FuncAttr::builtinMemReadOnly) &&
                        !callee->hasFnAttr(FuncAttr::builtinMemWriteOnly))
                        continue;

                    // For memcpy intrinsic, a more precise analysis is available.
                    if (callee->hasFnAttr(FuncAttr::isMemcpyIntrinsic)) {
                        auto actual_args = call->getArgs();
                        auto dest = actual_args[0].get();
                        auto src = actual_args[1].get();
                        for (const auto &mayalias : res.getPtrInfo(dest).potential_alias) {
                            if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                                mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                                res.write.insert(mayalias);
                        }
                        for (const auto &mayalias : res.getPtrInfo(src).potential_alias) {
                            if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                                mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                                res.write.insert(mayalias);
                        }
                    } else if (callee->hasFnAttr(FuncAttr::builtinMemWriteOnly)) {
                        auto actual_args = call->getArgs();
                        for (const auto &actual : actual_args) {
                            if (actual->getType()->getTrait() == IRCTYPE::PTR) {
                                for (const auto &mayalias : res.getPtrInfo(actual.get()).potential_alias) {
                                    if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                                        mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                                        res.write.insert(mayalias);
                                }
                            }
                        }
                    } else if (callee->hasFnAttr(FuncAttr::builtinMemReadOnly)) {
                        auto actual_args = call->getArgs();
                        for (const auto &actual : actual_args) {
                            if (actual->getType()->getTrait() == IRCTYPE::PTR) {
                                for (const auto &mayalias : res.getPtrInfo(actual.get()).potential_alias) {
                                    if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                                        mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                                        res.read.insert(mayalias);
                                }
                            }
                        }
                    } else
                        res.has_untracked_call = true;
                }
            }
        }
    }

    return res;
}
} // namespace IR
