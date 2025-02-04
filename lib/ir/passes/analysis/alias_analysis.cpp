#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/control.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/utils/logger.hpp"

#include <deque>


namespace IR {
PM::UniqueKey AliasAnalysisPass::Key;

bool AliasAnalysisResult::insertAlias(const Value *target, const Value *alias) {
    Err::gassert(target->getType()->getTrait() == IRCTYPE::PTR);

    auto &info = ptr_info[target];
    if (target->getVTrait() == ValueTrait::GLOBAL_VARIABLE ||
        target->getVTrait() == ValueTrait::FORMAL_PARAMETER) {
        info.untracked = true;
        return info.potential_alias.insert(target).second;
    } else {
        const auto &alias_info = ptr_info[alias];
        bool changed = false;
        for (const auto &r : alias_info.potential_alias)
            changed |= info.potential_alias.insert(r).second;
        info.untracked |= alias_info.untracked;
        return changed;
    }
    return false;
}
AliasAnalysisResult::PtrInfo AliasAnalysisResult::getPtrInfo(const Value *ptr) const {
    Err::gassert(ptr->getType()->getTrait() == IRCTYPE::PTR);
    if (ptr->getVTrait() == ValueTrait::GLOBAL_VARIABLE) {
        return PtrInfo{
            .untracked = true,
            .potential_alias = {ptr}
        };
    }

    auto it = ptr_info.find(ptr);
    Err::gassert(it != ptr_info.end());
    return it->second;
}

bool isPtrInfoAlias(const AliasAnalysisResult::PtrInfo& info1, const AliasAnalysisResult::PtrInfo& info2) {
    if (info1.untracked || info2.untracked)
        return true;

    for (auto p1 : info1.potential_alias) {
        for (auto p2 : info2.potential_alias) {
            if (p1 == p2)
                return true;
        }
    }

    return false;
}

// GEP: same ptr with different indices
bool isNoAliasGEP(const Value *v1, const Value *v2) {
    auto gep1 = dynamic_cast<const GEPInst*>(v1);
    auto gep2 = dynamic_cast<const GEPInst*>(v2);
    if (gep1 && gep2) { // Both are gep
        if (gep1->getPtr() == gep2->getPtr()) { // Same ptr
            auto idx1 = gep1->getIdxs();
            auto idx2 = gep2->getIdxs();
            if (idx1.size() == idx2.size()) { // Same number of index
                auto idx1_0 = std::dynamic_pointer_cast<ConstantInt>(idx1[0])->getVal();
                auto idx2_0 = std::dynamic_pointer_cast<ConstantInt>(idx2[0])->getVal();
                if (idx1.size() == 1) { // 1
                    if (idx1_0 != idx2_0)
                        return true;
                }
                else if (idx1.size() == 2) { // 2
                    auto idx1_1 = std::dynamic_pointer_cast<ConstantInt>(idx1[1])->getVal();
                    auto idx2_1 = std::dynamic_pointer_cast<ConstantInt>(idx2[1])->getVal();
                    auto size = toPtrType(gep1->getPtr()->getType())->getBytes();
                    auto inner_size = toPtrType(gep1->getPtr()->getType())->getElmType()->getBytes();
                    if (size * idx1_0 + inner_size * idx1_1
                         != size * idx2_0 + inner_size * idx2_1) {
                        return true;
                    }
                }
                else
                    Err::unreachable("Unexpected size of GEP.");
            }
        }
    }
    return false;
}

AliasAnalysisResult::AliasInfo
AliasAnalysisResult::getAliasInfo(const Value *v1, const Value *v2) const {
    Err::gassert(v1->getType()->getTrait() == IRCTYPE::PTR
        && v2->getType()->getTrait() == IRCTYPE::PTR);

    auto info1 = getPtrInfo(v1);
    auto info2 = getPtrInfo(v2);

    if (info1.potential_alias.size() == 1 && info2.potential_alias.size() == 1) {
        if (isNoAliasGEP(v1, v2))
            return AliasInfo::NoAlias;
    }

    if (isPtrInfoAlias(info1, info2))
        return AliasInfo::MustAlias;

    return AliasInfo::NoAlias;
}

AliasAnalysisResult::ModRefInfo
AliasAnalysisResult::getInstModRefInfo(const Instruction *inst,
                                       const Value *candidate) const {
    Err::gassert(candidate->getType()->getTrait() == IRCTYPE::PTR);

    auto candidate_info = getPtrInfo(candidate);
    if (auto load = dynamic_cast<const LOADInst*>(inst)) {
        auto load_info = getPtrInfo(load->getPtr().get());
        if (load_info.potential_alias.size() == 1 && candidate_info.potential_alias.size() == 1) {
            if (isNoAliasGEP(load, candidate))
                return ModRefInfo::NoModRef;
        }
        if (isPtrInfoAlias(load_info, candidate_info))
            return ModRefInfo::Ref;
    }
    else if (auto store = dynamic_cast<const STOREInst*>(inst)) {
        auto store_info = getPtrInfo(store->getPtr().get());
        if (store_info.potential_alias.size() == 1 && candidate_info.potential_alias.size() == 1) {
            if (isNoAliasGEP(store, candidate))
                return ModRefInfo::NoModRef;
        }
        if (isPtrInfoAlias(store_info, candidate_info))
            return ModRefInfo::Mod;
    }
    else if (auto call = dynamic_cast<const CALLInst*>(inst)) {
        // FIXME: Recursion Call.
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

AliasAnalysisResult AliasAnalysisPass::run(Function &func, FAM &fam) {
    AliasAnalysisResult res;

    // Array arguments
    for (const auto& curr : func.getParams()) {
        auto curr_trait = curr->getType()->getTrait();
        Err::gassert(curr_trait == IRCTYPE::PTR || curr_trait == IRCTYPE::BASIC);
        if (curr_trait == IRCTYPE::PTR) {
            auto& info = res.ptr_info[curr.get()];
            info.untracked = true;
            info.potential_alias = { curr.get() };
        }
    }

    auto entry = func.getBlocks()[0].get();

    // Local arrays
    for (const auto& inst : *entry) {
        if (auto alloca = std::dynamic_pointer_cast<ALLOCAInst>(inst)) {
            if (alloca->isArray())
                res.ptr_info[alloca.get()].potential_alias = { alloca.get() };
        }
    }

    // Alias
    bool changed = true;
    while (changed) {
        std::deque<BasicBlock *> worklist {entry};
        std::set<const BasicBlock *> visited;

        while (!worklist.empty()) {
            BasicBlock *curr = worklist.front();
            worklist.pop_front();
            visited.insert(curr);

            for (const auto& inst : *curr) {
                if (auto gep = std::dynamic_pointer_cast<GEPInst>(inst))
                    changed |= res.insertAlias(gep.get(), gep->getPtr().get());
                else if (auto phi = std::dynamic_pointer_cast<PHIInst>(inst)) {
                    if (phi->getType()->getTrait() == IRCTYPE::PTR) {
                        for (const auto& oper : phi->getPhiOpers())
                            changed |= res.insertAlias(phi.get(), oper->getValue().get());
                    }
                }
            }

            for (const auto& succ : curr->getNextBB()) {
                if (visited.find(succ.get()) == visited.end())
                    worklist.emplace_back(succ.get());
            }
        }
    }

    // ModRef
    for (const auto& bb : func) {
        for (const auto& inst : *bb) {
            if (auto load = std::dynamic_pointer_cast<LOADInst>(inst)) {
                auto ptr = load->getPtr().get();
                if (res.getPtrInfo(ptr).untracked)
                    res.read.insert(ptr);
            }
            else if (auto store = std::dynamic_pointer_cast<STOREInst>(inst)) {
                auto ptr = store->getPtr().get();
                if (res.getPtrInfo(ptr).untracked)
                    res.write.insert(ptr);
            }
            else if (auto call = std::dynamic_pointer_cast<CALLInst>(inst)) {
                auto call_fn = call->getFunc().get();
                if (call_fn->isSylib()) {
                    if (call_fn->getName() != "@_sysy_starttime"
                        && call_fn->getName() != "@_sysy_stoptime") {
                        res.has_untracked_call = true;
                    }
                }
                else if (call_fn->isBuiltin()) {
                    // IRGen only use memset to initialize array
                    if (call_fn->getName() != "@" + std::string{Config::IR::BUILTIN_MEMSET})
                        res.has_untracked_call = true;
                }
                else // FIXME: Recursion call.
                    res.has_untracked_call = true;
            }
        }
    }

    return res;
}


} // namespace IR
