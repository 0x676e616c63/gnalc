// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// SLP Vectorizer
// Reference:
//   - "Exploiting Superword Level Parallelism with Multimedia Instruction Sets"
//       https://groups.csail.mit.edu/cag/slp/SLP-PLDI-2000.pdf
//   - "Loop-Aware SLP in GCC - Proceedings of the GCC Developers’ Summit"
//       http://gcc.gnu.org/wiki/HomePage?action=AttachFile&do=get&target=GCC2007-Proceedings.pdf
//   - "VeGen: a vectorizer generator for SIMD and beyond"
//       https://dl.acm.org/doi/10.1145/3445814.3446692
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_VECTORIZER_HPP
#define GNALC_IR_PASSES_TRANSFORMS_VECTORIZER_HPP

#include <utility>

#include "config/config.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/pass_manager.hpp"
#include "ir/target/target.hpp"

namespace IR {
int getAlign(const pVal &inst);

class VectorizerPass : public PM::PassInfo<VectorizerPass> {
private:
    pBlock curr_block;
    BasicAAResult *basic_aa{};
    LoopAAResult *loop_aa{};
    pTarget target;

    struct SchedData {};

    class Scheduler {
    private:
        pBlock block;

        pInst sched_begin;
        pInst sched_end;

        SchedData *first_load_store{};
        SchedData *last_load_store{};

        size_t region_size{};
        size_t max_region_size{};

        std::list<SchedData> data;
        std::unordered_map<pVal, SchedData *> data_map;

    public:
        bool tryScheduleBundle(const std::vector<pVal> &scalars, const pVal &op, VectorizerPass *vectorizer) {
            if (op->is<PHIInst>())
                return true;

            auto old_sched_end = sched_end;
            SchedData *prev_in_bundle = nullptr;
            SchedData *bundle = nullptr;
            bool re_sched = false;

            Err::todo();
        }

        bool cancelScheduling(const std::vector<pVal> &scalars, const pVal &op) {
            Err::todo();
        }
    };
    std::unordered_map<pBlock, Scheduler> schedulers;

    std::vector<pStore> seed_stores;
    std::unordered_map<pStore, std::vector<pStore>> store_map;

    struct Tree {
        std::vector<pVal> scalars;
        pVal vec;
        bool need_to_gather;
        std::vector<int> user_tree_indices;
    };

    std::vector<Tree> vec_trees;
    std::unordered_map<pVal, int> scalar_to_tree;
    std::unordered_set<pVal> must_gather;

    Tree *newTree(const std::vector<pVal> &scalars, bool vectorized, int &user_tree_idx);

    void deleteTree();
    Tree *getTree(const pVal &val);

    void collectSeeds();

    std::tuple<std::unordered_set<pStore>, std::unordered_set<pStore>, std::map<pStore, pStore>>
    findConsecutiveStoreChain();

    bool vectorizeStoreChains();

    bool vectorizeStoreChain(const std::vector<pStore> &chain, size_t scalars_size);

    void buildTree(const std::vector<pVal> &scalars);

    std::optional<OP> getAltOpcode(OP Op);

    // fadd, fsub, fadd, fsub...
    std::optional<OP> tryAnalyzeAlternativeOp(const std::vector<pVal> &scalars);

    std::optional<OP> analyzeOpcode(const std::vector<pVal> &scalars);

    bool isAllConstant(const std::vector<pVal> &scalars);

    bool isAllSame(const std::vector<pVal> &scalars);

    bool isInSameBlock(const std::vector<pVal> &scalars);

    void buildTreeImpl(const std::vector<pVal> &scalars, int depth, int user_tree_idx);

    struct ExternalUser {
        pVal scalar;
        pUser user;
        int lane;
        ExternalUser(pVal scalar, pUser user, int lane)
            : scalar(std::move(scalar)), user(std::move(user)), lane(lane) {}
    };

    std::vector<ExternalUser> external_users;

    bool inTreeUserNeedToExtract(const pVal &val, const pInst &user);
    void collectExternalUsers();

    int getGatherCost(const pVecType &ty);

    int getBaseCost(const Tree &tree);

    // Calculate the vectorization cost of the SLP tree.
    // Negative for profitable.
    int getTreeCost();

    void vectorizeTree();

public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
