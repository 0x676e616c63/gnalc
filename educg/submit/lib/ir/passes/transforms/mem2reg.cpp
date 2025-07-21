// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/mem2reg.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/instructions/phi.hpp"
#include "../../../../include/ir/passes/analysis/loop_analysis.hpp"
#include "../../../../include/utils/exception.hpp"

#include <algorithm>
#include <queue>
#include <stack>

namespace IR {
bool PromotePass::iADomB(const pInst &ia, const pInst &ib) {
    if (ia->getParent() == ib->getParent()) {
        return ia->getIndex() < ib->getIndex();
    }
    return pDT->ADomB(ia->getParent(), ib->getParent());
}

void PromotePass::analyseAlloca() {
    for (const auto &inst : entry_block->getInsts()) {
        if (inst->getOpcode() == OP::ALLOCA) {
            const auto alloca_inst = inst->as<ALLOCAInst>();
            ALLOCA_INFO info = {alloca_inst};
            bool promotable = true;
            // 遍历所有User, 只接受LOAD, STORE语句
            for (const auto &user : inst->users()) {
                // Attention: 这里前提是所有的ORDINARY_VARIABLE都是INSTRUCTION
                if (user->getVTrait() == ValueTrait::ORDINARY_VARIABLE ||
                    user->getVTrait() == ValueTrait::VOID_INSTRUCTION) {
                    auto inst_user = user->as<Instruction>();
                    if (inst_user->getOpcode() == OP::LOAD) {
                        auto load = inst_user->as<LOADInst>();
                        info.loads.emplace_back(load);
                        info.user_blocks[load->getParent()].load_map[inst_user->getIndex()] = load;
                    } else if (inst_user->getOpcode() == OP::STORE) {
                        auto store = inst_user->as<STOREInst>();
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
        for (auto &load : cur_info.loads) {
            auto it = cur_info.user_blocks[load->getParent()].store_map.lower_bound(load->getIndex());
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
    std::queue<pBlock> tmp_work_queue; // 临时处理队列
    std::unordered_set<pBlock> live_in_blocks;   // 即需要传递alloca值的块
    std::unordered_set<pBlock> define_blocks;    // 定义块

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

        for (const auto &p : b->preds()) {
            if (auto i = cur_info.user_blocks.find(p); i != cur_info.user_blocks.end()) {
                if (!i->second.store_map.empty())
                    // if p is a def block...
                    continue;
            }
            tmp_work_queue.push(p);
        }
    }

    std::unordered_set<pBlock> phi_blocks;
    computeIDF(define_blocks, live_in_blocks, phi_blocks);

    unsigned version = 0;
    for (const auto &bb : phi_blocks) {
        auto node = std::make_shared<PHIInst>(cur_info.alloca->getName() + "." + std::to_string(++version),
                                              cur_info.alloca->getBaseType());
        bb->addPhiInst(node);
        phi_to_alloca_map[node] = cur_info.alloca;
    }
}

void PromotePass::rename(Function &f) {
    auto &DT = *pDT;
    if (alloca_infos.empty())
        return;
    using ABPair = std::pair<std::shared_ptr<ALLOCAInst>, pBlock>;
    std::unordered_map<ABPair, pVal, Util::PairHash> incoming_values;
    incoming_values.reserve(alloca_infos.size() * f.getBlocks().size());
    for (auto &info : alloca_infos) {
        for (auto &b : f.getBlocks())
            incoming_values[{info.alloca, b}] = undef_val;
    }

    std::stack<pBlock> work_stack;
    std::unordered_set<pBlock> visited;
    work_stack.push(entry_block);
    while (!work_stack.empty()) {
        const auto b = work_stack.top();
        work_stack.pop();
        if (!visited.insert(b).second)
            continue;

        //  process load store and phi
        for (const auto &i : b->phis()) {
            if (del_queue.count(i) || !phi_to_alloca_map.count(i))
                continue;
            incoming_values[{phi_to_alloca_map[i], b}] = i;
        }
        for (const auto &i : b->getInsts()) {
            if (del_queue.count(i))
                continue;
            switch (i->getOpcode()) {
            case OP::LOAD:
                if (!incoming_values.count({i->as<LOADInst>()->getPtr()->as<ALLOCAInst>(), b}))
                    break;
                // 用于在替换前检查是否是undef_val, 若是则沿cfg向上查找非undef的值
                if (auto alloca = i->as<LOADInst>()->getPtr()->as<ALLOCAInst>();
                    incoming_values[{alloca, b}] == undef_val) {
                    for (auto pb = b;;) {
                        if (incoming_values[{alloca, pb}] == undef_val) {
                            if (DT[pb]->parent() != nullptr)
                                pb = DT[pb]->parent()->block();
                            else {
                                // Err::error("PromotePass::rename(): IDOM is nullptr! Maybe node is root.");
                                Logger::logWarning(
                                    "[M2R] rename(): Value are not defined for all dominance nodes! Use zero instead.");
                                auto btype = alloca->getBaseType()->as<BType>();
                                Err::gassert(btype != nullptr && (btype->getInner() == IRBTYPE::I32 ||
                                                                  btype->getInner() == IRBTYPE::FLOAT),
                                             "Unexpected load type in mem2reg.");
                                if (btype->getInner() == IRBTYPE::I32)
                                    incoming_values[{alloca, b}] = f.getConst(0);
                                else
                                    incoming_values[{alloca, b}] = f.getConst(0.0f);
                                break;
                            }
                        } else {
                            incoming_values[{alloca, b}] = incoming_values[{alloca, pb}];
                            Err::gassert(incoming_values[{alloca, b}] != nullptr,
                                         "PromotePass::rename(): Incoming value is null!");
                            break;
                        }
                    }
                }
                i->replaceSelf(incoming_values[{i->as<LOADInst>()->getPtr()->as<ALLOCAInst>(), b}]);
                del_queue.insert(i);
                break;
            case OP::STORE:
                if (!incoming_values.count({i->as<STOREInst>()->getPtr()->as<ALLOCAInst>(), b}))
                    break;
                incoming_values[{i->as<STOREInst>()->getPtr()->as<ALLOCAInst>(), b}] = i->as<STOREInst>()->getValue();
                del_queue.insert(i);
                break;
            default:
                break;
            }
        }

        for (const auto &n : b->succs()) {
            // process phi in next block
            for (const auto &phi_node : n->phis()) {
                if (!phi_to_alloca_map.count(phi_node))
                    continue;

                // 用于在替换前检查是否是undef_val, 若是则沿cfg向上查找非undef的值
                if (auto alloca = phi_to_alloca_map[phi_node]; incoming_values[{alloca, b}] == undef_val) {
                    for (auto pb = b;;) {
                        if (incoming_values[{alloca, pb}] == undef_val) {
                            if (DT[pb]->parent() != nullptr)
                                pb = DT[pb]->parent()->block();
                            else {
                                // Err::error("PromotePass::rename(): IDOM is nullptr! Maybe node is root.");
                                Logger::logWarning(
                                    "[M2R] rename(): Value are not defined for all dominance nodes! Use zero instead.");
                                auto btype = alloca->getBaseType()->as<BType>();
                                Err::gassert(btype != nullptr && (btype->getInner() == IRBTYPE::I32 ||
                                                                  btype->getInner() == IRBTYPE::FLOAT),
                                             "Unexpected load type in mem2reg.");
                                if (btype->getInner() == IRBTYPE::I32)
                                    incoming_values[{alloca, b}] = f.getConst(0);
                                else
                                    incoming_values[{alloca, b}] = f.getConst(0.0f);
                                break;
                            }
                        } else {
                            incoming_values[{alloca, b}] = incoming_values[{alloca, pb}];
                            Err::gassert(incoming_values[{alloca, b}] != nullptr,
                                         "PromotePass::rename(): Incoming value is null!");
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
void PromotePass::computeIDF(const std::unordered_set<pBlock> &def_blk, const std::unordered_set<pBlock> &live_in_blk,
                             std::unordered_set<pBlock> &phi_blk) {
    auto &DT = *pDT;
    using pDTN = std::shared_ptr<DomTree::Node>;
    using DTNPair = std::pair<unsigned, pDTN>;
    // todo : why less?
    std::priority_queue<DTNPair, std::vector<DTNPair>, std::less<>> PQ; // DT节点优先队列
    for (const auto &b : def_blk) {
        PQ.emplace((DTNPair){DT[b]->bfs_num(), DT[b]});
    }

    std::unordered_set<pDTN> visited_pq;
    std::unordered_set<pDTN> visited_stn; // subtree node queue (work list in llvm)

    visited_pq.reserve(PQ.size());
    visited_stn.reserve(PQ.size());

    // std::unordered_set<pBlock> idf; // JUST FOR TEST DomTree::getDF()

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
            for (const auto &next : node->block()->succs()) {
                auto next_node = DT[next];

                if (next_node->parent() == node)
                    continue;

                if (next_node->level() > root->level())
                    continue;

                if (!visited_pq.insert(next_node).second)
                    continue;

                if (!live_in_blk.count(next))
                    continue;

                phi_blk.insert(next);
                if (!def_blk.count(next))
                    PQ.emplace((DTNPair){next_node->bfs_num(), next_node});
            }

            for (const auto &dom_child : node->children())
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

    Err::gassert(entry_block->getNumPreds() == 0, "First block is not entry block");

    analyseAlloca();

    for (auto it = alloca_infos.begin(); it != alloca_infos.end();) {
        cur_info = *it;
        if (removeUnusedAlloca() || rewriteSingleStoreAlloca() || promoteSingleBlockAlloca()) {
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
    std::unordered_set<pBlock> del_inst_blocks;
    for (const auto &inst : del_queue)
        del_inst_blocks.insert(inst->getParent());
    for (const auto &blk : del_inst_blocks)
        blk->delInstIf([this](const auto &inst) { return del_queue.count(inst); }, BasicBlock::DEL_MODE::ALL);
}

PM::PreservedAnalyses PromotePass::run(Function &function, FAM &manager) {
    pDT = &manager.getResult<DomTreeAnalysis>(function);

    promoteMemoryToRegister(function);

    cur_info = {};
    alloca_infos.clear();
    phi_to_alloca_map.clear();
    entry_block = nullptr;
    pDT = nullptr;
    del_queue.clear();

    return PreserveCFGAnalyses();
}
} // namespace IR
