#include "ir/passes/transforms/vectorizer.hpp"

#include "ir/block_utils.hpp"
#include "ir/formatter.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/pattern_match.hpp"

#include <algorithm>

namespace IR {
std::ostream &operator<<(std::ostream &os, const VectorizerPass::Pack &expr) {
    for (auto it = expr.stmts.begin(); it != expr.stmts.end(); ++it) {
        const auto &stmt = *it;
        os << IRFormatter::formatOp(stmt->getOpcode()) << " " << stmt->getName() << " addr-" << stmt.get();
        if (it != expr.stmts.end() - 1)
            os << ", ";
    }
    return os;
}
std::ostream &operator<<(std::ostream &os, const VectorizerPass &vec) {
    os << "For BasicBlock '" << vec.curr_block->getName() << "':\n";
    size_t i = 0;
    for (const auto &pack : vec.pack_set)
        os << "Pack " << i++ << ": " << pack << "\n";
    return os;
}

// Check if instructions are isomorphic.
bool isIsomorphic(const pInst &stmt1, const pInst &stmt2) { return stmt1->getOpcode() == stmt2->getOpcode(); }

// Check if there is use-def dependency between two instructions.
bool isIndependent(const pInst &stmt1, const pInst &stmt2) {
    auto AhasUseToB = [](const pInst &a, const pInst &b) {
        std::vector<pVal> worklist;
        for (const auto &oper : a->operands())
            worklist.emplace_back(oper);

        std::unordered_set<pVal> visited;
        while (!worklist.empty()) {
            auto curr = worklist.back();
            worklist.pop_back();
            visited.emplace(curr);

            if (curr == b)
                return true;

            if (auto curr_user = curr->as<User>()) {
                for (const auto &oper : curr_user->operands()) {
                    if (!visited.count(oper))
                        worklist.emplace_back(oper);
                }
            }
        }
        return false;
    };

    return !AhasUseToB(stmt2, stmt1) && !AhasUseToB(stmt1, stmt2);
}

// Instructions act as seeds.
bool hasMemoryRef(const pInst &inst) { return inst->getOpcode() == OP::STORE || inst->getOpcode() == OP::LOAD; }

// Currently we only conside load/store and binary instructions
bool isVectorizable(const pInst &inst) {
    return inst->getOpcode() == OP::LOAD || inst->getOpcode() == OP::STORE || inst->is<BinaryInst>();
}



// Check if two pointers are adjacent, e.g. a[i], a[i + 1]
// FIXME: Improve precision. Currently only match a[0][i], a[0][i + 1] for debug
bool isPtrAdjacent(const pVal &ptr1, const pVal &ptr2) {
    auto gep1 = ptr1->as<GEPInst>();
    auto gep2 = ptr2->as<GEPInst>();
    if (!gep1 || !gep2 || gep1->getPtr() != gep2->getPtr())
        return false;
    auto idx1 = gep1->getIdxs();
    auto idx2 = gep2->getIdxs();
    if (idx1.size() != idx2.size())
        return false;
    for (size_t i = 0; i < idx1.size() - 1; ++i)
        if (idx1[i] != idx2[i])
            return false;

    const auto &offset1 = idx1.back();
    const auto &offset2 = idx2.back();

    // c, c + 1
    int ci32;
    if (match(offset1, M::Bind(ci32)) && match(offset2, M::Is(ci32 + 1)))
        return true;

    // x, x + 1
    if (match(offset2, M::Add(M::Is(offset1), M::Is(1))) || match(offset2, M::Add(M::Is(1), M::Is(offset1))))
        return true;

    // x - 1, x
    if (match(offset1, M::Sub(M::Is(offset2), M::Is(1))))
        return true;

    // x + c, x + c + 1
    pVal base;
    if (match(offset1, M::Add(M::Bind(base), M::Bind(ci32))) || match(offset1, M::Add(M::Bind(ci32), M::Bind(base)))) {
        if (match(offset2, M::Add(M::Is(base), M::Is(ci32 + 1))) ||
            match(offset2, M::Add(M::Is(ci32 + 1), M::Is(base))))
            return true;
    }

    // x + (c - 1), x + c
    if (match(offset2, M::Add(M::Bind(base), M::Bind(ci32))) || match(offset2, M::Add(M::Bind(ci32), M::Bind(base)))) {
        if (match(offset1, M::Add(M::Is(base), M::Is(ci32 - 1))) ||
            match(offset1, M::Add(M::Is(ci32 - 1), M::Is(base))))
            return true;
    }
    return false;
}

// Check if the load/store is adjacent.
bool isInstAdjacent(const pInst &inst1, const pInst &inst2) {
    if (inst1->is<LOADInst>() && inst2->is<LOADInst>()) {
        if (!isSameType(inst1->getType(), inst2->getType()))
            return false;
        auto ptr1 = inst1->as<LOADInst>()->getPtr();
        auto ptr2 = inst2->as<LOADInst>()->getPtr();
        return isPtrAdjacent(ptr1, ptr2);
    }

    if (inst1->is<STOREInst>() && inst2->is<STOREInst>()) {
        auto store1 = inst1->as<STOREInst>();
        auto store2 = inst2->as<STOREInst>();
        if (!isSameType(store1->getValue()->getType(), store2->getValue()->getType()))
            return false;
        return isPtrAdjacent(store1->getPtr(), store2->getPtr());
    }

    return false;
}

// Get the align of the instruction, -1 will be returned if the instruction does not have align.
auto getAlign(const pInst &inst) {
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

VectorizerPass::Pack::Pack(const pInst &stmt1, const pInst &stmt2) : stmts({stmt1, stmt2}), stmt_set({stmt1, stmt2}) {
    update_front();
}
VectorizerPass::Pack::Pack(const Pack &a, const Pack &b) : stmts(a.stmts), stmt_set(a.stmt_set) {
    stmts.insert(stmts.end(), b.stmts.begin(), b.stmts.end());
    stmt_set.insert(b.stmt_set.begin(), b.stmt_set.end());
    update_front();
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

VectorizerPass::Pack VectorizerPass::Pack::truncate(size_t size) {
    Err::gassert(size < stmts.size(), "Invalid size");
    std::vector<pInst> ret_stmts;
    std::unordered_set<pInst> ret_stmt_set;
    for (size_t i = size; i < stmts.size(); ++i) {
        ret_stmts.emplace_back(stmts[i]);
        ret_stmt_set.emplace(stmts[i]);
        stmt_set.erase(stmts[i]);
    }
    stmts.erase(stmts.begin() + size, stmts.end());
    update_front();

    Pack ret;
    ret.stmts = ret_stmts;
    ret.stmt_set = ret_stmt_set;
    ret.update_front();
    return ret;
}

const pInst &VectorizerPass::Pack::front() const { return front_inst; }
void VectorizerPass::Pack::update_front() {
    front_inst = *std::min_element(stmts.begin(), stmts.end(),
                                   [](const pInst &a, const pInst &b) { return a->getIndex() < b->getIndex(); });
}

// Check if two instructions can be packed together.
bool VectorizerPass::stmtCanPack(const pInst &stmt1, const pInst &stmt2, int align) {
    // Skip Non-vectorizable
    if (!isVectorizable(stmt1) || !isVectorizable(stmt2))
        return false;

    // Only isomorphic instructions can be packed
    if (!isIsomorphic(stmt1, stmt2))
        return false;

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

    // Alignment consistency
    auto align1 = getAlign(stmt1);
    auto align2 = getAlign(stmt2);
    if (align1 == -1 || align1 == 4 || align1 == align) {
        if (align2 == -1 || align2 == 4 || align2 == align + ElementSize)
            return true;
    }

    return false;
}

// Estimate the savings of packing two instructions.
// TODO: Cost Model
int VectorizerPass::estimateSavings(const pInst &stmt1, const pInst &stmt2) { return 0; }

// Investigate the operands of the pack
bool VectorizerPass::followUseDefs(const Pack &pack) {
    Err::gassert(pack.isPair());
    auto stmt1 = pack.getLeft();
    auto stmt2 = pack.getRight();
    auto align = getAlign(stmt1);

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
        if (stmtCanPack(x1, x2, align)) {
            if (estimateSavings(x1, x2) >= 0) {
                pack_set.emplace_back(x1, x2);
                setAlign(x1, align);
                setAlign(x2, align);
                modified = true;
            }
        }
    }
    return modified;
}

// Investigate the users of the pack
bool VectorizerPass::followDefUses(const Pack &pack) {
    Err::gassert(pack.isPair());
    auto stmt1 = pack.getLeft();
    auto stmt2 = pack.getRight();
    auto align = getAlign(stmt1);
    int savings = -1;

    pInst x1, x2;
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
            if (stmtCanPack(user1, user2, align)) {
                auto est = estimateSavings(user1, user2);
                if (est > savings) {
                    savings = est;
                    x1 = user1;
                    x2 = user2;
                }
            }
        }
    }

    if (x1 && x2 && savings >= 0) {
        pack_set.emplace_back(x1, x2);
        setAlign(x1, align);
        setAlign(x2, align);
        return true;
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

            if (isInstAdjacent(inst, candidate)) {
                auto align = getAlign(inst);
                if (stmtCanPack(inst, candidate, align))
                    pack_set.emplace_back(inst, candidate);
            }
        }
    }
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
                    Pack to_insert(*it1, *it2);
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
}

// Split packs to 2/4-sized packs
void VectorizerPass::rearrangePack() {
    std::vector<Pack> new_packs;
    for (auto it = pack_set.begin(); it != pack_set.end(); ++it) {
        if (it->size() == 2 || it->size() == 4)
            continue;

        if (it->size() == 3 || it->size() == 5) {
            it->truncate(it->size() - 1);
            return;
        }

        Err::gassert(it->size() >= 6);
        auto tail = it->truncate(4);
        while (tail.size() > 4) {
            new_packs.emplace_back(tail);
            tail = new_packs.back().truncate(4);
        }
        if (tail.size() == 3)
            tail.truncate(2);
        if (tail.size() == 2 || tail.size() == 4)
            new_packs.emplace_back(tail);
    }
    for (auto &pack : new_packs)
        pack_set.emplace_back(pack);
}

void VectorizerPass::fixArrayAlign() {
    // TODO: fix array alignment
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

// Emit insert and shuffle.
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

    auto insert_before = user_pack->front()->getIter();
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
        auto v2 = vectors_to_shuffle.size() == 2 ? vectors_to_shuffle[1] : v1;
        auto shuffle =
            std::make_shared<SHUFFLEInst>(user_pack->front()->getName() + ".slp.sh", v1, v2, cpool.getConst(mask));
        curr_block->addInst(insert_before, shuffle);
        return shuffle;
    }

    // Extract and Insert
    std::vector base_vector(user_pack->size(), 0);
    pVal base_val = cpool.getConst(base_vector);
    for (size_t i = 0; i < expected.size(); ++i) {
        auto to_insert = expected[i];
        if (auto inst = to_insert->as<Instruction>()) {
            [&] {
                for (const auto &cand : candidate_packs) {
                    if (!cand->contains(inst))
                        continue;
                    for (size_t j = 0; j < cand->size(); ++j) {
                        if (cand->stmts[j] == inst) {
                            auto extract =
                                std::make_shared<EXTRACTInst>(expected[i]->getName() + ".slp.ex", scheduled_packs[cand],
                                                              cpool.getConst(static_cast<int>(j)));
                            curr_block->addInst(insert_before, extract);
                            to_insert = extract;
                            return;
                        }
                    }
                }
            }();
        }

        auto insert = std::make_shared<INSERTInst>(expected[i]->getName() + ".slp.in", base_val, to_insert,
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
    return worklist;
}

// Schedule packs and emit SIMD instructions
bool VectorizerPass::schedule() {
    bool modified = false;
    computePackUseDef();
    splitDependencyCycle();

    auto rpo = computeTopologicalOrder();
    for (const auto &curr : rpo) {
        if (auto load = curr->front()->as<LOADInst>()) {
            auto bitcast = std::make_shared<BITCASTInst>(load->getName() + ".slp.bit", load->getPtr(),
                                                         makePtrType(makeVectorType(load->getType(), curr->size())));
            auto vec_load =
                std::make_shared<LOADInst>(load->getName() + ".slp.ldr", bitcast, ElementSize * curr->size());
            curr_block->addInst(load->getIter(), bitcast);
            curr_block->addInst(load->getIter(), vec_load);
            scheduled_packs[curr] = vec_load;
            modified = true;
        } else if (auto store = curr->front()->as<STOREInst>()) {
            auto bitcast =
                std::make_shared<BITCASTInst>(store->getValue()->getName() + ".slp.bit", store->getPtr(),
                                              makePtrType(makeVectorType(store->getValue()->getType(), curr->size())));
            auto val = gatherVector(curr, [](const pInst &store) { return store->as<STOREInst>()->getValue(); });
            auto vec_store = std::make_shared<STOREInst>(val, bitcast, ElementSize * curr->size());
            curr_block->addInst(store->getIter(), bitcast);
            curr_block->addInst(store->getIter(), vec_store);
            scheduled_packs[curr] = nullptr;
            modified = true;
        } else if (auto binary = curr->front()->as<BinaryInst>()) {
            auto lhs = gatherVector(curr, [](const pInst &binary) { return binary->as<BinaryInst>()->getLHS(); });
            auto rhs = gatherVector(curr, [](const pInst &binary) { return binary->as<BinaryInst>()->getRHS(); });
            auto vec_binary =
                std::make_shared<BinaryInst>(binary->getName() + ".slp.bin", binary->getOpcode(), lhs, rhs);
            curr_block->addInst(binary->getIter(), vec_binary);
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
                        extract = std::make_shared<EXTRACTInst>(inst->getName() + ".slp.ex", vec,
                                                                curr_block->getParent()->getConst(static_cast<int>(i)));
                        curr_block->addInst(std::next(vec->getIter()), extract);
                    }
                    use->setValue(extract);
                }
            }
        }
    }
    return modified;
}

void VectorizerPass::cleanup() {
    std::unordered_set<pInst> dead_insts;
    for (const auto &pack : pack_set)
        dead_insts.insert(pack.stmts.begin(), pack.stmts.end());
    curr_block->delInstIf([&](const pInst &inst) { return dead_insts.count(inst); });
    reset();
}

void VectorizerPass::reset() {
    curr_block = nullptr;
    pack_set.clear();
    operand_pack_map.clear();
    user_pack_map.clear();
}

PM::PreservedAnalyses VectorizerPass::run(Function &function, FAM &fam) {
    bool vectorizer_inst_modified = false;

    for (const auto &block : function) {
        curr_block = block;
        findAdjacentReferences();
        Logger::logDebug("[Vectorizer] on '", function.getName(), " AFTER FindAdj:\n", *this);
        extendPackList();
        Logger::logDebug("[Vectorizer] on '", function.getName(), " AFTER Extend:\n", *this);
        combinePacks();
        Logger::logDebug("[Vectorizer] on '", function.getName(), " AFTER Combine:\n", *this);
        rearrangePack();
        fixArrayAlign();
        Logger::logDebug("[Vectorizer] on '", function.getName(), " AFTER Rearrange:\n", *this);
        vectorizer_inst_modified |= schedule();
        Logger::logDebug("[Vectorizer] on '", function.getName(), " Done:\n", *this);
        cleanup();
    }

    reset();

    return vectorizer_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR
