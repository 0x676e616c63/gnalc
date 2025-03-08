#include "../../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../../include/utils/exception.hpp"

#include <stack>
#include <algorithm>

#include "../../../../include/ir/instructions/phi.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"

namespace IR {
bool PromotePass::iADomB(const std::shared_ptr<Instruction> &ia,
                         const std::shared_ptr<Instruction> &ib) {
    if (ia->getParent() == ib->getParent()) {
        return ia->getIndex() < ib->getIndex();
    }
    return DT.ADomB(ia->getParent().get(), ib->getParent().get());
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
                        info.user_blocks[load->getParent()].load_map[inst_user->getIndex()] = load;
                    } else if (inst_user->getOpcode() == OP::STORE) {
                        auto store = std::dynamic_pointer_cast<STOREInst>(inst_user);
                        info.stores.emplace_back(store);
                        info.user_blocks[store->getParent()].store_map[inst_user->getIndex()] = store;
                    } else {
                        promotable = false;
                        break;
                    }
                    } else {
                        promotable = false;
                        break;
                    }
            }
            if (promotable) {
                alloca_infos.emplace_back(info);
            }
        }
    }
}

bool PromotePass::removeUnusedAlloca() {
    if (cur_info.loads.empty()) {
        for (auto &store : cur_info.stores) {
            del_queue.insert(store);
        }
        del_queue.insert(cur_info.alloca);
        return true;
    }
    return false;
}

bool PromotePass::rewriteSingleStoreAlloca() {
    if (cur_info.stores.size() == 1) {
        const auto store = cur_info.stores.front();
        auto rval = store->getValue();
        for (auto &load : cur_info.loads) {
            if (!iADomB(store, load)) {
                // Err::error("PromotePass::rewriteSingleStoreAlloca(): load before single store.");
                Logger::logWarning("[M2R] rewriteSingleStoreAlloca(): load before single store!");
                return false;
            }
            load->replaceSelf(rval);
            del_queue.insert(load);
        }
        del_queue.insert(store);
        del_queue.insert(cur_info.alloca);
        return true;
    }
    return false;
}

bool PromotePass::promoteSingleBlockAlloca() {
    if (cur_info.user_blocks.size() == 1) {
        for (auto & load : cur_info.loads) {
            auto it =  cur_info.user_blocks[load->getParent()].store_map.lower_bound(load->getIndex());
            if (it == cur_info.user_blocks[load->getParent()].store_map.begin()) {
                Logger::logWarning("[M2R] promoteSingleBlockAlloca(): store map is empty or load before store.");
                return false;
            }
            auto rval = (--it)->second->getValue();
            if (rval == load) {
                Err::error("PromotePass::promoteSingleBlockAlloca(): Unreachable load after promoting store.");
                return false;
            }
            load->replaceSelf(rval);
            del_queue.insert(load);
        }
        for (auto &store : cur_info.stores) {
            del_queue.insert(store);
        }
        del_queue.insert(cur_info.alloca);
        return true;
    }
    return false;
}

void PromotePass::insertPhi() {
    std::queue<std::shared_ptr<BasicBlock>> tmp_work_queue; // 临时处理队列
    std::set<std::shared_ptr<BasicBlock>> live_in_blocks;   // 即需要传递alloca值的块
    std::set<std::shared_ptr<BasicBlock>> define_blocks;    // 定义块

    // 初步处理 user_block
    for (const auto &[b, i] : cur_info.user_blocks) {
        if (!i.store_map.empty()) {
            define_blocks.insert(b);
        }
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

    std::set<std::shared_ptr<BasicBlock>> phi_blocks;
    computeIDF(define_blocks, live_in_blocks, phi_blocks);

    unsigned version = 0;
    for (const auto& bb : phi_blocks) {
        auto node = std::make_shared<PHIInst>(cur_info.alloca->getName() + "." + std::to_string(++version), cur_info.alloca->getBaseType());
        bb->addPhiInst(node);
        phi_to_alloca_map[node] = cur_info.alloca;
    }
}

void PromotePass::rename(Function &f) {
    if (alloca_infos.empty()) return;
    using ABPair = std::pair<std::shared_ptr<ALLOCAInst>, std::shared_ptr<BasicBlock>>;
    std::map<ABPair, std::shared_ptr<Value>> incoming_values;
    for (auto &info : alloca_infos) {
        for (auto &b : f.getBlocks())
            incoming_values[{info.alloca, b}] = undef_val;
    }

    std::stack<std::shared_ptr<BasicBlock>> work_stack;
    std::set<std::shared_ptr<BasicBlock>> visited;
    work_stack.push(entry_block);
    while (!work_stack.empty()) {
        const auto b = work_stack.top();
        work_stack.pop();
        if (!visited.insert(b).second)
            continue;

        //  process load store and phi
        for (const auto &i : b->getPhiInsts()) {
            if (del_queue.count(i)) continue;
            incoming_values[{phi_to_alloca_map[std::dynamic_pointer_cast<PHIInst>(i)], b}] = i;
        }
        for (const auto& i : b->getInsts()) {
            if (del_queue.count(i)) continue;
            switch (i->getOpcode()) {
                case OP::LOAD:
                    if (!incoming_values.count({std::dynamic_pointer_cast<ALLOCAInst>(
                            std::dynamic_pointer_cast<LOADInst>(i)->getPtr()), b})) break;
                    // 用于在替换前检查是否是undef_val, 若是则沿cfg向上查找非undef的值
                    if (auto alloca = std::dynamic_pointer_cast<ALLOCAInst>(
                        std::dynamic_pointer_cast<LOADInst>(i)->getPtr()); incoming_values[{alloca, b}] == undef_val) {
                        for (auto pb = b;;) {
                            if (incoming_values[{alloca, pb}] == undef_val) {
                                if (DT.nodes[pb.get()]->parent != nullptr)
                                    pb = DT.nodes[pb.get()]->parent->bb->shared_from_this();
                                else {
                                    // Err::error("PromotePass::rename(): IDOM is nullptr! Maybe node is root.");
                                    Logger::logWarning("[M2R] rename(): Value are not defined for all dominance nodes! Use 0 instead.");
                                    incoming_values[{alloca, b}] = f.getConst(0);
                                    break;
                                }
                            } else {
                                incoming_values[{alloca, b}] = incoming_values[{alloca, pb}];
                                Err::gassert(incoming_values[{alloca, b}] != nullptr, "PromotePass::rename(): Incoming value is null!");
                                break;
                            }
                        }
                    }
                    i->replaceSelf(
                        incoming_values[{std::dynamic_pointer_cast<ALLOCAInst>(
                            std::dynamic_pointer_cast<LOADInst>(i)->getPtr()), b}]);
                    del_queue.insert(i);
                    break;
                case OP::STORE:
                    if (!incoming_values.count({std::dynamic_pointer_cast<ALLOCAInst>(
                            std::dynamic_pointer_cast<STOREInst>(i)->getPtr()), b})) break;
                    incoming_values[{std::dynamic_pointer_cast<ALLOCAInst>(
                            std::dynamic_pointer_cast<STOREInst>(i)->getPtr()), b}] = std::dynamic_pointer_cast<
                                STOREInst>(i)->getValue();
                    del_queue.insert(i);
                    break;
                default:
                    break;
            }
        }

        for (const auto &n : b->getNextBB()) {
            // process phi in next block
            for (const auto & phi_node : n->getPhiInsts()) {
                // 用于在替换前检查是否是undef_val, 若是则沿cfg向上查找非undef的值
                if (auto alloca = phi_to_alloca_map[phi_node]; incoming_values[{alloca, b}] == undef_val) {
                    for (auto pb = b;;) {
                        if (incoming_values[{alloca, pb}] == undef_val) {
                            if (DT.nodes[pb.get()]->parent != nullptr)
                                pb = DT.nodes[pb.get()]->parent->bb->shared_from_this();
                            else {
                                // Err::error("PromotePass::rename(): IDOM is nullptr! Maybe node is root.");
                                Logger::logWarning("[M2R] rename(): Value are not defined for all dominance nodes! Use 0 instead.");
                                incoming_values[{alloca, b}] = f.getConst(0);
                                break;
                            }
                        } else {
                            incoming_values[{alloca, b}] = incoming_values[{alloca, pb}];
                            Err::gassert(incoming_values[{alloca, b}] != nullptr, "PromotePass::rename(): Incoming value is null!");
                            break;
                        }
                    }
                }
                phi_node->addPhiOper(incoming_values[{phi_to_alloca_map[phi_node], b}], b);
            }

            work_stack.push(n);
        }
    }

    for (auto &info : alloca_infos) {
        del_queue.insert(info.alloca);
    }
}

// 大部分参考LLVM实现了...
void PromotePass::computeIDF(const std::set<std::shared_ptr<BasicBlock>>& def_blk,
                             const std::set<std::shared_ptr<BasicBlock>>& live_in_blk,
                             std::set<std::shared_ptr<BasicBlock>>& phi_blk) {
    using pDTN = std::shared_ptr<DomTree::Node>;
    using DTNPair = std::pair<unsigned, pDTN>;
    // todo : why less?
    std::priority_queue<DTNPair, std::vector<DTNPair>, std::less<>> PQ; // DT节点优先队列
    for (const auto &b : def_blk) {
        PQ.emplace((DTNPair){DT.nodes[b.get()]->bfs_num, DT.nodes[b.get()]});
    }

    std::set<pDTN> visited_pq;
    std::set<pDTN> visited_stn; // subtree node queue (work list in llvm)

    // std::set<std::shared_ptr<BasicBlock>> idf; // JUST FOR TEST DomTree::getDF()

    // process every def nodes, find dom frontier
    while (!PQ.empty()) {
        auto root = PQ.top().second;
        PQ.pop();

        // // JUST FOR TEST DomTree::getDF()
        // auto df = DT.getDomFrontier(root->bb);
        // for (const auto &b : df) {
        //     if (visited_pq.count(DT.nodes[b]))
        //         continue;
        //     auto sb = b->shared_from_this();
        //     if (!live_in_blk.count(sb))
        //         continue;
        //     idf.insert(sb);
        // }

        std::stack<pDTN> STN{}; // subtree node queue (work list in llvm)
        STN.push(root);
        visited_stn.insert(root);

        // dfs subtree
        while (!STN.empty()) {
            auto node = STN.top();
            STN.pop();

            // process succ node in cfg
            for (const auto& next : node->bb->getNextBB()) {
                auto next_node = DT.nodes[next.get()];

                if (next_node->parent == node.get())
                    continue;

                if (next_node->level > root->level)
                    continue;

                if (!visited_pq.insert(next_node).second)
                    continue;

                if (!live_in_blk.count(next))
                    continue;

                phi_blk.insert(next);
                if (!def_blk.count(next))
                    PQ.emplace((DTNPair){next_node->bfs_num, next_node});
            }

            for (const auto& dom_child : node->children)
                if (visited_stn.insert(dom_child).second)
                    STN.push(dom_child);
        }
    }

    // // JUST FOR TEST DomTree::getDF()
    // if (phi_blk.size() == idf.size() && std::equal(phi_blk.begin(), phi_blk.end(), idf.begin()))
    //     std::cout << "TEST DF: IDF IS EQUAL." << std::endl;
    // else
    //     Err::error("TEST DF: IDF IS NOT EQUAL!");
}

void PromotePass::promoteMemoryToRegister(Function &function) {
    entry_block = function.getBlocks().front();

    Err::gassert(entry_block->getPreBB().empty(),
        "First block is not entry block");

    analyseAlloca();

    for (auto it = alloca_infos.begin(); it != alloca_infos.end(); ) {
        cur_info = *it;
        if (removeUnusedAlloca() ||
            rewriteSingleStoreAlloca() ||
            promoteSingleBlockAlloca()) {
            it = alloca_infos.erase(it);
        } else {
            insertPhi();
            ++it;
        }
    }

    rename(function);

    // for (const auto& inst : del_queue) {
    //     Logger::logDebug("[M2R] Deleting: "+IRFormatter::formatInst(*inst));
    //     if (inst->getParent() == nullptr) {
    //         Logger::logWarning("[M2R] The instruction to be deleted is incorrect, skip.");
    //         continue;
    //     }
    //     inst->getParent()->delFirstOfInst(inst);
    // }
    std::set<std::shared_ptr<BasicBlock>> del_inst_blocks;
    for (const auto& inst : del_queue)
        del_inst_blocks.insert(inst->getParent());
    for (const auto& blk : del_inst_blocks)
        blk->delInstIf([this](const auto& inst){ return del_queue.count(inst); }, BasicBlock::DEL_MODE::ALL);
}

PM::PreservedAnalyses PromotePass::run(Function &function, FAM &manager) {
    DT = manager.getResult<DomTreeAnalysis>(function);

    promoteMemoryToRegister(function);

    cur_info = {};
    alloca_infos.clear();
    phi_to_alloca_map.clear();
    entry_block = nullptr;
    DT = {};
    del_queue.clear();

    return PreserveCFGAnalyses();
}
}// namespace IR
