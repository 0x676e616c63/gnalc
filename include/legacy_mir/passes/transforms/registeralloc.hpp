// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_MIR_LEGACY_PASSES_TRANSFORMS_REGISTERALLOC_HPP
#define GNALC_MIR_LEGACY_PASSES_TRANSFORMS_REGISTERALLOC_HPP
#include "config/config.hpp"
#include "legacy_mir/module.hpp"
#include "legacy_mir/passes/pass_manager.hpp"
#include <optional>

namespace LegacyMIR {

class RAPass : public PM::PassInfo<RAPass> {
public:
    using OperSet = std::set<std::shared_ptr<Operand>>;
    using WorkList = std::set<std::shared_ptr<Operand>>;
    using Nodes = std::set<std::shared_ptr<Operand>>;
    using Moves = std::set<std::shared_ptr<Instruction>>;

    struct Edge {
        OperP u, v;

        bool operator==(const Edge &another) const;
    };

    struct EdgeHash {
        std::size_t operator()(const Edge &_edge) const;
    };

public:
    virtual PM::PreservedAnalyses run(Function &, FAM &);

protected:
    // datas
    Function *Func;

    OperSet precolored;
    OperSet initial;

    WorkList simplifyWorkList;
    WorkList freezeWorkList;
    WorkList spillWorkList;

    Nodes coalescedNodes;
    Nodes spilledNodes;
    Nodes coloredNodes;

    // Operands wait to be colored
    std::vector<std::shared_ptr<Operand>> selectStack;

    Moves coalescedMoves;
    Moves constrainedMoves;
    Moves frozenMoves;
    Moves worklistMoves;
    Moves activeMoves;

    // others
    std::unordered_set<Edge, EdgeHash> adjSet;
    std::unordered_map<OperP, OperSet> adjList;
    std::unordered_map<OperP, unsigned int> degree; // precolored will be initialize with -1
    std::unordered_map<OperP, Moves> moveList;
    std::map<OperP, OperP> alias;
    // color
    unsigned int K = Config::LegacyMIR::CORE_REGISTER_MAX_NUM;

protected:
    /// procedures
    void Main(FAM &);
    // void LivenessAnalysis();
    void Build();
    void MkWorkList(); //
    void AddEdge(const OperP &, const OperP &);
    void Simplify();
    void DecrementDegree(const OperP &);
    void EnableMoves(const Nodes &);
    void Coalesce();
    void AddWorkList(const OperP &);
    void Combine(const OperP &, const OperP &);
    void Freeze();
    void FreezeMoves(const OperP &);
    void SelectSpill();
    virtual void AssignColors();

    void ReWriteProgram(); // 用于不同的ReWrite

protected:
    /// function
    Nodes Adjacent(const OperP &);
    Moves NodeMoves(const OperP &);
    bool MoveRelated(const OperP &);

    bool OK(const OperP &t, const OperP &r); // 合并precolored的启发式算法
    bool Conservative(const Nodes &);        // Briggs 开发的合并启发式算法
    OperP GetAlias(OperP);                   // 递归

protected:
    void clearall();

    std::set<int> colors;

    bool isInitialed;

    ///@note 活跃分析以及信息
    Liveness liveinfo;

    ///@note 变量池
    VarPool *varpool;

    ///@note 判断是否是 "move"指令
    virtual bool isMoveInstruction(const InstP &);

    ///@note get函数需要过滤
    virtual Nodes getUse(const InstP &);
    virtual Nodes getDef(const InstP &);

    template <typename Cx, typename Cy> void addBySet(Cx &victim, const Cy &set) {
        static_assert(std::is_same_v<typename Cx::value_type, typename Cy::value_type>,
                      "Cx Cy element types must be identical");

        for (const auto &ptr : set) {
            victim.insert(ptr);
        }
    }
    template <typename Cx, typename Cy> void delBySet(Cx &victim, const Cy &set) {
        static_assert(std::is_same_v<typename Cx::value_type, typename Cy::value_type>,
                      "Cx Cy element types must be identical");

        for (const auto &ptr : set) {
            victim.erase(ptr);
        }
    }

    template <typename T, typename... Tsets> std::set<T> getUnion(Tsets... sets) {
        std::set<T> union_set;
        (union_set.insert(sets.begin(), sets.end()), ...);
        return union_set;
    }

    template <typename T, typename... Tsets> std::set<T> getExclude(std::set<T> victim, Tsets... sets) {
        auto exclude_set = std::move(victim);

        auto lambda = [&exclude_set](const auto &set) -> void {
            for (const auto &t : set) {
                exclude_set.erase(t);
            }
        };

        (lambda(sets), ...);
        return exclude_set;
    }

    /// @note selectspill时使用的启发式算法
    OperP heuristicSpill();
    // std::map<OperP, unsigned int> intervalLengths;

    /// @note 选择合适的方式溢出, 将原变量替换为一套临时变量(相当于弃用原变量)
    virtual Nodes spill_tryOpt(const OperP &);
    virtual Nodes spill_classic(const OperP &);
    Nodes spill_opt(const OperP &);

    ///@note 用于溢出优化的浮点寄存器
    std::set<unsigned int> *availableSRegisters;

    ///@note 溢出次数(包含opt)
    unsigned int spilltimes = 0;
};

class NeonRAPass : public RAPass {
public:
    PM::PreservedAnalyses run(Function &, FAM &) override;

protected:
    // datas
    unsigned int K = Config::LegacyMIR::FPU_REGISTER_MAX_NUM;

protected:
    // procedures
    void AssignColors() override;

protected:
    bool isMoveInstruction(const InstP &) override;
    Nodes getUse(const InstP &) override;
    Nodes getDef(const InstP &) override;
    Nodes spill_tryOpt(const OperP &) override;
    Nodes spill_classic(const OperP &) override;
    std::set<unsigned int> availableSRegisters;
};

} // namespace MIR

#endif
#endif