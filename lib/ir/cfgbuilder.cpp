/**
 * @attention 默认删除块中 break; continue; 后的所有指令
 **/

#include "ir/cfgbuilder.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/helper.hpp"
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

    auto ifthen = std::make_shared<BasicBlock>(nam.getIfthen());
    auto ifelse = std::make_shared<BasicBlock>(nam.getIfelse());
    auto ifend = std::make_shared<BasicBlock>(nam.getIfend());

    // if (!el) nam.ifelseidx--; // 为避免出错，直接不回溯了

    if (el)
        addCondBr(ifinst->getCond(), ifthen, ifelse);
    else
        addCondBr(ifinst->getCond(), ifthen, ifend);

    cur_blk = ifthen;
    cur_making_func->addBlock(cur_blk);
    auto it = ifinst->getBodyInsts().begin();
    if (!adder(it, ifinst->getBodyInsts().end(), true))
        cur_blk->addInst(std::make_shared<BRInst>(ifend));

    if (el) {
        cur_blk = ifelse;
        cur_making_func->addBlock(cur_blk);
        it = ifinst->getElseInsts().begin();
        if (!adder(it, ifinst->getElseInsts().end(), true))
            cur_blk->addInst(std::make_shared<BRInst>(ifend));
    }

    cur_blk = ifend;
    cur_making_func->addBlock(cur_blk);
}

void CFGBuilder::newWh(const std::shared_ptr<WHILEInst> &whinst) {
    auto whcond = std::make_shared<BasicBlock>(nam.getWhcond());
    auto whbody = std::make_shared<BasicBlock>(nam.getWhbody());
    auto whend = std::make_shared<BasicBlock>(nam.getWhend());
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
    if (auto it = whinst->getBodyInsts().begin(); !adder(it, whinst->getBodyInsts().end(), true))
        cur_blk->addInst(std::make_shared<BRInst>(whcond));

    cur_blk = whend;
    cur_making_func->addBlock(cur_blk);

    _while_cond_for_continue.pop();
    _while_end_for_break.pop();
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
