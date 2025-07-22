// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/analysis/basic_alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/utils/logger.hpp"

#include <optional>

namespace IR {
RWInfo getCallRWInfo(FAM &fam, CALLInst *call) {
    auto guard = Logger::scopeDisable();

    auto callee = call->getFunc().get();
    auto callee_def = callee->as_raw<Function>();

    // For parallel entry function, analyze the parallel body.
    if (callee->hasAttr(FuncAttr::ParallelEntry)) {
        Err::gassert(callee_def == nullptr);
        auto args = call->getArgs();
        for (const auto& arg : args) {
            if (auto parallel_body = arg->as_raw<Function>()) {
                Err::gassert(parallel_body->hasAttr(FuncAttr::ParallelBody));
                callee_def = parallel_body;
            }
        }
        Err::gassert(callee_def != nullptr);
    }

    if (callee_def == nullptr) {
        Err::gassert(!callee->hasAttr(FuncAttr::NotBuiltin), "Not builtin but has no definition");

        // For memcpy intrinsic, a more precise analysis is available.
        if (callee->hasAttr(FuncAttr::isMemcpyIntrinsic)) {
            auto actual_args = call->getArgs();
            auto dest = actual_args[0].get();
            auto src = actual_args[1].get();
            return {.read = {src}, .write = {dest}, .untracked = false};
        }

        auto actual_args = call->getArgs();
        std::vector<Value *> arg_ptrs;
        for (auto &r : actual_args) {
            if (r->getType()->getTrait() == IRCTYPE::PTR)
                arg_ptrs.emplace_back(r.get());
        }

        if (callee->hasAttr(FuncAttr::builtinMemWriteOnly))
            return {.read = {}, .write = arg_ptrs, .untracked = false};

        if (callee->hasAttr(FuncAttr::builtinMemReadOnly))
            return {.read = arg_ptrs, .write = {}, .untracked = false};

        if (callee->hasAttr(FuncAttr::builtinMemReadWrite))
            return {.read = arg_ptrs, .write = arg_ptrs, .untracked = false};

        if (!callee->hasAttr(FuncAttr::builtinMemReadOnly) && !callee->hasAttr(FuncAttr::builtinMemWriteOnly))
            return {};

        return {.untracked = true};
    }

    const auto& callee_aa = fam.getResult<BasicAliasAnalysis>(*callee_def);

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
// For a function, its purity or side effect cannot change during optimization.
// But for BasicBlock/Loop or a CALLInst's RWInfo, there is no such guarantee.
// Therefore, only those two functions have cache.
// Though AliasAnalysis can be invalidated during transforms, their cache never expires.
bool isPure(FAM &fam, FunctionDecl *decl) {
    static std::unordered_map<const FunctionDecl *, bool> cache;
    auto guard = Logger::scopeDisable();

    // Recognized pure functions
    if (decl->hasAttr(FuncAttr::isSIMDIntrinsic))
        return true;

    auto callee_def = decl->as_raw<Function>();
    // Unknown builtin/sylib
    if (callee_def == nullptr)
        return cache[decl] = false;

    auto it = cache.find(decl);
    if (it != cache.end())
        return it->second;

    const auto& call_res = fam.getResult<BasicAliasAnalysis>(*callee_def);
    if (call_res.hasSylibCall() || call_res.hasUntrackedCall())
        return cache[decl] = false;
    return cache[decl] = (call_res.getFunctionModRefInfo() == ModRefInfo::NoModRef);
}
bool isPure(FAM &fam, const pFuncDecl &decl) { return isPure(fam, decl.get()); }

bool isPure(FAM &fam, const CALLInst *call) { return isPure(fam, call->getFunc()); }
bool isPure(FAM &fam, const pCall &call) { return isPure(fam, call.get()); }

bool hasSideEffect(FAM &fam, FunctionDecl *decl) {
    static std::unordered_map<const FunctionDecl *, bool> cache;
    auto guard = Logger::scopeDisable();

    // Recognized pure functions
    if (decl->hasAttr(FuncAttr::isSIMDIntrinsic))
        return false;

    auto callee_def = decl->as_raw<Function>();
    // Unknown builtin/sylib
    if (callee_def == nullptr)
        return true;

    auto it = cache.find(decl);
    if (it != cache.end())
        return it->second;

    const auto& call_res = fam.getResult<BasicAliasAnalysis>(*callee_def);
    if (call_res.hasSylibCall() || call_res.hasUntrackedCall())
        return cache[decl] = true;
    return cache[decl] = (call_res.getFunctionModRefInfo() == ModRefInfo::Mod ||
                          call_res.getFunctionModRefInfo() == ModRefInfo::ModRef);
}
bool hasSideEffect(FAM &fam, const pFuncDecl &decl) { return hasSideEffect(fam, decl.get()); }

bool hasSideEffect(FAM &fam, const CALLInst *call) { return hasSideEffect(fam, call->getFunc()); }
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

bool hasSideEffect(FAM &fam, BasicBlock *block) {
    auto guard = Logger::scopeDisable();
    const auto& aa_res = fam.getResult<BasicAliasAnalysis>(*block->getParent());
    for (const auto &inst : block->all_insts()) {
        if (auto call = inst->as<CALLInst>()) {
            if (hasSideEffect(fam, call))
                return true;
        } else if (auto store = inst->as<STOREInst>()) {
            auto store_ptr = store->getPtr();

            if (!aa_res.isLocal(store_ptr))
                return true;

            const auto &cfgdfv = block->getDFVisitor();
            for (const auto &child : cfgdfv) {
                for (const auto &child_inst : *child) {
                    auto modref = aa_res.getInstModRefInfo(child_inst, store_ptr, fam);
                    if (modref == ModRefInfo::ModRef || modref == ModRefInfo::Ref)
                        return true;
                }
            }
        } else if (inst->is<RETInst>() || inst->is<ALLOCAInst>())
            return true;
    }
    return false;
}
bool hasSideEffect(FAM &fam, const pBlock &block) { return hasSideEffect(fam, block.get()); }

// Check if the loop has side effect
bool hasSideEffect(FAM &fam, const Loop *loop) {
    for (const auto &block : loop->blocks()) {
        if (hasSideEffect(fam, block))
            return true;
    }
    return false;
}
bool hasSideEffect(FAM &fam, const pLoop &loop) { return hasSideEffect(fam, loop.get()); }

pVal getMemLocation(Value *i) {
    if (auto load = i->as_raw<LOADInst>())
        return load->getPtr();
    if (auto store = i->as_raw<STOREInst>())
        return store->getPtr();
    return nullptr;
}
pVal getMemLocation(const pVal &i) {
    return getMemLocation(i.get());
}

Value* getPtrBase(Value *ptr) {
    Err::gassert(ptr->getType()->is<PtrType>());
    auto base = ptr;
    while (true) {
        if (auto bitcast = base->as_raw<BITCASTInst>())
            base = bitcast->getOVal().get();
        else if (auto gep = base->as_raw<GEPInst>())
            base = gep->getPtr().get();
        else if (auto phi = base->as<PHIInst>()) {
            Value* common_base = nullptr;
            for (const auto &[val, bb] : phi->incomings()) {
                auto curr = getPtrBase(val);
                if (curr == nullptr)
                    return nullptr;
                if (common_base == nullptr)
                    common_base = curr.get();
                else if (common_base != curr.get())
                    return nullptr;
            }
            base = common_base;
        } else if (base->is<ALLOCAInst, GlobalVariable, FormalParam>())
            return base;
        else if (base->is<LOADInst, INTTOPTRInst, PTRTOINTInst>()) {
            return nullptr;
        } else
            Err::unreachable();
    }
}


pVal getPtrBase(const pVal &ptr) {
    Err::gassert(ptr->getType()->is<PtrType>());
    auto base = ptr;
    while (true) {
        if (auto bitcast = base->as_raw<BITCASTInst>())
            base = bitcast->getOVal();
        else if (auto gep = base->as_raw<GEPInst>())
            base = gep->getPtr();
        else if (auto phi = base->as<PHIInst>()) {
            pVal common_base = nullptr;
            // bugs?
            static std::unordered_set<Value*> visited;
            for (const auto &[val, bb] : phi->incomings()) {
                if (!visited.emplace(val.get()).second)
                    continue;
                auto curr = getPtrBase(val);
                visited.erase(curr.get());

                if (curr == nullptr)
                    return nullptr;
                if (common_base == nullptr)
                    common_base = curr;
                else if (common_base != curr)
                    return nullptr;
            }
            if (common_base == nullptr)
                return nullptr;
            base = common_base;
        } else if (auto select = base->as_raw<SELECTInst>()) {
            auto true_base = getPtrBase(select->getTrueVal());
            auto false_base = getPtrBase(select->getFalseVal());
            if (true_base == nullptr || false_base == nullptr || true_base != false_base)
                return nullptr;
            base = true_base;
        } else if (base->is<ALLOCAInst, GlobalVariable, FormalParam>())
            return base;
        else if (base->is<LOADInst, INTTOPTRInst, PTRTOINTInst>()) {
            return nullptr;
        } else
            Err::unreachable();
    }
    return nullptr;
}

} // namespace IR
