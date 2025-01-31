// Generic Sparse Conditional Property Propagation, used by ConstantPropagationPass
// See:
//    - The opcache optimizer
//          Author's blog:  https://www.npopov.com/2022/05/22/The-opcache-optimizer.html
//          scdf.c:         https://github.com/php/php-src/blob/cc506a81e17c3e059d44b560213ed914f8199ed5/Zend/Optimizer/scdf.c
//          sccp.c:         https://github.com/php/php-src/blob/cc506a81e17c3e059d44b560213ed914f8199ed5/Zend/Optimizer/sccp.c
//    - Wegman, Mark N. and Zadeck, F. Kenneth. "Constant Propagation with Conditional Branches."
//          https://dl.acm.org/doi/pdf/10.1145/103135.103136
#pragma once
#ifndef GNALC_IR_PASSES_HELPER_SPARSE_PROPAGATION_HPP
#define GNALC_IR_PASSES_HELPER_SPARSE_PROPAGATION_HPP

#include <algorithm>
#include <deque>

#include "../../base.hpp"
#include "../../basic_block.hpp"
#include "../../function.hpp"
#include "../../instructions/control.hpp"
#include "../../instructions/phi.hpp"

namespace IR {
template <typename KeyT, typename ValT>
class SparsePropagationSolver {
    public:
    class LatticeFunction {
    public:
        virtual ValT merge(ValT lhs, ValT rhs) = 0;
        virtual ValT& getVal(KeyT key) = 0;
        virtual void transfer(Instruction* inst, KeyT key) = 0;

        virtual ~LatticeFunction() = default;
    };

    private:
    std::deque<BasicBlock*> flow_worklist;
    std::deque<Instruction*> ssa_worklist;

    LatticeFunction* lattice_func;

    std::set<const BasicBlock*> executable_flow;

    public:
    explicit SparsePropagationSolver(LatticeFunction* func_)
        : lattice_func(func_) {}

    void set_transfer_function(LatticeFunction* func_) { lattice_func = func_; }

    void solve(Function& target) {
        executable_flow.clear();
        flow_worklist.clear();
        ssa_worklist.clear();

        for (const auto& flow : target.getBlocks()[0]->getNextBB())
            flow_worklist.emplace_back(flow.get());

        while (!flow_worklist.empty() || !ssa_worklist.empty())
        {
            while (!ssa_worklist.empty())
            {
                auto curr = ssa_worklist.front();
                ssa_worklist.pop_front();

                if (curr->getOpcode() == OP::PHI)
                    visitPHI(dynamic_cast<const PHIInst*>(curr));
                else
                {
                    auto incomings = curr->getUseList();
                    if (std::count_if(incomings.cbegin(), incomings.cend(),
                        [this](auto&& use) {
                           return isExecutable(dynamic_cast<Instruction*>
                               (use->getUser())->getParent().get()); }))
                    {
                        visitInst(curr);
                    }
                }
            }

            while (!flow_worklist.empty())
            {
                auto curr = flow_worklist.front();
                flow_worklist.pop_front();
                if (!isExecutable(curr))
                {
                    markExexecutable(curr);

                    for (const auto& inst : curr->getInsts())
                    {
                        if (inst->getOpcode() == OP::PHI)
                            visitPHI(std::dynamic_pointer_cast<PHIInst>(inst).get());
                    }

                    if (isFirstEvaluated(curr))
                    {
                        for (const auto& inst : curr->getInsts())
                        {
                            if (inst->getOpcode() != OP::PHI)
                                visitInst(inst.get());
                        }
                    }

                    if (curr->getNextBB().size() == 1)
                        flow_worklist.emplace_back(curr->getNextBB().cbegin()->get());
                }
            }
        }
    }

    bool isExecutable(const BasicBlock* bb) {
        return executable_flow.find(bb) != executable_flow.end();
    }

    bool isFirstEvaluated(const BasicBlock* bb) {
        auto incomings = bb->getPreBB();
        return incomings.empty()
            || 1 == std::count_if(incomings.cbegin(), incomings.cend(),
            [this](auto&& pre) { return isExecutable(pre.get()); });
    }

    void markExexecutable(const BasicBlock* bb) {
        executable_flow.insert(bb);
    }

    void visitPHI(const PHIInst* phi) {
        auto incomings = phi->getPhiOpers();

        for (const auto& in : incomings)
        {

        }
    }

    void visitInst(const Instruction* inst) {
        Err::gassert(inst->getOpcode() != OP::PHI);

        if (auto br_inst = dynamic_cast<const BRInst*>(inst); br_inst && br_inst->isConditional())
        {

        }
        else
        {

        }

    }

};

}

#endif
