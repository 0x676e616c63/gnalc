// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/vectorizer.hpp"

#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/irbuilder.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/analysis/target_analysis.hpp"

namespace IR {
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
bool VectorizerPass::AlignRewriter::trySetBaseAlign(pVal ptr, int align, Function *curr_func, Changes& changes) {
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
                if (!trySetBaseAlign(call->getArgs()[fp->getIndex()], align, caller_func, changes))
                    return false;
            }
            return true;
        } else if (auto phi = ptr->as<PHIInst>()) {
            for (const auto &[phi_ptr, bb] : phi->incomings()) {
                if (!trySetBaseAlign(phi_ptr, align, curr_func, changes))
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

bool VectorizerPass::AlignRewriter::trySetInstAlign(const pInst &inst, int align) {
    pVal ptr;
    if (auto load = inst->as_raw<LOADInst>())
        ptr = load->getPtr();
    else if (auto store = inst->as_raw<STOREInst>())
        ptr = store->getPtr();
    else Err::unreachable();

    int align_on_base = loop_aa->getAlignOnBase(ptr);
    if (align_on_base < align)
        return false;

    Changes curr_changes;
    auto func=  inst->getParent()->getParent().get();
    if (trySetBaseAlign(ptr, align, func, curr_changes)) {
        rewritten[inst] = curr_changes;
        setAlign(inst, align);
        return true;
    }

    for (auto &[ptr, align] : curr_changes)
        setAlign(ptr, align);
    return false;
}

void VectorizerPass::AlignRewriter::restoreInstAlign(const pInst& inst) {
    for (auto &[ptr, align] : rewritten[inst])
        setAlign(ptr, align);
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
            if (store->getType()->is<VectorType>())
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
    for (size_t offset = 0; offset < chain.size() - vf;) {
        std::vector<pVal> scalars;
        for (size_t i = offset; i < offset + vf; i++)
            scalars.emplace_back(chain[i]);
        deleteTree();
        buildTree(scalars);
        collectExternalUsers();
        if (getTreeCost() < -Config::IR::SLP_COST_THRESHOLD) {
            vectorizeTrees();
            rewritten_aligns.clear();
            offset += vf;
            changed = true;
        } else {
            ++offset;
            for (const auto& re : rewritten_aligns)
                align_rewriter.restoreInstAlign(re);
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
    auto &sched = schedulers[scalars[0]->as<Instruction>()->getParent()];
    if (!sched.tryScheduleBundle(scalars, scalars[0], this)) {
        Logger::logDebug("[SLP]: buildTree failed due to unschedulable bundle.");
        gather();
        return;
    }

    auto cancel_sched_and_gather = [&] {
        sched.cancelScheduling(scalars, scalars[0]);
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
        // TODO: Reuse
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
        int align = tree.scalars.size() * scalar_ty->getBytes();
        auto inst = tree.scalars[0]->as<Instruction>();
        if (align_rewriter.trySetInstAlign(inst->as<Instruction>(), align))
            rewritten_aligns.emplace_back(inst);
        else
            align = AlignRewriter::getAlign(tree.scalars[0]);

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

void VectorizerPass::scheduleBlock(Scheduler *sched) {}

void VectorizerPass::setInsertPointAfterBundle(const std::vector<pVal> &scalars) {
    BBInstIter last_it;
    size_t last_pos = 0;
    for (const auto &scalar : scalars) {
        auto it = scalar->as<Instruction>();
        Err::gassert(it != nullptr, "Can not set set insert point after a bundle of constants.");
        if (it->getIndex() >= last_pos) {
            last_it = it->getIter();
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
    // RAII Object to restore insert point when this function exits,
    // since there can be recursive calls to vectorizeTree.
    InsertPointGuard guard(builder);

    if (tree->vec) {
        Logger::logDebug("[SLP]: Diamond merged for '", tree->vec->getName(), "'.");
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
        builder.setInsertPoint(block, (*block->begin())->getIter());

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
        // TODO: Reuse
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
        Logger::logDebug("[SLP]: GEP vectorized");

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
    for (auto &sched : schedulers)
        scheduleBlock(&sched.second);

    auto vec_root = vectorizeTree(&vec_trees[0]);

    for (const auto &euser : external_users) {
        const auto &scalar = euser.scalar;
        const auto &user = euser.user;

        // If we've replaced it before, skip it.
        // This can happen when a value is used multiple times by one user.
        if (user && Util::contains(scalar->users(), user))
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
        }
    }

    for (const auto &tree : vec_trees) {
        if (tree.need_to_gather)
            continue;

        Err::gassert(tree.vec != nullptr);
        std::unordered_set<pInst> dead;
        for (const auto &scalar : tree.scalars)
            dead.emplace(scalar->as<Instruction>());
        (*dead.begin())
            ->getParent()
            ->delInstIf([&](const pInst &inst) { return dead.count(inst); }, BasicBlock::DEL_MODE::ALL);
    }

    return vec_trees[0].vec;
}

PM::PreservedAnalyses VectorizerPass::run(Function &function, FAM &fam) {
    target = fam.getResult<TargetAnalysis>(function);
    if (!target->isVectorSupported())
        return PreserveAll();

    bool vectorizer_inst_modified = false;

    basic_aa = &fam.getResult<BasicAliasAnalysis>(function);
    loop_aa = &fam.getResult<LoopAliasAnalysis>(function);
    align_rewriter.loop_aa = loop_aa;
    cpool = &function.getConstantPool();

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
