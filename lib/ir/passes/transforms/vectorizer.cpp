// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/vectorizer.hpp"

#include "ir/block_utils.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/analysis/target_analysis.hpp"

namespace IR {
int getAlign(const pVal &inst) {
    if (!inst)
        return -1;
    if (auto load = inst->as<LOADInst>())
        return load->getAlign();
    if (auto store = inst->as<STOREInst>())
        return store->getAlign();
    return -1;
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

void VectorizerPass::collectSeeds() {
    seed_stores.clear();
    store_map.clear();

    for (const auto &inst : *curr_block) {
        if (auto store = inst->as<STOREInst>()) {
            if (store->getType()->is<VectorType>())
                continue;
            seed_stores.emplace_back(store);
            store_map[store].emplace_back(store);
        }
    }
}

std::tuple<std::unordered_set<pStore>, std::unordered_set<pStore>, std::map<pStore, pStore>>
VectorizerPass::findConsecutiveStoreChain() {
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

    auto [heads, tails, store_chains] = findConsecutiveStoreChain();
    std::unordered_set<pStore> vectorized;
    for (const auto &store : heads) {
        Err::gassert(!tails.count(store), "Bad store chain");
        auto chain_elem = store;
        std::vector<pStore> chain;
        while ((tails.count(chain_elem) || heads.count(chain_elem)) && !vectorized.count(chain_elem)) {
            chain.emplace_back(chain_elem);
            chain_elem = store_chains[chain_elem];

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
    }
    return changed;
}

bool VectorizerPass::vectorizeStoreChain(const std::vector<pStore> &chain, size_t scalars_size) {
    bool changed = false;
    auto elem_size = chain[0]->getValue()->getType()->getBytes() * 8;
    auto vf = scalars_size / elem_size;

    // Find the most profitable offset
    for (size_t offset = 0; offset < chain.size() - vf;) {
        std::vector<pVal> scalars;
        for (size_t i = offset; i < offset + vf; i++)
            scalars.emplace_back(chain[i]);
        deleteTree();
        buildTree(scalars);
        collectExternalUsers();
        if (getTreeCost() < -Config::IR::SLP_COST_THRESHOLD) {
            vectorizeTree();
            offset += vf;
            changed = true;
        } else
            ++offset;
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

void VectorizerPass::buildTreeImpl(const std::vector<pVal> &scalars, int depth, int user_tree_idx) {
    auto gather = [&] { newTree(scalars, false, user_tree_idx); };
    auto &sched = schedulers[curr_block];
    auto cancel_sched_and_gather = [&] {
        sched.cancelScheduling(scalars, scalars[0]);
        newTree(scalars, false, user_tree_idx);
    };

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

    if (!sched.tryScheduleBundle(scalars, scalars[0], this)) {
        Logger::logDebug("[SLP]: buildTree failed due to unschedulable bundle.");
        gather();
        return;
    }

    switch (*opcode) {
    case OP::PHI: {
        auto phi0 = scalars[0]->as<PHIInst>();
        newTree(scalars, true, user_tree_idx);

        for (size_t i = 0; i < phi0->getNumIncomings(); ++i) {
            std::vector<pVal> operands;

            for (const auto &s : scalars) {
                operands.emplace_back(s->as<PHIInst>()->getValueForBlock(phi0->getIncomingBlock(i)));
            }

            buildTreeImpl(operands, depth + 1, user_tree_idx);
        }

        return;
    }
    case OP::EXTRACT: {
        // TODO: Reuse Extract
        Logger::logDebug("[SLP]: TODO: Reuse Extract");

        cancel_sched_and_gather();
        return;
        return;
    }
    case OP::LOAD: {
        for (size_t i = 0; i < scalars.size() - 1; ++i) {
            if (!loop_aa->isConsecutiveAccess(scalars[i], scalars[i + 1])) {
                cancel_sched_and_gather();
                return;
            }
        }
        return;
    }
    case OP::STORE: {
        for (size_t i = 0; i < scalars.size() - 1; ++i) {
            if (!loop_aa->isConsecutiveAccess(scalars[i], scalars[i + 1])) {
                cancel_sched_and_gather();
                return;
            }
        }

        newTree(scalars, true, user_tree_idx);

        std::vector<pVal> operands;
        for (const auto &scalar : scalars)
            operands.emplace_back(scalar->as<STOREInst>()->getPtr());
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
                if (getTree(user) != nullptr) {
                    if (!inTreeUserNeedToExtract(scalar, user))
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
    auto scalar_type = tree.scalars[0]->getType();
    if (auto store = tree.scalars[0]->as<STOREInst>())
        scalar_type = store->getValue()->getType();
    else if (auto icmp = tree.scalars[0]->as<ICMPInst>())
        scalar_type = icmp->getLHS()->getType();
    else if (auto fcmp = tree.scalars[0]->as<FCMPInst>())
        scalar_type = fcmp->getLHS()->getType();

    auto vector_type = makeVectorType(scalar_type, tree.scalars.size());

    if (tree.need_to_gather) {
        if (isAllConstant(tree.scalars))
            return 0;
        if (isAllSame(tree.scalars))
            return target->getShuffleCost(vector_type, ShuffleKind::Broadcast);
        return getGatherCost(vector_type);
    }

    auto opcode = *analyzeOpcode(tree.scalars);
    switch (opcode) {
    case OP::PHI:
        return 0;
    case OP::EXTRACT:
        // TODO: Reuse
        return getGatherCost(vector_type);
    case OP::ZEXT:
    case OP::SEXT:
    case OP::FPTOSI:
    case OP::SITOFP:
    case OP::BITCAST: {
        auto src_ty = tree.scalars[0]->as<CastInst>()->getOType();
        auto dst_ty = tree.scalars[0]->as<CastInst>()->getTType();
        int scalar_cost = tree.scalars.size() * target->getCastCost(opcode, src_ty, dst_ty);

        auto src_vec_ty = makeVectorType(src_ty, tree.scalars.size());
        int vector_cost = target->getCastCost(opcode, src_vec_ty, vector_type);

        return vector_cost - scalar_cost;
    }
    case OP::ICMP:
    case OP::FCMP: {
        auto val_ty = tree.scalars[0]->getType();
        int scalar_cost = tree.scalars.size() * target->getCmpCost(opcode, val_ty);
        int vector_cost = target->getCmpCost(opcode, vector_type);
        return vector_cost - scalar_cost;
    }
    case OP::SELECT: {
        auto val_ty = tree.scalars[0]->getType();
        int scalar_cost = tree.scalars.size() * target->getSelectCost(val_ty);
        int vector_cost = target->getSelectCost(vector_type);
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

        int scalar_cost = tree.scalars.size() * target->getBinaryCost(opcode, scalar_type, lhs_trait, rhs_trait);
        int vector_cost = target->getBinaryCost(opcode, vector_type, lhs_trait, rhs_trait);
        return vector_cost - scalar_cost;
    }
    case OP::GEP: {
        // We've ensured it is a single constant index gep
        auto ptr_trait = OperandTrait::none();
        OperandTrait index_trait {
            .kind = OperandKind::UniformConstant,
            .prop = OperandProp::None,
        };
        int scalar_cost = tree.scalars.size() * target->getBinaryCost(OP::ADD, scalar_type, ptr_trait, index_trait);
        int vector_cost = target->getBinaryCost(OP::ADD, vector_type, ptr_trait, index_trait);
        return vector_cost - scalar_cost;
    }
    case OP::LOAD:
    case OP::STORE: {
        auto align = getAlign(tree.scalars[0]);
        int scalar_cost = tree.scalars.size() * target->getMemCost(opcode, scalar_type, align);
        int vector_cost = target->getMemCost(opcode, vector_type, align);
        return vector_cost - scalar_cost;
    }
    case OP::CALL: {
        // TODO:
        // Vector intrinsic or whole-func vectorize
        return getGatherCost(vector_type);
    }
    case OP::SHUFFLE: {
        // TODO:
        // Alternate Shuffle
        return getGatherCost(vector_type);
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

    int cost = 0;
    for (const auto &tree : vec_trees)
        cost += getBaseCost(tree);

    std::unordered_set<pVal> extracted;
    for (const auto &euser : external_users) {
        if (!extracted.insert(euser.scalar).second)
            continue;

        auto vec_ty = makeVectorType(euser.scalar->getType(), vf);
        cost += target->getVecInstCost(OP::EXTRACT, vec_ty, euser.lane);
    }

    // TODO: Spill/Refill Cost
    return cost;
}

void VectorizerPass::vectorizeTree() {}

PM::PreservedAnalyses VectorizerPass::run(Function &function, FAM &fam) {
    target = fam.getResult<TargetAnalysis>(function);
    if (!target->isVectorSupported())
        return PreserveAll();

    bool vectorizer_inst_modified = false;

    basic_aa = &fam.getResult<BasicAliasAnalysis>(function);
    loop_aa = &fam.getResult<LoopAliasAnalysis>(function);

    auto podfv = function.getDFVisitor<Util::DFVOrder::PostOrder>();
    for (auto &bb : podfv) {
        curr_block = bb;
        collectSeeds();

        if (!seed_stores.empty())
            vectorizer_inst_modified |= vectorizeStoreChains();
    }

    return vectorizer_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR
