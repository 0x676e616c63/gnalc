// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/vectorizer.hpp"

#include "ir/block_utils.hpp"
#include "ir/formatter.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/analysis/target_analysis.hpp"

#include <algorithm>

namespace IR {
std::ostream &operator<<(std::ostream &os, const VectorizerPass::Pack &expr) {
    for (auto it = expr.stmts.begin(); it != expr.stmts.end(); ++it) {
        const auto &stmt = *it;
        if (auto str = stmt->as<STOREInst>()) {
            os << "store val " << str->getValue()->getName() << " addr-" << stmt.get();
        }
        else
            os << IRFormatter::formatOp(stmt->getOpcode()) << " " << stmt->getName() << " addr-" << stmt.get();
        if (it != expr.stmts.end() - 1)
            os << ", ";
    }
    return os;
}
std::ostream &operator<<(std::ostream &os, const VectorizerPass &vec) {
    os << "For BasicBlock '" << vec.curr_block->getName() << "':\n";
    for (const auto &pack : vec.pack_set)
        os << "Pack " << pack.id << ": " << pack << "\n";
    return os;
}

// Check if instructions are isomorphic.
bool isIsomorphic(const pInst &stmt1, const pInst &stmt2) { return stmt1->getOpcode() == stmt2->getOpcode(); }

// Check if there is use-def dependency between two instructions.
bool isIndependent(const pInst &stmt1, const pInst &stmt2) {
    return !AhasUseToB(stmt2, stmt1) && !AhasUseToB(stmt1, stmt2);
}

// Instructions act as seeds.
bool hasMemoryRef(const pInst &inst) { return inst->getOpcode() == OP::STORE || inst->getOpcode() == OP::LOAD; }

// Currently we only conside load/store and binary instructions
bool isVectorizable(const pInst &inst) {
    if (auto load = inst->as<LOADInst>())
        return load->getType()->is<BType>();
    if (auto store = inst->as<STOREInst>())
        return store->getValue()->getType()->is<BType>();
    if (auto binary = inst->as<BinaryInst>())
        return binary->getType()->is<BType>();

    return false;
}

// Check if the load/store is adjacent.
bool isInstAdjacent(const pInst &inst1, const pInst &inst2, LoopAAResult &loop_aa) {
    if (inst1->is<LOADInst>() && inst2->is<LOADInst>()) {
        if (!isSameType(inst1->getType(), inst2->getType()))
            return false;
        auto ptr1 = inst1->as<LOADInst>()->getPtr();
        auto ptr2 = inst2->as<LOADInst>()->getPtr();
        return loop_aa.isV2NextToV1(ptr1, ptr2);
    }

    if (inst1->is<STOREInst>() && inst2->is<STOREInst>()) {
        auto store1 = inst1->as<STOREInst>();
        auto store2 = inst2->as<STOREInst>();
        if (!isSameType(store1->getValue()->getType(), store2->getValue()->getType()))
            return false;
        return loop_aa.isV2NextToV1(store1->getPtr(), store2->getPtr());
    }

    return false;
}

// Get the align of the instruction, -1 will be returned if the instruction does not have align.
auto getAlign(const pInst &inst) {
    if (!inst)
        return -1;
    if (auto load = inst->as<LOADInst>())
        return load->getAlign();
    if (auto store = inst->as<STOREInst>())
        return store->getAlign();
    return -1;
}

// Set the align of the instruction.
void setAlign(const pInst &inst, int align) {
    if (auto load = inst->as<LOADInst>())
        load->setAlign(align);
    else if (auto store = inst->as<STOREInst>())
        store->setAlign(align);
}

// Warning: This could change Allocas in other functions
bool trySetBaseAlign(pVal ptr, int align, Function *curr_func) {
    while (true) {
        if (auto bitcast = ptr->as<BITCASTInst>())
            ptr = bitcast->getOVal();
        else if (auto gep = ptr->as<GEPInst>())
            ptr = gep->getPtr();
        else if (auto alloc = ptr->as<ALLOCAInst>()) {
            if (alloc->getAlign() < align)
                alloc->setAlign(align);
            return true;
        } else if (auto gv = ptr->as<GlobalVariable>()) {
            if (gv->getAlign() < align)
                gv->setAlign(align);
            return true;
        } else if (auto fp = ptr->as<FormalParam>()) {
            bool all_success = true;
            std::vector<int> orig_aligns;

            for (auto user : curr_func->inst_users()) {
                auto call = user->as<CALLInst>();
                Err::gassert(call != nullptr, "Expected a call user");
                Function *caller_func = call->getParent()->getParent().get();
                all_success &= trySetBaseAlign(call->getArgs()[fp->getIndex()], align, caller_func);
            }

            // Restore the original alignment
            if (!all_success) {
                size_t i = 0;
                for (auto user : curr_func->inst_users()) {
                    if (i >= orig_aligns.size())
                        break;
                    auto call = user->as<CALLInst>();
                    Function *caller_func = call->getParent()->getParent().get();
                    all_success &= trySetBaseAlign(call->getArgs()[fp->getIndex()], orig_aligns[i], caller_func);
                    ++i;
                }
                return false;
            }

            return true;
        } else if (auto phi = ptr->as<PHIInst>()) {
            bool all_success = true;
            std::vector<int> orig_aligns;
            for (const auto &[phi_ptr, bb] : phi->incomings()) {
                orig_aligns.emplace_back(getAlign(phi_ptr->as<Instruction>()));
                all_success &= trySetBaseAlign(phi_ptr, align, curr_func);
                if (!all_success)
                    break;
            }

            // Restore the original alignment
            if (!all_success) {
                auto phi_opers = phi->getPhiOpers();
                for (size_t i = 0; i < orig_aligns.size(); ++i)
                    trySetBaseAlign(phi_opers[i].value, orig_aligns[i], curr_func);
                return false;
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
            if (!fp_alloca)
                return false;
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
            if (!fp_val)
                return false;
            ptr = fp_val;
        } else
            Err::unreachable("Unknown Pointer");
    }
    return false;
}

VectorizerPass::Pack::Pack(size_t id_, const pInst &stmt1, const pInst &stmt2)
    : stmts({stmt1, stmt2}), stmt_set({stmt1, stmt2}), id(id_) {}
VectorizerPass::Pack::Pack(size_t id_, const Pack &a, const Pack &b)
    : stmts(a.stmts), stmt_set(a.stmt_set), align(a.align > b.align ? b.align : a.align), id(id_) {
    stmts.insert(stmts.end(), b.stmts.begin(), b.stmts.end());
    stmt_set.insert(b.stmt_set.begin(), b.stmt_set.end());
}

bool VectorizerPass::Pack::contains(const pInst &stmt) const { return stmt_set.count(stmt); }

bool VectorizerPass::Pack::isPair() const { return size() == 2; }
pInst VectorizerPass::Pack::getLeft() const {
    Err::gassert(isPair());
    return stmts[0];
}
pInst VectorizerPass::Pack::getRight() const {
    Err::gassert(isPair());
    return stmts[1];
}
size_t VectorizerPass::Pack::size() const { return stmts.size(); }

VectorizerPass::Pack VectorizerPass::Pack::truncate(size_t size, size_t id_) {
    Err::gassert(size < stmts.size(), "Invalid size");
    std::vector<pInst> ret_stmts;
    std::unordered_set<pInst> ret_stmt_set;
    for (size_t i = size; i < stmts.size(); ++i) {
        ret_stmts.emplace_back(stmts[i]);
        ret_stmt_set.emplace(stmts[i]);
        stmt_set.erase(stmts[i]);
    }
    stmts.erase(stmts.begin() + size, stmts.end());

    Pack ret;
    ret.stmts = ret_stmts;
    ret.stmt_set = ret_stmt_set;
    ret.align = 4;
    ret.id = id_;
    return ret;
}

const pInst &VectorizerPass::Pack::front() const { return stmts.front(); }
const pInst &VectorizerPass::Pack::back() const { return stmts.back(); }

const pInst &VectorizerPass::Pack::pos_index_back() const {
    return *std::max_element(stmts.begin(), stmts.end(),
                             [](const pInst &a, const pInst &b) { return a->getIndex() < b->getIndex(); });
}

const pInst &VectorizerPass::Pack::pos_index_front() const {
    return *std::min_element(stmts.begin(), stmts.end(),
                             [](const pInst &a, const pInst &b) { return a->getIndex() < b->getIndex(); });
}

// Check if two instructions can be packed together.
bool VectorizerPass::stmtCanPack(const pInst &stmt1, const pInst &stmt2) {
    // Skip Non-vectorizable
    if (!isVectorizable(stmt1) || !isVectorizable(stmt2))
        return false;

    // Only isomorphic instructions can be packed
    if (!isIsomorphic(stmt1, stmt2))
        return false;

    // Ensure no intervening memory reference/modification
    //
    // %a = load xxx, i
    // store xxx, i + 1
    // %b = load i + 1
    // ----  or  ----
    // store xxx, i
    // %a = load/store i + 1
    // store xxx, i + 1
    if (hasMemoryRef(stmt1)) {
        Err::gassert(hasMemoryRef(stmt2), "Not isomorphic.");

        auto it = stmt1->getIter();
        auto end = stmt2->getIter();
        if (stmt1->getIndex() > stmt2->getIndex())
            std::swap(it, end);
        it = std::next(it);
        if (stmt1->is<LOADInst>()) {
            auto ptr = (*end)->as<LOADInst>()->getPtr();
            for (; it != end; ++it) {
                auto modref = basic_aa->getInstModRefInfo(*it, ptr, *fam);
                if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef)
                    return false;
            }
        } else if (stmt1->is<STOREInst>()) {
            auto ptr = (*end)->as<STOREInst>()->getPtr();
            for (; it != end; ++it) {
                auto modref = basic_aa->getInstModRefInfo(*it, ptr, *fam);
                if (modref != ModRefInfo::NoModRef)
                    return false;
            }
        }
    }

    // Ensure no use-def dependency
    if (!isIndependent(stmt1, stmt2))
        return false;

    // The left/right stmt must not be packed as a left/right stmt before.
    for (const auto &p : pack_set) {
        Err::gassert(p.isPair(), "This should be called before extendPackList");
        if (p.getLeft() == stmt1 || p.getRight() == stmt2)
            return false;

        // Skip Identical Packs
        if (p.getLeft() == stmt2 && p.getRight() == stmt1)
            return false;
    }

    return true;
}

VectorizerPass::Pack *VectorizerPass::stmtInPack(const pInst &stmt) {
    for (auto &pack : pack_set) {
        for (const auto &cand : pack.stmts) {
            if (cand == stmt)
                return &pack;
        }
    }
    return nullptr;
}

// Investigate the operands of the pack
bool VectorizerPass::followUseDefs(const Pack &pack) {
    Err::gassert(pack.isPair());
    auto stmt1 = pack.getLeft();
    auto stmt2 = pack.getRight();

    bool modified = false;
    for (size_t i = 0; i < stmt1->getNumOperands(); ++i) {
        auto x1 = stmt1->getOperand(i)->getValue()->as<Instruction>();
        auto x2 = stmt2->getOperand(i)->getValue()->as<Instruction>();
        if (!x1 || !x2)
            continue;
        if (x1->getParent() != curr_block || x2->getParent() != curr_block)
            continue;
        // Adjacent load/store has already been packed. The load/store here can't be adjacent.
        if (x1->is<LOADInst, STOREInst>() || x2->is<LOADInst, STOREInst>())
            continue;
        if (stmtCanPack(x1, x2)) {
            pack_set.emplace_back(pack_id++, x1, x2);
            modified = true;
        }
    }
    return modified;
}

// Investigate the users of the pack
bool VectorizerPass::followDefUses(const Pack &pack) {
    Err::gassert(pack.isPair());
    auto stmt1 = pack.getLeft();
    auto stmt2 = pack.getRight();

    for (const auto &user1 : stmt1->inst_users()) {
        if (user1->getParent() != curr_block)
            continue;
        for (const auto &user2 : stmt2->inst_users()) {
            if (user1 == user2)
                continue;
            if (user2->getParent() != curr_block)
                continue;
            // Adjacent load/store has already been packed. The load/store here can't be adjacent.
            if (user1->is<LOADInst, STOREInst>() || user2->is<LOADInst, STOREInst>())
                continue;
            if (stmtCanPack(user1, user2)) {
                // FIXME: Need Cost Model Here ?
                pack_set.emplace_back(pack_id++, user1, user2);
                return true;
            }
        }
    }

    return false;
}

// Collect seeds
void VectorizerPass::findAdjacentReferences() {
    for (const auto &inst : *curr_block) {
        if (!hasMemoryRef(inst))
            continue;

        for (const auto &candidate : *curr_block) {
            if (inst == candidate || !hasMemoryRef(candidate))
                continue;

            if (isInstAdjacent(inst, candidate, *loop_aa)) {
                if (stmtCanPack(inst, candidate))
                    pack_set.emplace_back(pack_id++, inst, candidate);
            }
        }
    }
    if constexpr (log_step_by_step)
        Logger::logDebug("[SLP] on '", curr_func->getName(), " AFTER FindAdj:\n", *this);
}

// Extend the PackSet through the use-def chain.
void VectorizerPass::extendPackList() {
    bool modified = true;
    while (modified) {
        modified = false;
        auto pack_set_prev = pack_set;
        for (const auto &pack : pack_set_prev) {
            modified |= followUseDefs(pack);
            modified |= followDefUses(pack);
        }
    }
    if constexpr (log_step_by_step)
        Logger::logDebug("[SLP] on '", curr_func->getName(), " AFTER Extend:\n", *this);
}

// Combine packs if possible, e.g.
// <s1, s2> + <s2, s3> ---> <s1, s2, s3, s4>
void VectorizerPass::combinePacks() {
    auto one_pass = [&] {
        for (auto it1 = pack_set.begin(); it1 != pack_set.end(); ++it1) {
            for (auto it2 = pack_set.begin(); it2 != pack_set.end(); ++it2) {
                if (it1 == it2)
                    continue;
                if (it1->stmts.back() == it2->stmts.front()) {
                    it1->stmts.pop_back();
                    Pack to_insert(pack_id++, *it1, *it2);
                    pack_set.erase(it1);
                    pack_set.erase(it2);
                    pack_set.emplace_back(to_insert);
                    return true;
                }
            }
        }
        return false;
    };

    while (one_pass())
        ;

    if constexpr (log_step_by_step)
        Logger::logDebug("[SLP] on '", curr_func->getName(), " AFTER Combine:\n", *this);
}

// Split packs to 2/4-sized packs
void VectorizerPass::rearrangePack() {
    std::vector<Pack> new_packs;
    for (auto &pack : pack_set) {
        if (pack.size() == 2 || pack.size() == 4)
            continue;

        if (pack.size() == 3 || pack.size() == 5) {
            pack.truncate(pack.size() - 1, pack_id++);
            continue;
        }

        Err::gassert(pack.size() >= 6);
        auto tail = pack.truncate(4, pack_id++);
        while (tail.size() > 4) {
            new_packs.emplace_back(tail);
            tail = new_packs.back().truncate(4, pack_id++);
        }
        if (tail.size() == 3)
            tail.truncate(2, pack_id++);
        if (tail.size() == 2 || tail.size() == 4)
            new_packs.emplace_back(tail);
    }
    for (auto &pack : new_packs)
        pack_set.emplace_back(pack);

    if constexpr (log_step_by_step)
        Logger::logDebug("[SLP] on '", curr_func->getName(), " AFTER Rearrange:\n", *this);
}

// For an instruction, collect all its users in post order.
// Returns: (has phi, users in post order)
//
//       a -- uses --> b -- uses --> c
//         -- uses --> d
//
// Given a, Returns: (false, [a, b, c, d])
std::pair<bool, std::vector<pInst>> collectOperandTreeInBlock(const pInst &seed) {
    std::vector worklist{seed};
    std::unordered_set visited{seed};
    bool has_phi = false;
    std::vector<pInst> ret;
    while (!worklist.empty()) {
        auto curr = worklist.back();
        worklist.pop_back();

        visited.emplace(curr);
        ret.emplace_back(curr);

        if (curr->is<PHIInst>())
            has_phi = true;

        for (auto oper : curr->operands()) {
            auto inst_oper = oper->as<Instruction>();
            if (!inst_oper || inst_oper->getParent() != seed->getParent())
                continue;

            if (!visited.count(inst_oper))
                worklist.emplace_back(inst_oper);
        }
    }

    return {has_phi, ret};
}

bool isDisjoint(const VectorizerPass::Pack &pack1, const VectorizerPass::Pack &pack2) {
    return pack1.pos_index_back()->getIndex() < pack2.pos_index_front()->getIndex() ||
           pack2.pos_index_back()->getIndex() < pack1.pos_index_front()->getIndex();
}

// FIXME: Need Optimization.
void VectorizerPass::removeUnschedulable() {
    // If packs with use-def dependency is not disjoint, remove one.
    auto joint_one_pass = [&] {
        for (auto it1 = pack_set.begin(); it1 != pack_set.end(); ++it1) {
            for (auto it2 = pack_set.begin(); it2 != pack_set.end(); ++it2) {
                if (it1 == it2)
                    continue;

                auto should_remove = [&] {
                    if (!isDisjoint(*it1, *it2)) {
                        for (const auto &inst1 : it1->stmts) {
                            for (const auto &inst2 : it2->stmts)
                                if (!isIndependent(inst1, inst2))
                                    return true;
                        }
                    }
                    return false;
                }();
                if (should_remove) {
                    // FIXME: Remove which one?
                    pack_set.erase(it1);
                    // pack_set.erase(it2);
                    return true;
                }
            }
        }
        return false;
    };
    while (joint_one_pass())
        ;

    auto no_phi_one_pass = [&] {
        for (auto it = pack_set.begin(); it != pack_set.end(); ++it) {
            const auto &pack = *it;
            auto should_remove = [&] {
                for (const auto &inst : pack.stmts) {
                    const auto [has_phi, users] = collectOperandTreeInBlock(inst);
                    if (has_phi)
                        return true;
                }
                return false;
            }();

            if (should_remove) {
                pack_set.erase(it);
                return true;
            }
        }
        return false;
    };

    while (no_phi_one_pass())
        ;

    if constexpr (log_step_by_step)
        Logger::logDebug("[SLP] on '", curr_func->getName(), " AFTER RemoveUnsch:\n", *this);
}

void VectorizerPass::removeUnprofitable() {
    // TODO: Cost Model

    if constexpr (log_step_by_step)
        Logger::logDebug("[SLP] on '", curr_func->getName(), " AFTER RemoveUnpro:\n", *this);
}

void VectorizerPass::extendAlign() {
    for (auto &pack : pack_set) {
        int expected = ElementSize * pack.size();
        pVal ptr;
        if (auto load = pack.front()->as<LOADInst>())
            ptr = load->getPtr();
        else if (auto store = pack.front()->as<STOREInst>())
            ptr = store->getPtr();
        else
            continue;

        auto align_on_base = loop_aa->getAlignOnBase(ptr);
        if (align_on_base >= expected) {
            bool align_set = trySetBaseAlign(ptr, expected, curr_func);
            pack.align = align_set ? expected : 4;
        } else
            pack.align = 4;
    }

    if constexpr (log_step_by_step)
        Logger::logDebug("[SLP] on '", curr_func->getName(), " AFTER ExtendAlign:\n", *this);
}

// Calculate the use-def chain for pack scheduling
void VectorizerPass::computePackUseDef() {
    for (auto &pack : pack_set) {
        for (const auto &inst : pack.stmts) {
            for (const auto &operand : inst->operands()) {
                if (auto operand_inst = operand->as<Instruction>()) {
                    for (auto &operand_pack : pack_set) {
                        if (operand_pack.contains(operand_inst)) {
                            auto &opers = operand_pack_map[&pack];
                            if (std::find(opers.begin(), opers.end(), &operand_pack) == opers.end())
                                opers.emplace_back(&operand_pack);
                            auto &users = user_pack_map[&operand_pack];
                            if (std::find(users.begin(), users.end(), &pack) == users.end())
                                users.emplace_back(&pack);
                        }
                    }
                }
            }
        }
    }
}

// Split dependency cycle
void VectorizerPass::splitDependencyCycle() {
    for (auto it = pack_set.begin(); it != pack_set.end();) {
        auto pack = &*it;
        auto worklist = operand_pack_map[pack];
        bool cycle_detected = false;
        while (!worklist.empty()) {
            auto curr = worklist.back();
            worklist.pop_back();

            // Cycle Detected
            if (curr == pack) {
                // Cleanup use-def
                for (const auto &oper : operand_pack_map[pack]) {
                    auto &users = user_pack_map[oper];
                    auto user_it = std::find(users.begin(), users.end(), pack);
                    Err::gassert(user_it != users.end());
                    users.erase(user_it);
                }
                for (const auto &user : user_pack_map[pack]) {
                    auto &operands = operand_pack_map[user];
                    auto oper_it = std::find(operands.begin(), operands.end(), pack);
                    Err::gassert(oper_it != operands.end());
                    operands.erase(oper_it);
                }

                it = pack_set.erase(it);
                cycle_detected = true;
                break;
            }

            for (auto &operand_pack : operand_pack_map[curr])
                worklist.emplace_back(operand_pack);
        }
        if (!cycle_detected)
            ++it;
    }
}

// Emit insert, extract and shuffle.
pVal VectorizerPass::gatherVector(Pack *user_pack, const std::function<pVal(const pInst &)> &proj) {
    auto &cpool = curr_block->getParent()->getConstantPool();
    // Expected Output Vector
    std::vector<pVal> expected;
    expected.reserve(user_pack->size());
    for (const auto &user_inst : user_pack->stmts)
        expected.emplace_back(proj(user_inst));

    // Quick Path for Constant Vector
    if (std::all_of(expected.begin(), expected.end(),
                    [](const pVal &v) { return v->getVTrait() == ValueTrait::CONSTANT_LITERAL; })) {
        if (expected[0]->is<ConstantFloat>()) {
            std::vector<float> cfv;
            cfv.reserve(expected.size());
            for (const auto &cf : expected)
                cfv.emplace_back(cf->as<ConstantFloat>()->getVal());
            return cpool.getConst(cfv);
        }
        if (expected[0]->is<ConstantInt>()) {
            std::vector<int> civ;
            civ.reserve(expected.size());
            for (const auto &ci : expected)
                civ.emplace_back(ci->as<ConstantInt>()->getVal());
            return cpool.getConst(civ);
        }
    }

    // Candidate Operand Packs to Shuffle
    std::vector<Pack *> candidate_packs;
    for (const auto &p : operand_pack_map[user_pack]) {
        for (const auto &e : expected) {
            if (p->contains(e->as<Instruction>())) {
                candidate_packs.emplace_back(p);
                break;
            }
        }
    }

    // Do Shuffle, Extract or Insert
    int base_mask = 0;
    std::vector<int> mask;
    std::vector<pVal> vectors_to_shuffle;
    auto emit_shuffle = [&] {
        if (candidate_packs.empty())
            return false;

        pType common_type = scheduled_packs[candidate_packs[0]]->getType();
        for (const auto &cand : candidate_packs) {
            if (!isSameType(scheduled_packs[cand]->getType(), common_type))
                return false;
        }
        size_t single_pack_size = candidate_packs[0]->size();
        if (single_pack_size * candidate_packs.size() != user_pack->size())
            return false;

        // At this point, we've ensured the candidate packs' size and type
        // are suitable to shuffle. Now calculate the mask.
        for (const auto &curr : expected) {
            auto found_suitable_vec = [&] {
                auto curr_inst = curr->as<Instruction>();
                if (!curr_inst)
                    return false;

                for (const auto &oper_pack : candidate_packs) {
                    for (size_t i = 0; i < oper_pack->size(); ++i) {
                        if (oper_pack->stmts[i] == curr_inst) {
                            auto vec = scheduled_packs[oper_pack];
                            Err::gassert(vec != nullptr);

                            if (mask.empty()) {
                                vectors_to_shuffle.emplace_back(vec);
                                base_mask = 0;
                                mask.emplace_back(i);
                            } else if (mask.size() == single_pack_size) {
                                vectors_to_shuffle.emplace_back(vec);
                                base_mask = static_cast<int>(single_pack_size);
                                mask.emplace_back(base_mask + i);
                            } else {
                                if (vectors_to_shuffle.back() != vec)
                                    return false;
                                mask.emplace_back(base_mask + i);
                            }

                            return true;
                        }
                    }
                }
                return false;
            }();

            // If the expected operand cannot be found in any candidate pack,
            // we cannot shuffle to get it.
            if (!found_suitable_vec)
                return false;
        }
        return true;
    }();

    auto insert_before = user_pack->pos_index_back()->getIter();
    // Shuffle
    if (emit_shuffle) {
        Err::gassert(vectors_to_shuffle.size() == 1 || vectors_to_shuffle.size() == 2);
        auto is_identity_shuffle = [&] {
            if (vectors_to_shuffle.size() != 1)
                return false;
            for (size_t i = 0; i < mask.size(); ++i) {
                if (i != mask[i])
                    return false;
            }
            return true;
        }();

        if (is_identity_shuffle)
            return vectors_to_shuffle[0];

        auto v1 = vectors_to_shuffle[0];
        pVal v2;
        if (vectors_to_shuffle.size() == 2)
            v2 = vectors_to_shuffle[1];
        else {
            auto v1_type = v1->getType()->as<VectorType>();
            Err::gassert(v1_type != nullptr);
            v2 = cpool.getConst(std::vector(v1_type->getVectorSize(), 0));
        }
        auto shuffle =
            std::make_shared<SHUFFLEInst>("%slp.sh" + std::to_string(name_cnt++), v1, v2, cpool.getConst(mask));
        curr_block->addInst(insert_before, shuffle);
        return shuffle;
    }

    // Extract and Insert
    pVal base_val;
    auto btype = expected[0]->getType()->as<BType>()->getInner();
    if (btype == IRBTYPE::I32) {
        std::vector base_vector(user_pack->size(), 0);
        base_val = cpool.getConst(base_vector);
    } else if (btype == IRBTYPE::FLOAT) {
        std::vector base_vector(user_pack->size(), 0.0f);
        base_val = cpool.getConst(base_vector);
    } else
        Err::not_implemented("Vectorizer for '" + expected[0]->getType()->toString() + "'.");

    for (size_t i = 0; i < expected.size(); ++i) {
        auto to_insert = expected[i];
        if (auto inst = to_insert->as<Instruction>()) {
            [&] {
                for (const auto &cand : candidate_packs) {
                    if (!cand->contains(inst))
                        continue;
                    for (size_t j = 0; j < cand->size(); ++j) {
                        if (cand->stmts[j] == inst) {
                            auto sched_vec = scheduled_packs[cand];
                            auto extract = std::make_shared<EXTRACTInst>(
                                "%slp.ex" + std::to_string(name_cnt++), sched_vec, cpool.getConst(static_cast<int>(j)));
                            curr_block->addInst(insert_before, extract);
                            to_insert = extract;
                            // Err::gassert(sched_vec->getIndex() < extract->getIndex());
                            return;
                        }
                    }
                }
            }();
        }

        auto insert = std::make_shared<INSERTInst>("%slp.in" + std::to_string(name_cnt++), base_val, to_insert,
                                                   cpool.getConst(static_cast<int>(i)));
        curr_block->addInst(insert_before, insert);
        base_val = insert;
    }

    return base_val;
}

// Compute Topological Order (Reverse Post Order) of PackSet
// FIXME: Refactor with Generic Visitor
std::vector<VectorizerPass::Pack *> VectorizerPass::computeTopologicalOrder() {
    std::vector<Pack *> worklist;
    std::deque<std::pair<Pack *, bool>> s;
    std::set<Pack *> visited;
    for (auto &pack : pack_set) {
        if (operand_pack_map[&pack].empty()) {
            s.emplace_back(&pack, false);
            visited.emplace(&pack);
        }
    }

    while (!s.empty()) {
        auto [curr, processed] = s.back();
        s.pop_back();

        if (processed)
            worklist.push_back(curr);
        else {
            s.emplace_back(curr, true);
            const auto &children = user_pack_map[curr];
            for (const auto &child : children) {
                if (visited.insert(child).second)
                    s.emplace_back(child, false);
            }
        }
    }
    std::reverse(worklist.begin(), worklist.end());

    if (log_step_by_step) {
        std::string order;
        for (const auto &w : worklist)
            order += std::to_string(w->id) + ", ";
        Logger::logDebug("[SLP]: Topological Order: ", order);
    }

    return worklist;
}

// Schedule packs and emit SIMD instructions
bool VectorizerPass::schedule() {
    bool modified = false;
    computePackUseDef();
    splitDependencyCycle();

    auto rpo = computeTopologicalOrder();
    for (const auto &curr : rpo) {
        auto insert_before = curr->pos_index_back()->getIter();
        if (auto load = curr->front()->as<LOADInst>()) {
            auto bitcast = std::make_shared<BITCASTInst>("%slp.bc" + std::to_string(name_cnt++), load->getPtr(),
                                                         makePtrType(makeVectorType(load->getType(), curr->size())));
            auto vec_load = std::make_shared<LOADInst>("%slp.ld" + std::to_string(name_cnt++), bitcast, curr->align);
            curr_block->addInst(insert_before, bitcast);
            curr_block->addInst(insert_before, vec_load);
            scheduled_packs[curr] = vec_load;
            modified = true;
        } else if (auto store = curr->front()->as<STOREInst>()) {
            auto bitcast =
                std::make_shared<BITCASTInst>("%slp.bc" + std::to_string(name_cnt++), store->getPtr(),
                                              makePtrType(makeVectorType(store->getValue()->getType(), curr->size())));
            auto val = gatherVector(curr, [](const pInst &store) { return store->as<STOREInst>()->getValue(); });
            auto vec_store = std::make_shared<STOREInst>(val, bitcast, curr->align);
            curr_block->addInst(insert_before, bitcast);
            curr_block->addInst(insert_before, vec_store);
            scheduled_packs[curr] = nullptr;
            modified = true;
        } else if (auto binary = curr->front()->as<BinaryInst>()) {
            auto lhs = gatherVector(curr, [](const pInst &binary) { return binary->as<BinaryInst>()->getLHS(); });
            auto rhs = gatherVector(curr, [](const pInst &binary) { return binary->as<BinaryInst>()->getRHS(); });
            auto vec_binary =
                std::make_shared<BinaryInst>("%slp.bin" + std::to_string(name_cnt++), binary->getOpcode(), lhs, rhs);
            curr_block->addInst(insert_before, vec_binary);
            scheduled_packs[curr] = vec_binary;
            modified = true;
        } else
            Err::unreachable("Unknown instruction to vectorize.");
    }

    // Fix scalar uses
    for (const auto &pack : pack_set) {
        for (size_t i = 0; i < pack.size(); ++i) {
            const auto &inst = pack.stmts[i];
            pExtract extract = nullptr;
            auto use_list = inst->getUseList();
            for (const auto &use : use_list) {
                auto user = use->getUser()->as<Instruction>();
                auto is_scalar_use = [&] {
                    // Not in this block, this can only be a scalar use.
                    if (user->getParent() != curr_block)
                        return true;
                    // If this use is within a pack, it will be eliminated later.
                    for (const auto &p : pack_set) {
                        if (p.contains(user))
                            return false;
                    }
                    // Scalar use within the block
                    return true;
                }();
                if (is_scalar_use) {
                    if (extract == nullptr) {
                        const auto &vec = scheduled_packs[&pack];
                        extract = std::make_shared<EXTRACTInst>("%slp.ex" + std::to_string(name_cnt++), vec,
                                                                curr_block->getParent()->getConst(static_cast<int>(i)));
                        curr_block->addInst(std::next(vec->getIter()), extract);
                    }
                    use->setValue(extract);

                    // Move the use after the def, we've ensured the safety in removeUnschedulable.
                    if (user->getParent() == curr_block && user->getIndex() < extract->getIndex()) {
                        std::vector<pInst> worklist;
                        auto [has_phi, opers] = collectOperandTreeInBlock(extract);
                        std::sort(opers.begin(), opers.end(),
                                  [](const pInst &a, const pInst &b) { return a->getIndex() > b->getIndex(); });
                        Err::gassert(!has_phi);
                        auto move_before = user->getIter();
                        auto move_before_index = user->getIndex();
                        for (const auto &moving_oper : opers) {
                            // Only move forward
                            if (moving_oper->getIndex() < move_before_index)
                                continue;

                            Err::gassert(!moving_oper->is<PHIInst>());
                            curr_block->delFirstOfInst(moving_oper);
                            curr_block->addInst(move_before, moving_oper);

                            Logger::logDebug("[SLP]: In BasicBlock '", curr_block->getName(), "': Moving '",
                                             moving_oper->getName(), "' before '", (*move_before)->getName(), "'.");

                            move_before = moving_oper->getIter();
                            move_before_index = moving_oper->getIndex();
                        }
                    }
                }
            }
        }
    }

    if constexpr (log_step_by_step)
        Logger::logDebug("[SLP] on '", curr_func->getName(), " Done:\n", *this);

    return modified;
}

void VectorizerPass::cleanup() {
    std::unordered_set<pInst> dead_insts;
    for (const auto &pack : pack_set)
        dead_insts.insert(pack.stmts.begin(), pack.stmts.end());
    curr_block->delInstIf([&](const pInst &inst) { return dead_insts.count(inst); });
    curr_block = nullptr;
    pack_set.clear();
    operand_pack_map.clear();
    user_pack_map.clear();
}

void VectorizerPass::reset() {
    name_cnt = 0;
    pack_id = 0;
    curr_func = nullptr;
    curr_block = nullptr;
    fam = nullptr;
    basic_aa = nullptr;
    loop_aa = nullptr;
    pack_set.clear();
    operand_pack_map.clear();
    user_pack_map.clear();
}

PM::PreservedAnalyses VectorizerPass::run(Function &function, FAM &manager) {
    auto& target = manager.getResult<TargetAnalysis>(function);
    if (!target->isVectorSupported())
        return PreserveAll();

    bool vectorizer_inst_modified = false;

    curr_func = &function;
    basic_aa = &manager.getResult<BasicAliasAnalysis>(function);
    loop_aa = &manager.getResult<LoopAliasAnalysis>(function);
    fam = &manager;

    for (const auto &block : function) {
        curr_block = block;
        findAdjacentReferences();
        extendPackList();
        combinePacks();
        rearrangePack();
        removeUnprofitable();
        removeUnschedulable();
        extendAlign();
        vectorizer_inst_modified |= schedule();
        cleanup();
    }

    reset();

    return vectorizer_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR
