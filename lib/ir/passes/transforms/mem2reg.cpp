#include "../../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../../include/utils/exception.hpp"

namespace IR {
bool PromotePass::iADomB(const std::shared_ptr<Instruction>& ia, const std::shared_ptr<Instruction>& ib) {
    if (ia->getParent() == ib->getParent()) {
        return ia->getParent()->getInstIndex(ia) < ib->getParent()->getInstIndex(ib);
    }
    return DT.ADomB(ia->getParent(), ib->getParent());
}

void PromotePass::analyseAlloca() {
    for (const auto &inst : entry_block->getInsts()) {
        if (inst->getOpcode() == OP::ALLOCA) {
            const auto alloca_inst =
                std::dynamic_pointer_cast<ALLOCAInst>(inst);
            ALLOCA_INFO info = {alloca_inst};
            bool promotable = true;
            // 遍历所有User, 只接受LOAD, STORE语句
            for (const auto &use : inst->getUseList()) {
                const auto user = use->getUser()->shared_from_this();
                // Attention: 这里前提是所有的ORDINARY_VARIABLE都是INSTRUCTION
                if (user->getVTrait() == ValueTrait::ORDINARY_VARIABLE ||
                    user->getVTrait() == ValueTrait::VOID_INSTRUCTION) {
                    auto inst_user = std::dynamic_pointer_cast<Instruction>(user);
                    if (inst_user->getOpcode() == OP::LOAD) {
                        auto load = std::dynamic_pointer_cast<LOADInst>(inst_user);
                        info.loads.emplace_back(load);
                        info.user_blocks[load->getParent()].load_map[inst_user->getParent()->getInstIndex(inst_user)] = load;
                    } else if (inst_user->getOpcode() == OP::STORE) {
                        auto store = std::dynamic_pointer_cast<STOREInst>(inst_user);
                        info.stores.emplace_back(store);
                        info.user_blocks[store->getParent()].store_map[inst_user->getParent()->getInstIndex(inst_user)] = store;
                    } else {
                        promotable = false;
                        break;
                    }
                    } else {
                        promotable = false;
                        break;
                    }
                // if (user->getVTrait() == ValueTrait::ORDINARY_VARIABLE &&
                //     std::dynamic_pointer_cast<Instruction>(user)->getOpcode() ==
                //         OP::LOAD) {
                //     info.loads.emplace_back(
                //         std::dynamic_pointer_cast<LOADInst>(user));
                // } else if (user->getVTrait() == ValueTrait::VOID_INSTRUCTION &&
                //            std::dynamic_pointer_cast<Instruction>(user)
                //                    ->getOpcode() == OP::STORE) {
                //     info.stores.emplace_back(
                //         std::dynamic_pointer_cast<STOREInst>(user));
                // } else {
                //     promotable = false;
                //     break;
                // }
            }
            if (promotable) {
                alloca_infos.push(info);
            }
        }
    }
}

bool PromotePass::removeUnusedAlloca() {
    if (cur_info.loads.empty()) {
        for (auto &store : cur_info.stores) {
            store->getParent()->delFirstOfInst(store);
        }
        entry_block->delFirstOfInst(cur_info.alloca);
        return true;
    }
    return false;
}

bool PromotePass::rewriteSingleStoreAlloca() {
    if (cur_info.stores.size() == 1) {
        auto store = cur_info.stores.front();
        auto rval = store->getValue();
        for (auto &load : cur_info.loads) {
            if (!iADomB(store, load)) {
                // todo: 替换为undef?
                Err::error("PromotePass::rewriteSingleStoreAlloca(): load before single store.");
                return false;
            }
            load->replaceSelf(rval);
            load->getParent()->delFirstOfInst(load);
        }
        store->getParent()->delFirstOfInst(store);
        entry_block->delFirstOfInst(cur_info.alloca);
        return true;
    }
    return false;
}

bool PromotePass::promoteSingleBlockAlloca() {
    if (cur_info.user_blocks.size() == 1) {
        for (auto & load : cur_info.loads) {
            auto it =  cur_info.user_blocks[load->getParent()].store_map.lower_bound(load->getParent()->getInstIndex(load));
            if (it == cur_info.user_blocks[load->getParent()].store_map.begin()) {
                Err::error("PromotePass::promoteSingleBlockAlloca(): store map is empty or load before store.");
                return false;
            }
            auto rval = (--it)->second->getValue();
            if (rval == load) {
                Err::error("PromotePass::promoteSingleBlockAlloca(): Unreachable load after promoting store.");
                return false;
            }
            load->replaceSelf(rval);
            load->getParent()->delFirstOfInst(load);
        }
        for (auto &store : cur_info.stores) {
            store->getParent()->delFirstOfInst(store);
        }
        entry_block->delFirstOfInst(cur_info.alloca);
        return true;
    }
    return false;
}

void PromotePass::computeProcessQueue() {
    std::queue<std::shared_ptr<BasicBlock>> tmp_work_queue; // 临时处理队列
    std::set<std::shared_ptr<BasicBlock>> live_in_blocks; // 即需要传递alloca值的块

    // 初步处理 user_block
    for (const auto &[b, i] : cur_info.user_blocks) {
        if (!i.load_map.empty()) {
            if (!i.store_map.empty()) {
                if (i.store_map.begin()->first < i.load_map.begin()->first) {
                    // store's index is less than load's
                    continue;
                }
            }
            tmp_work_queue.push(b);
        }
    }

    // 进一步递归向前遍历前驱构造 live_in_blocks
    while (!tmp_work_queue.empty()) {
        auto b = tmp_work_queue.front();
        tmp_work_queue.pop();

        if (!live_in_blocks.insert(b).second)
            continue;

        for (const auto &p : b->getPreBB()) {
            if (auto i = cur_info.user_blocks.find(p);
                i != cur_info.user_blocks.end()) {
                if (!i->second.store_map.empty())
                    // if p is a def block...
                        continue;
                }
            tmp_work_queue.push(p);
        }
    }
    // todo

}

void PromotePass::processAlloca() {
    // todo
}

void PromotePass::promoteMemoryToRegister(Function &function) {
    entry_block = function.getBlocks().front();
    Err::gassert(entry_block->isName("entry"),
                 "First block is not named entry");

    analyseAlloca();
    while (!alloca_infos.empty()) {
        cur_info = alloca_infos.front();
        if (removeUnusedAlloca()) ;
        else if (rewriteSingleStoreAlloca()) ;
        else if (promoteSingleBlockAlloca()) ;
        else {
            computeProcessQueue();
            processAlloca();
        }
        alloca_infos.pop();
    }
}

PM::PreservedAnalyses PromotePass::run(Function &function, FAM &manager) {
    DT = manager.getResult<DomTreeAnalysis>(function);

    promoteMemoryToRegister(function);

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    return pa;
}
}// namespace IR
