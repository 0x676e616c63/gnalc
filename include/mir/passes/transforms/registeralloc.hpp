#pragma once
#ifndef GNALC_MIRTOOLS_REGISTERALLOC_HPP
#define GNALC_MIRTOOLS_REGISTERALLOC_HPP
#include "../../../../include/config/config.hpp"
#include "../../module.hpp"
#include "../analysis/live_analysis.hpp"
#include "../pass_manager.hpp"
#include <optional>
#include <stdarg.h>

namespace MIR {

class RAPass : public PM::PassInfo<RAPass> {
public:
    using OperSet = std::unordered_set<std::shared_ptr<Operand>>;
    using WorkList = std::unordered_set<std::shared_ptr<Operand>>;
    using Nodes = std::unordered_set<std::shared_ptr<Operand>>;
    using Moves = std::unordered_set<std::shared_ptr<Instruction>>;

    struct Edge {
        OperP u, v;

        bool operator==(const Edge &another) const {
            return (another.u == u && another.v == v) || (another.u == v && another.v == u);
        }
    };

    struct EdgeHash {
        std::size_t operator()(const Edge &_edge) const {
            return std::hash<std::size_t>()((size_t)(_edge.v.get()) ^ (size_t)(_edge.u.get()));
            // 这么写可能合理, 但这么写合理不太可能
        }
    };

public:
    ///@todo 需要往这个Pass传一个浮点寄存器的占用表
    virtual PM::PreservedAnalyses run(Function &, FAM &);

protected:
    // datas
    Function *Func{}; // 用裸指针是因为不清楚是栈上还是堆上的内存

    OperSet precolored{};
    OperSet initial{};

    WorkList simplifyWorkList{};
    WorkList freezeWorkList{};
    WorkList spillWorkList{};

    Nodes coalescedNodes{};
    Nodes spilledNodes{};
    Nodes coloredNodes{};

    // Operands wait to be colored
    std::vector<std::shared_ptr<Operand>> selectStack{};

    Moves coalescedMoves{};
    Moves constrainedMoves{};
    Moves frozenMoves{};
    Moves worklistMoves{};
    Moves activeMoves{};

    // others
    std::unordered_set<Edge, EdgeHash> adjSet;
    std::unordered_map<OperP, OperSet> adjList;
    std::unordered_map<OperP, unsigned int> degree; // precolored will be initialize with -1
    std::unordered_map<OperP, Moves> moveList;
    std::map<OperP, OperP> alias;
    // color
    unsigned int K = Config::MIR::CORE_REGISTER_MAX_NUM;

protected:
    /// procedures
    void Main();
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
    // 土制函数及数据结构

    ///@note 填充initial 和 precolored
    ///@bug 由于FAM特性, 不同Function使用相同Pass时, 简单数据不会清空, 所以需要在run中手动置空
    bool isInitialed;

    ///@note 活跃分析以及信息
    Liveness liveinfo;

    ///@note 变量池
    VarPool *varpool;

    ///@note 判断是否是 "move"指令
    bool isMoveInstruction(const InstP &);

    ///@note get函数需要过滤
    virtual Nodes getUse(const InstP &);
    virtual Nodes getDef(const InstP &);

    template <typename Tx, typename Ty>
    void addBySet(std::unordered_set<Tx> &victim, const std::unordered_set<Ty> &set) {
        for (const auto &ptr : set) {
            victim.insert(ptr);
        }
    }
    template <typename Tx, typename Ty>
    void delBySet(std::unordered_set<Tx> &victim, const std::unordered_set<Ty> &set) {
        for (const auto &ptr : set) {
            victim.erase(ptr);
        }
    }
    template <typename T, typename... Tsets> std::unordered_set<T> getUnion(Tsets... sets) {
        std::unordered_set<T> union_set;
        // (void)std::initializer_list<int>{(union_set.insert(sets.begin(), sets.end()), 0)...};
        (union_set.insert(sets.begin(), sets.end()), ...);
        return union_set;
    }
    template <typename T, typename... Tsets>
    std::unordered_set<T> getExclude(std::unordered_set<T> victim, Tsets... sets) {
        auto exclude_set = std::move(victim);

        if (exclude_set.empty())
            return exclude_set;

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
    std::map<OperP, unsigned int> intervalLengths;

    /// @note 选择合适的方式溢出, 将原变量替换为一套临时变量(相当于弃用原变量)
    virtual Nodes spill_tryOpt(const OperP &);
    virtual Nodes spill_classic(const OperP &);
    Nodes spill_opt(const OperP &);

    ///@note 用于溢出优化的浮点寄存器, 只出不进
    std::vector<unsigned int> availableSRegisters;

    ///@note 溢出次数(包含opt)
    unsigned int spilltimes = 0;
};

class NeonRAPass : public RAPass {
public:
    PM::PreservedAnalyses run(Function &, FAM &) override;

protected:
    // datas
    unsigned int K = Config::MIR::FPU_REGISTER_MAX_NUM;

protected:
    // procedures
    void AssignColors() override;

protected:
    Nodes getUse(const InstP &) override;
    Nodes getDef(const InstP &) override;
    Nodes spill_tryOpt(const OperP &) override;
    Nodes spill_classic(const OperP &) override;
    std::vector<unsigned int> availableSRegisters;
};

} // namespace MIR

#endif