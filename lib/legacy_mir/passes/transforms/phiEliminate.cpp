#ifdef GNALC_EXTENSION_ARMv7
#include "legacy_mir/passes/transforms/phiEliminate.hpp"
#include "legacy_mir/instructions/binary.hpp"
#include "legacy_mir/instructions/branch.hpp"
#include "legacy_mir/instructions/copy.hpp"
#include <forward_list>
#include <queue>

namespace LegacyMIR {

std::size_t PhiEliminatePass::tempHash::operator()(const std::pair<InstP, BlkP> &pair) const {
    return std::hash<size_t>()((size_t)(pair.first.get()) ^ (size_t)(pair.second.get()));
}

PM::PreservedAnalyses PhiEliminatePass::run(Module &bkd_module, MAM & /*mam*/) {
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

        if (!phiInst) {
            ///@note phi函数的翻译应该在blk的开头并且连在一起?
            break;
        }

        const auto target = phiInst->getTargetOP();
        const auto &phiOpers = phiInst->getPhiOper();

        ///@brief 重新翻译phi IR op
        for (auto &phioper : phiOpers) {
            if (phioper.pre != blk_name) {
                continue;
            }

            const auto &ir_op = phioper.val;
            OperP mir_op = nullptr;

            if (auto i32 = ir_op->as<IR::ConstantInt>()) {
                mir_op = cur_varpool->getLoaded(i32->getVal(), blk).first;
            } else if (auto f32 = ir_op->as<IR::ConstantFloat>()) {
                ///@note notice that we got a gpr reg here
                mir_op = cur_varpool->getLoaded(f32->getVal(), blk).first;
            } else {
                mir_op = cur_varpool->getValue(*ir_op);
            }

            Err::gassert(mir_op != nullptr, "phieli: replace IR op with MIR op failed");

            dst_src_vec.emplace_back(target, mir_op);
        }

        ///@brief 准备删除PhiInst
        delList.insert(std::make_pair(phiInst, succ));
    }

    return dst_src_vec;
}

void PhiEliminatePass::MkWorkList() {
    auto &func_list = module->getFuncs();

    for (auto &func : func_list) {
        cur_func = func; ///@warning
        cur_varpool = &(cur_func->editInfo().varpool);

        PhiFunction func_phi;
        for (const auto &blk : func->getBlocks()) {
            for (const auto &succ : blk->getSuccs()) {
                if (!succ->containPhi) {
                    continue;
                }
                PhiBlkPairs blk_phipairs{func, blk, succ};
                blk_phipairs.pairs = std::move(findPair(blk, succ));
                func_phi.PhiList.emplace_back(blk_phipairs);
            }
        }

        if (!func_phi.PhiList.empty()) {
            processList.emplace_back(func_phi);
        }
    }
}

void PhiEliminatePass::pushBeforeBranch(const BlkP &emitBlk, std::string destBlk, const OperP &dst, OperP src) {

    Err::gassert(std::dynamic_pointer_cast<BindOnVirOP>(dst) != nullptr, "dst operand is a const value");

    std::list<InstP> insts;

    ///@brief 寻址操作数展开
    if (src->getOperandTrait() == OperandTrait::BaseAddress) {
        auto addressing = src->as<BaseADROP>();
        ///@bug 应当根据BaseADR的不同进行分类, 而不是直接弄一个新的
        ///@bug 但add1, add2都没有时, 应当考虑别的方式
        auto relay = cur_varpool->mkOP_backup(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
        InstP add1 = nullptr;
        InstP add2 = nullptr;

        if (addressing->getTrait() == BaseAddressTrait::Local) {
            auto stk = addressing->as<StackADROP>();
            auto unknown = make<UnknownConstant>(stk->getObj());
            add1 =
                make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, relay, addressing->getBase(), unknown, nullptr);
            insts.emplace_back(add1);
        }

        if (auto constoffset = addressing->getConstOffset()) {
            auto constobj = module->getConst(constoffset);
            if (isImmCanBeEncodedInText(static_cast<unsigned>(constoffset))) {
                add2 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, relay,
                                           add1 ? relay : addressing->getBase(), make<ConstantIDX>(constobj), nullptr);
            } else {
                auto loaded = cur_varpool->getLoaded(constoffset, emitBlk).first;
                add2 = make<binaryImmInst>(OpCode::ADD, SourceOperandType::rr, relay,
                                           add1 ? relay : addressing->getBase(), loaded, nullptr);
            }
            insts.emplace_back(add2);
        }

        if (add1 || add2) { // patch
            src = relay;
        }
    }

    auto dst_reg = dst->as<BindOnVirOP>();
    Err::gassert(dst_reg != nullptr, "phiEli: dst op(" + dst_reg->toString() + ") is not bind on reg bank");

    /// @note when copy a constant float to phioper, copy spr, gpr may happen
    // Err::gassert(src->as<BindOnVirOP>() == nullptr || src->as<BindOnVirOP>()->getBank() == dst_reg->getBank(),
    //              "phiEli: copy ops dosen't match");
    // Err::gassert(src->as<BindOnVirOP>() == nullptr || !(src->as<BindOnVirOP>()->getBank() == RegisterBank::spr &&
    //                                                     dst_reg->getBank() == RegisterBank::gpr),
    //              "phiEli: copy ops dosen't match");

    if (src->getName() == "%37" && dst->getName() == "%7") {
        int useless;
    }

    auto copy = std::make_shared<COPY>(dst_reg, src);
    insts.emplace_back(copy);
    ///@brief 插入到branch之前

    auto &instList = emitBlk->getInsts();

    for (auto it = instList.begin(); it != instList.end(); ++it) {
        auto &inst = *it;

        if (auto b = std::dynamic_pointer_cast<branchInst>(inst)) {
            if (std::get<OpCode>(b->getOpCode()) != OpCode::B || b->getJmpTo() != destBlk) {
                continue;
            } else {
                instList.insert(it, insts.begin(), insts.end());
                return; // 假设一个块到另一个块只存在一个对应的跳转指令
            }
        }
    }

    Err::unreachable("pushBeforeBranch didn't find a branch inst");
}

// 返回的是 COPY dst, stageR 中的stageR
// COPY stageR dst(暂存)
// COPY dst, src(runOnGraph中插入)
// push_before_branch
OperP PhiEliminatePass::addCOYPInst(const BlkP &emitBlk, std::string destBlk, const OperP &dst, const FuncP &func) {
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
    pushBeforeBranch(emitBlk, destBlk, stagedVal, dst);

    return stagedVal;
}

BlkP PhiEliminatePass::splitCriticalEgde(const BlkP &pred, const BlkP &succ, const FuncP &func) {
    ///@brief 判断 critical edge
    ///@note 这种两层map的好处是不用维护新出现的PhiBlkPairs
    if (pred->getSuccs().size() == 1 || succ->getPreds().size() == 1) {
        return pred;
    }

    if (getMidBlk.find(pred) == getMidBlk.end()) {
        getMidBlk[pred] = std::map<BlkP, BlkP>();
    }

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
    for (auto &phiBlk : func.PhiList) {
        cur_func = phiBlk.func;
        cur_varpool = &(cur_func->editInfo().varpool);
        RunOnBlkPair(phiBlk);
    }
}

void PhiEliminatePass::RunOnBlkPair(const PhiBlkPairs &process) {
    ///@note 每次只处理一对blks

    auto func = process.func;
    BlkP pred = process.src;
    BlkP succ = process.dst;
    auto vec = process.pairs; // dst, src

    struct Node {
        // 从目的寄存器指向源寄存器
        std::forward_list<unsigned int> nxt; // 指向该Node的源寄存器
        unsigned int indegree = 0;           // 由于phi函数性质, 这个地方要么0要么1
    };

    std::map<OperP, unsigned int> mapping;
    std::vector<Node> graph(vec.size());

    ///@brief 填充mapping
    for (int i = 0; i < vec.size(); ++i) {
        mapping[vec[i].second] = i; // bug but not a bug ?
    }

    ///@brief 填充graph
    for (int i = 0; i < vec.size(); ++i) {
        if (mapping.find(vec[i].first) != mapping.end()) {
            unsigned int src = i;
            auto dst = mapping[vec[i].first];

            // graph[src].nxt.push_front(dst);
            // ++graph[dst].indegree; ///@bug

            graph[dst].nxt.push_front(src);
            ++graph[src].indegree;
        }
    }

    ///@brief 遍历队列
    std::queue<unsigned> queue;
    for (int i = 0; i < vec.size(); ++i) {
        if (graph[i].indegree == 0) {
            queue.push(i);
        }
    }

    // find a stagedR by src
    std::map<OperP, OperP> StagedMap;

    BlkP emitBlk = splitCriticalEgde(pred, succ, func); // 中端做过了
    if (!emitBlk) {
        emitBlk = pred; // not a critical edge
    }

    auto limit = vec.size();
    for (int i = 0, j = 0; i < limit;) {

        ///@brief visit a node, and add COPY

        auto visit = [&](unsigned idx) {
            ///@note 遍历src
            ++i;

            // auto [src, dst] = vec[idx];
            auto [dst, src] = vec[idx];

            if (StagedMap.find(src) != StagedMap.end()) {
                src = StagedMap[src]; // 无需stage(暂时不需要)
            }

            if (graph[idx].indegree) {
                ///@note 可能会出现一种比较极端的情况, %0 = phi [... ...], ..., [%0, ...]
                ///@note 理论上由于单赋值, 所以不需要做什么, 但是算法会还是会插入一个stage, 以及一个冗余的copy
                Err::gassert(graph[idx].indegree == 1, "indegree must be 1");
                Logger::logDebug("phiEli: need a stage by " + dst->toString());

                graph[idx].indegree = 0;
                auto stagedVal = addCOYPInst(emitBlk, succ->getName(), dst, func); // push_before_branch
                StagedMap[dst] = stagedVal;
            }

            pushBeforeBranch(emitBlk, succ->getName(), dst, src); ///@bug, src和dst可能还需要再考虑一下

            auto &node = graph[idx];
            for (auto nxt : node.nxt) { // 源操作数
                auto &nxt_node = graph[nxt];
                // Err::gassert(nxt_node.indegree == 1, "phiEli: source phi op is not 1 indegree");
                --nxt_node.indegree;
                if (nxt_node.indegree == 0) {
                    queue.push(nxt);
                }
            }
        };

        ///@brief topo sorted
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
                if (!queue.empty()) {
                    break;
                }
            }
        }
    }
}
} // namespace MIR
#endif