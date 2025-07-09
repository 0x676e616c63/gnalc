// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/vectorizer.hpp"

#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "ir/formatter.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/irbuilder.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/analysis/target_analysis.hpp"
#include "ir/passes/utilities/irprinter.hpp"
#include "match/match.hpp"
#include "utils/scope_guard.hpp"

#include <set>
#include <sstream>
#include <string>
#include <unordered_set>
#include <vector>

using namespace Match;

namespace IR {
std::string dumpScalars(const std::vector<pVal> &scalars) {
    std::stringstream ss;
    for (auto &s : scalars) {
        if (auto store = s->as<STOREInst>())
            ss << "store[" << s->getName() << "](ptr: " << store->getPtr()->getName()
               << ", val: " << store->getValue()->getName() << ") ";
        else if (auto load = s->as<LOADInst>())
            ss << "load[" << load->getName() << "](ptr: " << load->getPtr()->getName() << ") ";
        else if (auto binary = s->as<BinaryInst>())
            ss << "binary[" << s->getName() << "](op: " << IRFormatter::formatOp(binary->getOpcode())
               << ", lhs: " << binary->getLHS()->getName() << ", rhs: " << binary->getRHS()->getName() << ") ";
        else if (auto cast = s->as<CastInst>())
            ss << "cast[" << s->getName() << "](op: " << IRFormatter::formatOp(cast->getOpcode())
               << ", val: " << cast->getOVal()->getName() << ") ";
        else if (auto icmp = s->as<ICMPInst>())
            ss << "icmp[" << s->getName() << "](cond: " << IRFormatter::formatCMPOP(icmp->getCond())
               << ", lhs: " << icmp->getLHS()->getName() << ", rhs: " << icmp->getRHS()->getName() << ") ";
        else if (auto fcmp = s->as<FCMPInst>())
            ss << "fcmp[" << s->getName() << "](cond: " << IRFormatter::formatCMPOP(fcmp->getCond())
               << ", lhs: " << fcmp->getLHS()->getName() << ", rhs: " << fcmp->getRHS()->getName() << ") ";
        else if (auto select = s->as<SELECTInst>())
            ss << "select[" << s->getName() << "](cond: " << select->getCond()->getName()
               << ", true: " << select->getTrueVal()->getName() << ", false: " << select->getFalseVal()->getName()
               << ") ";
        else if (auto phi = s->as<PHIInst>())
            ss << "phi[" << s->getName() << "] ";
        else if (auto gep = s->as<GEPInst>())
            ss << "gep[" << gep->getName() << "](ptr: " << gep->getPtr()->getName()
               << ", index: " << gep->getIdxs()[0]->getName() << ") ";
        else if (s->getVTrait() == ValueTrait::CONSTANT_LITERAL)
            ss << s->getName() << " ";
        else
            ss << "unknown[" << s->getName() << "] ";
    }
    return ss.str();
}

int VectorizerPass::AlignRewriter::getAlign(const pVal &val) {
    Err::gassert(val != nullptr);
    if (auto load = val->as<LOADInst>())
        return load->getAlign();
    if (auto store = val->as<STOREInst>())
        return store->getAlign();
    if (auto alloc = val->as<ALLOCAInst>())
        return alloc->getAlign();
    if (auto gv = val->as<GlobalVariable>())
        return gv->getAlign();
    return -1;
}
void VectorizerPass::AlignRewriter::setAlign(const pVal &val, int align) {
    Err::gassert(val != nullptr);
    if (auto load = val->as<LOADInst>())
        load->setAlign(align);
    else if (auto store = val->as<STOREInst>())
        store->setAlign(align);
    else if (auto alloc = val->as<ALLOCAInst>())
        alloc->setAlign(align);
    else if (auto gv = val->as<GlobalVariable>())
        gv->setAlign(align);
}

// Warning: This could change Allocas in other functions
bool VectorizerPass::AlignRewriter::trySetBaseAlign(pVal ptr, int align, Function *curr_func, Changes &changes) {
    while (true) {
        if (auto bitcast = ptr->as<BITCASTInst>())
            ptr = bitcast->getOVal();
        else if (auto gep = ptr->as<GEPInst>())
            ptr = gep->getPtr();
        else if (auto alloc = ptr->as<ALLOCAInst>()) {
            if (alloc->getAlign() < align) {
                changes.emplace_back(alloc, alloc->getAlign());
                alloc->setAlign(align);
            }
            return true;
        } else if (auto gv = ptr->as<GlobalVariable>()) {
            if (gv->getAlign() < align) {
                changes.emplace_back(gv, gv->getAlign());
                gv->setAlign(align);
            }
            return true;
        } else if (auto fp = ptr->as<FormalParam>()) {
            for (auto user : curr_func->inst_users()) {
                auto call = user->as<CALLInst>();
                Err::gassert(call != nullptr, "Expected a call user");
                Function *caller_func = call->getParent()->getParent().get();
                if (!trySetBaseAlign(call->getArgs()[fp->getIndex()], align, caller_func, changes)) {
                    Logger::logDebug("[SLP]: Failed to rewrite the align of FormalParam '", fp->getName(), "'");
                    return false;
                }
            }
            return true;
        } else if (auto phi = ptr->as<PHIInst>()) {
            for (const auto &[phi_ptr, bb] : phi->incomings()) {
                if (!trySetBaseAlign(phi_ptr, align, curr_func, changes)) {
                    Logger::logDebug("[SLP]: Failed to rewrite the align of PhiOperand '[", phi_ptr->getName(), ", ",
                                     bb->getName(), "'");
                    return false;
                }
            }
            return true;
        }
        // If setBaseAlign is called from a CALLInst in a callee function,
        // the caller function have not run PromotePass. (since the callee is always prior to
        // the caller in the function list, due to the absence of function declarations).
        // Typically, the LOADInst is loading formal parameter in the caller function, which is a
        // pointer from the caller's caller.
        // For example,
        // define dso_local i32 @foo(i32* noundef %0) {
        //    entry:
        //      %2 = alloca i32*, align 4
        //      store i32* %0, i32** %2, align 4
        //    4:
        //      %5 = load i32*, i32** %2, align 4
        //      %6 = call i32 @bar(i32* noundef %5)
        //    ...
        else if (auto load = ptr->as<LOADInst>()) {
            Err::gassert(load->getType()->is<PtrType>());
            auto fp_alloca = load->getPtr()->as<ALLOCAInst>();
            if (!fp_alloca) {
                Logger::logDebug("[SLP]: Failed to rewrite the align of pointer loaded from '",
                                 load->getPtr()->getName(), "', because it is not a Alloca for FormalParam.");
                return false;
            }
            // Find the first store that stores the formal parameter
            auto fp_val = [&]() -> pVal {
                auto entry = curr_func->getBlocks().front();
                for (auto &inst : *entry) {
                    if (auto fp_store = inst->as<STOREInst>()) {
                        if (fp_store->getPtr() == fp_alloca) {
                            if (fp_store->getValue()->is<FormalParam>())
                                return fp_store->getValue();
                        }
                    }
                }
                return nullptr;
            }();
            if (!fp_val) {
                Logger::logDebug("[SLP]: Failed to rewrite the align of pointer loaded from '",
                                 load->getPtr()->getName(), "', because we cannot find the store of the FormalParam.");
                return false;
            }
            ptr = fp_val;
        } else
            Err::unreachable("Unknown Pointer");
    }
    return false;
}

bool VectorizerPass::AlignRewriter::trySetInstAlign(const pInst &inst, int align) {
    pVal ptr;
    if (auto load = inst->as_raw<LOADInst>())
        ptr = load->getPtr();
    else if (auto store = inst->as_raw<STOREInst>())
        ptr = store->getPtr();
    else
        Err::unreachable();

    int align_on_base = loop_aa->getAlignOnBase(ptr);
    if (align_on_base < align) {
        Logger::logDebug("[SLP]: Failed to rewrite the align of '", ptr->getName(),
                         "', due to its narrow align on base. (AlignOnBase: ", align_on_base, ", Expected: ", align,
                         ").");
        return false;
    }

    Changes curr_changes;
    auto func = inst->getParent()->getParent().get();
    if (trySetBaseAlign(ptr, align, func, curr_changes)) {
        rewritten[inst] = curr_changes;
        setAlign(inst, align);
        return true;
    }

    Logger::logDebug("[SLP]: Failed to rewrite the align of '", ptr->getName(),
                     "', due to failure of rewriting its base align.");

    for (auto &[ptr, align] : curr_changes)
        setAlign(ptr, align);
    return false;
}

void VectorizerPass::AlignRewriter::restoreInstAlign(const pInst &inst) {
    for (auto &[ptr, align] : rewritten[inst])
        setAlign(ptr, align);
}

VectorizerPass::SchedData *VectorizerPass::Scheduler::getData(const pVal &val) {
    auto it = sched_data_map.find(val);
    if (it != sched_data_map.end() && it->second->region_id == region_id)
        return it->second;
    return nullptr;
}

bool VectorizerPass::Scheduler::hasMemAccess(const pInst &inst) {
    if (inst->is<LOADInst>() || inst->is<STOREInst>())
        return true;
    if (auto call = inst->as<CALLInst>()) {
        auto rw = getCallRWInfo(*fam, call);
        if (!rw.read.empty() || !rw.write.empty())
            return true;
    }
    return false;
}

void VectorizerPass::Scheduler::initSchedData(BBInstIter from, BBInstIter to, SchedData *prev_mem_access,
                                              SchedData *next_mem_access) {
    SchedData *curr_mem_access = prev_mem_access;
    for (auto it = from; it != to; ++it) {
        const auto &curr = *it;
        auto sched_data = sched_data_map[curr];
        if (!sched_data) {
            sched_data_list.emplace_back();
            sched_data = &sched_data_list.back();
            sched_data->inst = curr;
            sched_data_map[curr] = sched_data;
        }
        sched_data->init(region_id);

        if (hasMemAccess(curr)) {
            if (curr_mem_access)
                curr_mem_access->next_mem_access = sched_data;
            else
                first_mem_access = sched_data;
            curr_mem_access = sched_data;
        }
    }

    if (next_mem_access) {
        if (curr_mem_access)
            curr_mem_access->next_mem_access = next_mem_access;
    } else
        last_mem_access = curr_mem_access;
}

bool VectorizerPass::Scheduler::extendRegion(const pInst &inst) {
    Err::gassert(inst != nullptr);

    if (getData(inst))
        return true;

    if (!sched_begin) {
        initSchedData(inst->iter(), std::next(inst->iter()), nullptr, nullptr);
        sched_begin = inst;
        sched_end = *std::next(inst->iter());
        return true;
    }

    if (sched_begin->getIndex() > inst->getIndex()) {
        if (++region_size > max_region_size)
            return false;
        initSchedData(inst->iter(), sched_begin->iter(), nullptr, first_mem_access);
        sched_begin = inst;
        return true;
    }
    if (sched_end->getIndex() <= inst->getIndex()) {
        if (++region_size > max_region_size)
            return false;
        initSchedData(sched_end->iter(), std::next(inst->iter()), last_mem_access, nullptr);
        sched_end = *std::next(inst->iter());
        return true;
    }
    return true;
}

void VectorizerPass::Scheduler::resetSchedule() {
    for (auto it = sched_begin->iter(); it != sched_end->iter(); ++it) {
        auto sched = getData(*it);
        sched->is_sched = false;
        sched->resetUnschedDeps();
    }
    dry_run_ready_list.clear();
}

bool VectorizerPass::Scheduler::inRegion(SchedData *sched) const { return sched->region_id == region_id; }

struct InstRWInfo {
    std::vector<pVal> read;
    std::vector<pVal> write;
    bool untracked = false;
};

InstRWInfo collectRWInfo(FAM *fam, const pInst &inst) {
    if (auto load = inst->as<LOADInst>()) {
        return {
            .read = {load->getPtr()},
            .write = {},
            .untracked = false,
        };
    }
    if (auto store = inst->as<STOREInst>()) {
        return {
            .read = {},
            .write = {store->getPtr()},
            .untracked = false,
        };
    }
    if (auto call = inst->as<CALLInst>()) {
        auto callrw = getCallRWInfo(*fam, call);
        return {
            .read = callrw.read,
            .write = callrw.write,
            .untracked = callrw.untracked,
        };
    }
    Err::unreachable();
    return {};
}

bool setMayAlias(LoopAAResult *loop_aa, const std::vector<pVal> &ptrs1, const std::vector<pVal> &ptrs2) {
    for (const auto &ptr1 : ptrs1) {
        for (const auto &ptr2 : ptrs2) {
            if (loop_aa->getAliasInfo(ptr1, ptr2) != AliasInfo::NoAlias)
                return true;
        }
    }
    return false;
}

bool VectorizerPass::Scheduler::isMemDependent(const pInst &inst1, const pInst &inst2) const {
    Err::gassert(inst1 != inst2);

    // Quick path for two load/stores
    if (!inst1->is<CALLInst>() && !inst2->is<CALLInst>()) {
        if (inst1->is<LOADInst>() && inst2->is<LOADInst>())
            return false;
        auto loc1 = getMemLocation(inst1);
        auto loc2 = getMemLocation(inst2);
        return loop_aa->getAliasInfo(loc1, loc2) != AliasInfo::NoAlias;
    }

    auto rw1 = collectRWInfo(fam, inst1);
    auto rw2 = collectRWInfo(fam, inst2);

    if (rw1.untracked || rw2.untracked)
        return true;

    if (rw1.write.empty() && rw2.write.empty())
        return false;

    if (setMayAlias(loop_aa, rw1.read, rw2.write) || setMayAlias(loop_aa, rw1.write, rw2.write) ||
        setMayAlias(loop_aa, rw1.write, rw2.read))
        return true;

    return false;
}

void VectorizerPass::Scheduler::updateDeps(SchedData *sched, bool insert_in_ready_list) {
    std::vector worklist{sched};

    while (!worklist.empty()) {
        auto curr = worklist.back();
        worklist.pop_back();

        auto member = curr;
        while (member) {
            if (!member->isDepsValid()) {
                member->num_deps = 0;
                member->resetUnschedDeps();

                // Use-def dependencies
                // One instruction must be scheduled before its user, thus must be
                // scheduling after its user is scheduled. So user is all its operands' dependency
                for (auto user : member->inst->inst_users()) {
                    auto user_sched = getData(user);
                    if (user_sched && inRegion(user_sched->first_in_bundle)) {
                        ++member->num_deps;
                        auto dest_bundle = user_sched->first_in_bundle;
                        if (!dest_bundle->is_sched)
                            member->incUnschedDeps(1);
                        if (!dest_bundle->isDepsValid())
                            worklist.emplace_back(dest_bundle);
                    }
                }

                // Memory dependencies
                // For memory operations, we can't
                //   R W --> W R            (Read got wrong value)
                //   W R --> R W            (Read got wrong value)
                //   W_1 W_2 --> W_2 W_1    (Final memory state may be different)
                // To preserve correctness, any write must remain after all preceding reads and writes.
                // Therefore, each write introduces a dependency on all prior memory accesses --
                // both reads and writes. In scheduling, a memory write is treated as a user of
                // all preceding memory operations, which act as its operands.
                auto dep_dest = member->next_mem_access;
                while (dep_dest) {
                    if (isMemDependent(member->inst, dep_dest->inst)) {
                        dep_dest->mem_deps.emplace_back(member);
                        ++member->num_deps;
                        auto dest_bundle = dep_dest->first_in_bundle;
                        if (!dest_bundle->is_sched)
                            member->incUnschedDeps(1);
                        if (!dest_bundle->isDepsValid())
                            worklist.emplace_back(dest_bundle);
                    }
                    dep_dest = dep_dest->next_mem_access;
                }
            }
            member = member->next_in_bundle;
        }
        if (insert_in_ready_list && sched->isReady() && sched->isSchedEntity())
            dry_run_ready_list.insert(sched);
    }
}

bool VectorizerPass::Scheduler::tryScheduleBundle(const std::vector<pVal> &scalars) {
    const auto &op = scalars[0];
    if (op->is<PHIInst>())
        return true;

    auto old_sched_end = sched_end;
    SchedData *bundle = nullptr;
    SchedData *prev_member = nullptr;
    bool re_sched = false;

    for (const auto &val : scalars) {
        if (!extendRegion(val->as<Instruction>())) {
            Logger::logDebug("[SLP]: Failed to schedule because extend region failed.");
            return false;
        }
    }

    for (const auto &scalar : scalars) {
        auto inst = scalar->as<Instruction>();
        auto member = getData(inst);
        if (member->is_sched)
            re_sched = true;

        if (prev_member)
            prev_member->next_in_bundle = member;
        else
            bundle = member;

        member->num_unsched_deps_in_bundle = 0;
        bundle->num_unsched_deps_in_bundle += member->num_unsched_deps;
        member->first_in_bundle = bundle;
        prev_member = member;
    }

    // If the region got new instructions at the lower end (or it is a
    // new region for the first bundle), recalculate all dependencies.
    if (sched_end != old_sched_end) {
        for (auto it = sched_begin->iter(); it != sched_end->iter(); ++it)
            getData(*it)->clearDeps();

        re_sched = true;
    }

    if (re_sched) {
        resetSchedule();
        initialFillReadyList(dry_run_ready_list);
    }

    updateDeps(bundle, true);

    while (!bundle->isReady() && !dry_run_ready_list.empty()) {
        auto picked = *dry_run_ready_list.begin();
        dry_run_ready_list.erase(dry_run_ready_list.begin());
        Err::gassert(picked->isSchedEntity() && picked->isReady());
        schedule(picked, dry_run_ready_list);
    }

    if (!bundle->isReady()) {
        Logger::logDebug("[SLP]: Scheduling failed because of unscheduled dependencies for bundle '",
                         bundle->inst->getName(), "'.");
        if (slp_print_debug_message) {
            std::cerr << "Unscheduled Bundle:\n";
            std::cerr << dumpSchedData(bundle);
        }

        cancelScheduling(scalars);
        return false;
    }

    return true;
}

void VectorizerPass::Scheduler::cancelScheduling(const std::vector<pVal> &scalars) {
    const auto &op = scalars[0];
    if (op->is<PHIInst>())
        return;

    auto member = getData(op);
    while (member) {
        // Break up bundles
        member->first_in_bundle = member;
        auto next = member->next_in_bundle;
        member->next_in_bundle = nullptr;
        // Restore unscheduled deps
        member->num_unsched_deps_in_bundle = member->num_unsched_deps;

        if (member->num_unsched_deps_in_bundle == 0)
            dry_run_ready_list.insert(member);
        member = next;
    }
}

std::string VectorizerPass::Scheduler::dumpSchedData(SchedData *bundle) {
    std::stringstream ss;
    auto member = bundle;
    std::vector<pVal> scalars;
    while (member) {
        scalars.emplace_back(member->inst);
        member = member->next_in_bundle;
    }
    ss << "Bundle: " << bundle->inst->getName() << "\n";
    ss << "Scalars: " << dumpScalars(scalars) << "\n";
    member = bundle;
    while (member) {
        ss << "Member: " << member->inst->getName() << "\n";
        ss << "  Operands: ";
        for (auto op : member->inst->operands())
            ss << op->getName() << " ";
        ss << "\n";
        ss << "  MemDeps: ";
        for (auto &mem_dep : member->mem_deps)
            ss << mem_dep->inst->getName() << " ";
        ss << "\n";
        ss << "  num_deps: " << member->num_deps << "\n";
        ss << "  num_unsched_deps: " << member->num_unsched_deps << "\n";
        ss << "  Users: \n";
        for (auto user : member->inst->inst_users()) {
            ss << "    " << user->getName() << ": ";
            auto user_bundle = getData(user);
            if (user_bundle && inRegion(user_bundle->first_in_bundle))
                ss << (user_bundle->is_sched ? "Scheduled" : "Unscheduled") << "\n";
            else
                ss << "Outside Region\n";
        }
        ss << "  MemUsers (NOT MemDeps): \n";
        std::vector<SchedData *> mem_users;
        for (auto &sched_data : sched_data_list) {
            for (auto &mem : sched_data.mem_deps) {
                if (mem == member)
                    mem_users.push_back(&sched_data);
            }
        }
        for (const auto &mem_user : mem_users) {
            ss << "    " << mem_user->inst->getName() << ": " << (mem_user->is_sched ? "Scheduled" : "Unscheduled")
               << "\n";
        }
        member = member->next_in_bundle;
    }
    return ss.str();
}

std::string VectorizerPass::Scheduler::dumpAllData() {
    std::string ret;
    for (auto &sched_data : sched_data_list)
        ret += dumpSchedData(&sched_data) + "\n";
    return ret;
}

VectorizerPass::Scheduler &VectorizerPass::getScheduler(const pBlock &block) {
    auto &sched = schedulers[block];
    if (sched.block == nullptr) {
        sched = Scheduler{
            .block = block,
            .fam = fam,
            .loop_aa = loop_aa,
            .slp_print_debug_message = slp_print_debug_message,
            .region_id = ++next_region_id,
        };
    }
    return sched;
}

std::pair<pType, pVecType> analyzeType(const std::vector<pVal> &scalars) {
    auto scalar_type = scalars[0]->getType();
    if (auto store = scalars[0]->as<STOREInst>())
        scalar_type = store->getValue()->getType();
    else if (auto icmp = scalars[0]->as<ICMPInst>())
        scalar_type = icmp->getLHS()->getType();
    else if (auto fcmp = scalars[0]->as<FCMPInst>())
        scalar_type = fcmp->getLHS()->getType();

    auto vector_type = makeVectorType(scalar_type, scalars.size());
    return std::make_pair(scalar_type, vector_type);
}

VectorizerPass::Tree *VectorizerPass::newTree(const std::vector<pVal> &scalars, bool vectorized, int &user_tree_idx) {
    int idx = static_cast<int>(vec_trees.size());
    vec_trees.emplace_back(Tree{scalars});
    auto &tree = vec_trees.back();
    tree.need_to_gather = !vectorized;
    if (vectorized) {
        for (const auto &scalar : tree.scalars) {
            Err::gassert(getTree(scalar) == nullptr);
            scalar_to_tree[scalar] = idx;
        }
    } else
        must_gather.insert(scalars.begin(), scalars.end());

    if (user_tree_idx >= 0)
        tree.user_tree_indices.emplace_back(user_tree_idx);
    user_tree_idx = idx;
    return &tree;
}

void VectorizerPass::deleteTree() {
    vec_trees.clear();
    scalar_to_tree.clear();
    must_gather.clear();
    external_users.clear();
    schedulers.clear();
}

VectorizerPass::Tree *VectorizerPass::getTree(const pVal &val) {
    auto it = scalar_to_tree.find(val);
    if (it != scalar_to_tree.end())
        return &vec_trees[it->second];
    return nullptr;
}

void VectorizerPass::collectSeeds(const pBlock &block) {
    seed_stores.clear();

    for (const auto &inst : *block) {
        if (auto store = inst->as<STOREInst>()) {
            if (store->getValue()->getType()->is<VectorType>())
                continue;
            seed_stores.emplace_back(store);
        }
    }
}

std::tuple<std::unordered_set<pStore>, std::unordered_set<pStore>, std::map<pStore, pStore>>
VectorizerPass::findConsecutiveStoreLinks() const {
    std::unordered_set<pStore> heads, tails;
    std::map<pStore, pStore> consecutive_chain;

    for (size_t i = 0; i < seed_stores.size(); i++) {
        const auto &curr_store = seed_stores[i];
        auto do_search = [&](const pStore &next_store) {
            if (loop_aa->isConsecutiveAccess(curr_store, next_store)) {
                tails.emplace(next_store);
                heads.emplace(curr_store);
                consecutive_chain[curr_store] = next_store;
            }
        };
        // pairing with immediate succeeding or preceding stores first
        for (size_t j = i + 1; j < seed_stores.size(); j++)
            do_search(seed_stores[j]);
        for (int j = static_cast<int>(i) - 1; j >= 0; j--)
            do_search(seed_stores[j]);
    }
    return {heads, tails, consecutive_chain};
}
bool VectorizerPass::vectorizeStoreChains() {
    bool changed = false;

    auto [heads, tails, links] = findConsecutiveStoreLinks();
    std::unordered_set<pStore> vectorized;
    for (const auto &chain_begin : heads) {
        // Only process the beginning element of the chain
        // For example,
        //   str1 -> str2          |
        //   str2 -> str3          |     str1 -> str2 -> str3
        //   str10 -> str11        |     str10 -> str11 -> str12
        //   str11 -> str12        |
        // We only process str1 and str10, which is store that starts a link but don't end any link.
        if (tails.count(chain_begin))
            continue;

        // Get the chain from the beginning
        auto chain_elem = chain_begin;
        std::vector<pStore> chain;
        while ((tails.count(chain_elem) || heads.count(chain_elem)) && !vectorized.count(chain_elem)) {
            chain.emplace_back(chain_elem);
            chain_elem = links[chain_elem];
        }

        if (slp_print_debug_message) {
            std::cerr << "Vectorizing chain: " << chain[0]->getName();
            for (size_t i = 1; i < chain.size(); i++)
                std::cerr << " -> " << chain[i]->getName();
            std::cerr << "\n";
        }

        // Try to vectorize the chain with multiple VFs
        const auto max_size = target->getMaxVectorRegisterSize();
        const auto min_size = target->getMinVectorRegisterSize();
        Err::gassert(Util::isPowerOfTwo(max_size) && Util::isPowerOfTwo(min_size), "Bad vector register size");
        for (size_t s = max_size; s >= min_size; s /= 2) {
            if (vectorizeStoreChain(chain, s)) {
                for (const auto &str : chain)
                    vectorized.emplace(str);
                changed = true;
                break;
            }
        }
    }
    return changed;
}

bool VectorizerPass::vectorizeStoreChain(const std::vector<pStore> &chain, size_t scalars_size) {
    bool changed = false;
    auto elem_size = chain[0]->getValue()->getType()->getBytes() * 8;
    auto vf = scalars_size / elem_size;

    // Find the most profitable offset
    for (size_t offset = 0; offset + vf <= chain.size();) {
        std::vector<pVal> scalars;
        for (size_t i = offset; i < offset + vf; i++)
            scalars.emplace_back(chain[i]);
        deleteTree();
        buildTree(scalars);
        collectExternalUsers();
        auto cost = getTreeCost();
        if (cost < -Config::IR::SLP_COST_THRESHOLD) {
            vectorizeTrees();
            rewritten_aligns.clear();
            offset += vf;
            changed = true;
        } else {
            Logger::logDebug("[SLP]: Vectorization canceled because the cost (", cost, ") is too high.");
            ++offset;
            for (const auto &re : rewritten_aligns)
                align_rewriter.restoreInstAlign(re);
            rewritten_aligns.clear();
        }
    }
    return changed;
}

void VectorizerPass::buildTree(const std::vector<pVal> &scalars) { buildTreeImpl(scalars, 0, -1); }

std::optional<OP> VectorizerPass::getAltOpcode(OP Op) {
    switch (Op) {
    case OP::FADD:
        return OP::FSUB;
    case OP::FSUB:
        return OP::FADD;
    case OP::ADD:
        return OP::SUB;
    case OP::SUB:
        return OP::ADD;
    default:
        return std::nullopt;
    }
    return std::nullopt;
}

// fadd, fsub, fadd, fsub...
std::optional<OP> VectorizerPass::tryAnalyzeAlternativeOp(const std::vector<pVal> &scalars) {
    auto tmp = scalars[0]->as<Instruction>();
    auto opcode = tmp->getOpcode();

    auto alt = getAltOpcode(opcode);
    if (!alt)
        return std::nullopt;

    for (size_t i = 1; i < scalars.size(); i++) {
        auto inst = scalars[i]->as<Instruction>();
        if (!inst || inst->getOpcode() != ((i % 2 != 0) ? *alt : opcode))
            return std::nullopt;
    }
    return OP::SHUFFLE;
}

std::optional<OP> VectorizerPass::analyzeOpcode(const std::vector<pVal> &scalars) {
    auto tmp = scalars[0]->as<Instruction>();
    if (!tmp)
        return std::nullopt;
    auto opcode = tmp->getOpcode();
    for (size_t i = 1; i < scalars.size(); i++) {
        auto inst = scalars[i]->as<Instruction>();
        if (!inst || inst->getOpcode() != opcode) {
            // See if we can emit a shuffle here
            if (i == 1)
                return tryAnalyzeAlternativeOp(scalars);
            return std::nullopt;
        }
    }
    return opcode;
}

bool VectorizerPass::isAllConstant(const std::vector<pVal> &scalars) {
    return std::all_of(scalars.begin(), scalars.end(),
                       [](const pVal &v) { return v->getVTrait() == ValueTrait::CONSTANT_LITERAL; });
}

bool VectorizerPass::isAllSame(const std::vector<pVal> &scalars) {
    return std::all_of(scalars.begin(), scalars.end(), [&scalars](const pVal &v) { return v == scalars[0]; });
}

bool VectorizerPass::isInSameBlock(const std::vector<pVal> &scalars) {
    auto same_block = scalars[0]->as<Instruction>()->getParent();
    return std::all_of(scalars.begin(), scalars.end(),
                       [&same_block](const pVal &v) { return v->as<Instruction>()->getParent() == same_block; });
}

bool VectorizerPass::canReuseExtract(const std::vector<pVal> &scalars) {
    auto vec = scalars[0]->as<EXTRACTInst>()->getVector();
    if (scalars.size() != vec->getType()->as<VectorType>()->getVectorSize())
        return false;

    for (size_t i = 0; i < scalars.size(); i++) {
        auto extract = scalars[i]->as<EXTRACTInst>();
        if (!match(extract->getIdx(), M::Is(static_cast<int>(i))))
            return false;
        if (extract->getVector() != vec)
            return false;
    }
    return true;
}

void VectorizerPass::buildTreeImpl(const std::vector<pVal> &scalars, int depth, int user_tree_idx) {
    auto gather = [&] { newTree(scalars, false, user_tree_idx); };

    if (depth == Config::IR::SLP_BUILD_TREE_RECURSION_THRESHOLD) {
        Logger::logDebug("[SLP]: buildTree reached its recursion threshold");
        gather();
        return;
    }

    // Skip vectors
    if (scalars[0]->getType()->is<VectorType>()) {
        gather();
        return;
    }
    if (auto store = scalars[0]->as<STOREInst>()) {
        if (store->getValue()->getType()->is<VectorType>()) {
            gather();
            return;
        }
    }

    auto opcode = analyzeOpcode(scalars);
    if (!opcode) {
        gather();
        return;
    }

    bool is_alt_shuffle = false;
    if (*opcode == OP::SHUFFLE && scalars[0]->as<Instruction>()->getOpcode() != OP::SHUFFLE) {
        is_alt_shuffle = true;
    }

    // For constants and identical values, we have a more optimized way.
    if (isAllConstant(scalars) || isAllSame(scalars) || !isInSameBlock(scalars)) {
        gather();
        return;
    }

    // Check tree dependency
    for (const auto &scalar : scalars) {
        if (must_gather.count(scalar)) {
            gather();
            return;
        }

        if (auto tree = getTree(scalar)) {
            if (tree->scalars != scalars) {
                gather();
                return;
            }

            // Reuse identical tree
            tree->user_tree_indices.emplace_back(user_tree_idx);
            return;
        }
    }

    // Ensure each value occurs only once
    for (size_t i = 0; i < scalars.size(); i++) {
        for (size_t j = i + 1; j < scalars.size(); j++) {
            if (scalars[i] == scalars[j]) {
                gather();
                return;
            }
        }
    }

    // At this point, scalars are some vectorizable instructions.
    auto block = scalars[0]->as<Instruction>()->getParent();
    auto &scheduler = getScheduler(block);
    if (!scheduler.tryScheduleBundle(scalars)) {
        Logger::logDebug("[SLP]: buildTree failed due to unschedulable bundle '", scalars[0]->getName(), "'.");
        Err::gassert(!scheduler.getData(scalars[0]) || !scheduler.getData(scalars[0])->isPartOfBundle(),
                     "Bad canceling.");
        gather();
        return;
    }

    auto cancel_sched_and_gather = [&] {
        scheduler.cancelScheduling(scalars);
        Err::gassert(!scheduler.getData(scalars[0]) || !scheduler.getData(scalars[0])->isPartOfBundle(),
                     "Bad canceling.");
        newTree(scalars, false, user_tree_idx);
    };

    switch (*opcode) {
    case OP::PHI: {
        newTree(scalars, true, user_tree_idx);

        auto block = scalars[0]->as<Instruction>()->getParent();
        for (auto pred : block->preds()) {
            std::vector<pVal> operands;

            for (const auto &s : scalars)
                operands.emplace_back(s->as<PHIInst>()->getValueForBlock(pred));

            buildTreeImpl(operands, depth + 1, user_tree_idx);
        }

        return;
    }
    case OP::EXTRACT: {
        auto reuse = canReuseExtract(scalars);
        if (reuse)
            Logger::logDebug("[SLP]: Reusing extract: ", dumpScalars(scalars));
        else
            cancel_sched_and_gather();

        newTree(scalars, reuse, user_tree_idx);
        return;
    }
    case OP::LOAD: {
        for (size_t i = 0; i < scalars.size() - 1; ++i) {
            if (!loop_aa->isConsecutiveAccess(scalars[i], scalars[i + 1])) {
                cancel_sched_and_gather();
                Logger::logDebug("[SLP]: TODO: Load wants to shuffle.");
                return;
            }
        }

        auto load0 = scalars[0]->as<LOADInst>();
        int expected_align = scalars.size() * load0->getType()->getBytes();
        if (align_rewriter.trySetInstAlign(load0, expected_align))
            rewritten_aligns.emplace_back(load0);

        newTree(scalars, true, user_tree_idx);
        return;
    }
    case OP::STORE: {
        for (size_t i = 0; i < scalars.size() - 1; ++i) {
            if (!loop_aa->isConsecutiveAccess(scalars[i], scalars[i + 1])) {
                cancel_sched_and_gather();
                Logger::logDebug("[SLP]: TODO: Store wants to mask.");
                return;
            }
        }

        auto store0 = scalars[0]->as<STOREInst>();
        int expected_align = scalars.size() * store0->getValue()->getType()->getBytes();
        if (align_rewriter.trySetInstAlign(store0, expected_align))
            rewritten_aligns.emplace_back(store0);

        newTree(scalars, true, user_tree_idx);

        std::vector<pVal> operands;
        for (const auto &scalar : scalars)
            operands.emplace_back(scalar->as<STOREInst>()->getValue());
        buildTreeImpl(operands, depth + 1, user_tree_idx);
        return;
    }
    case OP::ZEXT:
    case OP::SEXT:
    case OP::FPTOSI:
    case OP::SITOFP:
    case OP::BITCAST: {
        auto src_ty = scalars[0]->as<CastInst>()->getOType();
        for (size_t i = 1; i < scalars.size(); ++i) {
            if (isSameType(scalars[i]->as<CastInst>()->getOType(), src_ty)) {
                cancel_sched_and_gather();
                return;
            }
        }

        std::vector<pVal> operands;
        for (const auto &scalar : scalars)
            operands.emplace_back(scalar->as<CastInst>()->getOVal());
        buildTreeImpl(operands, depth + 1, user_tree_idx);
        return;
    }
    case OP::ICMP: {
        // Check cmpop
        auto icmp0 = scalars[0]->as<ICMPInst>();
        auto cmp_op = icmp0->getCond();
        auto cmp_ty = icmp0->getLHS()->getType();
        for (size_t i = 1; i < scalars.size(); i++) {
            if (cmp_op != scalars[i]->as<ICMPInst>()->getCond() ||
                cmp_ty != scalars[i]->as<ICMPInst>()->getLHS()->getType()) {
                cancel_sched_and_gather();
                return;
            }
        }

        newTree(scalars, true, user_tree_idx);

        std::vector<pVal> lhs_operands;
        std::vector<pVal> rhs_operands;
        for (const auto &scalar : scalars) {
            auto icmp = scalar->as<ICMPInst>();
            lhs_operands.emplace_back(icmp->getLHS());
            rhs_operands.emplace_back(icmp->getRHS());
        }
        buildTreeImpl(lhs_operands, depth + 1, user_tree_idx);
        buildTreeImpl(rhs_operands, depth + 1, user_tree_idx);
        return;
    }
    case OP::FCMP: {
        // Check cmpop
        auto fcmp0 = scalars[0]->as<FCMPInst>();
        auto cmp_op = fcmp0->getCond();
        auto cmp_ty = fcmp0->getLHS()->getType();
        for (size_t i = 1; i < scalars.size(); i++) {
            if (cmp_op != scalars[i]->as<FCMPInst>()->getCond() ||
                cmp_ty != scalars[i]->as<FCMPInst>()->getLHS()->getType()) {
                cancel_sched_and_gather();
                return;
            }
        }

        newTree(scalars, true, user_tree_idx);

        std::vector<pVal> lhs_operands;
        std::vector<pVal> rhs_operands;
        for (const auto &scalar : scalars) {
            auto fcmp = scalar->as<FCMPInst>();
            lhs_operands.emplace_back(fcmp->getLHS());
            rhs_operands.emplace_back(fcmp->getRHS());
        }
        buildTreeImpl(lhs_operands, depth + 1, user_tree_idx);
        buildTreeImpl(rhs_operands, depth + 1, user_tree_idx);
        return;
    }
    case OP::ADD:
    case OP::FADD:
    case OP::SUB:
    case OP::FSUB:
    case OP::MUL:
    case OP::FMUL:
    case OP::DIV:
    case OP::FDIV:
    case OP::SREM:
    case OP::UREM:
    case OP::FREM:
    case OP::SHL:
    case OP::LSHR:
    case OP::ASHR:
    case OP::AND:
    case OP::OR:
    case OP::XOR: {
        newTree(scalars, true, user_tree_idx);

        auto bin0 = scalars[0]->as<BinaryInst>();
        if (bin0->isCommutative()) {
            // TODO: canonicalize operands
        }

        std::vector<pVal> lhs_operands;
        std::vector<pVal> rhs_operands;
        for (const auto &scalar : scalars) {
            auto bin = scalar->as<BinaryInst>();
            lhs_operands.emplace_back(bin->getLHS());
            rhs_operands.emplace_back(bin->getRHS());
        }
        buildTreeImpl(lhs_operands, depth + 1, user_tree_idx);
        buildTreeImpl(rhs_operands, depth + 1, user_tree_idx);
        return;
    }
    case OP::SELECT: {
        newTree(scalars, true, user_tree_idx);

        std::vector<pVal> conds;
        std::vector<pVal> lhs_operands;
        std::vector<pVal> rhs_operands;
        for (const auto &scalar : scalars) {
            auto sel = scalar->as<SELECTInst>();
            conds.emplace_back(sel->getCond());
            lhs_operands.emplace_back(sel->getTrueVal());
            rhs_operands.emplace_back(sel->getFalseVal());
        }
        buildTreeImpl(conds, depth + 1, user_tree_idx);
        buildTreeImpl(lhs_operands, depth + 1, user_tree_idx);
        buildTreeImpl(rhs_operands, depth + 1, user_tree_idx);
        return;
    }
    case OP::GEP: {
        auto gep0 = scalars[0]->as<GEPInst>();
        auto cur_ty = gep0->getBaseType();
        for (const auto &scalar : scalars) {
            auto gep = scalar->as<GEPInst>();
            auto index = gep->getIdxs();
            if (gep->getBaseType() != cur_ty || index.size() != 1 || // Skip complicated GEPs
                index[0]->getVTrait() != ValueTrait::CONSTANT_LITERAL) {
                cancel_sched_and_gather();
                return;
            }
        }

        newTree(scalars, true, user_tree_idx);

        std::vector<pVal> ptrs;
        std::vector<pVal> idxs;
        for (const auto &scalar : scalars) {
            auto gep = scalar->as<GEPInst>();
            ptrs.emplace_back(gep->getPtr());
            idxs.emplace_back(gep->getIdxs()[0]);
        }
        buildTreeImpl(ptrs, depth + 1, user_tree_idx);
        buildTreeImpl(idxs, depth + 1, user_tree_idx);
        return;
    }
    case OP::CALL: {
        // TODO: Vector Intrinsics
        // Maybe whole function vectorization in the future?
        // https://compilers.cs.uni-saarland.de/papers/karrenberg_wfv.pdf

        cancel_sched_and_gather();
        return;
        return;
    }
    case OP::SHUFFLE: {
        if (!is_alt_shuffle) {
            cancel_sched_and_gather();
            return;
        }
        // TODO Alternate Shuffle vectors

        Logger::logDebug("[SLP]: TODO: Alternate opcode vectorize");
        cancel_sched_and_gather();
        return;
    }
    default:
        cancel_sched_and_gather();
        return;
    }
}

bool VectorizerPass::inTreeUserNeedToExtract(const pVal &val, const pInst &user) {
    if (auto load = user->as<LOADInst>())
        return load->getPtr() == val;
    if (auto store = user->as<STOREInst>())
        return store->getValue() == val;
    return false;
}
void VectorizerPass::collectExternalUsers() {
    for (const auto &tree : vec_trees) {
        if (tree.need_to_gather)
            continue;

        for (int lane = 0; lane < tree.scalars.size(); ++lane) {
            const auto &scalar = tree.scalars[lane];
            for (auto user : scalar->inst_users()) {
                if (auto user_tree = getTree(user)) {
                    // In-tree users like the first vectorized load/store's pointer operand,
                    // still need to be a scalar.
                    if (user_tree->scalars[0] != user || !inTreeUserNeedToExtract(scalar, user))
                        continue;
                }
                external_users.emplace_back(scalar, user, lane);
            }
        }
    }
}

int VectorizerPass::getGatherCost(const pVecType &ty) {
    int cost = 0;
    for (size_t i = 0; i < ty->getVectorSize(); ++i)
        cost += target->getVecInstCost(OP::INSERT, ty, i);
    return cost;
}

int VectorizerPass::getBaseCost(const Tree &tree) {
    auto [scalar_ty, vec_ty] = analyzeType(tree.scalars);

    if (tree.need_to_gather) {
        if (isAllConstant(tree.scalars))
            return 0;
        if (isAllSame(tree.scalars))
            return target->getShuffleCost(vec_ty, ShuffleKind::Broadcast);
        return getGatherCost(vec_ty);
    }

    auto opcode = *analyzeOpcode(tree.scalars);
    switch (opcode) {
    case OP::PHI:
        return 0;
    case OP::EXTRACT:
        if (canReuseExtract(tree.scalars)) {
            int dead_cost = 0;
            for (int i = 0; i < tree.scalars.size(); ++i) {
                auto extract = tree.scalars[i]->as<EXTRACTInst>();
                // If all users are going to be vectorized, the extract will be vectorized eventually,
                // thus can be considered as dead.
                // In particular, if the extract has only one user, that user must be us and
                // the extract will be vectorized for sure.
                if (extract->getUseCount() == 1 || std::all_of(extract->user_begin(), extract->user_end(), [this](auto user) {
                    return scalar_to_tree.count(user);
                })) {
                    dead_cost += target->getVecInstCost(OP::EXTRACT, vec_ty, i);
                }
            }
            return -dead_cost;
        }
        return getGatherCost(vec_ty);
    case OP::ZEXT:
    case OP::SEXT:
    case OP::FPTOSI:
    case OP::SITOFP:
    case OP::BITCAST: {
        auto src_ty = tree.scalars[0]->as<CastInst>()->getOType();
        auto dst_ty = tree.scalars[0]->as<CastInst>()->getTType();
        int scalar_cost = tree.scalars.size() * target->getCastCost(opcode, src_ty, dst_ty);

        auto src_vec_ty = makeVectorType(src_ty, tree.scalars.size());
        int vector_cost = target->getCastCost(opcode, src_vec_ty, vec_ty);

        return vector_cost - scalar_cost;
    }
    case OP::ICMP:
    case OP::FCMP: {
        auto val_ty = tree.scalars[0]->getType();
        int scalar_cost = tree.scalars.size() * target->getCmpCost(opcode, val_ty);
        int vector_cost = target->getCmpCost(opcode, vec_ty);
        return vector_cost - scalar_cost;
    }
    case OP::SELECT: {
        auto val_ty = tree.scalars[0]->getType();
        int scalar_cost = tree.scalars.size() * target->getSelectCost(val_ty);
        int vector_cost = target->getSelectCost(vec_ty);
        return vector_cost - scalar_cost;
    }
    case OP::ADD:
    case OP::FADD:
    case OP::SUB:
    case OP::FSUB:
    case OP::MUL:
    case OP::FMUL:
    case OP::DIV:
    case OP::FDIV:
    case OP::SREM:
    case OP::UREM:
    case OP::FREM:
    case OP::SHL:
    case OP::LSHR:
    case OP::ASHR:
    case OP::AND:
    case OP::OR:
    case OP::XOR: {
        OperandTrait lhs_trait, rhs_trait;

        auto uniform_lhs = tree.scalars[0]->as<BinaryInst>()->getLHS();
        auto uniform_rhs = tree.scalars[0]->as<BinaryInst>()->getRHS();
        for (size_t i = 1; i < tree.scalars.size(); ++i) {
            auto bin = tree.scalars[i]->as<BinaryInst>();
            if (bin->getLHS() != uniform_lhs)
                uniform_lhs = nullptr;
            if (bin->getRHS() != uniform_rhs)
                uniform_rhs = nullptr;
        }

        auto analyze_op = [](const pVal &val, OperandKind &op_kind, OperandProp &op_prop) {
            if (val) {
                if (val->getVTrait() == ValueTrait::CONSTANT_LITERAL) {
                    op_kind = OperandKind::UniformConstant;
                    if (auto ci32 = val->as<ConstantInt>()) {
                        if (Util::isPowerOfTwo(ci32->getVal()))
                            op_prop = OperandProp::PowerOfTwo;
                    }
                } else
                    op_kind = OperandKind::Uniform;
            }
        };

        analyze_op(uniform_lhs, lhs_trait.kind, lhs_trait.prop);
        analyze_op(uniform_rhs, rhs_trait.kind, rhs_trait.prop);

        int scalar_cost = tree.scalars.size() * target->getBinaryCost(opcode, scalar_ty, lhs_trait, rhs_trait);
        int vector_cost = target->getBinaryCost(opcode, vec_ty, lhs_trait, rhs_trait);
        return vector_cost - scalar_cost;
    }
    case OP::GEP: {
        // We've ensured it is a single constant index gep
        auto ptr_trait = OperandTrait::none();
        OperandTrait index_trait{
            .kind = OperandKind::UniformConstant,
            .prop = OperandProp::None,
        };
        int scalar_cost = tree.scalars.size() * target->getBinaryCost(OP::ADD, scalar_ty, ptr_trait, index_trait);
        int vector_cost = target->getBinaryCost(OP::ADD, vec_ty, ptr_trait, index_trait);
        return vector_cost - scalar_cost;
    }
    case OP::LOAD:
    case OP::STORE: {
        int align = AlignRewriter::getAlign(tree.scalars[0]);

        int scalar_cost = tree.scalars.size() * target->getMemCost(opcode, scalar_ty, align);
        int vector_cost = target->getMemCost(opcode, vec_ty, align);
        return vector_cost - scalar_cost;
    }
    case OP::CALL: {
        // TODO:
        // Vector intrinsic or whole-func vectorize
        return getGatherCost(vec_ty);
    }
    case OP::SHUFFLE: {
        // TODO:
        // Alternate Shuffle
        return getGatherCost(vec_ty);
    }
    default:
        Err::unreachable();
    }
    Err::unreachable();
    return 0;
}

// Calculate the vectorization cost of the SLP tree.
// Negative for profitable.
int VectorizerPass::getTreeCost() {
    size_t vf = vec_trees[0].scalars.size();

    int base_cost = 0;
    for (const auto &tree : vec_trees)
        base_cost += getBaseCost(tree);

    int extract_cost = 0;
    std::unordered_set<pVal> extracted;
    for (const auto &euser : external_users) {
        if (!extracted.insert(euser.scalar).second)
            continue;

        auto vec_ty = makeVectorType(euser.scalar->getType(), vf);
        extract_cost += target->getVecInstCost(OP::EXTRACT, vec_ty, euser.lane);
    }

    if (slp_print_debug_message) {
        std::cerr << "Base Cost: " << base_cost << "\n";
        std::cerr << "Extract Cost: " << extract_cost << "\n\n";
        printTree(std::cerr);
    }

    // TODO: Spill/Refill Cost
    return base_cost + extract_cost;
}

void VectorizerPass::printTree(std::ostream &os) {
    for (size_t i = 0; i < vec_trees.size(); i++) {
        os << "Tree " << i << ": \n";
        os << "Need to Gather: " << (vec_trees[i].need_to_gather ? "true" : "false") << "\n";

        auto opcode = analyzeOpcode(vec_trees[i].scalars);
        os << "Kind: ";
        if (isAllConstant(vec_trees[i].scalars))
            os << "Constant";
        else if (isAllSame(vec_trees[i].scalars))
            os << "Splat";
        else if (opcode)
            os << IRFormatter::formatOp(*opcode);
        else
            os << "None";
        os << "\n";

        if (opcode && (opcode == OP::LOAD || opcode == OP::STORE))
            os << "Align: " << AlignRewriter::getAlign(vec_trees[i].scalars[0]) << "\n";

        os << "Scalars: " << dumpScalars(vec_trees[i].scalars) << "\n";

        std::vector<pVal> need_to_extract;
        for (const auto &scalar : vec_trees[i].scalars) {
            auto need = [&]() -> bool {
                for (const auto &eu : external_users) {
                    if (eu.scalar == scalar)
                        return true;
                }
                return false;
            }();
            if (need)
                need_to_extract.emplace_back(scalar);
        }
        os << "Need to Extract: ";
        for (const auto &scalar : need_to_extract)
            os << scalar->getName() << " ";
        os << "\n";

        os << "User Tree Indices: ";
        for (auto &u : vec_trees[i].user_tree_indices)
            os << u << " ";
        os << "\n";

        os << std::endl;
    }
    os << "------------------------------\n";
}

void VectorizerPass::scheduleBlock(Scheduler *scheduler) {
    if (!scheduler->sched_begin)
        return;

    // Clear Dry-run schedule
    scheduler->resetSchedule();

    struct SchedCmp {
        bool operator()(SchedData *sched1, SchedData *sched2) const { return sched2->priority < sched1->priority; }
    };
    std::set<SchedData *, SchedCmp> ready_list;

    int idx = 0;
    int num_to_sched = 0;
    for (auto it = scheduler->sched_begin->iter(); it != scheduler->sched_end->iter(); ++it) {
        auto sched = scheduler->getData(*it);
        Err::gassert(sched->isPartOfBundle() == (getTree(sched->inst) != nullptr),
                     "Vectorized Tree doesn't form a bundle?");
        sched->first_in_bundle->priority = idx++;
        if (sched->isSchedEntity()) {
            scheduler->updateDeps(sched, false);
            ++num_to_sched;
        }
    }
    scheduler->initialFillReadyList(ready_list);

    auto last_sched_inst = scheduler->sched_end;
    while (!ready_list.empty()) {
        auto picked = *ready_list.begin();
        ready_list.erase(ready_list.begin());

        auto member = picked;
        while (member) {
            auto picked_inst = member->inst;
            if (std::next(last_sched_inst->iter()) != picked_inst->iter()) {
                scheduler->block->delFirstOfInst(picked_inst);
                scheduler->block->addInst(last_sched_inst->iter(), picked_inst);
            }
            last_sched_inst = picked_inst;
            member = member->next_in_bundle;
        }

        scheduler->schedule(picked, ready_list);
        --num_to_sched;
    }

    Err::gassert(num_to_sched == 0);

    scheduler->sched_begin = nullptr;
}

void VectorizerPass::setInsertPointAfterBundle(const std::vector<pVal> &scalars) {
    BBInstIter last_it;
    size_t last_pos = 0;
    for (const auto &scalar : scalars) {
        auto it = scalar->as<Instruction>();
        Err::gassert(it != nullptr, "Can not set set insert point after a bundle of constants.");
        if (it->getIndex() >= last_pos) {
            last_it = it->iter();
            last_pos = it->getIndex();
        }
    }
    builder.setInsertPoint(scalars[0]->as<Instruction>()->getParent(), ++last_it);
}

pVal VectorizerPass::gatherTree(const std::vector<pVal> &scalars, const pVecType &ty) {
    Err::gassert(scalars.size() == ty->getVectorSize());

    // FIXME: What we really want is a undefined value, not zero.
    pVal vec = cpool->getZero(ty);
    for (int i = 0; i < ty->getVectorSize(); ++i) {
        vec = builder.makeInsert(vec, scalars[i], cpool->getConst(i));

        // Handle external users
        if (auto tree = getTree(scalars[i])) {
            int user_lane = -1;
            for (int lane = 0; lane < scalars.size(); ++lane) {
                if (tree->scalars[lane] == scalars[i]) {
                    user_lane = lane;
                    break;
                }
            }
            Err::gassert(user_lane >= 0);
            external_users.emplace_back(scalars[i], vec->as<Instruction>(), user_lane);
        }
    }

    return vec;
}

pVal VectorizerPass::vectorizeFromScalars(const std::vector<pVal> &scalars) {
    if (auto tree = getTree(scalars[0])) {
        if (tree->scalars == scalars)
            return vectorizeTree(tree);
    }

    auto [scalar_ty, vec_ty] = analyzeType(scalars);
    return gatherTree(scalars, vec_ty);
}

pVal VectorizerPass::vectorizeTree(Tree *tree) {
    auto dbg_guard = Util::make_scope_guard([&] {
        if (tree->vec)
            Logger::logDebug("[SLP]: Vectorized '", dumpScalars(tree->scalars), "' to '", tree->vec->getName(), "'.");
    });

    // RAII Object to restore insert point when this function exits,
    // since there can be recursive calls to vectorizeTree.
    InsertPointGuard insertpoint_guard(builder);

    if (tree->vec) {
        Logger::logDebug("[SLP]: Diamond merged for '", tree->vec->getName(), "'.");
        dbg_guard.release();
        return tree->vec;
    }

    auto [scalar_ty, vec_ty] = analyzeType(tree->scalars);

    if (tree->need_to_gather) {
        setInsertPointAfterBundle(tree->scalars);
        auto vec = gatherTree(tree->scalars, vec_ty);
        tree->vec = vec;
        return vec;
    }

    auto block = tree->scalars[0]->as<Instruction>()->getParent();
    auto opcode = *analyzeOpcode(tree->scalars);

    switch (opcode) {
    case OP::PHI: {
        builder.setInsertPoint(block, (*block->begin())->iter());

        auto vec_phi = builder.makePhi(vec_ty);
        tree->vec = vec_phi;

        for (auto pred : block->preds()) {
            std::vector<pVal> operands;
            operands.reserve(tree->scalars.size());
            for (const auto &scalar : tree->scalars)
                operands.emplace_back(scalar->as<PHIInst>()->getValueForBlock(pred));

            builder.setInsertPoint(pred, pred->getEndInsertPoint());
            auto incoming_vec = vectorizeFromScalars(operands);
            vec_phi->addPhiOper(incoming_vec, pred);
        }

        Err::gassert(vec_phi->getNumIncomings() == block->getNumPreds() &&
                         vec_phi->getNumIncomings() == tree->scalars[0]->as<PHIInst>()->getNumIncomings(),
                     "Bad PHI Nodes");

        return vec_phi;
    }
    case OP::EXTRACT: {
        if (canReuseExtract(tree->scalars)) {
            auto vec = tree->scalars[0]->as<EXTRACTInst>()->getVector();
            tree->vec = vec;
            return vec;
        }
        setInsertPointAfterBundle(tree->scalars);
        auto vec = gatherTree(tree->scalars, vec_ty);
        tree->vec = vec;
        return vec;
    }
    case OP::ZEXT:
    case OP::SEXT:
    case OP::FPTOSI:
    case OP::SITOFP:
    case OP::BITCAST: {
        std::vector<pVal> operands;
        for (const auto &scalar : tree->scalars)
            operands.emplace_back(scalar->as<CastInst>()->getOVal());

        setInsertPointAfterBundle(tree->scalars);

        auto ori_vec = vectorizeFromScalars(operands);
        auto vec_cast = builder.makeCast(opcode, ori_vec, vec_ty);
        tree->vec = vec_cast;
        return vec_cast;
    }
    case OP::ICMP: {
        std::vector<pVal> lhs, rhs;
        ICMPOP cmpop = ICMPOP::eq;
        for (const auto &scalar : tree->scalars) {
            auto icmp = scalar->as<ICMPInst>();
            cmpop = icmp->getCond();
            lhs.emplace_back(icmp->getLHS());
            rhs.emplace_back(icmp->getRHS());
        }

        setInsertPointAfterBundle(tree->scalars);

        auto lhs_vec = vectorizeFromScalars(lhs);
        auto rhs_vec = vectorizeFromScalars(rhs);

        auto vec_icmp = builder.makeIcmp(cmpop, lhs_vec, rhs_vec);
        tree->vec = vec_icmp;
        return vec_icmp;
    }
    case OP::FCMP: {
        std::vector<pVal> lhs, rhs;
        FCMPOP cmpop = FCMPOP::oeq;
        for (const auto &scalar : tree->scalars) {
            auto icmp = scalar->as<FCMPInst>();
            cmpop = icmp->getCond();
            lhs.emplace_back(icmp->getLHS());
            rhs.emplace_back(icmp->getRHS());
        }

        setInsertPointAfterBundle(tree->scalars);

        auto lhs_vec = vectorizeFromScalars(lhs);
        auto rhs_vec = vectorizeFromScalars(rhs);

        auto vec_fcmp = builder.makeFcmp(cmpop, lhs_vec, rhs_vec);
        tree->vec = vec_fcmp;
        return vec_fcmp;
    }

    case OP::SELECT: {
        std::vector<pVal> cond, true_val, false_val;
        for (const auto &scalar : tree->scalars) {
            auto select = scalar->as<SELECTInst>();
            cond.emplace_back(select->getCond());
            true_val.emplace_back(select->getTrueVal());
            false_val.emplace_back(select->getFalseVal());
        }

        setInsertPointAfterBundle(tree->scalars);

        auto cond_vec = vectorizeFromScalars(cond);
        auto true_vec = vectorizeFromScalars(true_val);
        auto false_vec = vectorizeFromScalars(false_val);

        auto vec_select = builder.makeSelect(cond_vec, true_vec, false_vec);
        tree->vec = vec_select;
        return vec_select;
    }
    case OP::ADD:
    case OP::FADD:
    case OP::SUB:
    case OP::FSUB:
    case OP::MUL:
    case OP::FMUL:
    case OP::DIV:
    case OP::FDIV:
    case OP::SREM:
    case OP::UREM:
    case OP::FREM:
    case OP::SHL:
    case OP::LSHR:
    case OP::ASHR:
    case OP::AND:
    case OP::OR:
    case OP::XOR: {
        std::vector<pVal> lhs, rhs;
        // TODO: Reorder commutive

        for (const auto &scalar : tree->scalars) {
            auto bin = scalar->as<BinaryInst>();
            lhs.emplace_back(bin->getLHS());
            rhs.emplace_back(bin->getRHS());
        }

        setInsertPointAfterBundle(tree->scalars);

        auto lhs_vec = vectorizeFromScalars(lhs);
        auto rhs_vec = vectorizeFromScalars(rhs);
        auto vec_bin = builder.makeBinary(opcode, lhs_vec, rhs_vec);

        tree->vec = vec_bin;
        return vec_bin;
    }
    case OP::LOAD: {
        setInsertPointAfterBundle(tree->scalars);

        auto load0 = tree->scalars[0]->as<LOADInst>();
        auto raw_ptr = load0->getPtr();
        auto vec_ptr = builder.makeBitcast(raw_ptr, makePtrType(vec_ty));
        auto vec_load = builder.makeLoad(vec_ptr);
        auto align = load0->getAlign();
        vec_load->setAlign(align);

        if (getTree(raw_ptr))
            external_users.emplace_back(raw_ptr, vec_ptr, 0);

        tree->vec = vec_load;
        return vec_load;
    }
    case OP::STORE: {
        std::vector<pVal> val;

        for (const auto &scalar : tree->scalars)
            val.emplace_back(scalar->as<STOREInst>()->getValue());

        setInsertPointAfterBundle(tree->scalars);
        auto val_vec = vectorizeFromScalars(val);

        auto store0 = tree->scalars[0]->as<STOREInst>();
        auto raw_ptr = store0->getPtr();
        auto vec_ptr = builder.makeBitcast(raw_ptr, makePtrType(vec_ty));
        auto vec_store = builder.makeStore(val_vec, vec_ptr);
        auto align = store0->getAlign();
        vec_store->setAlign(align);

        if (getTree(raw_ptr))
            external_users.emplace_back(raw_ptr, vec_ptr, 0);

        tree->vec = vec_store;
        return vec_store;
    }
    case OP::GEP: {
        setInsertPointAfterBundle(tree->scalars);

        std::vector<pVal> ptr, index;
        for (const auto &scalar : tree->scalars) {
            ptr.emplace_back(scalar->as<GEPInst>()->getPtr());
            index.emplace_back(scalar->as<GEPInst>()->getIdxs()[0]);
        }

        auto ptr_vec = vectorizeFromScalars(ptr);
        auto index_vec = vectorizeFromScalars(index);

        // FIXME: the base type?
        auto vec_gep = builder.makeGep(ptr_vec, index_vec);

        tree->vec = vec_gep;
        return vec_gep;
    }

        // TODO
    case OP::CALL:
    case OP::SHUFFLE:
        Err::todo("call and shuffle");
        return nullptr;

    default:
        Err::unreachable("Unknown opcode");
    }
    Err::unreachable("Unknown opcode");
    return nullptr;
}

pVal VectorizerPass::vectorizeTrees() {
    if (slp_print_debug_message) {
        // Sometimes this is too noisy even when debugging
        auto &os = Util::null_stream();
        // auto& os = std::cerr;
        IRPrinter printer(os);
        for (auto &sched : schedulers) {
            os << "All Schedule Data: \n" << sched.second.dumpAllData() << "\n";
            os << "Before Scheduling: \n";
            sched.second.block->accept(printer);
            scheduleBlock(&sched.second);
            os << "After Scheduling: \n";
            sched.second.block->accept(printer);
        }
    } else {
        for (auto &sched : schedulers)
            scheduleBlock(&sched.second);
    }

    auto vec_root = vectorizeTree(&vec_trees[0]);

    for (const auto &euser : external_users) {
        const auto &scalar = euser.scalar;
        const auto &user = euser.user;

        // If we've replaced it before, skip it.
        // This can happen when a value is used multiple times by one user.
        if (user && !Util::contains(scalar->users(), user))
            continue;

        auto tree = getTree(scalar);
        Err::gassert(tree && !tree->need_to_gather);

        auto lane_ci = cpool->getConst(euser.lane);
        if (auto vec_inst = tree->vec->as<Instruction>()) {
            if (auto phi = user->as<PHIInst>()) {
                for (auto [val, bb] : phi->incomings()) {
                    if (val == scalar) {
                        builder.setInsertPoint(bb, bb->getEndInsertPoint());
                        auto extract = builder.makeExtract(tree->vec, lane_ci);
                        phi->setValueForBlock(bb, extract);
                    }
                }
            } else if (auto inst = user->as<Instruction>()) {
                builder.setInsertPoint(inst);
                auto extract = builder.makeExtract(tree->vec, lane_ci);
                inst->replaceAllOperands(scalar, extract);
            } else
                Err::unreachable();

            Logger::logDebug("[SLP]: Extracted '", tree->vec->getName(), "' for external users of '", scalar->getName(),
                             "'.");
        }
    }

    std::unordered_set<pInst> dead;
    for (const auto &tree : vec_trees) {
        if (tree.need_to_gather)
            continue;

        Err::gassert(tree.vec != nullptr);
        for (const auto &scalar : tree.scalars)
            dead.emplace(scalar->as<Instruction>());
    }
    for (const auto &block : *func) {
        block->delInstIf([&](const pInst &inst) { return dead.count(inst); }, BasicBlock::DEL_MODE::ALL);
    }

    // static int i = 0;
    // for (const auto &d : dead) {
    //     d->appendDbgData("SLPDead" + std::to_string(i++));
    // }
    return vec_trees[0].vec;
}

PM::PreservedAnalyses VectorizerPass::run(Function &function, FAM &fam) {
    target = fam.getResult<TargetAnalysis>(function);
    if (!target->isVectorSupported())
        return PreserveAll();

    bool vectorizer_inst_modified = false;

    this->fam = &fam;
    func = &function;
    loop_aa = &fam.getResult<LoopAliasAnalysis>(function);
    align_rewriter.loop_aa = loop_aa;
    cpool = &function.getConstantPool();
    next_region_id = 1;

    auto podfv = function.getDFVisitor<Util::DFVOrder::PostOrder>();
    for (auto &bb : podfv) {
        collectSeeds(bb);

        if (!seed_stores.empty())
            vectorizer_inst_modified |= vectorizeStoreChains();
    }

    reset();
    return vectorizer_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR
