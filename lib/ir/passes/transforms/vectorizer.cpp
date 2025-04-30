#include "ir/passes/transforms/vectorizer.hpp"

#include "ir/formatter.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/pattern_match.hpp"

namespace IR {
std::ostream &operator<<(std::ostream &os, const VectorizerPass::Pack &expr) {
    for (auto it = expr.stmts.begin(); it != expr.stmts.end(); ++it) {
        const auto& stmt = *it;
        os << IRFormatter::formatOp(stmt->getOpcode()) << " " << stmt->getName() << " idx-" << stmt->getIndex();
        if (it != expr.stmts.end() - 1)
            os << ", ";
    }
    return os;
}
std::ostream &operator<<(std::ostream &os, const VectorizerPass &vec) {
    os << "For BasicBlock '" << vec.curr_block->getName() << "':\n";
    size_t i = 0;
    for (const auto& pack : vec.pack_set)
        os << "Pack " << i++ << ": " << pack << "\n";
    return os;
}

bool isIsomorphic(const pInst &stmt1, const pInst &stmt2) { return stmt1->getOpcode() == stmt2->getOpcode(); }

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

bool hasMemoryRef(const pInst &inst) { return inst->getOpcode() == OP::STORE || inst->getOpcode() == OP::LOAD; }

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

    const auto& offset1 = idx1.back();
    const auto& offset2 = idx2.back();

    // c, c + 1
    int ci32;
    if (match(offset1, M::Bind(ci32)) && match(offset2, M::Is(ci32 + 1)))
        return true;

    // x, x + 1
    if (match(offset2, M::Add(M::Is(offset1), M::Is(1))) ||
        match(offset2, M::Add(M::Is(1), M::Is(offset1))))
        return true;

    // x - 1, x
    if (match(offset1, M::Sub(M::Is(offset2), M::Is(1))))
        return true;

    // x + c, x + c + 1
    pVal base;
    if (match(offset1, M::Add(M::Bind(base), M::Bind(ci32))) ||
        match(offset1, M::Add(M::Bind(ci32), M::Bind(base)))) {
        if (match(offset2, M::Add(M::Is(base), M::Is(ci32 + 1))) ||
            match(offset2, M::Add(M::Is(ci32 + 1), M::Is(base))))
            return true;
    }

    // x + (c - 1), x + c
    if (match(offset2, M::Add(M::Bind(base), M::Bind(ci32))) ||
        match(offset2, M::Add(M::Bind(ci32), M::Bind(base)))) {
        if (match(offset1, M::Add(M::Is(base), M::Is(ci32 - 1))) ||
            match(offset1, M::Add(M::Is(ci32 - 1), M::Is(base))))
            return true;
    }
    return false;
}

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

auto getAlign(const pInst &inst) {
    if (auto load = inst->as<LOADInst>())
        return load->getAlign();
    if (auto store = inst->as<STOREInst>())
        return store->getAlign();
    return -1;
}

void setAlign(const pInst &inst, int align) {
    if (auto load = inst->as<LOADInst>())
        load->setAlign(align);
    else if (auto store = inst->as<STOREInst>())
        store->setAlign(align);
}

VectorizerPass::Pack::Pack(const pInst &stmt1, const pInst &stmt2) : stmts({stmt1, stmt2}) {}
VectorizerPass::Pack::Pack(const Pack &a, const Pack &b) : stmts(a.stmts) {
    stmts.insert(stmts.end(), b.stmts.begin(), b.stmts.end());
}

void VectorizerPass::Pack::addStmt(const pInst &stmt) {
    Err::gassert(stmts.empty() || isIsomorphic(stmts[0], stmt));
    stmts.emplace_back(stmt);
}

bool VectorizerPass::Pack::isPair() const { return stmts.size() == 2; }
pInst VectorizerPass::Pack::getLeft() const {
    Err::gassert(isPair());
    return stmts[0];
}
pInst VectorizerPass::Pack::getRight() const {
    Err::gassert(isPair());
    return stmts[1];
}

bool VectorizerPass::stmtCanPack(const pInst &stmt1, const pInst &stmt2, int align) {
    if (isIsomorphic(stmt1, stmt2)) {
        if (isIndependent(stmt1, stmt2)) {
            for (const auto &p : pack_set) {
                Err::gassert(p.isPair(), "This should be called before extendPackList");
                if (p.getLeft() == stmt1 || p.getRight() == stmt2)
                    return false;
            }

            auto align1 = getAlign(stmt1);
            auto align2 = getAlign(stmt2);
            if (align1 == -1 || align1 == 4 || align1 == align) {
                if (align2 == -1 || align2 == 4 || align2 == align + 4)
                    return true;
            }
        }
    }
    return false;
}

// TODO: Cost Model
int VectorizerPass::estimateSavings(const pInst &stmt1, const pInst &stmt2) { return 0; }

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
            if (user2->getParent() != curr_block)
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
    if (savings > 0) {
        pack_set.emplace_back(x1, x2);
        setAlign(x1, align);
        setAlign(x2, align);
        return true;
    }
    return false;
}

void VectorizerPass::findAdjacentReferences() {
    for (const auto& inst : *curr_block) {
        if (!hasMemoryRef(inst))
            continue;

        for (const auto& candidate : *curr_block) {
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

bool VectorizerPass::schedule() {
    // TODO: Schedule
    return false;
}

void VectorizerPass::reset() {
    curr_block = nullptr;
    pack_set.clear();
}

PM::PreservedAnalyses VectorizerPass::run(Function &function, FAM &fam) {
    bool vectorizer_inst_modified = false;

    for (const auto &block : function) {
        curr_block = block;
        pack_set.clear();
        findAdjacentReferences();
        extendPackList();
        combinePacks();
        vectorizer_inst_modified |= schedule();
        Logger::logDebug("[Vectorizer] on '", function.getName(), ":\n", *this);
    }

    reset();

    return vectorizer_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR
