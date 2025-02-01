#include "../../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../../include/utils/exception.hpp"

namespace IR {
    void PromotePass::analyseAlloca() {
        for (const auto& inst : entry_block->getInsts()) {
            if (inst->getOpcode() == OP::ALLOCA) {
                const auto alloca_inst = std::dynamic_pointer_cast<ALLOCAInst>(inst);
                ALLOCA_INFO info = {alloca_inst};
                bool promotable = true;
                // 遍历所有User, 只接受LOAD, STORE语句
                for (const auto& use : inst->getUseList()) {
                    const auto user = use->getUser()->shared_from_this();
                    // 这里前提是所有的ORDINARY_VARIABLE都是INSTRUCTION
                    if (user->getVTrait() == ValueTrait::ORDINARY_VARIABLE
                        && std::dynamic_pointer_cast<Instruction>(user)->getOpcode() == OP::LOAD) {
                        info.loads.emplace_back(std::dynamic_pointer_cast<LOADInst>(user));
                    } else if (user->getVTrait() == ValueTrait::VOID_INSTRUCTION
                               && std::dynamic_pointer_cast<Instruction>(user)->getOpcode() == OP::STORE) {
                        info.stores.emplace_back(std::dynamic_pointer_cast<STOREInst>(user));
                    } else {
                        promotable = false;
                        break;
                    }
                }
                if (promotable) {
                    alloca_infos.push(info);
                }
            }
        }
    }

    bool PromotePass::removeUnusedAlloca() {
        if (auto cur_info =  alloca_infos.front(); cur_info.loads.empty()) {
            for (auto & store : cur_info.stores) {
                store->getParent()->delFirstOfInst(store);
            }
            entry_block->delFirstOfInst(cur_info.alloca);
            return true;
        }
        return false;
    }

    // todo: store前load
    bool PromotePass::rewriteSingleStoreAlloca() {
        if (auto cur_info =  alloca_infos.front(); cur_info.stores.size() == 1) {
            std::shared_ptr<Value> store_val = cur_info.stores.front()->getValue();
            for (auto & load : cur_info.loads) {
                // for (const auto & use : load->getUseList()) {
                //     use->getUser()->replaceUse(load, store_val);
                // }
                load->replaceSelf(store_val);
                load->getParent()->delFirstOfInst(load);
            }
            entry_block->delFirstOfInst(cur_info.alloca);
            return true;
        }
        return false;
    }

    bool PromotePass::promoteSingleBlockAlloca() {
        return false;
    }

    void PromotePass::promoteMemoryToRegister(Function &function) {
        entry_block = function.getBlocks().front();
        Err::gassert(entry_block->isName("entry") , "First block is not named entry");

        analyseAlloca();

        while (!alloca_infos.empty()) {
            if (removeUnusedAlloca()) {
            }
            else if (rewriteSingleStoreAlloca()) {
            }
            // todo
            alloca_infos.pop();
        }
    }

    PM::PreservedAnalyses PromotePass::run(Function &function, FAM &manager) {
        promoteMemoryToRegister(function);
        // todo
    }
}
