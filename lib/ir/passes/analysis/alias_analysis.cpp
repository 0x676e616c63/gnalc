#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/utils/logger.hpp"

#include <deque>
#include <optional>

namespace IR {
PM::UniqueKey AliasAnalysis::Key;

bool AliasAnalysisResult::insertPotentialAlias(const Value *target,
                                               const Value *alias) {
    Err::gassert(target->getType()->getTrait() == IRCTYPE::PTR);

    auto &info = ptr_info[target];
    if (alias->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
        info.global_var = true;
        return info.potential_alias.insert(alias).second;
    } else if (alias->getVTrait() == ValueTrait::FORMAL_PARAMETER) {
        info.untracked_array = true;
        return info.potential_alias.insert(alias).second;
    } else {
        const auto &alias_info = ptr_info[alias];
        bool changed = false;
        for (const auto &r : alias_info.potential_alias)
            changed |= info.potential_alias.insert(r).second;
        info.untracked_array |= alias_info.untracked_array;
        info.global_var |= alias_info.global_var;
        return changed;
    }
    return false;
}
AliasAnalysisResult::PtrInfo
AliasAnalysisResult::getPtrInfo(const Value *ptr) const {
    Err::gassert(ptr->getType()->getTrait() == IRCTYPE::PTR);
    if (ptr->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
        return PtrInfo{.untracked_array = false,
                       .global_var = true,
                       .potential_alias = { ptr }};
    }

    auto it = ptr_info.find(ptr);
    Err::gassert(it != ptr_info.end());
    return it->second;
}

bool mayPtrInfoAlias(const AliasAnalysisResult::PtrInfo &info1,
                    const AliasAnalysisResult::PtrInfo &info2) {
    if (info1.untracked_array || info2.untracked_array
        || info1.global_var || info2.global_var)
        return true;

    for (auto p1 : info1.potential_alias) {
        for (auto p2 : info2.potential_alias) {
            if (p1 == p2)
                return true;
        }
    }

    return false;
}

// Returns the ALLOCA/GlobalVariable and offset about it.
std::optional<std::tuple<const Value*, size_t>> getGepTotalOffset(const GEPInst* gep) {
    size_t offset = 0;
    while (gep) {
        if (!gep->isConstantOffset())
            return std::nullopt;
        offset += gep->getConstantOffset();
        auto base_ptr = gep->getPtr().get();
        if (auto base_gep = dynamic_cast<const GEPInst*>(base_ptr)) {
            gep = base_gep;
        }
        else if (auto alloca = dynamic_cast<const ALLOCAInst*>(base_ptr))
            return std::make_tuple(alloca, offset);
        else if (auto gv = dynamic_cast<GlobalVariable*>(base_ptr))
            return std::make_tuple(gv, offset);
        else Err::unreachable();
    }
    return std::nullopt;
}

AliasAnalysisResult::AliasInfo
AliasAnalysisResult::getAliasInfo(const Value *v1, const Value *v2) const {
    Err::gassert(v1->getType()->getTrait() == IRCTYPE::PTR &&
                 v2->getType()->getTrait() == IRCTYPE::PTR);

    if (v1 == v2)
        return AliasInfo::MustAlias;

    auto info1 = getPtrInfo(v1);
    auto info2 = getPtrInfo(v2);

    if (info1.untracked_array && info2.untracked_array)
        return AliasInfo::MayAlias;
    if (info1.global_var && info2.global_var)
        return AliasInfo::NoAlias;

    auto gep1 = dynamic_cast<const GEPInst *>(v1);
    auto gep2 = dynamic_cast<const GEPInst *>(v2);
    // If all gep and no phi involves
    if (gep1 && gep2 && info1.potential_alias.size() == 1 && info2.potential_alias.size() == 1) {
        auto opt1 = getGepTotalOffset(gep1);
        auto opt2 = getGepTotalOffset(gep2);
        if (opt1.has_value() && opt2.has_value()) {
            auto [base1, offset1] = opt1.value();
            auto [base2, offset2] = opt2.value();
            // They are all constant offset, and all based on ALLOCAInst or GlobalVariable
            // If the base and offset are identical, the gep must alias.
            if (base1 == base2 && offset1 == offset2)
                return AliasInfo::MustAlias;
            return AliasInfo::NoAlias;
        }
    }

    for (auto p1 : info1.potential_alias) {
        for (auto p2 : info2.potential_alias) {
            if (p1 == p2)
                return AliasInfo::MayAlias;
        }
    }

    return AliasInfo::NoAlias;
}

AliasAnalysisResult::ModRefInfo
AliasAnalysisResult::getInstModRefInfo(const Instruction *inst,
                                       const Value *location, FAM &fam) const {
    Err::gassert(location->getType()->getTrait() == IRCTYPE::PTR);

    auto location_info = getPtrInfo(location);
    if (auto load = dynamic_cast<const LOADInst *>(inst)) {
        auto aa = getAliasInfo(load->getPtr().get(), location);
        if (aa == AliasInfo::NoAlias)
            return ModRefInfo::NoModRef;
        else
            return ModRefInfo::Ref;
    } else if (auto store = dynamic_cast<const STOREInst *>(inst)) {
        auto aa = getAliasInfo(store->getPtr().get(), location);
        if (aa == AliasInfo::NoAlias)
            return ModRefInfo::NoModRef;
        else
            return ModRefInfo::Mod;
    } else if (auto call = dynamic_cast<const CALLInst *>(inst)) {
        auto callee = call->getFunc().get();
        if (auto callee_def = dynamic_cast<Function *>(callee)) {
            if (callee_def != this->func) {
                auto callee_aa = fam.getResult<AliasAnalysis>(*callee_def);
                if (callee_aa.has_untracked_call)
                    return ModRefInfo::ModRef;
                if (callee_aa.getFunctionModRefInfo() == ModRefInfo::NoModRef)
                    return ModRefInfo::NoModRef;

                bool mod = false;
                bool ref = false;

                for (auto write : callee_aa.write) {
                    PtrInfo write_info;
                    if (write->getVTrait() == ValueTrait::GLOBAL_VARIABLE)
                        write_info = getPtrInfo(write);
                    else {
                        Err::gassert(write->getVTrait() ==
                                     ValueTrait::FORMAL_PARAMETER);
                        auto fp = dynamic_cast<const FormalParam *>(write);
                        write_info =
                            getPtrInfo(call->getArgs()[fp->getIndex()].get());
                    }
                    mod |= mayPtrInfoAlias(location_info, write_info);
                    if (mod)
                        break;
                }
                for (auto read : callee_aa.read) {
                    PtrInfo read_info;
                    if (read->getVTrait() == ValueTrait::GLOBAL_VARIABLE)
                        read_info = getPtrInfo(read);
                    else {
                        Err::gassert(read->getVTrait() ==
                                     ValueTrait::FORMAL_PARAMETER);
                        auto fp = dynamic_cast<const FormalParam *>(read);
                        read_info =
                            getPtrInfo(call->getArgs()[fp->getIndex()].get());
                    }
                    ref |= mayPtrInfoAlias(location_info, read_info);
                    if (ref)
                        break;
                }

                if (mod && ref)
                    return ModRefInfo::ModRef;
                if (mod)
                    return ModRefInfo::Mod;
                if (ref)
                    return ModRefInfo::Ref;
            }
        } else if (!isPureBuiltinOrSylibFunc(callee))
            return ModRefInfo::ModRef;
    }

    return ModRefInfo::NoModRef;
}

AliasAnalysisResult::ModRefInfo
AliasAnalysisResult::getFunctionModRefInfo() const {
    if (has_untracked_call)
        return ModRefInfo::ModRef;

    if (read.empty() && write.empty())
        return ModRefInfo::NoModRef;

    if (read.empty() && !write.empty())
        return ModRefInfo::Mod;

    if (write.empty() && !read.empty())
        return ModRefInfo::Ref;

    return ModRefInfo::ModRef;
}
bool AliasAnalysisResult::hasUntrackedCall() const {
    return has_untracked_call;
}

AliasAnalysisResult AliasAnalysis::run(Function &func, FAM &fam) {
    AliasAnalysisResult res;
    res.func = &func;

    // Array arguments
    for (const auto &curr : func.getParams()) {
        auto curr_trait = curr->getType()->getTrait();
        Err::gassert(curr_trait == IRCTYPE::PTR ||
                     curr_trait == IRCTYPE::BASIC);
        if (curr_trait == IRCTYPE::PTR) {
            res.ptr_info[curr.get()] =
                AliasAnalysisResult::PtrInfo{
                    .untracked_array = true,
                    .global_var = false,
                    .potential_alias = { curr.get() }
                };
        }
    }

    auto entry = func.getBlocks()[0].get();

    // Local Alloca
    for (const auto &inst : *entry) {
        if (auto alloca = std::dynamic_pointer_cast<ALLOCAInst>(inst)) {
            res.ptr_info[alloca.get()] =
                AliasAnalysisResult::PtrInfo{
                    .untracked_array = false,
                    .global_var = false,
                    .potential_alias = { alloca.get() }
                };
        }
    }

    // Alias
    bool changed = true;
    while (changed) {
        changed = false;
        // A domtree traversal may be faster ?
        auto dfv = func.getDFVisitor();
        for (const auto& curr : dfv) {
            for (const auto &inst : *curr) {
                if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst))
                    changed |= res.insertPotentialAlias(gep.get(),
                                                        gep->getPtr().get());
                else if (auto phi = std::dynamic_pointer_cast<PHIInst>(inst)) {
                    if (phi->getType()->getTrait() == IRCTYPE::PTR) {
                        for (const auto &oper : phi->getPhiOpers())
                            changed |= res.insertPotentialAlias(
                                phi.get(), oper.value.get());
                    }
                }
            }
        }
    }

    // ModRef
    for (const auto &bb : func) {
        for (const auto &inst : *bb) {
            if (auto load = std::dynamic_pointer_cast<LOADInst>(inst)) {
                auto ptr = load->getPtr().get();
                if (res.getPtrInfo(ptr).untracked_array ||
                    res.getPtrInfo(ptr).global_var) {
                    if (auto gep = dynamic_cast<GEPInst*>(ptr)) {
                        Value* array = gep->getPtr().get();
                        while (dynamic_cast<GEPInst*>(array))
                            array = dynamic_cast<GEPInst*>(array)->getPtr().get();
                        res.read.insert(array);
                    }
                    else
                        res.read.insert(ptr);
                }
            } else if (auto store =
                           std::dynamic_pointer_cast<STOREInst>(inst)) {
                auto ptr = store->getPtr().get();
                if (res.getPtrInfo(ptr).untracked_array ||
                    res.getPtrInfo(ptr).global_var)
                {
                    if (auto gep = dynamic_cast<GEPInst*>(ptr)) {
                        Value* array = gep->getPtr().get();
                        while (dynamic_cast<GEPInst*>(array))
                            array = dynamic_cast<GEPInst*>(array)->getPtr().get();
                        res.write.insert(array);
                    }
                    else
                        res.write.insert(ptr);
                }
            } else if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
                auto callee = call->getFunc().get();
                if (auto callee_def = dynamic_cast<Function *>(callee)) {
                    // SysY enforces strict definition-before-use for functions,
                    // but with no support for function declarations.
                    // This implies that mutual recursion (fn0 -> fn1 -> fn0) is impossible.
                    // For example, without function declarations,
                    // the following can't compile.
                    // int fn0() { return fn1(); }
                    // int fn1() { return fn0(); }
                    // Given that, we only check if the `call` refers to
                    // current function to see if it is in a recursive chain.
                    if (callee_def != &func) {
                        auto callee_aa =
                            fam.getResult<AliasAnalysis>(*callee_def);

                        for (auto write : callee_aa.write) {
                            if (callee_aa.getPtrInfo(write).global_var)
                                res.write.insert(write);
                            else if (callee_aa.getPtrInfo(write)
                                         .untracked_array) {
                                auto fp =
                                    dynamic_cast<const FormalParam *>(write);
                                auto param_info = res.getPtrInfo(
                                    call->getArgs()[fp->getIndex()].get());
                                if (param_info.untracked_array ||
                                    param_info.global_var)
                                    res.write.insert(write);
                            }
                        }

                        for (auto read : callee_aa.read) {
                            if (callee_aa.getPtrInfo(read).global_var)
                                res.read.insert(read);
                            else if (callee_aa.getPtrInfo(read)
                                         .untracked_array) {
                                auto fp =
                                    dynamic_cast<const FormalParam *>(read);
                                auto param_info = res.getPtrInfo(
                                    call->getArgs()[fp->getIndex()].get());
                                if (param_info.untracked_array ||
                                    param_info.global_var)
                                    res.read.insert(read);
                            }
                        }

                        res.has_untracked_call |= callee_aa.has_untracked_call;
                    }
                } else if (!isPureBuiltinOrSylibFunc(callee))
                    res.has_untracked_call = true;
            }
        }
    }

    return res;
}
bool isPureBuiltinOrSylibFunc(const FunctionDecl *fn) {
    if (fn->isSylib()) {
        if (fn->getName() == "@_sysy_starttime" ||
            fn->getName() == "@_sysy_stoptime")
            return true;
    } else if (fn->isBuiltin()) {
        // IRGen only use memset to initialize array
        if (fn->getName() == "@" + std::string{Config::IR::BUILTIN_MEMSET})
            return true;
    }
    return false;
}

bool isPure(FAM &fam, const CALLInst *call) {
    auto callee = call->getFunc().get();
    // Recognized pure functions
    if (isPureBuiltinOrSylibFunc(callee))
        return true;

    auto callee_def = dynamic_cast<Function *>(callee);
    // Unknown builtin/sylib
    if (callee_def == nullptr)
        return false;

    auto call_res = fam.getResult<AliasAnalysis>(*callee_def);
    return call_res.getFunctionModRefInfo() ==
           AliasAnalysisResult::ModRefInfo::NoModRef;
}

bool hasSideEffect(FAM &fam, const CALLInst *call) {
    auto callee = call->getFunc().get();

    // Recognized pure functions
    if (isPureBuiltinOrSylibFunc(callee))
        return false;

    auto callee_def = dynamic_cast<Function *>(callee);
    // Unknown builtin/sylib
    if (callee_def == nullptr)
        return true;

    auto call_res = fam.getResult<AliasAnalysis>(*callee_def);
    return call_res.getFunctionModRefInfo() ==
               AliasAnalysisResult::ModRefInfo::Mod ||
           call_res.getFunctionModRefInfo() ==
               AliasAnalysisResult::ModRefInfo::ModRef;
}
} // namespace IR
