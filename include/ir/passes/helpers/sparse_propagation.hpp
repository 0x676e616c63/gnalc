// Generic Sparse Conditional Property Propagation, used by ConstantPropagationPass
// See:
//    - Static Single Assignment Book, P104, 8.2.2, Algorithm 8.1
//    - Wegman, Mark N. and Zadeck, F. Kenneth. "Constant Propagation with Conditional Branches."
//          https://dl.acm.org/doi/pdf/10.1145/103135.103136
//    - LLVM SparseSolver
//          SparsePropagation.h: https://github.com/llvm/llvm-project/blob/main/llvm/include/llvm/Analysis/SparsePropagation.h
//    - The opcache optimizer
//          Author's blog:  https://www.npopov.com/2022/05/22/The-opcache-optimizer.html
//          scdf.c:         https://github.com/php/php-src/blob/cc506a81e17c3e059d44b560213ed914f8199ed5/Zend/Optimizer/scdf.c
//          sccp.c:         https://github.com/php/php-src/blob/cc506a81e17c3e059d44b560213ed914f8199ed5/Zend/Optimizer/sccp.c
//    - QBE
//          Official Website: https://c9x.me/compile/
//          fold.c (Unofficial GitHub Mirror): https://github.com/caozhanhao/qbe/blob/master/fold.c
#pragma once
#ifndef GNALC_IR_PASSES_HELPER_SPARSE_PROPAGATION_HPP
#define GNALC_IR_PASSES_HELPER_SPARSE_PROPAGATION_HPP

#include <algorithm>
#include <deque>
#include <unordered_map>
#include <utility>

#include "../../base.hpp"
#include "../../basic_block.hpp"
#include "../../function.hpp"
#include "../../instructions/control.hpp"
#include "../../instructions/phi.hpp"

namespace IR {
// Generic Sparse Conditional Property Propagation
//
// KeyT and ValT is the type of lattice's key and value
//
// InfoT provides interface for manipulating lattice
// InfoT should provide:
//     InfoT::UNDEF;                                                      Indicating the top of the lattice.
//     InfoT::NAC;                                                        Indicating the bottom of the lattice.
//     KeyT InfoT::getKeyFromValue(const std::shared_ptr<Value>& val);    Getting a KeyT from an IR::Value
//     std::shared_ptr<Value> InfoT::getValueFromKey(const KeyT& val);    Getting an IR::Value from a KeyT
template <typename KeyT, typename ValT, typename InfoT>
class SparsePropagationSolver {
    public:
    class LatticeFunction {
    public:
        virtual ValT merge(ValT lhs, ValT rhs) const = 0;
        virtual void transfer(
            const std::shared_ptr<Instruction>& inst,
            std::unordered_map<KeyT, ValT>& changes,
            SparsePropagationSolver& solver) const = 0;
        virtual ConstantProxy getValueFromLatticeVal(const ValT& v) const = 0;
        virtual ~LatticeFunction() = default;
    };

    struct Edge {
        std::shared_ptr<BasicBlock> src;
        std::shared_ptr<BasicBlock> dest;
        bool operator<(const Edge& rhs) const { return src == rhs.src ? dest < rhs.dest : src < rhs.src; }
        Edge(std::shared_ptr<BasicBlock> src, std::shared_ptr<BasicBlock> dest)
            : src(std::move(src)), dest(std::move(dest)) {}
    };
    private:
    std::set<Edge> feasible_edges;
    std::deque<Edge> cfg_worklist;
    std::deque<std::shared_ptr<Instruction>> ssa_worklist;

    std::unordered_map<KeyT, ValT> lattice_map;
    LatticeFunction* lattice_func;
    public:
    explicit SparsePropagationSolver(LatticeFunction* func_)
        : lattice_func(func_) {}

    void solve(Function& target) {
        cfg_worklist.clear();
        ssa_worklist.clear();
        feasible_edges.clear();

        auto entry_node = target.getBlocks()[0];
        for (const auto& out : entry_node->getNextBB())
            cfg_worklist.emplace_back(entry_node, out);

        while (!cfg_worklist.empty() || !ssa_worklist.empty())
        {
            while (!ssa_worklist.empty())
            {
                auto curr = ssa_worklist.front();
                ssa_worklist.pop_front();

                if (curr->getOpcode() == OP::PHI)
                    visitPHI(std::dynamic_pointer_cast<PHIInst>(curr));
                else if (countFeasibleInEdge(curr->getParent()))
                    visitInst(curr);
            }

            while (!cfg_worklist.empty())
            {
                auto curr = cfg_worklist.front();
                cfg_worklist.pop_front();

                markFeasible(curr);

                // i.e. the target node is encountered to be executable for the first time
                if (countFeasibleInEdge(curr.dest) == 1)
                {
                    for (const auto& inst : *curr.dest)
                    {
                        if (inst->getOpcode() == OP::PHI)
                            visitPHI(std::dynamic_pointer_cast<PHIInst>(inst));
                        else
                            visitInst(inst);
                    }
                }
                else
                {
                    for (const auto& inst : *curr.dest)
                    {
                        if (inst->getOpcode() == OP::PHI)
                            visitPHI(std::dynamic_pointer_cast<PHIInst>(inst));
                    }
                }

                auto outgoings = curr.dest->getNextBB();
                if (outgoings.size() == 1 && !isFeasible(curr.dest, *outgoings.begin()))
                    cfg_worklist.emplace_back(curr.dest, *outgoings.begin());
            }
        }
    }

    ValT getVal(KeyT key) {
        auto it = lattice_map.find(key);
        if (it != lattice_map.end())
            return it->second;
        return lattice_map[key] = InfoT::UNDEF;
    }

    const auto& get_map() const { return lattice_map; }


    bool isFeasible(const std::shared_ptr<BasicBlock>& src,
                    const std::shared_ptr<BasicBlock>& dest) const {
        return isFeasible(Edge(src, dest));
    }

    bool isFeasible(const Edge& e) const {
        return feasible_edges.find(e) != feasible_edges.end();
    }

    size_t countFeasibleInEdge(const std::shared_ptr<BasicBlock>& bb) const {
        auto incomings = bb->getPreBB();
        return std::count_if(incomings.cbegin(), incomings.cend(),
                        [&bb, this](auto&& in) { return isFeasible(in, bb); });
    }

private:
    void updateVal(KeyT key, ValT val) {
        auto it = lattice_map.find(key);
        if (it != lattice_map.end() && it->second == val)
            return;

        lattice_map[key] = std::move(val);

        std::shared_ptr<Value> changed_value = InfoT::getValueFromKey(key);
        for (const auto& use : changed_value->getUseList())
            ssa_worklist.emplace_back(std::dynamic_pointer_cast<Instruction>(use->getUser()));
    }

    void markFeasible(const Edge& e) {
        feasible_edges.insert(e);
    }

    void visitPHI(const std::shared_ptr<PHIInst>& phi) {
        auto incomings = phi->getPhiOpers();

        auto phi_key = InfoT::getKeyFromValue(phi);
        auto phi_lattice = getVal(phi_key);

        for (const auto& in : incomings)
        {
            if (!isFeasible(in->getBlock(), phi->getParent()))
                continue;

            auto in_key = InfoT::getKeyFromValue(in->getValue());
            auto in_lattice = getVal(in_key);
            if (in_lattice != phi_lattice)
                phi_lattice = lattice_func->merge(phi_lattice, in_lattice);

            if (phi_lattice == InfoT::NAC)
                break;
        }

        updateVal(phi_key, phi_lattice);
    }

    void visitInst(const std::shared_ptr<Instruction>& inst) {
        Err::gassert(inst->getOpcode() != OP::PHI);
        if (auto br_inst = std::dynamic_pointer_cast<BRInst>(inst); br_inst && br_inst->isConditional())
        {
            auto cond_key = InfoT::getKeyFromValue(br_inst->getCond());
            auto cond_lattice = getVal(cond_key);
            if (cond_lattice == InfoT::NAC || cond_lattice == InfoT::UNDEF)
            {
                cfg_worklist.emplace_back(br_inst->getParent(), br_inst->getTrueDest());
                cfg_worklist.emplace_back(br_inst->getParent(), br_inst->getFalseDest());
            }
            // To ensure it contains a ConstantI1, we use `proxy.get_i1()` rather than `proxy == true`.
            // If it does not contain a ConstantI1, an exception will be thrown.
            else if (lattice_func->getValueFromLatticeVal(cond_lattice).get_i1())
                cfg_worklist.emplace_back(br_inst->getParent(), br_inst->getTrueDest());
            else
                cfg_worklist.emplace_back(br_inst->getParent(), br_inst->getFalseDest());
        }
        else if (inst->getVTrait() != ValueTrait::VOID_INSTRUCTION)
        {
            auto inst_key = InfoT::getKeyFromValue(inst);
            auto inst_lattice = getVal(inst_key);

            std::unordered_map<KeyT, ValT> changes;
            lattice_func->transfer(inst, changes, *this);
            for (const auto& [key, val] : changes)
                updateVal(key, val);
        }
    }
};

}

#endif
