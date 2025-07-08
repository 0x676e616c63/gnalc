// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// SLP Vectorizer
// Bottom Up SLP Vectorizer
//
// Reference:
//   - "Exploiting Superword Level Parallelism with Multimedia Instruction Sets"
//       https://groups.csail.mit.edu/cag/slp/SLP-PLDI-2000.pdf
//   - "Loop-Aware SLP in GCC - Proceedings of the GCC Developers’ Summit"
//       http://gcc.gnu.org/wiki/HomePage?action=AttachFile&do=get&target=GCC2007-Proceedings.pdf
//   - "VeGen: a vectorizer generator for SIMD and beyond"
//       https://dl.acm.org/doi/10.1145/3445814.3446692
//   - "Paper Reading | Exploiting Superword Level Parallelism with Multimedia Instruction Sets"
//       https://enna1.github.io/post/slp-vectorizer_pldi00/
//   - "SLP Vectorizer: Part 1 - Implementation in LLVM"
//       https://enna1.github.io/post/llvm-slp-vectorizer-part1/
//   - "SLP Vectorizer: Part 2 - Performance of LLVM SLP Vectorizer"
//       https://enna1.github.io/post/llvm-slp-vectorizer-part2/
//   - LLVM SLP Vectorizer
//       https://github.com/llvm/llvm-project/blob/main/llvm/include/llvm/Transforms/Vectorize/SLPVectorizer.h
//       https://github.com/llvm/llvm-project/blob/main/llvm/lib/Transforms/Vectorize/SLPVectorizer.cpp
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_VECTORIZER_HPP
#define GNALC_IR_PASSES_TRANSFORMS_VECTORIZER_HPP

#include "config/config.hpp"
#include "ir/irbuilder.hpp"

#include <utility>

#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "ir/passes/analysis/loop_alias_analysis.hpp"
#include "ir/passes/pass_manager.hpp"
#include "ir/target/target.hpp"

namespace IR {
class VectorizerPass : public PM::PassInfo<VectorizerPass> {
private:
    struct AlignRewriter {
        friend class VectorizerPass;
        using Changes = std::vector<std::pair<pVal, int>>;
        static int getAlign(const pVal &val);
        static void setAlign(const pVal &val, int align);
        static bool trySetBaseAlign(pVal ptr, int align, Function *curr_func, Changes &changes);

    private:
        std::unordered_map<pInst, Changes> rewritten;
        LoopAAResult *loop_aa{};

    public:
        void reset() {
            rewritten.clear();
            loop_aa = nullptr;
        }

        bool trySetInstAlign(const pInst &inst, int align);
        void restoreInstAlign(const pInst &inst);
    };

    // Scheduling Data for Instruction
    // It is for a single instruction or a bundle of instructions
    struct SchedData {
        // The underlying instruction being scheduled
        pInst inst;

        // The first item in the bundle, which is an entity for scheduling
        // For single instruction, first_in_bundle == this
        SchedData *first_in_bundle;
        // The next item in the bundle
        SchedData *next_in_bundle;

        // The next memory access instruction in the REGION
        SchedData *next_mem_access;

        // The memory dependencies
        // (Like operands in use-def dependency)
        std::vector<SchedData *> mem_deps;

        // Schedule Region ID
        int region_id;

        // Priority to make the schedule be as close as possible to the original instruction order.
        int priority;

        // Number of dependencies = use-def dep + mem dep (users count)
        int num_deps;

        // Number of unscheduled dependencies (unscheduled users count)
        int num_unsched_deps;

        // Number of unscheduled dependencies in the bundle
        // (unscheduled users count for the whole bundle)
        // For single instruction, num_unsched_deps_in_bundle == num_unsched_deps
        // ONLY available for the first inst of a bundle
        int num_unsched_deps_in_bundle;

        // Whether the instruction has been scheduled
        bool is_sched;

        SchedData()
            : inst(nullptr), first_in_bundle(nullptr), next_in_bundle(nullptr), next_mem_access(nullptr), region_id(0),
              priority(0), num_deps(-1), num_unsched_deps(-1), num_unsched_deps_in_bundle(-1), is_sched(false) {}

        void init(int region_id_) {
            region_id = region_id_;
            first_in_bundle = this;
            next_in_bundle = nullptr;
            next_mem_access = nullptr;
            is_sched = false;
            num_unsched_deps_in_bundle = num_unsched_deps;
            clearDeps();
        }

        // Updating the whole bundle's unscheduled dependencies
        int incUnschedDeps(int v) {
            num_unsched_deps += v;
            return first_in_bundle->num_unsched_deps_in_bundle += v;
        }

        // num unsched + num deps - num unsched ---> num deps
        void resetUnschedDeps() { incUnschedDeps(num_deps - num_unsched_deps); }

        void clearDeps() {
            num_deps = -1;
            mem_deps.clear();
            resetUnschedDeps();
        }

        // The head of the bundle
        bool isSchedEntity() const { return first_in_bundle == this; }

        // See if the bundle is ready to be scheduled, which has no unscheduled dependencies
        bool isReady() const {
            Err::gassert(isSchedEntity(), "SchedData::isReady: not head");
            return num_unsched_deps_in_bundle == 0 && !is_sched;
        }

        // See if the bundle's dependencies are valid
        bool isDepsValid() const { return num_deps >= 0; }

        // See if this SchedData is part of a bundle
        bool isPartOfBundle() const { return next_in_bundle != nullptr || first_in_bundle != this; }
    };

    struct Scheduler {
        // The current block being scheduled
        pBlock block;

        // For Alias Analysis
        FAM *fam;
        LoopAAResult *loop_aa;

        bool slp_print_debug_message;

        // Ready Instructions, only used in dry run.
        // For real scheduling, we consider the original instruction order
        std::set<SchedData *> dry_run_ready_list;

        // The beginning of the region
        pInst sched_begin;
        // The end of the region
        pInst sched_end;

        // The first memory access
        SchedData *first_mem_access{};
        // The last memory access
        SchedData *last_mem_access{};

        // Current region size, used to avoid too large region
        size_t region_size{};
        size_t max_region_size = Config::IR::SLP_SCHEDULER_MAX_REGION_SIZE;

        // Current region ID
        int region_id{};

        // Schedule Data
        std::list<SchedData> sched_data_list;
        std::unordered_map<pVal, SchedData *> sched_data_map;

        SchedData *getData(const pVal &val);

        bool hasMemAccess(const pInst &inst);
        bool hasMemWrite(const pInst &inst);

        void initSchedData(BBInstIter from, BBInstIter to, SchedData *prev_mem_access, SchedData *next_mem_access);

        bool extendRegion(const pInst &inst);

        void resetSchedule();

        bool inRegion(SchedData *sched) const;

        void updateDeps(SchedData *sched, bool insert_in_ready_list);

        template <typename ReadyListT> void schedule(SchedData *sched_data, ReadyListT &ready_list) {
            Err::gassert(sched_data->isReady(), "SchedData::schedule: not ready");
            // if (slp_print_debug_message)
            //     std::cerr << "Scheduling '" << sched_data->inst->getName() << "'" << std::endl;

            sched_data->is_sched = true;

            auto member = sched_data;
            while (member) {
                // Use-def dependencies
                for (auto oper : member->inst->operands()) {
                    auto oper_sched = getData(oper);
                    if (oper_sched && oper_sched->isDepsValid() && oper_sched->incUnschedDeps(-1) == 0) {
                        auto dep_bundle = oper_sched->first_in_bundle;
                        Err::gassert(!dep_bundle->is_sched,
                                     "SchedData::schedule: already scheduled use-def dependency.");
                        ready_list.insert(dep_bundle);
                    }
                }
                // Memory dependencies
                for (const auto &mem_sched : member->mem_deps) {
                    if (mem_sched->incUnschedDeps(-1) == 0) {
                        auto dep_bundle = mem_sched->first_in_bundle;
                        Err::gassert(!dep_bundle->is_sched,
                                     "SchedData::schedule: already scheduled memory dependency.");
                        ready_list.insert(dep_bundle);
                    }
                }
                member = member->next_in_bundle;
            }
        }

        template <typename ReadyListT> void initialFillReadyList(ReadyListT &ready_list) {
            for (auto it = sched_begin->iter(); it != sched_end->iter(); ++it) {
                auto sched = getData(*it);
                if (sched->isSchedEntity() && sched->isReady())
                    ready_list.insert(sched);
            }
        }
        bool tryScheduleBundle(const std::vector<pVal> &scalars);

        void cancelScheduling(const std::vector<pVal> &scalars);
    };

    Scheduler &getScheduler(const pBlock &block);

    struct Tree {
        std::vector<pVal> scalars;
        pVal vec;
        bool need_to_gather;
        std::vector<int> user_tree_indices;
    };

    struct ExternalUser {
        pVal scalar;
        pUser user;
        int lane;
        ExternalUser(pVal scalar, pUser user, int lane)
            : scalar(std::move(scalar)), user(std::move(user)), lane(lane) {}
    };

    AlignRewriter align_rewriter;
    std::vector<pInst> rewritten_aligns;

    ConstantPool *cpool{};
    FAM *fam{};
    LoopAAResult *loop_aa{};
    pTarget target;

    std::unordered_map<pBlock, Scheduler> schedulers;
    std::vector<pStore> seed_stores;

    std::vector<Tree> vec_trees;
    std::unordered_map<pVal, int> scalar_to_tree;
    std::unordered_set<pVal> must_gather;

    std::vector<ExternalUser> external_users;
    IRBuilder builder;

    int next_region_id{1};

    bool slp_print_debug_message{false};

    void reset() {
        fam = nullptr;
        cpool = nullptr;
        loop_aa = nullptr;
        target = nullptr;
        schedulers.clear();
        seed_stores.clear();
        vec_trees.clear();
        scalar_to_tree.clear();
        must_gather.clear();
        external_users.clear();
        align_rewriter.reset();
        next_region_id = 1;
    }

    void collectSeeds(const pBlock &block);

    Tree *newTree(const std::vector<pVal> &scalars, bool vectorized, int &user_tree_idx);

    void deleteTree();
    Tree *getTree(const pVal &val);

    std::tuple<std::unordered_set<pStore>, std::unordered_set<pStore>, std::map<pStore, pStore>>
    findConsecutiveStoreLinks() const;

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

    bool inTreeUserNeedToExtract(const pVal &val, const pInst &user);
    void collectExternalUsers();

    int getGatherCost(const pVecType &ty);

    int getBaseCost(const Tree &tree);

    // Calculate the vectorization cost of the SLP tree.
    // Negative for profitable.
    int getTreeCost();

    void printTree(std::ostream &os);

    void scheduleBlock(Scheduler *scheduler);

    void setInsertPointAfterBundle(const std::vector<pVal> &scalars);

    pVal gatherTree(const std::vector<pVal> &scalars, const pVecType &ty);

    pVal vectorizeFromScalars(const std::vector<pVal> &scalars);

    pVal vectorizeTree(Tree *tree);

    pVal vectorizeTrees();

public:
    explicit VectorizerPass(bool slp_debug = false) : slp_print_debug_message(slp_debug) {}
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
