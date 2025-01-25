/**
 * @attention 默认删除块中break; continue; 后的所有指令
**/

#include "../../../include/passes/transforms/cfgbuilder.hpp"
#include "../../../include/ir/utilities.hpp"
#include "../../../include/utils/logger.hpp"

namespace IR {

PreservedAnalyses BuildCFGPass::run(Function& function, FunctionAnalysisManager& manager) {
    cur_func = &function;
    divider();
    linker();
    return PreservedAnalyses::none();
}

    // !!!需要尽量确保第一个BB是entry, 最后一个是return
    void BuildCFGPass::divider() {
        cur_blk = std::make_shared<BasicBlock>("%entry");
        cur_func->addBlock(cur_blk);
        // Only by doing so can get const_iterator...
        const auto& fkinst = cur_func->getInsts();
        auto inst_it = fkinst.begin();
        adder(inst_it, fkinst.end(), false);
        nam.reset();
    }

    void BuildCFGPass::newIf(const std::shared_ptr<IFInst>& ifinst) {
        const bool el = ifinst->hasElse();

        auto ifthen = std::make_shared<BasicBlock>(nam.getIfthen());
        auto ifelse = std::make_shared<BasicBlock>(nam.getIfelse());
        auto ifend = std::make_shared<BasicBlock>(nam.getIfend());

        // if (!el) nam.ifelseidx--; // 为避免出错，直接不回溯了

        if (el) addCondBr(ifinst->getCond(), ifthen, ifelse);
        else addCondBr(ifinst->getCond(), ifthen, ifend);

        cur_blk = ifthen;
        cur_func->addBlock(cur_blk);
        auto it = ifinst->getBodyInsts().begin();
        if (!adder(it, ifinst->getBodyInsts().end(), true)) cur_blk->addInst(std::make_shared<BRInst>(ifend));

        if (el) {
            cur_blk = ifelse;
            cur_func->addBlock(cur_blk);
            it = ifinst->getElseInsts().begin();
            if (!adder(it, ifinst->getElseInsts().end(), true)) cur_blk->addInst(std::make_shared<BRInst>(ifend));
        }

        cur_blk = ifend;
        cur_func->addBlock(cur_blk);
    }

    void BuildCFGPass::newWh(const std::shared_ptr<WHILEInst>& whinst) {
        auto whcond = std::make_shared<BasicBlock>(nam.getWhcond());
        auto whbody = std::make_shared<BasicBlock>(nam.getWhbody());
        auto whend = std::make_shared<BasicBlock>(nam.getWhend());
        _while_cond_for_continue.push(whcond);
        _while_end_for_break.push(whend);

        cur_blk->addInst(std::make_shared<BRInst>(whcond));

        cur_blk = whcond;
        cur_func->addBlock(cur_blk);
        for (auto& cond : whinst->getCondInsts()) {
            cur_blk->addInst(cond);
        }

        addCondBr(whinst->getCond(), whbody, whend);

        cur_blk = whbody;
        cur_func->addBlock(cur_blk);
        if (auto it = whinst->getBodyInsts().begin(); !adder(it, whinst->getBodyInsts().end(), true))
            cur_blk->addInst(std::make_shared<BRInst>(whcond));

        cur_blk = whend;
        cur_func->addBlock(cur_blk);

        _while_cond_for_continue.pop();
        _while_end_for_break.pop();
    }

    // link basic blocks by prevBB and nextBB
    void BuildCFGPass::linker() {
        for (auto blk_it = cur_func->getBlocks().begin(); blk_it != cur_func->getBlocks().end(); ++blk_it) {
            if ((*blk_it)->getInsts().empty()) continue;
            switch (std::shared_ptr<Instruction> end_inst = (*blk_it)->getInsts().back(); end_inst->getOpcode()) {
                case OP::BR:
                {
                    if (const auto inst = std::dynamic_pointer_cast<BRInst>(end_inst); inst->isConditional()) {
                        linkBB(*blk_it, inst->getTrueDest());
                        linkBB(*blk_it, inst->getFalseDest());
                    } else {
                        linkBB(*blk_it, inst->getDest());
                    }
                    break;
                }
                case OP::RET:
                    break;
                default:
                    auto next_blk = std::next(blk_it);
                    if (next_blk != cur_func->getBlocks().end()) {
                        linkBB(*blk_it, *next_blk);
                    }
                    break;
            }
        }

        // link完了之后，遍历基本块，查找空块和不可达的块并删除
        for (auto it = cur_func->getBlocks().begin(); it != cur_func->getBlocks().end(); ) {
            // 删除不可达块
            if ((*it)->getPreBB().empty() && it != cur_func->getBlocks().begin()) {
                for (auto nextbb: (*it)->getNextBB()) {
                    WeakListDel(nextbb->getRPreBB(), *it);
                }
                it = cur_func->getBlocks().erase(it);
                continue;
            }
            // 删除空块
            if ((*it)->getInsts().empty()) {
                // 遍历user去替换为他的prebb中的br
                // 非结尾块的情况，prebb的br替换为惟一nextbb
                if ((*it)->getNextBB().size() == 1) {
                    auto nxt = (*it)->getNextBB().front();
                    for (auto prebb : (*it)->getPreBB()) {
                        if (prebb->getInsts().back()->getOpcode() == OP::BR) {
                            auto brinst = std::dynamic_pointer_cast<BRInst>(prebb->getInsts().back());
                            Err::gassert(brinst != nullptr, "CFGBuilder::linker(): can't cast BRInst");
                            brinst->replaceUse(*it, nxt); // 改 br
                        }
                        WeakListReplace(prebb->getRNextBB(), *it, nxt); //改nextbb
                        WeakListReplace(nxt->getRPreBB(), *it, prebb); // 改prebb
                    }
                    it = cur_func->getBlocks().erase(it);
                } else if ((*it)->getNextBB().size() == 0) {
                    // 结尾块
                    if (toBType(toFunctionType(cur_func->getType())->getRet())->getInner() == IRBTYPE::VOID) {
                        (*it)->addInst(std::make_shared<RETInst>());
                    }
                    else {
                        Err::unreachable("CFGBuilder::linker(): invalid function type.");
                    }
                    ++it;
                } else {
                    Err::unreachable("CFGBuilder::linker(): empty block has multiple next block.");
                }
                continue;
            }
            ++it;
        }
    }

    bool BuildCFGPass::adder(std::vector<std::shared_ptr<IR::Instruction> >::const_iterator &it
                             , const std::vector<std::shared_ptr<IR::Instruction> >::const_iterator &end
                             , const bool allow_break)
    {
        bool inserted_terminator = false;
        for ( ; it!=end && !inserted_terminator; ++it) {
            if ((*it)->getOpcode() == OP::HELPER) {
                switch(std::shared_ptr<HELPERInst> helper = std::dynamic_pointer_cast<HELPERInst>(*it); helper->getHlpType()) {
                    case HELPERTY::IF:
                        newIf(std::dynamic_pointer_cast<IFInst>(helper));
                        break;
                    case HELPERTY::WHILE:
                        newWh(std::dynamic_pointer_cast<WHILEInst>(helper));
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
    void BuildCFGPass::short_circuit_process(const std::shared_ptr<CONDValue> &cond,
                                       const std::shared_ptr<BasicBlock> &true_blk,
                                       const std::shared_ptr<BasicBlock> &false_blk) {
        if (cond->getCondType() == CONDTY::AND) {
            const auto land = std::dynamic_pointer_cast<ANDValue>(cond);
            auto landlt = std::make_shared<BasicBlock>(nam.getLandlt()); //land lhs true
            addCondBr(land->getLHS(), landlt, false_blk);
            cur_blk = landlt;
            cur_func->addBlock(cur_blk);
            for (const auto& rhsinst : land->getRHSInsts()) {
                cur_blk->addInst(rhsinst);
            }
            addCondBr(land->getRHS(), true_blk, false_blk);
        } else if (cond->getCondType() == CONDTY::OR) {
            const auto lor = std::dynamic_pointer_cast<ORValue>(cond);
            auto lorlf = std::make_shared<BasicBlock>(nam.getLorlf()); // lor lhs false
            addCondBr(lor->getLHS(), true_blk, lorlf);
            cur_blk = lorlf;
            cur_func->addBlock(cur_blk);
            for (const auto& rhsinst : lor->getRHSInsts()) {
                cur_blk->addInst(rhsinst);
            }
            addCondBr(lor->getRHS(), true_blk, false_blk);
        } else {
            Err::unreachable("CFGBuilder::short_circuit_process: Invalid condition type.");
        }
    }

    void BuildCFGPass::addCondBr(const std::shared_ptr<Value> &cond,
                                const std::shared_ptr<BasicBlock> &true_blk,
                                const std::shared_ptr<BasicBlock> &false_blk) {
        if (cond->getVTrait() == ValueTrait::CONDHELPER) {
            const auto cond_value = std::dynamic_pointer_cast<CONDValue>(cond);
            Err::gassert(cond_value != nullptr, "CFGBuilder::addCondBr: CONDValue cast failed.");
            short_circuit_process(cond_value, true_blk, false_blk);
        } else {
            cur_blk->addInst(std::make_shared<BRInst>(cond, true_blk, false_blk));
        }
    }
}
