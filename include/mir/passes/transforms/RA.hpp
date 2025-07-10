// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#include "mir/tools.hpp"
#ifndef GNALC_MIR_PASSES_TRANSFROMS_RA
#define GNALC_MIR_PASSES_TRANSFROMS_RA

#include "config/config.hpp"
#include "mir/passes/analysis/liveanalysis.hpp"
#include "utils/fast_set.hpp"

namespace MIR {

class RegisterAlloc : public PM::PassInfo<RegisterAlloc> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class RegisterAllocImpl {
public:
    using OperSet = Util::FastSet<MIROperand_p>;
    using WorkList = Util::FastSet<MIROperand_p>;
    using Nodes = Util::FastSet<MIROperand_p>;
    using Moves = Util::FastSet<MIRInst_p>;

    struct Edge {
        MIROperand_p u, v;
        bool operator==(const Edge &anthor) const;
    };

    struct EdgeHash {
        std::size_t operator()(const Edge &_edge) const {
            return std::hash<std::size_t>()(static_cast<std::size_t>(reinterpret_cast<uintptr_t>(_edge.v.get())) ^
                                            static_cast<std::size_t>(reinterpret_cast<uintptr_t>(_edge.u.get())));
        }
    };

public:
    virtual void impl(MIRFunction &, FAM &);
    RegisterAllocImpl() : mfunc(nullptr), K(Config::MIR::AARCH64_CORE_REGISTER_MAX_NUM), isInitialized(false) {}
    explicit RegisterAllocImpl(int fpuRegCnt) : mfunc(nullptr), K(fpuRegCnt), isInitialized(false) {}
    virtual ~RegisterAllocImpl() = default;

protected:
    MIRFunction *mfunc;

    OperSet precolored;
    OperSet initial;

    WorkList simplifyWorkList;
    WorkList freezeWorkList;
    WorkList spillWorkList;

    Nodes coalescedNodes;
    Nodes spilledNodes;
    Nodes coloredNodes;

    // Operands wait to be colored
    std::vector<MIROperand_p> selectStack;

    Moves coalescedMoves;
    Moves constrainedMoves;
    Moves frozenMoves;
    Moves worklistMoves;
    Moves activeMoves;

    // others
    std::unordered_set<Edge, EdgeHash> adjSet;
    std::map<MIROperand_p, OperSet> adjList;
    std::unordered_map<MIROperand_p, unsigned int> degree; // precolored will be initialized with -1
    std::unordered_map<MIROperand_p, Moves> moveList;
    std::unordered_map<MIROperand_p, MIROperand_p> alias;
    // color
    unsigned int K;

protected:
    /// procedures
    void Main(FAM &);
    // void LivenessAnalysis();
    virtual void Build();
    virtual void MkWorkList(); //
    void AddEdge(const MIROperand_p &, const MIROperand_p &);
    void Simplify();
    void DecrementDegree(const MIROperand_p &);
    void EnableMoves(const Nodes &);
    void Coalesce();
    void AddWorkList(const MIROperand_p &);
    void Combine(const MIROperand_p &, const MIROperand_p &);
    void Freeze();
    void FreezeMoves(const MIROperand_p &);
    void SelectSpill();
    virtual void AssignColors();

    void ReWriteProgram();

protected:
    /// function
    inline Nodes Adjacent(const MIROperand_p &);
    Moves NodeMoves(const MIROperand_p &);
    bool MoveRelated(const MIROperand_p &);

    bool OK(const MIROperand_p &t, const MIROperand_p &r); // 合并precolored的启发式算法
    bool Conservative(const Nodes &);                      // Briggs 开发的合并启发式算法
    MIROperand_p GetAlias(MIROperand_p);                   // 递归

protected:
    void clearall();

    std::set<int> colors;

    bool isInitialized;

    ///@note 活跃分析以及信息
    Liveness liveinfo;

    ///@note 判断是否是 "move"指令
    virtual bool isMoveInstruction(const MIRInst_p &);

    /// speed up
    bool NodeMovesEmpty(const MIROperand_p &);

    ///@note get函数需要过滤
    virtual Nodes getUse(const MIRInst_p &);
    virtual Nodes getDef(const MIRInst_p &);

    bool isCore(const MIROperand_p &n) {
        if ((n->type() == OpT::Int16 || n->type() == OpT::Int32 || n->type() == OpT::Int64 || n->type() == OpT::Int)) {
            return true;
        } else {
            return false;
        }
    }

    bool isExt(const MIROperand_p &n) {
        if (inSet(n->type(), OpT::Float, OpT::Float32, OpT::Floatvec, OpT::Intvec, OpT::Int64vec)) {
            return true;
        } else {
            return false;
        }
    }

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

    template <typename T, bool inOrder = true, typename... Tsets> auto getUnion(const Tsets &...sets) {
        if constexpr (!inOrder) {
            std::unordered_set<T> temp;
            (temp.insert(sets.begin(), sets.end()), ...);
            return temp;
        } else {
            std::set<T> set;

            (set.insert(sets.begin(), sets.end()), ...);

            return set;
        }
    }

    template <typename T> auto getUnion(const std::set<T> &set1, const std::set<T> &set2) {
        std::set<T> set;

        std::set_union(set1.begin(), set1.end(), set2.begin(), set2.end(), std::inserter(set, set.begin()));

        return set;
    }

    template <typename T> auto getUnion(const Util::FastSet<T> &set1, const Util::FastSet<T> &set2) {
        return Util::fastset_union(set1, set2);
    }

    template <typename T, typename... Tsets> bool isInUnion(const T &elem, const Tsets &...sets) {
        return (sets.count(elem) | ...);
    }

    template <typename T, bool inOrder = true, typename... Tsets>
    auto getExclude(const Util::FastSet<T> &victim, const Tsets &...sets) {
        if constexpr (inOrder) {
            Util::FastSet<T> result;
            result.reserve(victim.size());
            for (const auto &elem : victim) {
                if ((!sets.count(elem) && ...))
                    result.insert(elem);
            }
            return result;
        } else {
            auto exclude_unioon = getUnion<T, false>(sets...);
            std::unordered_set<T> result;
            for (const auto &elem : exclude_unioon) {
                if (!victim.count(elem)) {
                    result.insert(elem);
                }
            }
            return result;
        }
    }

    MIROperand_p heuristicSpill();

    virtual Nodes spill(const MIROperand_p &);

    unsigned int spilltimes = 0;

protected:
    /// debug
    auto find_if(const Nodes &set, unsigned recover) {
        return std::find_if(set.begin(), set.end(),
                            [&recover](const MIROperand_p &mop) { return mop->getRecover() == recover; });
    };
};

class VectorRegisterAllocImpl : public RegisterAllocImpl {

public:
    void impl(MIRFunction &, FAM &) override;
    VectorRegisterAllocImpl() : RegisterAllocImpl(Config::MIR::AARCH64_FPU_REGISTER_MAX_NUM) {}
    ~VectorRegisterAllocImpl() override = default;

protected:
    void Build() override;
    void MkWorkList() override;

protected:
    bool isMoveInstruction(const MIRInst_p &) override;
    Nodes getUse(const MIRInst_p &) override;
    Nodes getDef(const MIRInst_p &) override;
    // Nodes spill(const MIROperand_p &) override; //
};
}; // namespace MIR

#endif
