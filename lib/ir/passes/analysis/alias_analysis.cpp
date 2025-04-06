#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/loop_analysis.hpp"
#include "config/config.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "utils/logger.hpp"

#include <optional>

namespace IR {
PM::UniqueKey AliasAnalysis::Key;

bool AliasAnalysisResult::insertPotentialAlias(Value *target, Value *alias) {
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
AliasAnalysisResult::PtrInfo AliasAnalysisResult::getPtrInfo(Value *ptr) const {
    Err::gassert(ptr->getType()->getTrait() == IRCTYPE::PTR);
    if (ptr->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
        return PtrInfo{.untracked_array = false, .global_var = true, .potential_alias = {ptr}};
    }

    auto it = ptr_info.find(ptr);
    Err::gassert(it != ptr_info.end(), "No such pointer registered.");
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
        if (auto base_gep = base_ptr->as_raw<GEPInst>())
            gep = base_gep;
        else if (auto alloca = base_ptr->as_raw<ALLOCAInst>())
            return std::make_tuple(alloca, offset);
        else if (auto gv = base_ptr->as_raw<GlobalVariable>())
            return std::make_tuple(gv, offset);
        else if (auto fp = base_ptr->as_raw<FormalParam>())
            return std::make_tuple(fp, offset);
        else if (auto phi = base_ptr->as_raw<PHIInst>()) {
            const Value* common_base = nullptr;
            size_t common_offset = 0;
            for (const auto& [phi_gep, bb] : phi->incomings()) {
                if (!phi_gep->is<GEPInst>())
                    return std::nullopt;
                auto opt = getGepTotalOffset(phi_gep->as_raw<GEPInst>());
                if (!opt.has_value())
                    return std::nullopt;
                auto [phi_base, phi_offset] = *opt;
                if (common_base == nullptr) { // first
                    common_base = phi_base;
                    common_offset = phi_offset;
                }
                else {
                    if (phi_base != common_base || phi_offset != common_offset)
                        return std::nullopt;
                }
            }
            return std::make_tuple(common_base, common_offset);
        }
        else
            Err::unreachable();
    }
    return std::nullopt;
}

AliasInfo AliasAnalysisResult::getAliasInfo(Value *v1, Value *v2) const {
    Err::gassert(v1->getType()->getTrait() == IRCTYPE::PTR && v2->getType()->getTrait() == IRCTYPE::PTR);

    if (v1 == v2)
        return AliasInfo::MustAlias;

    auto cache_key = std::make_tuple(v1, v2);
    if (auto it = alias_cache.find(cache_key); it != alias_cache.end())
        return it->second;
    if (auto it = alias_cache.find(std::make_tuple(v2, v1)); it != alias_cache.end())
        return it->second;

    auto info1 = getPtrInfo(v1);
    auto info2 = getPtrInfo(v2);

    if (info1.untracked_array && info2.untracked_array)
        return alias_cache[cache_key] = AliasInfo::MayAlias;

    auto gep1 = v1->as_raw<GEPInst>();
    auto gep2 = v2->as_raw<GEPInst>();
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
                return alias_cache[cache_key] = AliasInfo::MustAlias;
            return alias_cache[cache_key] = AliasInfo::NoAlias;
        }
    }

    for (auto p1 : info1.potential_alias) {
        for (auto p2 : info2.potential_alias) {
            if (p1 == p2)
                return alias_cache[cache_key] = AliasInfo::MayAlias;
        }
    }

    return alias_cache[cache_key] =  AliasInfo::NoAlias;
}
bool AliasAnalysisResult::isLocal(Value *v) const {
    auto info = getPtrInfo(v);
    return !info.global_var && !info.untracked_array;
}

ModRefInfo AliasAnalysisResult::getInstModRefInfo(Instruction *inst, Value *location, FAM &fam) const {
    Err::gassert(location->getType()->getTrait() == IRCTYPE::PTR);

    if (auto load = inst->as_raw<LOADInst>()) {
        auto aa = getAliasInfo(load->getPtr().get(), location);
        if (aa == AliasInfo::NoAlias)
            return ModRefInfo::NoModRef;
        else
            return ModRefInfo::Ref;
    } else if (auto store = inst->as_raw<STOREInst>()) {
        auto aa = getAliasInfo(store->getPtr().get(), location);
        if (aa == AliasInfo::NoAlias)
            return ModRefInfo::NoModRef;
        else
            return ModRefInfo::Mod;
    } else if (auto call = inst->as_raw<CALLInst>()) {
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

void AliasAnalysisResult::addClonedInst(Instruction *inst, Instruction *cloned) {
    Err::gassert(ptr_info.count(inst), "No such instruction registered.");
    ptr_info[cloned] = ptr_info[inst];
}

AliasInfo AliasAnalysisResult::getAliasInfo(const pVal &v1, const pVal &v2) const {
    return getAliasInfo(v1.get(), v2.get());
}
bool AliasAnalysisResult::isLocal(const pVal &v) const { return isLocal(v.get()); }
ModRefInfo AliasAnalysisResult::getInstModRefInfo(const pInst &inst, const pVal &location, FAM &fam) const {
    return getInstModRefInfo(inst.get(), location.get(), fam);
}
void AliasAnalysisResult::addClonedInst(const pInst &inst, const pInst &cloned) {
    addClonedInst(inst.get(), cloned.get());
}

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
        if (auto alloca = inst->as<ALLOCAInst>()) {
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
                    } else
                        Err::unreachable("Unknown ptr type");
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
                            else if (callee_aa.getPtrInfo(read).untracked_array) {
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

// This should not have cache since call's argument is mutable.
RWInfo getCallRWInfo(FAM &fam, CALLInst *call) {
    auto guard = Logger::scopeDisable();

    auto callee = call->getFunc().get();
    if (isPureBuiltinOrSylibFunc(callee))
        return {};

    auto callee_def = callee->as_raw<Function>();
    // Unknown builtin/sylib
    if (callee_def == nullptr) {
        if (callee->getName() == "@getint" || callee->getName() == "@getch" || callee->getName() == "@getfloat" ||
            callee->getName() == "@putint" || callee->getName() == "@putch" || callee->getName() == "@putfloat" ||
            callee->getName() == "@_sysy_starttime" || callee->getName() == "@_sysy_stoptime")
            return {};
        // int getarray(int a[]);
        if (callee->getName() == "@getarray" || callee->getName() == "@getfarray") {
            return {.read = {}, .write = {call->getArgs()[0].get()}, .untracked = false};
        }
        // void putarray(int n, int a[]);
        if (callee->getName() == "@putarray" || callee->getName() == "@putfarray" || callee->getName() == "@putf") {
            auto actual_args = call->getArgs();
            std::vector<Value *> read;
            for (auto &r : actual_args) {
                if (r->getType()->getTrait() == IRCTYPE::PTR)
                    read.emplace_back(r.get());
            }
            return {.read = read, .write = {}, .untracked = false};
        }

        if (callee->getName() == "@" + std::string{Config::IR::BUILTIN_MEMSET}) {
            auto actual_args = call->getArgs();
            std::vector<Value *> write;
            for (auto &r : actual_args) {
                if (r->getType()->getTrait() == IRCTYPE::PTR)
                    write.emplace_back(r.get());
            }
            return {.read = {}, .write = write, .untracked = false};
        }

        Logger::logWarning("[AliasAnalysis]: Unrecognized function '", callee->getName(), "'.");
        return {.untracked = true};
    }

    auto callee_aa = fam.getResult<AliasAnalysis>(*callee_def);

    std::vector<Value *> write_ret;
    std::vector<Value *> read_ret;
    for (auto write : callee_aa.getWrite()) {
        if (write->getVTrait() == ValueTrait::GLOBAL_VARIABLE)
            write_ret.emplace_back(write);
        else {
            Err::gassert(write->getVTrait() == ValueTrait::FORMAL_PARAMETER);
            auto fp = write->as_raw<FormalParam>();
            auto actual = call->getArgs()[fp->getIndex()].get();
            write_ret.emplace_back(actual);
        }
    }
    for (auto read : callee_aa.getRead()) {
        if (read->getVTrait() == ValueTrait::GLOBAL_VARIABLE)
            read_ret.emplace_back(read);
        else {
            Err::gassert(read->getVTrait() == ValueTrait::FORMAL_PARAMETER);
            auto fp = read->as_raw<FormalParam>();
            auto actual = call->getArgs()[fp->getIndex()].get();
            read_ret.emplace_back(actual);
        }
    }
    return {read_ret, write_ret, false};
}

// The following two functions:
//   bool isPure(FAM &fam, FunctionDecl *call)
//   bool hasSideEffect(FAM &fam, FunctionDecl *call)
// checks a function's property.
// For a function, its purity or side effect can not change during optimization.
// But for BasicBlock/Loop or a CALLInst's RWInfo, there are no such guarantee.
// Therefore, only those two functions have cache.
// Though AliasAnalysis can be invalidated during transforms, their cache never expires.
bool isPure(FAM& fam, FunctionDecl* decl) {
    static std::unordered_map<const FunctionDecl*, bool> cache;
    auto guard = Logger::scopeDisable();

    auto it = cache.find(decl);
    if (it != cache.end())
        return it->second;

    // Recognized pure functions
    if (isPureBuiltinOrSylibFunc(decl))
        return cache[decl] = true;

    auto callee_def = decl->as_raw<Function>();
    // Unknown builtin/sylib
    if (callee_def == nullptr)
        return cache[decl] = false;

    auto call_res = fam.getResult<AliasAnalysis>(*callee_def);
    if (call_res.hasSylibCall() || call_res.hasUntrackedCall())
        return cache[decl] = false;
    return cache[decl] = (call_res.getFunctionModRefInfo() == ModRefInfo::NoModRef);
}
bool isPure(FAM &fam, const pFuncDecl &decl) {
    return isPure(fam, decl.get());
}

bool isPure(FAM &fam, const CALLInst *call) {
    return isPure(fam, call->getFunc());
}
bool isPure(FAM &fam, const pCall &call) { return isPure(fam, call.get()); }

bool hasSideEffect(FAM& fam, FunctionDecl* decl) {
    static std::unordered_map<const FunctionDecl*, bool> cache;
    auto guard = Logger::scopeDisable();
    auto it = cache.find(decl);
    if (it != cache.end())
        return it->second;

    // Recognized pure functions
    if (isPureBuiltinOrSylibFunc(decl))
        return cache[decl] = false;

    auto callee_def = decl->as_raw<Function>();
    // Unknown builtin/sylib
    if (callee_def == nullptr)
        return cache[decl] = true;

    auto call_res = fam.getResult<AliasAnalysis>(*callee_def);
    if (call_res.hasSylibCall() || call_res.hasUntrackedCall())
        return cache[decl] = true;
    return cache[decl] = (call_res.getFunctionModRefInfo() == ModRefInfo::Mod ||
           call_res.getFunctionModRefInfo() == ModRefInfo::ModRef);
}
bool hasSideEffect(FAM &fam, const pFuncDecl &decl) {
    return hasSideEffect(fam, decl.get());
}

bool hasSideEffect(FAM &fam, const CALLInst *call) {
    return hasSideEffect(fam, call->getFunc());
}
bool hasSideEffect(FAM &fam, const pCall &call) { return hasSideEffect(fam, call.get()); }

SharedRWInfo getCallRWInfo(FAM &fam, const pCall &call) {
    auto rwinfo = getCallRWInfo(fam, call.get());
    std::vector<pVal> write;
    std::vector<pVal> read;
    for (auto r : rwinfo.read)
        read.emplace_back(r->as<Value>());
    for (auto w : rwinfo.write)
        write.emplace_back(w->as<Value>());
    return {read, write, rwinfo.untracked};
}

bool hasSideEffect(FAM &fam, BasicBlock* block) {
    auto guard = Logger::scopeDisable();
    auto& aa_res = fam.getResult<AliasAnalysis>(*block->getParent());
    for (const auto &inst : block->all_insts()) {
        if (auto call = inst->as<CALLInst>()) {
            if (hasSideEffect(fam, call))
                return true;
        }
        else if (auto store = inst->as<STOREInst>()) {
            auto store_ptr = store->getPtr();

            if (!aa_res.isLocal(store_ptr))
                return true;

            const auto& cfgdfv = block->getDFVisitor();
            for (const auto& child : cfgdfv) {
                for (const auto& child_inst : *child) {
                    auto modref = aa_res.getInstModRefInfo(child_inst, store_ptr, fam);
                    if (modref == ModRefInfo::ModRef || modref == ModRefInfo::Ref)
                        return true;
                }
            }
        }
        else if (inst->is<RETInst>() || inst->is<ALLOCAInst>())
            return true;
    }
    return false;
}
bool hasSideEffect(FAM &fam, const pBlock& block) {
    return hasSideEffect(fam, block.get());
}

// Check if the loop has side effect
bool hasSideEffect(FAM &fam, const Loop* loop) {
    for (const auto &block : loop->blocks()) {
        if (hasSideEffect(fam, block))
            return true;
    }
    return false;
}
bool hasSideEffect(FAM &fam, const pLoop& loop) {
    return hasSideEffect(fam, loop.get());
}
} // namespace IR
