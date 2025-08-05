// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_SIR_CLONE_HPP
#define GNALC_SIR_CLONE_HPP

#include "base.hpp"
#include "visitor.hpp"

namespace SIR {
struct CloneVisitor : Visitor {
    pVal curr_val = nullptr;
    std::stack<IList *> ilist_stack;
    std::stack<std::vector<pHelper>> break_continue_stack;

    // SIR has no phi. Therefore, if we do a pre-order traversal, one's operands
    // will become visible before cloning the user.
    std::map<pInst, pInst> old2new_inst;
    std::map<pFormalParam, pFormalParam> old2new_param;

    CloneVisitor() = default;

    // Clone LinearFunction
    void visit(LinearFunction &lfunc) override {
        // 1. Clone parameters
        std::vector<pFormalParam> new_params;
        for (const auto &param : lfunc.getParams()) {
            auto new_p = makeClone(param);
            old2new_param[param] = new_p;
            new_params.push_back(new_p);
        }
        // 2. Create new function skeleton
        auto cloned_fn =
            std::make_shared<LinearFunction>(lfunc.getName() + "_clone", new_params,
                                             lfunc.getType()->as<FunctionType>()->getRet(), &lfunc.getConstantPool());

        // 3. Set up stacks
        ilist_stack.push(&cloned_fn->getInsts());

        // 4. Visit body
        Visitor::visit(lfunc);

        ilist_stack.pop();

        curr_val = cloned_fn;
    }

    void visit(Instruction &inst) override {
        if (inst.is<IFInst, WHILEInst, FORInst, CONDValue>()) {
            Visitor::visit(inst);
            return;
        }
        // Non-helper instruction (leaf node)
        auto sinst = inst.as<Instruction>();
        auto cloned = makeClone(sinst);
        old2new_inst[sinst] = cloned;
        // Remap operands
        for (size_t i = 0; i < inst.getNumOperands(); ++i) {
            auto oper = inst.getOperand(i)->getValue();
            cloned->getOperand(i)->setValue(remapValue(oper));
        }

        static size_t name_cnt = 0;
        cloned->setName(inst.getName() + ".dup" + std::to_string(name_cnt++));
        if (!ilist_stack.empty())
            ilist_stack.top()->emplace_back(cloned);
        curr_val = cloned;

        if (cloned->is<BREAKInst, CONTINUEInst>())
            break_continue_stack.top().push_back(cloned->as<HELPERInst>());
    }

    // Cond value
    void visit(CONDValue &cond) override {
        auto new_lhs = remapValue(cond.getLHS());

        IList new_rhs_insts;
        ilist_stack.push(&new_rhs_insts);
        for (const auto &ri : cond.getRHSInsts())
            visit(*ri);
        ilist_stack.pop();

        auto new_rhs = remapCond(cond.getRHS());

        pCondValue new_cond;
        if (cond.getCondType() == CONDTY::AND)
            new_cond = std::make_shared<ANDValue>(new_lhs, new_rhs, new_rhs_insts);
        else
            new_cond = std::make_shared<ORValue>(new_lhs, new_rhs, new_rhs_insts);

        if (new_lhs->is<CONDValue>())
            new_cond->setLHSMemHolder(new_lhs);
        if (new_rhs->is<CONDValue>())
            new_cond->setRHSMemHolder(new_rhs);

        curr_val = new_cond;
    }

    void visit(IFInst &if_inst) override {
        auto new_cond = remapCond(if_inst.getCond());

        IList new_body, new_else;
        // Body
        ilist_stack.push(&new_body);
        for (const auto &inst : if_inst.getBodyInsts())
            visit(*inst);
        ilist_stack.pop();
        // Else
        ilist_stack.push(&new_else);
        for (const auto &inst : if_inst.getElseInsts())
            visit(*inst);
        ilist_stack.pop();

        auto new_if = std::make_shared<IFInst>(new_cond, std::move(new_body), std::move(new_else));
        if (!ilist_stack.empty())
            ilist_stack.top()->emplace_back(new_if);
        if (new_cond->is<CONDValue>())
            new_if->setMemHolder(new_cond);
        curr_val = new_if;
    }

    void visit(WHILEInst &while_inst) override {
        IList new_cond_insts, new_body;
        ilist_stack.push(&new_cond_insts);
        for (const auto &inst : while_inst.getCondInsts())
            visit(*inst);
        ilist_stack.pop();

        auto new_cond = remapCond(while_inst.getCond());

        break_continue_stack.push({});
        ilist_stack.push(&new_body);
        for (const auto &inst : while_inst.getBodyInsts())
            visit(*inst);
        ilist_stack.pop();

        auto new_while = std::make_shared<WHILEInst>(new_cond, std::move(new_cond_insts), std::move(new_body));
        if (!ilist_stack.empty())
            ilist_stack.top()->emplace_back(new_while);
        if (new_cond->is<CONDValue>())
            new_while->setMemHolder(new_cond);
        curr_val = new_while;

        for (const auto &cb : break_continue_stack.top()) {
            if (auto break_inst = cb->as<BREAKInst>())
                break_inst->setLoop(new_while);
            else if (auto cont_inst = cb->as<CONTINUEInst>())
                cont_inst->setLoop(new_while);
        }
        break_continue_stack.pop();
    }

    void visit(FORInst &for_inst) override {
        auto orig_mem = for_inst.getIndVar()->getOrigMem();
        pVal new_orig_mem = orig_mem;
        if (auto mem_inst = orig_mem->as<Instruction>()) {
            if (old2new_inst.count(mem_inst))
                new_orig_mem = old2new_inst[mem_inst]->as<Instruction>();
        }
        auto new_base = remapValue(for_inst.getBase());
        auto new_bound = remapValue(for_inst.getBound());
        auto new_step = remapValue(for_inst.getStep());
        static size_t name_cnt = 0;
        auto iv_name = for_inst.getIndVar()->getName() + ".dup" + std::to_string(name_cnt++);
        auto new_iv = std::make_shared<IndVar>(iv_name, new_orig_mem, new_base, new_bound, new_step,
                                               for_inst.getIndVar()->getDepth());

        old2new_inst[for_inst.getIndVar()] = new_iv;

        break_continue_stack.push({});
        IList new_body;
        ilist_stack.push(&new_body);
        for (const auto &inst : for_inst.getBodyInsts())
            visit(*inst);
        ilist_stack.pop();

        auto new_for = std::make_shared<FORInst>(new_iv, std::move(new_body));
        if (!ilist_stack.empty())
            ilist_stack.top()->emplace_back(new_for);
        curr_val = new_for;

        for (const auto &cb : break_continue_stack.top()) {
            if (auto break_inst = cb->as<BREAKInst>())
                break_inst->setLoop(new_for);
            else if (auto cont_inst = cb->as<CONTINUEInst>())
                cont_inst->setLoop(new_for);
        }
        break_continue_stack.pop();
    }

    void visit(Value &value) override {
        if (value.is<CONDValue>())
            visit(value.as_ref<CONDValue>());
        else if (value.is<Instruction>())
            visit(value.as_ref<Instruction>());
        else
            curr_val = value.as<Value>();
    }

    pVal remapValue(const pVal &val) {
        if (auto val_inst = val->as<Instruction>()) {
            auto it = old2new_inst.find(val_inst);
            if (it == old2new_inst.end())
                return val;
            return it->second;
        }
        if (auto val_fp = val->as<FormalParam>()) {
            auto it = old2new_param.find(val_fp);
            if (it == old2new_param.end())
                return val;
            return it->second;
        }
        return val;
    }

    pVal remapCond(const pVal &val) {
        if (auto cond = val->as<CONDValue>()) {
            visit(*cond);
            return curr_val;
        }
        return remapValue(val);
    }
};
} // namespace SIR

#endif
