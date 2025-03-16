#include "../../../../include/mir/passes/transforms/phiEliminate.hpp"
#include "../../../../include/mir/instructions/branch.hpp"
#include "../../../../include/mir/instructions/copy.hpp"
#include <forward_list>
#include <queue>

namespace MIR {

PM::PreservedAnalyses PhiEliminatePass::run(Module &bkd_module, MAM &mam) {
    module = &bkd_module;

    MkWorkList(); // 筛选Phi fun && blk
    for (auto &phi_func : processList) {
        RunOnFunc(phi_func);
    }

    for (const auto &pair : delList) {
        pair.second->delInst(pair.first);
    }

    return PM::PreservedAnalyses::all();
}

std::vector<std::pair<OperP, OperP>> PhiEliminatePass::findPair(const BlkP &blk, const BlkP &succ) {
    std::vector<std::pair<OperP, OperP>> dst_src_vec;

    const std::string &blk_name = blk->getName();
    const std::string &succ_name = succ->getName();

    for (const auto &inst : succ->getInsts()) {
        auto phiInst = std::dynamic_pointer_cast<PHI>(inst);

        if (!phiInst)
            ///@note phi函数的翻译应该在blk的开头并且连在一起?
            break;

        const auto target = phiInst->getTargetOP();
        const auto &phiOpers = phiInst->getPhiOper();

        for (auto &phioper : phiOpers) {
            if (phioper.pre != blk_name)
                continue;

            dst_src_vec.emplace_back(target, phioper.val);
        }

        ///@brief 准备删除PhiInst
        delList.insert(std::make_pair(phiInst, succ));
    }

    return dst_src_vec;
}

void PhiEliminatePass::MkWorkList() {
    auto &func_list = module->getFuncs();

    for (const auto &func : func_list) {
        PhiFunction func_phi;
        for (const auto &blk : func->getBlocks()) {
            for (const auto &succ : blk->getSuccs()) {
                if (!succ->containPhi)
                    continue;
                PhiBlkPairs blk_phipairs{func, blk, succ};
                blk_phipairs.pairs = std::move(findPair(blk, succ));
                func_phi.PhiList.emplace_back(blk_phipairs);
            }
        }

        if (!func_phi.PhiList.empty())
            processList.emplace_back(func_phi);
    }
}

void PhiEliminatePass::pushBeforeBranch(const BlkP &emitBlk, const OperP &dst, const OperP &src) {

    Err::gassert(std::dynamic_pointer_cast<BindOnVirOP>(dst) != nullptr, "dst operand is a const value");

    auto copy = std::make_shared<COPY>(std::dynamic_pointer_cast<BindOnVirOP>(dst), src);

    ///@brief 插入到branch之前

    auto &instList = emitBlk->getInsts();

    for (auto it = instList.begin(); it != instList.end(); ++it) {
        auto &inst = *it;

        if (!std::dynamic_pointer_cast<branchInst>(inst))
            continue;

        instList.insert(it, copy); // before
        return;
    }

    Err::unreachable("pushBeforeBranch didn't find a branch inst");
}

// 返回的是 COPY dst, stageR 中的stageR
// COPY stageR dst(暂存)
// COPY dst, src(runOnGraph中插入)
// push_before_branch
OperP PhiEliminatePass::addCOYPInst(const BlkP &emitBlk, const OperP &dst, const FuncP &func) {
    ///@brief 设置stageR

    Err::gassert(std::dynamic_pointer_cast<BindOnVirOP>(dst) != nullptr, "dst operand is a const value");

    auto &varpool = func->editInfo().getPool();

    auto bank = std::dynamic_pointer_cast<BindOnVirOP>(dst)->getBank();

    auto stagedVal = std::make_shared<BindOnVirOP>(
        bank, '%' + std::to_string(varpool.size() + func->getBlocks().size() + func->getInfo().args)); // 注意计数

    ///@brief 用undefined是考虑到可能是双字或者四字数据
    auto temp_midVal = std::make_shared<IR::Value>(stagedVal->getName(), IR::makeBType(IR::IRBTYPE::UNDEFINED),
                                                   IR::ValueTrait::ORDINARY_VARIABLE);
    varpool.addValue(*temp_midVal, stagedVal);

    ///@brief push_before_branch
    pushBeforeBranch(emitBlk, stagedVal, dst);

    return stagedVal;
}

BlkP PhiEliminatePass::splitCriticalEgde(const BlkP &pred, const BlkP &succ, const FuncP &func) {
    ///@brief 判断 critical edge
    ///@note 这种两层map的好处是不用维护新出现的PhiBlkPairs
    if (pred->getSuccs().size() == 1 || succ->getPreds().size() == 1)
        return pred;

    if (getMidBlk.find(pred) == getMidBlk.end())
        getMidBlk[pred] = std::map<BlkP, BlkP>();

    if (getMidBlk[pred].find(succ) == getMidBlk[pred].end()) {
        auto blkName = pred->getName() + "_to_" + succ->getName();

        auto midBlk = std::make_shared<BasicBlock>(blkName, false); // 抽象名字

        ///@note 拆分critical边, 修改CFG(虽然大概率用不着)
        func->addBlock(midBlk->getName(), midBlk);
        pred->delSucc(succ);
        succ->delPred(pred);
        pred->addSucc(midBlk);
        succ->addPred(midBlk);
        ///@todo liveout没转移

        getMidBlk[pred][succ] = std::move(midBlk);
    }

    return getMidBlk[pred][succ];
}

void PhiEliminatePass::RunOnFunc(PhiFunction &func) {
    for (const auto &phiBlk : func.PhiList) {
        RunOnBlkPair(phiBlk);
    }
}

void PhiEliminatePass::RunOnBlkPair(const PhiBlkPairs &process) {
    auto func = process.func;
    BlkP pred = process.src;
    BlkP succ = process.dst;
    auto vec = process.pairs;

    struct Node {
        std::forward_list<unsigned int> nxt;
        unsigned int indegree = 0; // 由于phi函数性质, 这个地方要么0要么1
    };

    std::map<OperP, unsigned int> mapping;
    std::vector<Node> graph(vec.size());

    ///@brief 填充mapping
    for (int i = 0; i < vec.size(); ++i) {
        mapping[vec[i].second] = i;
    }

    ///@brief 填充graph
    for (int i = 0; i < vec.size(); ++i) {
        if (mapping.find(vec[i].first) != mapping.end()) {
            unsigned int src = i;
            auto dst = mapping[vec[i].first];

            graph[src].nxt.push_front(dst);
            ++graph[dst].indegree;
        }
    }

    ///@brief 遍历队列
    std::queue<unsigned> queue;
    for (int i = 0; i < vec.size(); ++i) {
        if (graph[i].indegree == 0)
            queue.push(i);
    }

    // find a stagedR by src
    std::map<OperP, OperP> StagedMap;

    BlkP emitBlk = splitCriticalEgde(pred, succ, func); // 中端做过了
    if (!emitBlk)
        emitBlk = pred; // not a critical edge

    auto limit = vec.size();
    for (int i = 0, j = 0; i < limit;) {

        ///@brief visit a node, and add COPY

        auto visit = [&](unsigned idx) {
            ++i;

            auto [src, dst] = vec[idx];

            if (StagedMap.find(src) != StagedMap.end()) {
                src = StagedMap[src]; // 无需stage(暂时不需要)
            }

            if (graph[idx].indegree) {
                ///@note 可能会出现一种比较极端的情况, %0 = phi [... ...], ..., [%0, ...]
                ///@note 理论上由于单赋值, 所以不需要做什么, 但是算法会还是会插入一个stage, 以及一个冗余的copy
                Err::gassert(graph[idx].indegree == 1, "indegree must be 1");
                graph[idx].indegree = 0;
                auto stagedVal = addCOYPInst(emitBlk, dst, func); // push_before_branch
                StagedMap[dst] = stagedVal;
            }

            pushBeforeBranch(emitBlk, src, dst); ///@bug, src和dst可能还需要再考虑一下

            auto &node = graph[idx];
            for (auto nxt : node.nxt) {
                auto &nxt_node = graph[nxt];
                --nxt_node.indegree;
                if (nxt_node.indegree == 0)
                    queue.push(nxt);
            }
        };

        ///@brief topo sort
        while (!queue.empty()) {
            unsigned cur_node = queue.front();
            queue.pop();
            visit(cur_node);
        }

        if (i >= limit) {
            Err::gassert(i == limit, "you visit too much");
            break;
        }

        for (; j < limit; ++j) {
            if (graph[j].indegree) {
                visit(j);
                if (!queue.empty())
                    break;
            }
        }
    }
}
} // namespace MIR