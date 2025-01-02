#include "../../include/irvisitors/cfgbuilder.hpp"
#include "../../include/utils/logger.hpp"

namespace IR {
    void CFGBuilder::build(Module& module) {
        Logger::logInfo("Building CFG For Module " + module.getName() + "...");
        for (auto& func : module.getFunctions()) {
            Logger::logDebug("Building CFG For Function " + func->getName() + "...");
            divider(*func);
            linker(*func);
        }
        Logger::logInfo("CFG For Module " + module.getName() + " Built.");
    }

    // !!!需要尽量确保第一个BB是entry, 最后一个是return
    void CFGBuilder::divider(Function& func) {
        inst_it = func.getInsts().begin();
        std::shared_ptr<BasicBlock> cur_blk;
        
        while (inst_it != func.getInsts().end()) {
            if(isTerminator()) {
                // todo
            } else {
                if(cur_blk == nullptr) {
                    cur_blk = std::make_shared<BasicBlock>(getNewBBName());
                    func.addBlock(cur_blk);
                }
                cur_blk->addInst(*inst_it);
                // (*inst_it)->setParent(cur_blk); // 写入addInst()中
                inst_it++;
            }
        }
        resetBBIdx();
    }

    // link basic blocks by prevBB and nextBB
    void CFGBuilder::linker(Function& func) {
        for (auto blk_it = func.getBlocks().begin(); blk_it != func.getBlocks().end(); blk_it++) {
            if ((*blk_it)->getInsts().empty()) continue;
            std::shared_ptr<Instruction> end_inst = (*blk_it)->getInsts().back();
            switch (end_inst->getOpcode()) {
                case OP::BR:
                {
                    auto inst = std::dynamic_pointer_cast<BRInst>(end_inst);
                    if (inst->isConditional()) {
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
                    if (next_blk != func.getBlocks().end()) {
                        linkBB(*blk_it, *next_blk);
                    }
                    break;
            }
        }
    }

    bool CFGBuilder::isTerminator() {
        // todo
        return false;
    }

    void CFGBuilder::resetBBIdx() {
        bb_idx = 0;
    }

    std::string CFGBuilder::getNewBBName() {
        if (bb_idx != 0) {
            return "b" + std::to_string(bb_idx++);
        } else {
            bb_idx++;
            return "entry";
        }
    }

}