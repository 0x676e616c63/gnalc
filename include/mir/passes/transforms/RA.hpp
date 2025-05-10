#pragma once
#ifndef GNALC_ARMV8_MIR_PASSES_TRANSFROMS_RA
#define GNALC_ARMV8_MIR_PASSES_TRANSFROMS_RA

#include "config/config.hpp"
#include "mir/passes/analysis/liveanalysis.hpp"
#include <set>

namespace MIR_new {

class RegisterAlloc : public PM::PassInfo<RegisterAlloc> {

public:
    PM::PreservedAnalyses run(MIRFunction &, FAM &);
};

class RegisterAllocImpl {
public:
    using OperSet = std::set<MIROperand_p>;
    using WorkList = std::set<MIROperand_p>;
    using Nodes = std::set<MIROperand_p>;
    using Moves = std::set<MIRInst_p>;

    struct Edge {
        MIROperand_p u, v;
        bool operator==(const Edge &anthor) const;
    };

    struct EdgeHash {
        std::size_t operator()(const Edge &_edge) const {
            /// 这tm还不如不修
            return std::hash<std::size_t>()(static_cast<std::size_t>(reinterpret_cast<uintptr_t>(_edge.v.get())) ^
                                            static_cast<std::size_t>(reinterpret_cast<uintptr_t>(_edge.u.get())));
        }
    };

public:
    virtual void impl(MIRFunction &, FAM &);
    RegisterAllocImpl() = default;
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
    std::map<MIROperand_p, unsigned int> degree; // precolored will be initialize with -1
    std::map<MIROperand_p, Moves> moveList;
    std::map<MIROperand_p, MIROperand_p> alias;
    // color
    unsigned int K = Config::MIR_new::CORE_REGISTER_MAX_NUM;

protected:
    /// procedures
    void Main(FAM &);
    // void LivenessAnalysis();
    void Build();
    void MkWorkList(); //
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
    Nodes Adjacent(const MIROperand_p &);
    Moves NodeMoves(const MIROperand_p &);
    bool MoveRelated(const MIROperand_p &);

    bool OK(const MIROperand_p &t, const MIROperand_p &r); // 合并precolored的启发式算法
    bool Conservative(const Nodes &);                      // Briggs 开发的合并启发式算法
    MIROperand_p GetAlias(MIROperand_p);                   // 递归

protected:
    void clearall();

    std::set<int> colors;

    bool isInitialed;

    ///@note 活跃分析以及信息
    Liveness liveinfo;

    ///@note 判断是否是 "move"指令
    virtual bool isMoveInstruction(const MIRInst_p &);

    ///@note get函数需要过滤
    virtual Nodes getUse(const MIRInst_p &);
    virtual Nodes getDef(const MIRInst_p &);

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

    // template <typename T, typename... Tsets> std::set<T> getUnion(Tsets... sets) {
    //     std::set<T> union_set;
    //     (union_set.insert(sets.begin(), sets.end()), ...);
    //     return union_set;
    // }

    template <typename T, typename... Tsets> std::set<T> getUnion(const Tsets &...sets) {
        std::unordered_set<T> temp;
        (temp.insert(sets.begin(), sets.end()), ...);
        return {temp.begin(), temp.end()};
    }

    // template <typename T, typename... Tsets> std::set<T> getExclude(std::set<T> victim, Tsets... sets) {
    //     auto exclude_set = std::move(victim);

    //     auto lambda = [&exclude_set](const auto &set) -> void {
    //         for (const auto &t : set) {
    //             exclude_set.erase(t);
    //         }
    //     };

    //     (lambda(sets), ...);
    //     return exclude_set;
    // }

    template <typename T, typename... Tsets> std::set<T> getExclude(const std::set<T> &victim, const Tsets &...sets) {
        auto exclude_union = getUnion<T>(sets...);
        std::set<T> result;
        std::set_difference(victim.begin(), victim.end(), exclude_union.begin(), exclude_union.end(),
                            std::inserter(result, result.end()));
        return result;
    }

    /// @note selectspill时使用的启发式算法
    MIROperand_p heuristicSpill();

    virtual Nodes spill(const MIROperand_p &);

    ///@note 溢出次数(包含opt)
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
    VectorRegisterAllocImpl() = default;
    ~VectorRegisterAllocImpl() override = default;

protected:
    unsigned int K = Config::MIR_new::FPU_REGISTER_MAX_NUM;

protected:
    // dont need to override AssignColors now

protected:
    bool isMoveInstruction(const MIRInst_p &) override;
    Nodes getUse(const MIRInst_p &) override;
    Nodes getDef(const MIRInst_p &) override;
    // Nodes spill(const MIROperand_p &) override; //
};

}; // namespace MIR_new

#endif
