#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/utils/logger.hpp"

#include <deque>
#include <optional>

namespace IR {
PM::UniqueKey AliasAnalysis::Key;

bool AliasAnalysisResult::insertPotentialAlias(const Value *target, const Value *alias) {
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
AliasAnalysisResult::PtrInfo AliasAnalysisResult::getPtrInfo(const Value *ptr) const {
    Err::gassert(ptr->getType()->getTrait() == IRCTYPE::PTR);
    if (ptr->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
        return PtrInfo{.untracked_array = false, .global_var = true, .potential_alias = {ptr}};
    }

    auto it = ptr_info.find(ptr);
    Err::gassert(it != ptr_info.end());
    return it->second;
}

// Returns the ALLOCA/GlobalVariable/FormalParameter and offset about it.
std::optional<std::tuple<const Value *, size_t>> getGepTotalOffset(const GEPInst *gep) {
    size_t offset = 0;
    while (gep) {
        if (!gep->isConstantOffset())
            return std::nullopt;
        offset += gep->getConstantOffset();
        auto base_ptr = gep->getPtr().get();
        if (auto base_gep = dynamic_cast<const GEPInst *>(base_ptr))
            gep = base_gep;
        else if (auto alloca = dynamic_cast<const ALLOCAInst *>(base_ptr))
            return std::make_tuple(alloca, offset);
        else if (auto gv = dynamic_cast<GlobalVariable *>(base_ptr))
            return std::make_tuple(gv, offset);
        else if (auto fp = dynamic_cast<FormalParam *>(base_ptr))
            return std::make_tuple(fp, offset);
        else
            Err::unreachable();
    }
    return std::nullopt;
}

AliasInfo AliasAnalysisResult::getAliasInfo(const Value *v1, const Value *v2) const {
    Err::gassert(v1->getType()->getTrait() == IRCTYPE::PTR && v2->getType()->getTrait() == IRCTYPE::PTR);

    if (v1 == v2)
        return AliasInfo::MustAlias;

    auto info1 = getPtrInfo(v1);
    auto info2 = getPtrInfo(v2);

    if (info1.untracked_array && info2.untracked_array)
        return AliasInfo::MayAlias;

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
bool AliasAnalysisResult::isLocal(const Value *v) const {
    auto info = getPtrInfo(v);
    return !info.global_var && !info.untracked_array;
}

ModRefInfo AliasAnalysisResult::getInstModRefInfo(const Instruction *inst, const Value *location, FAM &fam) const {
    Err::gassert(location->getType()->getTrait() == IRCTYPE::PTR);

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
        auto callee_def = dynamic_cast<Function *>(callee);

        if (callee_def == nullptr) {
            if (isPureBuiltinOrSylibFunc(callee) || callee->getName() == "@getint" || callee->getName() == "@getch" ||
                callee->getName() == "@getfloat" || callee->getName() == "@putint" || callee->getName() == "@putch" ||
                callee->getName() == "@putfloat" || callee->getName() == "@_sysy_starttime" ||
                callee->getName() == "@_sysy_stoptime")
                return ModRefInfo::NoModRef;
            // int getarray(int a[]);
            if (callee->getName() == "@getarray" || callee->getName() == "@getfarray") {
                auto alias = getAliasInfo(call->getArgs()[0].get(), location);
                if (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias)
                    return ModRefInfo::Mod;
                return ModRefInfo::NoModRef;
            }
            // void putarray(int n, int a[]);
            if (callee->getName() == "@putarray" || callee->getName() == "@putfarray" || callee->getName() == "@putf") {
                auto actual_args = call->getArgs();
                for (auto &r : actual_args) {
                    if (r->getType()->getTrait() == IRCTYPE::PTR) {
                        auto alias = getAliasInfo(r.get(), location);
                        if (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias)
                            return ModRefInfo::Ref;
                    }
                }
                return ModRefInfo::NoModRef;
            }

            if (callee->getName() == "@" + std::string{Config::IR::BUILTIN_MEMSET}) {
                auto actual_args = call->getArgs();
                for (auto &r : actual_args) {
                    if (r->getType()->getTrait() == IRCTYPE::PTR) {
                        auto alias = getAliasInfo(r.get(), location);
                        if (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias)
                            return ModRefInfo::Mod;
                    }
                }
                return ModRefInfo::NoModRef;
            }

            // Unrecognized sylib/builtin
            Logger::logWarning("[AliasAnalysis]: Unrecognized function '", callee->getName(), "'.");
            return ModRefInfo::ModRef;
        }

        auto callee_aa = fam.getResult<AliasAnalysis>(*callee_def);
        if (callee_aa.has_untracked_call)
            return ModRefInfo::ModRef;
        if (callee_aa.getFunctionModRefInfo() == ModRefInfo::NoModRef)
            return ModRefInfo::NoModRef;

        bool mod = false;
        bool ref = false;

        for (auto write : callee_aa.write) {
            if (write->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
                auto alias = getAliasInfo(write, location);
                mod |= (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias);
            } else {
                Err::gassert(write->getVTrait() == ValueTrait::FORMAL_PARAMETER);
                auto fp = dynamic_cast<const FormalParam *>(write);
                auto actual = call->getArgs()[fp->getIndex()].get();
                auto actual_alias = getPtrInfo(actual).potential_alias;
                for (const auto &mayalias : actual_alias) {
                    auto alias = getAliasInfo(mayalias, location);
                    mod |= (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias);
                }
            }
            if (mod)
                break;
        }
        for (auto read : callee_aa.read) {
            if (read->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
                auto alias = getAliasInfo(read, location);
                ref |= (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias);
            } else {
                Err::gassert(read->getVTrait() == ValueTrait::FORMAL_PARAMETER);
                auto fp = dynamic_cast<const FormalParam *>(read);
                auto actual = call->getArgs()[fp->getIndex()].get();
                auto actual_alias = getPtrInfo(actual).potential_alias;
                for (const auto &mayalias : actual_alias) {
                    auto alias = getAliasInfo(mayalias, location);
                    ref |= (alias == AliasInfo::MustAlias || alias == AliasInfo::MayAlias);
                }
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
    }

    return ModRefInfo::NoModRef;
}

ModRefInfo AliasAnalysisResult::getFunctionModRefInfo() const {
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
bool AliasAnalysisResult::hasUntrackedCall() const { return has_untracked_call; }
bool AliasAnalysisResult::hasSylibCall() const { return has_sylib_call; }

AliasAnalysisResult AliasAnalysis::run(Function &func, FAM &fam) {
    AliasAnalysisResult res;
    res.func = &func;

    // Array arguments
    for (const auto &curr : func.getParams()) {
        auto curr_trait = curr->getType()->getTrait();
        if (curr_trait == IRCTYPE::PTR) {
            res.ptr_info[curr.get()] = AliasAnalysisResult::PtrInfo{
                .untracked_array = true, .global_var = false, .potential_alias = {curr.get()}};
        }
    }

    auto entry = func.getBlocks().front().get();

    // Local Alloca
    for (const auto &inst : *entry) {
        if (auto alloca = std::dynamic_pointer_cast<ALLOCAInst>(inst)) {
            if (alloca->getBaseType()->getTrait() == IRCTYPE::ARRAY) {
                res.ptr_info[alloca.get()] = AliasAnalysisResult::PtrInfo{
                    .untracked_array = false, .global_var = false, .potential_alias = {alloca.get()}};
            }
        }
    }

    // Alias
    bool changed = true;
    while (changed) {
        changed = false;
        auto dfv = func.getDFVisitor();
        for (const auto &curr : dfv) {
            for (const auto &phi : curr->getPhiInsts()) {
                if (phi->getType()->getTrait() == IRCTYPE::PTR) {
                    for (const auto &oper : phi->getPhiOpers())
                        changed |= res.insertPotentialAlias(phi.get(), oper.value.get());
                }
            }
            for (const auto &inst : *curr) {
                if (inst->getType()->getTrait() == IRCTYPE::PTR) {
                    if (auto alloca = std::dynamic_pointer_cast<ALLOCAInst>(inst)) {
                        // We've handled it above
                        continue;
                    }
                    if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst))
                        changed |= res.insertPotentialAlias(gep.get(), gep->getPtr().get());
                    else if (auto bitcast = std::dynamic_pointer_cast<BITCASTInst>(inst)) {
                        Err::gassert(bitcast->getOVal()->getType()->getTrait() == IRCTYPE::PTR);
                        changed |= res.insertPotentialAlias(bitcast.get(), bitcast->getOVal().get());
                    } else
                        Err::unreachable("Unknown ptr type");
                }
            }
        }
    }

    // ModRef
    for (const auto &bb : func) {
        for (const auto &inst : *bb) {
            if (auto load = std::dynamic_pointer_cast<LOADInst>(inst)) {
                auto ptralias = res.getPtrInfo(load->getPtr().get()).potential_alias;
                for (const auto &mayalias : ptralias) {
                    if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                        mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                        res.read.insert(mayalias);
                }
            } else if (auto store = std::dynamic_pointer_cast<STOREInst>(inst)) {
                auto ptralias = res.getPtrInfo(store->getPtr().get()).potential_alias;
                for (const auto &mayalias : ptralias) {
                    if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                        mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                        res.write.insert(mayalias);
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
                        auto callee_aa = fam.getResult<AliasAnalysis>(*callee_def);

                        for (auto write : callee_aa.write) {
                            if (callee_aa.getPtrInfo(write).global_var)
                                res.write.insert(write);
                            else if (callee_aa.getPtrInfo(write).untracked_array) {
                                auto fp = dynamic_cast<const FormalParam *>(write);
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
                            else if (callee_aa.getPtrInfo(read).untracked_array) {
                                auto fp = dynamic_cast<const FormalParam *>(read);
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
                    if (isPureBuiltinOrSylibFunc(callee) || callee->getName() == "@getint" ||
                        callee->getName() == "@getch" || callee->getName() == "@getfloat" ||
                        callee->getName() == "@putint" || callee->getName() == "@putch" ||
                        callee->getName() == "@putfloat" || callee->getName() == "@_sysy_starttime" ||
                        callee->getName() == "@_sysy_stoptime") {
                        res.has_sylib_call = true;
                        continue;
                    }

                    // int getarray(int a[]);
                    if (callee->getName() == "@getarray" || callee->getName() == "@getfarray") {
                        auto actual = call->getArgs()[0].get();
                        for (const auto &mayalias : res.getPtrInfo(actual).potential_alias) {
                            if (mayalias->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
                                mayalias->getVTrait() == ValueTrait::FORMAL_PARAMETER)
                                res.write.insert(mayalias);
                        }
                        res.has_sylib_call = true;
                    }
                    // void putarray(int n, int a[]);
                    else if (callee->getName() == "@putarray" || callee->getName() == "@putfarray" ||
                             callee->getName() == "@putf") {
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
                        res.has_sylib_call = true;
                    } else if (callee->getName() == "@" + std::string{Config::IR::BUILTIN_MEMSET}) {
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
                    } else {
                        // Unrecognized sylib/builtin
                        Logger::logWarning("[AliasAnalysis]: Unrecognized function '", callee->getName(), "'.");
                        res.has_untracked_call = true;
                    }
                }
            }
        }
    }

    return res;
}

bool isPureBuiltinOrSylibFunc(const FunctionDecl *fn) { return false; }

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
    if (call_res.hasSylibCall() || call_res.hasUntrackedCall())
        return false;
    return call_res.getFunctionModRefInfo() == ModRefInfo::NoModRef;
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
    if (call_res.hasSylibCall() || call_res.hasUntrackedCall())
        return true;
    return call_res.getFunctionModRefInfo() == ModRefInfo::Mod ||
           call_res.getFunctionModRefInfo() == ModRefInfo::ModRef;
}
} // namespace IR
