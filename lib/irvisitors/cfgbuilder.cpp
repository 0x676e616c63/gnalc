/**
 * @attention 默认删除块中break; continue; 后的所有指令
**/

#include "../../include/irvisitors/cfgbuilder.hpp"
#include "../../include/utils/logger.hpp"

namespace IR {
    void CFGBuilder::build(const Module& module) {
        Logger::logInfo("Building CFG For Module " + module.getName() + "...");
        for (auto& func : module.getFunctions()) {
            Logger::logDebug("Building CFG For Function " + func->getName() + "...");
            cur_func = func;
            divider();
            linker();
        }
        Logger::logInfo("CFG For Module " + module.getName() + " Built.");
    }

    // !!!需要尽量确保第一个BB是entry, 最后一个是return
    void CFGBuilder::divider() {
        cur_blk = std::make_shared<BasicBlock>("%entry");
        cur_func->addBlock(cur_blk);
        // Only by doing so can get const_iterator...
        const auto& fkinst = cur_func->getInsts();
        auto inst_it = fkinst.begin();
        adder(inst_it, fkinst.end(), false);
        nam.reset();
    }

    void CFGBuilder::newIf(const std::shared_ptr<IFInst>& ifinst) {
        const bool el = ifinst->hasElse();

        auto ifthen = std::make_shared<BasicBlock>(nam.getIfthen());
        auto ifelse = std::make_shared<BasicBlock>(nam.getIfelse());
        auto ifend = std::make_shared<BasicBlock>(nam.getIfend());

        if (ifinst->getCond()->getVTrait() == ValueTrait::HELPER) {
            const auto cond = std::dynamic_pointer_cast<CONDValue>(ifinst->getCond());
            if (el) short_circuit_process(cond, ifthen, ifelse);
            else short_circuit_process(cond, ifthen, ifend);
        } else {
            if (el) cur_blk->addInst(std::make_shared<BRInst>(ifinst->getCond(), ifthen, ifelse));
            else cur_blk->addInst(std::make_shared<BRInst>(ifinst->getCond(), ifthen, ifend));
        }

        cur_blk = ifthen;
        cur_func->addBlock(cur_blk);
        auto it = ifinst->getBodyInsts().begin();
        if (!adder(it, ifinst->getBodyInsts().end(), true)) cur_blk->addInst(std::make_shared<BRInst>(ifend));

        if (el) {
            cur_blk = ifelse;
            cur_func->addBlock(cur_blk);
            it = ifinst->getElseInsts().begin();
            if (!adder(it, ifinst->getElseInsts().end(), true)) cur_blk->addInst(std::make_shared<BRInst>(ifend));
        } else {
            nam.ifelseidx--;
        }

        cur_blk = ifend;
        cur_func->addBlock(cur_blk);
    }

    void CFGBuilder::newWh(const std::shared_ptr<WHILEInst>& whinst) {
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
        cur_blk->addInst(std::make_shared<BRInst>(whinst->getCond(), whbody, whend));

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
    void CFGBuilder::linker() const {
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
    }

    bool CFGBuilder::adder(std::vector<std::shared_ptr<IR::Instruction> >::const_iterator &it
                           , const std::vector<std::shared_ptr<IR::Instruction> >::const_iterator &end
                           , const bool allow_break)
    {
        bool insert_br = false;
        for ( ; it!=end && !insert_br; ++it) {
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
                        insert_br = true;
                        break;
                    case HELPERTY::CONTINUE:
                        Err::gassert(allow_break, "CFGBuilder: continue in invalid block.");
                        Err::gassert(!_while_cond_for_continue.empty(), "CFGBuilder: stack while_cond_for_continue is empty!");
                        cur_blk->addInst(std::make_shared<BRInst>(_while_cond_for_continue.top()));
                        insert_br = true;
                        break;
                    default:
                        Err::unreachable("CFGBuilder::adder: Invalid HELPERInst type");
                }
            } else {
                cur_blk->addInst(*it);
            }
        }
        return insert_br;
    }

    void CFGBuilder::short_circuit_process(const std::shared_ptr<CONDValue> &cond,
                                       const std::shared_ptr<BasicBlock> &true_blk,
                                       const std::shared_ptr<BasicBlock> &false_blk) {
        if (cond->getCondType() == CONDTY::AND) {
            const auto land = std::dynamic_pointer_cast<ANDValue>(cond);
            auto landlt = std::make_shared<BasicBlock>(nam.getLandlt()); //land lhs true
            cur_blk->addInst(std::make_shared<BRInst>(land->getLHS(), landlt, false_blk));
            // todo: move rhs calculate inst to landlt blk
            cur_blk = landlt;
            cur_func->addBlock(cur_blk);
            cur_blk->addInst(std::make_shared<BRInst>(land->getRHS(), true_blk, false_blk));
        }
    }

}