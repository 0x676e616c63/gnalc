#include "mir/passes/transforms/scheduling.hpp"
#include <queue>

using namespace MIR_new;

PM::PreservedAnalyses PreRaScheduling::run(MIRFunction &_mfunc, FAM &_fam) {
    class PreRaSchedulingImpl impl(_mfunc, _fam);

    impl.Impl();

    return PM::PreservedAnalyses::all();
}

PM::PreservedAnalyses PostRaScheduling::run(MIRFunction &_mfunc, FAM &_fam) {
    class PostRaSchedulingImpl impl(_mfunc, _fam);

    impl.Impl();

    return PM::PreservedAnalyses::all();
}

void PreRaSchedulingImpl::Impl() {
    MkDAG();
    Scheduling();
    return;
}

void PreRaSchedulingImpl::MkDAG() {
    ///@todo
    return;
}

void PreRaSchedulingImpl::Scheduling() {
    ///@todo
    return;
}

void PostRaSchedulingImpl::Impl() {

    for (auto &mblk : mfunc.blks()) {
        cur_mblk = mblk;
        SchedulingModule Module{cur_mblk, {}, {}, {}};
        MkDAG(Module);
        Scheduling(Module);
    }

    return;
}

void PostRaSchedulingImpl::MkDAG(SchedulingModule &Module) {
    auto &antideps = Module.antideps;
    auto &degrees = Module.degrees; // 入度
    auto &rank = Module.rank;

    UM<unsigned, std::vector<MIRInst_p>> LatestUse;
    UM<unsigned, MIRInst_p> LatestDef;

    MIRInst_p LatestInst_SideEffect = nullptr;
    MIRInst_p LatestInst_ForcedInOrder = nullptr;

    // LAMBDA BEGIN

    ///@brief v antidepand on u (u depand on v), v have to exec before u,
    ///@brief and, in this prosedure, v means prev, u means succ
    auto newDependency = [&antideps, &degrees](MIRInst_p u, MIRInst_p v) {
        if (u != v && antideps[v].insert(u).second) {
            ++degrees[u];
        }
    };

    auto getDef = [](MIRInst_p inst) { return inst->getDef() ? inst->getDef()->isa() : -1; };

    auto getUses = [](MIRInst_p inst) {
        std::list<unsigned> tmp = {}; // register list
        for (int i = 1; i <= inst->getUseNr(); ++i) {
            auto &mop = inst->getOp(i);

            if (mop && mop->isReg()) {
                mop->isStack() ? tmp.emplace_back(ARMReg::SP) : tmp.emplace_back(mop->isa());
            }
        }

        return tmp;
    };

    auto hasSideEffect = [](MIRInst_p inst) -> bool {
        // 访存, 跳转, 标志位设置

        if (!inst->isGeneric()) {
            switch (inst->opcode<ARMOpC>()) {
            case ARMOpC::LDR:
            case ARMOpC::STR:
            // case ARMOpC::ADRP: // 仅读, 无副作用
            case ARMOpC::BL:
            case ARMOpC::CBNZ:
            case ARMOpC::LD1:
            case ARMOpC::LD2:
            case ARMOpC::LD3:
            case ARMOpC::LDUR:
            case ARMOpC::PUSH:
            case ARMOpC::POP:
            case ARMOpC::RET:
            case ARMOpC::ST1:
            case ARMOpC::ST2:
            case ARMOpC::ST3:
            case ARMOpC::STUR:
                return true;
            default:
                return false;
            }
        } else {
            switch (inst->opcode<OpC>()) {
            case OpC::InstBranch:
            case OpC::InstCopyStkPtr:
            case OpC::InstFCmp:
            case OpC::InstICmp:
            case OpC::InstLoad:
            case OpC::InstLoadGlobalAddress:
            case OpC::InstLoadRegFromStack:
            case OpC::InstLoadStackObjectAddr:
            case OpC::InstStore:
            case OpC::InstStoreRegToStack:
                return true;
            default:
                return false;
            }
        }
    };

    auto mustInOrder = [&hasSideEffect](MIRInst_p inst) -> bool {
        // pop push call ret b cbnz
        if (!inst->isGeneric()) {
            switch (inst->opcode<ARMOpC>()) {
            case ARMOpC::CSET_SELECT:
            case ARMOpC::CSEL:
            case ARMOpC::FCSEL:
            case ARMOpC::CSET:
            case ARMOpC::PUSH:
            case ARMOpC::POP:
            case ARMOpC::RET:
            case ARMOpC::BL:
            case ARMOpC::CBNZ:
                return true;
            default:
                return false;
            }
        } else {
            switch (inst->opcode<OpC>()) {
            case OpC::InstSelect:
            case OpC::InstICmp:
            case OpC::InstFCmp:
            case OpC::InstBranch:
                return true;
            default:
                return false;
            }
        }
    };

    // LAMBDA END

    ///@brief make DAGs
    auto &minsts = cur_mblk->Insts();
    for (auto &minst : minsts) {
        auto def = getDef(minst);
        auto uses = getUses(minst);

        ///@brief 遍历uses, 查询use的上一个defInst, 添加依赖
        ///@brief 将该useInst添加到use的最近使用列表
        for (auto use : uses) {
            if (auto it = LatestDef.find(use); it != LatestDef.end()) {
                newDependency(minst, it->second);
            }

            LatestUse[use].emplace_back(minst);
        }

        ///@brief 对最近使用过def的useInst, minst依赖于useInst, 即useInst需要在minst之前执行
        for (auto useInst : LatestUse[def]) {
            newDependency(minst, useInst);
        }

        LatestUse[def] = {minst}; // clear, and this is why u == v is possible
        LatestDef[def] = minst;

        if (LatestInst_ForcedInOrder) {
            newDependency(minst, LatestInst_ForcedInOrder);
        }

        if (hasSideEffect(minst)) {
            if (LatestInst_SideEffect) {
                newDependency(minst, LatestInst_SideEffect);
            }
            ///@brief 更新上一个sideEffect
            LatestInst_SideEffect = minst;

            if (mustInOrder(minst)) {

                for (auto &prevs : minsts) {
                    if (prevs == minst) {
                        break;
                    }
                    newDependency(minst, prevs);
                }

                ///@brief 更新上一个mustInOrder
                LatestInst_ForcedInOrder = minst;
            }
        }
    }

    UM<MIRInst_p, US<MIRInst_p>> deps;
    UM<MIRInst_p, unsigned> outDegree; // 出度

    // antideps -> deps, fill in degree
    for (auto &minst : minsts) {
        for (auto prev : antideps[minst]) {
            deps[prev].emplace(minst);
            ++outDegree[prev];
        }
    }

    std::queue<MIRInst_p> queue; // 拓扑序

    for (auto &minst : minsts) {
        if (outDegree[minst] == 0) { // or !outDegree.count(minst)
            rank.emplace(minst, 0);
            queue.push(minst);
        }
    }

    while (queue.size()) {
        auto u = queue.front();
        queue.pop();

        auto rank_u = rank[u];

        ///@brief 选取最大的rank + 1
        for (auto &v : deps[u]) {
            auto &rank_v = rank[v];
            rank_v = std::max(rank_v, rank_u + 1);

            if (--outDegree[v] == 0) {
                queue.push(v);
            }
        }
    }

    return;
}

void PostRaSchedulingImpl::Scheduling(SchedulingModule &Module) {

    auto scheduled_insts = Module.scheduling();

    cur_mblk->replaceInsts(scheduled_insts);

    return;
}

MIRInst_p_l SchedulingModule::scheduling() {

    MIRInst_p_l newInsts;
    MIRInst_p_l readyInsts;
    UM<MIRInst_p, unsigned> readyTimes;

    // LAMBDA BEGIN

    auto dynamicRank = [&](MIRInst_p inst, unsigned cur_cycle) {
        unsigned waitPenalty = 1; // need a fuzz
        return rank[inst] + (cur_cycle - readyTimes[inst]) * waitPenalty;
    };

    // LAMBDA END

    auto minsts = mblk->Insts(); // ??
    int expect_size = minsts.size();
    for (const auto &minst : minsts) {

        if (degrees[minst] == 0) {
            readyInsts.emplace_back(minst);
        }
    }

    unsigned cycle = 0, lastSuccessCycle = 0;

    while (newInsts.size() < expect_size) {
        MIRInst_p_l newInReady;

        ///@note 由于ALU可以双发射, 所以这里尝试两次
        for (int issue = 0; issue < multipleIssue; ++issue) {
            unsigned trySchCount = 0;
            bool success = false;

            readyInsts.sort(
                [&](const auto &l, const auto &r) { return dynamicRank(l, cycle) > dynamicRank(r, cycle); });

            while (trySchCount < readyInsts.size()) { // 最大尝试数量
                auto minst = readyInsts.front();
                readyInsts.pop_front();

                if (instScheduling(minst, cycle)) {
                    newInsts.emplace_back(minst);

                    lastSuccessCycle = 0;
                    success = true;

                    for (auto v : antideps[minst]) {
                        --degrees[v];
                        if (!degrees[v]) {
                            newInReady.emplace_back(v);
                        }
                    }

                    break;
                }

                ++trySchCount;
                readyInsts.emplace_back(minst); // lately will try again
            }

            if (!success) {
                break;
            }
        }

        ++cycle;
        ++lastSuccessCycle;

        Err::gassert(lastSuccessCycle < 256, "scheduling: deadlock occurred");

        for (auto &minst : newInReady) {
            ///@brief add into ready list of next cycle
            readyTimes[minst] = cycle;
            readyInsts.emplace_back(minst);
        }
    }

    return newInsts;
}

bool SchedulingModule::instScheduling(const MIRInst_p &minst, unsigned cycle) {
    // LAMBDA BEGIN

    auto getDef = [](MIRInst_p inst) { return inst->getDef() ? inst->getDef()->reg() : -1; };

    auto getUses = [](MIRInst_p inst) {
        std::list<unsigned> tmp = {}; // register list
        for (int i = 1; i <= inst->getUseNr(); ++i) {
            auto &mop = inst->getOp(i);

            if (mop && mop->isReg()) {
                mop->isStack() ? tmp.emplace_back(ARMReg::SP) : tmp.emplace_back(mop->reg());
            }
        }

        return tmp;
    };

    // LAMBDA END

    auto [latency, issueCycles, resource] = schedInfo(minst->opcode());

    if (!resource) {
        ///@note 难以调度或者不应调度的inst
        return true;
    }

    /// step1 : 检查指令发射条件
    bool regReady = true;
    for (auto &use : getUses(minst)) {
        if (cycle >= RegisterResources[ARMReg(use)]) {
            continue;
        }
        regReady = false;
    }

    if (!regReady) {
        return false;
    }

    /// step2 : 检查指令所需硬件
    bool machineReady = false;

    if (resource == A53UnitALU) {
        if (MachineResources[A53UnitALU_1] <= cycle || MachineResources[A53UnitALU_2] <= cycle) {
            machineReady = true;
        }
    } else {
        if (MachineResources[ResourcesA53(resource)] <= cycle) {
            return true;
        }
    }

    if (!machineReady) {
        return false;
    }

    /// step3 : 确认发射, 修改资源预期

    auto def = getDef(minst);

    RegisterResources[ARMReg(def)] = cycle + latency;

    MachineResources[ResourcesA53(resource)] = cycle + issueCycles;

    return true;
}