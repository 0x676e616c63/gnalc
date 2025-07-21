// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

// Generic Sparse Conditional Property Propagation, used by ConstantPropagationPass
// See:
//    - Static Single Assignment Book, P104, 8.2.2, Algorithm 8.1
//    - Wegman, Mark N. and Zadeck, F. Kenneth. "Constant Propagation with Conditional Branches."
//          https://dl.acm.org/doi/pdf/10.1145/103135.103136
//    - LLVM SparseSolver
//          SparsePropagation.h:
//          https://github.com/llvm/llvm-project/blob/main/llvm/include/llvm/Analysis/SparsePropagation.h
#pragma once
#ifndef GNALC_IR_PASSES_HELPER_SPARSE_PROPAGATION_HPP
#define GNALC_IR_PASSES_HELPER_SPARSE_PROPAGATION_HPP

#include "../../base.hpp"
#include "../../basic_block.hpp"
#include "../../function.hpp"
#include "../../instructions/control.hpp"
#include "../../instructions/phi.hpp"

#include <algorithm>
#include <deque>
#include <unordered_map>
#include <utility>

namespace IR {
// Generic Sparse Conditional Property Propagation
//
// KeyT and ValT is the type of lattice's key and value
//
// InfoT provides interface for manipulating lattice
// InfoT should provide:
//     InfoT::UNDEF;     Indicating the top of the lattice.
//     InfoT::NAC;       Indicating the bottom of the lattice.
//     KeyT InfoT::getKeyFromValue(const pValue& val);    Getting a KeyT from an IR::Value
//     pValue InfoT::getValueFromKey(const KeyT& val);    Getting an IR::Value from a KeyT
template <typename KeyT, typename ValT, typename InfoT> class SparsePropagationSolver {
public:
    class LatticeFunction {
    public:
        virtual ValT merge(ValT lhs, ValT rhs) const = 0;
        virtual void transfer(const pInst &inst, std::unordered_map<KeyT, ValT> &changes,
                              SparsePropagationSolver &solver) const = 0;
        virtual ConstantProxy getValueFromLatticeVal(const ValT &v) const = 0;
        virtual ValT computeLatticeVal(const KeyT &key) const = 0;
        virtual ~LatticeFunction() = default;
    };

    struct Edge {
        BasicBlock* src;
        BasicBlock* dest;
        Edge(BasicBlock* src, BasicBlock* dest) : src(src), dest(dest) {}
    };

private:
    struct EdgeHash {
        size_t operator()(const Edge &e) const {
            return std::hash<BasicBlock*>()(e.src) ^ std::hash<BasicBlock*>()(e.dest);
        }
    };
    struct EdgeCmp {
        bool operator()(const Edge &lhs, const Edge &rhs) const { return lhs.src == rhs.src && lhs.dest == rhs.dest; }
    };
    std::unordered_set<Edge, EdgeHash, EdgeCmp> feasible_edges;
    // A cache for faster `countFeasibleInEdge`
    std::unordered_set<BasicBlock*> known_all_incoming_feasible;
    std::deque<Edge> cfg_worklist;
    std::deque<pInst> ssa_worklist;

    std::unordered_map<KeyT, ValT> lattice_map;
    LatticeFunction *lattice_func;

public:
    explicit SparsePropagationSolver(LatticeFunction *func_) : lattice_func(func_) {}

    void clear() {
        cfg_worklist.clear();
        ssa_worklist.clear();
        lattice_map.clear();
    }

    void solve(Function &target) {
        clear();

        cfg_worklist.emplace_back(nullptr, target.begin()->get());

        while (!cfg_worklist.empty() || !ssa_worklist.empty()) {
            while (!ssa_worklist.empty()) {
                auto curr = ssa_worklist.front();
                ssa_worklist.pop_front();

                if (curr->getOpcode() == OP::PHI)
                    visitPHI(curr->as<PHIInst>());
                else if (countFeasibleInEdge(curr->getParent().get()))
                    visitInst(curr);
            }

            while (!cfg_worklist.empty()) {
                auto curr = cfg_worklist.front();
                cfg_worklist.pop_front();

                markFeasible(curr);

                for (const auto &inst : curr.dest->phis())
                    visitPHI(inst);

                // i.e. the target node is encountered to be executable for the
                // first time
                if (countFeasibleInEdge(curr.dest) == 1) {
                    for (const auto &inst : *curr.dest)
                        visitInst(inst);
                }

                if (curr.dest->getNumSuccs() == 1 && !isFeasible(curr.dest, (*curr.dest->succ_begin()).get()))
                    cfg_worklist.emplace_back(curr.dest, (*curr.dest->succ_begin()).get());
            }
        }
    }

    ValT getVal(const KeyT &key) {
        auto it = lattice_map.find(key);
        if (it != lattice_map.end())
            return it->second;
        return lattice_map[key] = lattice_func->computeLatticeVal(key);
    }

    const auto &get_map() const { return lattice_map; }

    bool isFeasible(BasicBlock* src, BasicBlock* dest) const { return isFeasible(Edge(src, dest)); }

    bool isFeasible(const Edge &e) const { return feasible_edges.find(e) != feasible_edges.end(); }

    size_t countFeasibleInEdge(BasicBlock* bb) {
        auto it = known_all_incoming_feasible.find(bb);
        if (it != known_all_incoming_feasible.end())
            return bb->getNumPreds();

        if (bb->getNumPreds() == 0) // Entry node
            return isFeasible(nullptr, bb) ? 1 : 0;
        auto ret = std::count_if(bb->pred_begin(), bb->pred_end(),
            [&bb, this](auto &&in) { return isFeasible(in.get(), bb); });
        if (ret == bb->getNumPreds())
            known_all_incoming_feasible.emplace(bb);
        return ret;
    }

private:
    void updateVal(KeyT key, ValT val) {
        auto it = lattice_map.find(key);
        if (it != lattice_map.end() && it->second == val)
            return;

        lattice_map[key] = std::move(val);

        pVal changed_value = InfoT::getValueFromKey(key);
        for (const auto &user : changed_value->inst_users())
            ssa_worklist.emplace_back(user);
    }

    void markFeasible(const Edge &e) { feasible_edges.insert(e); }

    void visitPHI(const pPhi &phi) {
        auto phi_key = InfoT::getKeyFromValue(phi);
        auto phi_lattice = getVal(phi_key);

        for (const auto &in : phi->incomings()) {
            if (!isFeasible(in.block.get(), phi->getParent().get()))
                continue;

            auto in_key = InfoT::getKeyFromValue(in.value);
            auto in_lattice = getVal(in_key);
            if (in_lattice != phi_lattice)
                phi_lattice = lattice_func->merge(phi_lattice, in_lattice);

            if (phi_lattice == InfoT::NAC)
                break;
        }

        updateVal(phi_key, phi_lattice);
    }

    void visitInst(const pInst &inst) {
        Err::gassert(inst->getOpcode() != OP::PHI);
        if (auto br_inst = inst->as_raw<BRInst>(); br_inst && br_inst->isConditional()) {
            auto cond_key = InfoT::getKeyFromValue(br_inst->getCond());
            auto cond_lattice = getVal(cond_key);
            if (cond_lattice == InfoT::NAC || cond_lattice == InfoT::UNDEF) {
                cfg_worklist.emplace_back(br_inst->getParent().get(), br_inst->getTrueDest().get());
                cfg_worklist.emplace_back(br_inst->getParent().get(), br_inst->getFalseDest().get());
            }
            // To ensure it contains a ConstantI1, we use `proxy.get_i1()`
            // rather than `proxy == true`. If it does not contain a ConstantI1,
            // an exception will be thrown.
            else if (lattice_func->getValueFromLatticeVal(cond_lattice).get_i1())
                cfg_worklist.emplace_back(br_inst->getParent().get(), br_inst->getTrueDest().get());
            else
                cfg_worklist.emplace_back(br_inst->getParent().get(), br_inst->getFalseDest().get());
        } else if (auto select = inst->as_raw<SELECTInst>()) {
            auto select_key = InfoT::getKeyFromValue(inst);
            auto cond_key = InfoT::getKeyFromValue(select->getCond());
            auto cond_lattice = getVal(cond_key);
            if (cond_lattice == InfoT::NAC)
                updateVal(select_key, InfoT::NAC);
            else if (cond_lattice != InfoT::UNDEF) {
                if (lattice_func->getValueFromLatticeVal(cond_lattice).get_i1()) {
                    auto true_key = InfoT::getKeyFromValue(select->getTrueVal());
                    auto true_lattice = getVal(true_key);
                    updateVal(select_key, true_lattice);
                }
                else {
                    auto false_key = InfoT::getKeyFromValue(select->getFalseVal());
                    auto false_lattice = getVal(false_key);
                    updateVal(select_key, false_lattice);
                }
            }
        }
        else if (inst->getVTrait() != ValueTrait::VOID_INSTRUCTION) {
            auto inst_key = InfoT::getKeyFromValue(inst);
            auto inst_lattice = getVal(inst_key);

            std::unordered_map<KeyT, ValT> changes;
            lattice_func->transfer(inst, changes, *this);
            for (const auto &[key, val] : changes)
                updateVal(key, val);
        }
    }
};

} // namespace IR

#endif
