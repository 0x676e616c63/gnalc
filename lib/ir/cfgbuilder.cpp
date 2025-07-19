// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @attention 默认删除块中 break; continue; 后的所有指令
 **/

#include "ir/cfgbuilder.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/helper.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/module.hpp"
#include "ir/type_alias.hpp"
#include "utils/misc.hpp"

using namespace IR;
namespace IR {
void CFGBuilder::build(Module &module) {
    for (auto &f : module.linear_funcs) {
        cur_linear_func = f;
        cur_making_func = std::make_shared<Function>(cur_linear_func->getName(), cur_linear_func->getParams(),
                                                     cur_linear_func->getType()->as<FunctionType>()->getRet(),
                                                     &cur_linear_func->getConstantPool(), cur_linear_func->getAttrs());
        cur_making_func->setParent(cur_linear_func->getParent());
        Err::gassert(cur_linear_func != nullptr, "Expected Linear IR.");
        divider();
        cur_making_func->updateAndCheckCFG();

        f->replaceSelf(cur_making_func);

        module.addFunction(cur_making_func);
        cur_making_func->updateAllIndex();
    }

    module.linear_funcs.clear();
    cur_linear_func = nullptr;
    cur_making_func = nullptr;
    cur_blk = nullptr;
    _while_cond_for_continue = {};
    _while_end_for_break = {};
}

// !!!需要尽量确保第一个BB是entry, 最后一个是return
void CFGBuilder::divider() {
    cur_blk = std::make_shared<BasicBlock>("%entry");
    cur_making_func->addBlock(cur_blk);
    // `adder` expects a `const_iterator&`, so make it a lvalue
    auto inst_it = cur_linear_func->cbegin();
    adder(inst_it, cur_linear_func->cend(), false);
    nam.reset();
}

void CFGBuilder::newIf(const pIfInst &ifinst) {
    const bool el = ifinst->hasElse();

    auto ifthen = std::make_shared<BasicBlock>(nam.getIfThen());
    auto ifelse = std::make_shared<BasicBlock>(nam.getIfElse());
    auto ifend = std::make_shared<BasicBlock>(nam.getIfEnd());

    // if (!el) nam.ifelseidx--; // 为避免出错，直接不回溯了

    if (el)
        addCondBr(ifinst->getCond(), ifthen, ifelse);
    else
        addCondBr(ifinst->getCond(), ifthen, ifend);

    cur_blk = ifthen;
    cur_making_func->addBlock(cur_blk);
    auto it = ifinst->getBodyInsts().cbegin();
    if (!adder(it, ifinst->getBodyInsts().cend(), true))
        cur_blk->addInst(std::make_shared<BRInst>(ifend));

    if (el) {
        cur_blk = ifelse;
        cur_making_func->addBlock(cur_blk);
        it = ifinst->getElseInsts().begin();
        if (!adder(it, ifinst->getElseInsts().cend(), true))
            cur_blk->addInst(std::make_shared<BRInst>(ifend));
    }

    cur_blk = ifend;
    cur_making_func->addBlock(cur_blk);
}

void CFGBuilder::newWh(const pWhileInst &whinst) {
    auto whcond = std::make_shared<BasicBlock>(nam.getWhCond());
    auto whbody = std::make_shared<BasicBlock>(nam.getWhBody());
    auto whend = std::make_shared<BasicBlock>(nam.getWhEnd());
    _while_cond_for_continue.push(whcond);
    _while_end_for_break.push(whend);

    cur_blk->addInst(std::make_shared<BRInst>(whcond));

    cur_blk = whcond;
    cur_making_func->addBlock(cur_blk);
    for (auto &cond : whinst->getCondInsts()) {
        cur_blk->addInst(cond);
    }

    addCondBr(whinst->getCond(), whbody, whend);

    cur_blk = whbody;
    cur_making_func->addBlock(cur_blk);
    if (auto it = whinst->getBodyInsts().cbegin(); !adder(it, whinst->getBodyInsts().cend(), true))
        cur_blk->addInst(std::make_shared<BRInst>(whcond));

    cur_blk = whend;
    cur_making_func->addBlock(cur_blk);

    _while_cond_for_continue.pop();
    _while_end_for_break.pop();
}

void CFGBuilder::newFor(const pForInst & for_inst) {
    auto for_cond = std::make_shared<BasicBlock>(nam.getForCond());
    auto for_body = std::make_shared<BasicBlock>(nam.getForBody());
    auto for_end = std::make_shared<BasicBlock>(nam.getForEnd());

    auto for_preheader = cur_blk;
    for_preheader->addInst(std::make_shared<BRInst>(for_cond));

    cur_blk = for_cond;
    cur_making_func->addBlock(for_cond);
    auto indvar = for_inst->getIndVar();
    auto phi = std::make_shared<PHIInst>(nam.getForIndVar(), indvar->getType());
    // Store to original alloca to fix outside loop uses of the induction variable.
    // mem2reg will finally eliminate such store.
    auto store = std::make_shared<STOREInst>(phi, indvar->getOrigAlloc());
    auto icmp = std::make_shared<ICMPInst>(phi->getName() + ".cmp", ICMPOP::slt, phi, indvar->getBound());
    auto for_br = std::make_shared<BRInst>(icmp, for_body, for_end);

    for_cond->addPhiInst(phi);
    for_cond->addInst(store);
    for_cond->addInst(icmp);
    for_cond->addInst(for_br);

    cur_blk = for_body;
    cur_making_func->addBlock(for_body);
    if (auto it = for_inst->getBodyInsts().cbegin(); !adder(it, for_inst->getBodyInsts().cend(), false))
        cur_blk->addInst(std::make_shared<BRInst>(for_cond));

    // Insert update insts
    auto update = std::make_shared<BinaryInst>(phi->getName() + ".update", OP::ADD, phi, indvar->getStep());
    cur_blk->addInstBeforeTerminator(update);

    phi->addPhiOper(indvar->getBase(), for_preheader);
    phi->addPhiOper(update, cur_blk);
    indvar->replaceSelf(phi);

    cur_blk = for_end;
    cur_making_func->addBlock(for_end);
}


bool CFGBuilder::adder(std::list<pInst>::const_iterator &it, const std::list<pInst>::const_iterator &end,
                       const bool allow_break) {
    bool inserted_terminator = false;
    for (; it != end && !inserted_terminator; ++it) {
        if ((*it)->getOpcode() == OP::HELPER) {
            switch (auto helper = (*it)->as<HELPERInst>(); helper->getHlpType()) {
            case HELPERTY::IF:
                newIf(helper->as<IFInst>());
                break;
            case HELPERTY::WHILE:
                newWh(helper->as<WHILEInst>());
                break;
            case HELPERTY::FOR:
                newFor(helper->as<FORInst>());
                break;
            case HELPERTY::BREAK:
                Err::gassert(allow_break, "CFGBuilder: break in invalid block.");
                Err::gassert(!_while_end_for_break.empty(), "CFGBuilder: stack while_end_for_break is empty!");
                cur_blk->addInst(std::make_shared<BRInst>(_while_end_for_break.top()));
                inserted_terminator = true;
                break;
            case HELPERTY::CONTINUE:
                Err::gassert(allow_break, "CFGBuilder: continue in invalid block.");
                Err::gassert(!_while_cond_for_continue.empty(), "CFGBuilder: stack while_cond_for_continue is empty!");
                cur_blk->addInst(std::make_shared<BRInst>(_while_cond_for_continue.top()));
                inserted_terminator = true;
                break;
            default:
                Err::unreachable("CFGBuilder::adder: Invalid HELPERInst type");
            }
        } else {
            cur_blk->addInst(*it);
            if ((*it)->getOpcode() == OP::RET) {
                inserted_terminator = true;
            }
        }
    }
    return inserted_terminator;
}

// 处理完整个的cond
void CFGBuilder::short_circuit_process(const pCondValue &cond, const pBlock &true_blk, const pBlock &false_blk) {
    if (cond->getCondType() == CONDTY::AND) {
        const auto land = cond->as<ANDValue>();
        auto landlt = std::make_shared<BasicBlock>(nam.getLandlt()); // land lhs true
        addCondBr(land->getLHS(), landlt, false_blk);
        cur_blk = landlt;
        cur_making_func->addBlock(cur_blk);
        for (const auto &rhsinst : land->getRHSInsts()) {
            cur_blk->addInst(rhsinst);
        }
        addCondBr(land->getRHS(), true_blk, false_blk);
    } else if (cond->getCondType() == CONDTY::OR) {
        const auto lor = cond->as<ORValue>();
        auto lorlf = std::make_shared<BasicBlock>(nam.getLorlf()); // lor lhs false
        addCondBr(lor->getLHS(), true_blk, lorlf);
        cur_blk = lorlf;
        cur_making_func->addBlock(cur_blk);
        for (const auto &rhsinst : lor->getRHSInsts()) {
            cur_blk->addInst(rhsinst);
        }
        addCondBr(lor->getRHS(), true_blk, false_blk);
    } else {
        Err::unreachable("CFGBuilder::short_circuit_process: Invalid condition type.");
    }
}

void CFGBuilder::addCondBr(const pVal &cond, const pBlock &true_blk, const pBlock &false_blk) {
    if (cond->getVTrait() == ValueTrait::CONDHELPER) {
        const auto cond_value = cond->as<CONDValue>();
        Err::gassert(cond_value != nullptr, "CFGBuilder::addCondBr: CONDValue cast failed.");
        short_circuit_process(cond_value, true_blk, false_blk);
    } else {
        cur_blk->addInst(std::make_shared<BRInst>(cond, true_blk, false_blk));
    }
}
} // namespace IR
