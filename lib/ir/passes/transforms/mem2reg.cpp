#include "../../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../../include/utils/exception.hpp"

#include <stack>
#include <algorithm>

#include "../../../../include/config/config.hpp"
#include "../../../../include/ir/instructions/phi.hpp"

namespace IR {
bool PromotePass::iADomB(const std::shared_ptr<Instruction> &ia,
                         const std::shared_ptr<Instruction> &ib) {
    if (ia->getParent() == ib->getParent()) {
        return ia->index < ib->index;
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
                        info.user_blocks[load->getParent()].load_map[inst_user->index] = load;
                    } else if (inst_user->getOpcode() == OP::STORE) {
                        auto store = std::dynamic_pointer_cast<STOREInst>(inst_user);
                        info.stores.emplace_back(store);
                        info.user_blocks[store->getParent()].store_map[inst_user->index] = store;
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
                alloca_infos.emplace_back(info);
            }
        }
    }
}

bool PromotePass::removeUnusedAlloca() {
    if (cur_info.loads.empty()) {
        for (auto &store : cur_info.stores) {
            // store->getParent()->delFirstOfInst(store);
            del_queue.insert(store);
        }
        // entry_block->delFirstOfInst(cur_info.alloca);
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
                Logger::logInfo("\033[33m[WARNING]\033[0m PromotePass::rewriteSingleStoreAlloca(): load before single store!");
                return false;
            }
            load->replaceSelf(rval);
            // load->getParent()->delFirstOfInst(load);
            del_queue.insert(load);
        }
        // store->getParent()->delFirstOfInst(store);
        // entry_block->delFirstOfInst(cur_info.alloca);
        del_queue.insert(store);
        del_queue.insert(cur_info.alloca);
        return true;
    }
    return false;
}

bool PromotePass::promoteSingleBlockAlloca() {
    if (cur_info.user_blocks.size() == 1) {
        for (auto & load : cur_info.loads) {
            auto it =  cur_info.user_blocks[load->getParent()].store_map.lower_bound(load->index);
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
            // load->getParent()->delFirstOfInst(load);
            del_queue.insert(load);
        }
        for (auto &store : cur_info.stores) {
            // store->getParent()->delFirstOfInst(store);
            del_queue.insert(store);
        }
        // entry_block->delFirstOfInst(cur_info.alloca);
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

    // 是否需要？将phi_blocks改为set之后可以删掉168-174, 181, 是否有其他作用？
    // if (phi_blocks.size() > 1) {
    //     std::sort(phi_blocks.begin(), phi_blocks.end(),
    //               [](const std::shared_ptr<BasicBlock> &a,
    //                     const std::shared_ptr<BasicBlock> &b) {
    //                     return a->index < b->index;
    //               });
    // }

    // 是否需要new_phi_nodes?
    unsigned version = 0;
    for (const auto& bb : phi_blocks) {
        // auto &node = new_phi_nodes[std::make_pair(cur_info.alloca->index, bb->index)];
        // if (node) continue;
        std::shared_ptr<PHIInst> node;
        if (!name_normalized)
            node = std::make_shared<PHIInst>(Config::IR::REGISTER_TEMP_NAME, cur_info.alloca->getBaseType());
        else
            node = std::make_shared<PHIInst>(cur_info.alloca->getName()+"."+std::to_string(++version), cur_info.alloca->getBaseType());
        bb->insertPhi(node);
        phi_to_alloca_map[node] = cur_info.alloca;
    }
}

void PromotePass::rename(Function &f) {
    if (alloca_infos.empty()) return;
    // std::map<std::shared_ptr<ALLOCAInst>, std::shared_ptr<Value>> incoming_values;
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

        // 可用livein信息优化? 应该不需要了
        // if (b->getPreBB().size() >= 1) {
        //     for (auto &info : alloca_infos) {
        //         incoming_values[{info.alloca, b}] = incoming_values[{info.alloca, b->getPreBB().front()}];
        //     }
        // }

        //  process load store and phi
        // std::vector<std::shared_ptr<Instruction>> del_insts;
        for (const auto& i : b->getInsts()) {
            if (del_queue.count(i)) continue;
            switch (i->getOpcode()) {
                case OP::PHI:
                    incoming_values[{phi_to_alloca_map[std::dynamic_pointer_cast<PHIInst>(i)], b}] = i;
                    break;
                case OP::LOAD:
                    if (!incoming_values.count({std::dynamic_pointer_cast<ALLOCAInst>(
                            std::dynamic_pointer_cast<LOADInst>(i)->getPtr()), b})) break;
                    // 用于在替换前检查是否是undef_val, 若是则沿cfg向上查找非undef的值
                    if (auto alloca = std::dynamic_pointer_cast<ALLOCAInst>(
                        std::dynamic_pointer_cast<LOADInst>(i)->getPtr()); incoming_values[{alloca, b}] == undef_val) {
                        for (auto pb = b;;) {
                            if (incoming_values[{alloca, pb}] == undef_val) {
                                // if (!pb->getPreBB().empty())
                                //     pb = pb->getPreBB().front();
                                if (DT.nodes[pb]->parent != nullptr)
                                    pb = DT.nodes[pb]->parent->bb;
                                else
                                    Err::error("PromotePass::rename(): IDOM is nullptr! Maybe node is root.");
                            } else {
                                incoming_values[{alloca, b}] = incoming_values[{alloca, pb}];
                                break;
                            }
                        }
                    }
                    i->replaceSelf(
                        incoming_values[{std::dynamic_pointer_cast<ALLOCAInst>(
                            std::dynamic_pointer_cast<LOADInst>(i)->getPtr()), b}]);
                    // del_insts.emplace_back(i);
                    del_queue.insert(i);
                    break;
                case OP::STORE:
                    if (!incoming_values.count({std::dynamic_pointer_cast<ALLOCAInst>(
                            std::dynamic_pointer_cast<STOREInst>(i)->getPtr()), b})) break;
                    incoming_values[{std::dynamic_pointer_cast<ALLOCAInst>(
                            std::dynamic_pointer_cast<STOREInst>(i)->getPtr()), b}] = std::dynamic_pointer_cast<
                                STOREInst>(i)->getValue();
                    // del_insts.emplace_back(i);
                    del_queue.insert(i);
                    break;
                default:
                    break;
            }
        }

        // todo: 可以在bb中添加返回删除后迭代器的方法
        // for (auto &inst : del_insts) {
        //     b->delInst(inst);
        // }

        for (const auto &n : b->getNextBB()) {
            // process phi in next block
            auto phi_it = n->getInsts().begin();
            for (unsigned i = 0; i < n->getPhiCount(); ++i) {
                if (auto phi_node = std::dynamic_pointer_cast<PHIInst>(*phi_it)) {
                    // 用于在替换前检查是否是undef_val, 若是则沿cfg向上查找非undef的值
                    if (auto alloca = phi_to_alloca_map[phi_node]; incoming_values[{alloca, b}] == undef_val) {
                        for (auto pb = b;;) {
                            if (incoming_values[{alloca, pb}] == undef_val) {
                                // if (!pb->getPreBB().empty())
                                //     pb = pb->getPreBB().front();
                                if (DT.nodes[pb]->parent != nullptr)
                                    pb = DT.nodes[pb]->parent->bb;
                                else {
                                    // Err::error("PromotePass::rename(): IDOM is nullptr! Maybe node is root.");
                                    Logger::logInfo("\033[33m[WARNING]\033[0m PromotePass::rename(): Value are not defined for all dominance nodes! Use 0 instead.");
                                    incoming_values[{alloca, b}] = f.getConstantPool().getConst(0);
                                    break;
                                }
                            } else {
                                incoming_values[{alloca, b}] = incoming_values[{alloca, pb}];
                                break;
                            }
                        }
                    }
                    phi_node->addPhiOper(
                        std::make_shared<PHIInst::PhiOperand>(incoming_values[{phi_to_alloca_map[phi_node], b}], b));
                } else {
                    Err::error("PromotePass::rename(): phi node cast failed!");
                }
                ++phi_it;
            }

            work_stack.push(n);
        }
    }

    for (auto &info : alloca_infos) {
        // entry_block->delFirstOfInst(info.alloca);
        del_queue.insert(info.alloca);
    }
}

// 大部分参考LLVM实现了...
void PromotePass::computeIDF(const std::set<std::shared_ptr<BasicBlock>>& def_blk,
                             const std::set<std::shared_ptr<BasicBlock>>& live_in_blk,
                             std::set<std::shared_ptr<BasicBlock>>& phi_blk) {
    using pDTN = std::shared_ptr<DomTree::Node>;
    using DTNPair = std::pair<unsigned, pDTN>;
    // todo : greater or less?
    // todo : why less?
    std::priority_queue<DTNPair, std::vector<DTNPair>, std::less<>> PQ; // DT节点优先队列
    for (const auto &b : def_blk) {
        PQ.emplace((DTNPair){DT.nodes[b]->bfs_num, DT.nodes[b]});
    }

    std::set<pDTN> visited_pq;
    std::set<pDTN> visited_stn; // subtree node queue (work list in llvm)

    // process every def nodes, find dom frontier
    while (!PQ.empty()) {
        auto root = PQ.top().second;
        PQ.pop();

        std::stack<pDTN> STN{}; // subtree node queue (work list in llvm)
        STN.push(root);
        visited_stn.insert(root);

        // dfs subtree
        while (!STN.empty()) {
            auto node = STN.top();
            STN.pop();

            // process succ node in cfg
            for (const auto& next : node->bb->getNextBB()) {
                auto next_node = DT.nodes[next];

                if (next_node->parent == node)
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
}

void PromotePass::promoteMemoryToRegister(Function &function) {
    entry_block = function.getBlocks().front();
    if (!name_normalized)
        Err::gassert(entry_block->isName("%entry"),
                     "First block is not named entry");

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

    for (const auto& inst : del_queue) {
        inst->getParent()->delFirstOfInst(inst);
    }
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

    PM::PreservedAnalyses pa;
    pa.preserve<DomTreeAnalysis>();
    return pa;
}
}// namespace IR
