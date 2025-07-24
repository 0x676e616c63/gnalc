// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/MIR.hpp"
#include "mir/passes/transforms/RA.hpp"
#include "mir/tools.hpp"
#include <algorithm>
#include <string>

using namespace MIR;

PM::PreservedAnalyses RegisterAlloc::run(MIRFunction &mfunc, FAM &fam) {
    mfunc.calleeSaveRegs() = mfunc.Context().registerInfo->initCalleeSaveBitmap();

    VectorRegisterAllocImpl vectorRA;
    vectorRA.impl(mfunc, fam);

    RegisterAllocImpl coreRA;
    coreRA.impl(mfunc, fam);

    return PM::PreservedAnalyses::all();
}

bool RegisterAllocImpl::Edge::operator==(const Edge &another) const {
    return (another.u == u && another.v == v) || (another.v == u && another.u == v);
}

void RegisterAllocImpl::clearall() {
    precolored.clear();
    initial.clear();
    simplifyWorkList.clear();
    freezeWorkList.clear();
    spilledNodes.clear();
    coalescedNodes.clear();
    spillWorkList.clear();
    coloredNodes.clear();
    selectStack.clear();
    coalescedMoves.clear();
    constrainedMoves.clear();
    frozenMoves.clear();
    worklistMoves.clear();
    activeMoves.clear();
    adjSet.clear();
    adjList.clear();
    degree.clear();
    moveList.clear();
    alias.clear();
    colors.clear();
    spilltimes = 0;
    isInitialized = false;
    GeneratedBySpill.clear();
}

void RegisterAllocImpl::impl(MIRFunction &_mfunc, FAM &fam) {
    mfunc = &_mfunc;
    registerInfo = mfunc->Context().registerInfo;
    frameInfo = mfunc->Context().frameInfo;

    clearall();

    K = registerInfo->getCoreRegisterNum();
    colors = registerInfo->getCoreRegisterAllocationList();

    ///@note remember to modify bitmap of mfunc when assign colors
    Main(fam);

    auto &spilled = mfunc->spill();
    spilled += spilltimes;

    Logger::logInfo("RegisterAllocImpl: " + mfunc->getName() + " spilled times: " + std::to_string(spilltimes));
}

void RegisterAllocImpl::Main(FAM &fam) {

    ///@note this will be easier to read flame graph
    do {
        if (isInitialized) {
            ReWriteProgram();
        }

        liveinfo = fam.getFreshResult<LiveAnalysis>(*mfunc);

        Build(); // set isInitialed as true
        MkWorkList();

        while (!simplifyWorkList.empty() || !worklistMoves.empty() || !freezeWorkList.empty() ||
               !spillWorkList.empty()) {
            if (!simplifyWorkList.empty()) {
                Simplify();
            } else if (!worklistMoves.empty()) {
                Coalesce();
            } else if (!freezeWorkList.empty()) {
                Freeze();
            } else if (!spillWorkList.empty()) {
                SelectSpill();
            }
        }

        AssignColors();

    } while (!spilledNodes.empty());
}

void RegisterAllocImpl::AddEdge(const MIROperand_p &u, const MIROperand_p &v) {
    Edge edge{u, v};

    if (u != v && !adjSet.count(edge)) {
        adjSet.insert(std::move(edge));

        if (!precolored.count(u)) { // not precolored
            adjList[u].insert(v);
            ++degree[u];
        }

        if (!precolored.count(v)) {
            adjList[v].insert(u);
            ++degree[v];
        }
    }
}

void RegisterAllocImpl::Build() {
    ///@note MkInitial
    if (!isInitialized) {

        for (const auto &blk : mfunc->blks()) {
            for (const auto &inst : blk->Insts()) {

                const auto &use = getUse(inst);
                const auto &def = getDef(inst);

                for (const auto &n : getUnion<MIROperand_p, false>(def, use)) {
                    if (n->isISA()) {
                        if (registerInfo->isCoreReg(n->isa())) {
                            precolored.insert(n);
                            degree[n] = -1;
                        }
                    } else if (n->isVReg() && isCore(n)) {
                        initial.insert(n);
                    } else {
                        Err::unreachable("trying to alloc register for a constant");
                    }
                }
            }
        }
    }
    isInitialized = true;

    for (const auto &blk : mfunc->blks()) {
        auto live = liveinfo.liveOut[blk];

        for (auto it = live.begin(); it != live.end();) {
            if (isExt(*it) || (*it)->isStack()) {
                it = live.erase(it);
            } else {
                ++it;
            }
        }

        const auto &insts = blk->Insts();

        for (auto inst_it = insts.rbegin(); inst_it != insts.rend(); ++inst_it) {
            const auto &inst = *inst_it;

            const auto &use = getUse(inst);
            const auto &def = getDef(inst);

            if (isMoveInstruction(inst)) {
                delBySet(live, use);

                for (const auto &n : getUnion<MIROperand_p, false>(def, use)) {
                    addBySet(moveList[n], Moves{inst});
                }

                addBySet(worklistMoves, Moves{inst});
            }

            addBySet(live, def);

            for (const auto &d : def) {
                for (const auto &l : live) {
                    AddEdge(l, d);
                }
            }

            delBySet(live, def);
            addBySet(live, use);
        }
    }
}

void RegisterAllocImpl::MkWorkList() {
    for (auto it = initial.begin(); it != initial.end();) {
        const auto n = *it;

        it = std::next(it);
        delBySet(initial, WorkList{n});

        if (!isVirtualReg(n->getRecover()) || n->isStack()) {
            continue;
        }

        if (degree[n] >= K) {
            addBySet(spillWorkList, WorkList{n});
        } else if (MoveRelated(n)) {
            addBySet(freezeWorkList, WorkList{n});
        } else if (isCore(n)) {
            addBySet(simplifyWorkList, WorkList{n});
        }
    }
}

void RegisterAllocImpl::Simplify() {

    auto it = simplifyWorkList.begin();

    auto n = *it;

    Err::gassert(n != nullptr, "n is nullptr");

    simplifyWorkList.erase(it);

    !n->isStack() ? void(selectStack.emplace_back(n)) : nop;

    for (const auto &m : Adjacent(n)) {
        DecrementDegree(m);
    }
}

void RegisterAllocImpl::DecrementDegree(const MIROperand_p &m) {
    Err::gassert(m != nullptr, "m is nullptr");

    auto d = degree[m];

    --degree[m];

    if (d == K) {
        EnableMoves(getUnion<MIROperand_p>(Nodes{m}, Adjacent(m)));
        delBySet(spillWorkList, WorkList{m});

        if (MoveRelated(m)) {
            addBySet(freezeWorkList, WorkList{m});
        } else {
            addBySet(simplifyWorkList, WorkList{m});
        }
    }
}

void RegisterAllocImpl::EnableMoves(const Nodes &nodes) {
    for (const auto &n : nodes) {
        for (const auto &m : NodeMoves(n)) {
            if (activeMoves.count(m)) {
                delBySet(activeMoves, Moves{m});
                addBySet(worklistMoves, Moves{m});
            }
        }
    }
}

void RegisterAllocImpl::Coalesce() {

    auto it = worklistMoves.begin();

    auto m = *it;
    worklistMoves.erase(m);

    Err::gassert(getDef(m).size() == 1 && getUse(m).size() == 1, "Coalesce a invalid 'move' inst");

    auto x = *(getDef(m).begin());
    auto y = *(getUse(m).begin());

    auto x_a = GetAlias(x);
    auto y_a = GetAlias(y);

    Edge edge{nullptr, nullptr};
    // {isa, vreg}, {isa, isa}, {vreg, vreg}
    if (precolored.count(y_a)) {
        edge.u = y_a, edge.v = x_a;
    } else {
        edge.u = x_a, edge.v = y_a;
    }

    auto &u = edge.u;
    auto &v = edge.v;
    if (u == v) {
        // 两边相同, 标记为合并的move
        addBySet(coalescedMoves, Moves{m});
        AddWorkList(u);
    } else if (precolored.count(v) || adjSet.count(edge)) {
        // {isa, isa}
        // 或者两边冲突
        // 标记为限制合并

        addBySet(constrainedMoves, Moves{m});
        AddWorkList(u);
        AddWorkList(v);
    }
    ///@note 将论文的一个if-else拆成了两个
    else if (precolored.count(u)) {
        ///@note George check
        // {isa, ...}
        // 对于任意一个v的邻接结点: 冲突小于k || 预着色 || 与u冲突

        bool flag = true;
        for (const auto &t : Adjacent(v)) {
            if (!OK(t, u)) {
                flag = false;
                break;
            }
        }

        if (flag) {
            goto __Combine_try;
        } else {
            goto __Combine_giveup;
        }

    } else if (!precolored.count(u) && Conservative(getUnion<MIROperand_p>(Adjacent(u), Adjacent(v)))) {
    ///@note Briggs check
    __Combine_try:
        addBySet(coalescedMoves, Moves{m});
        Combine(u, v);
        AddWorkList(u);
    } else {
    __Combine_giveup:
        addBySet(activeMoves, Moves{m});
    }
}

void RegisterAllocImpl::AddWorkList(const MIROperand_p &u) {
    if (!precolored.count(u) && !MoveRelated(u) && degree[u] < K) {
        delBySet(freezeWorkList, WorkList{u});
        addBySet(simplifyWorkList, WorkList{u});
    }
}

void RegisterAllocImpl::Combine(const MIROperand_p &u, const MIROperand_p &v) {
    if (freezeWorkList.count(v)) {
        delBySet(freezeWorkList, WorkList{v});
    } else {
        delBySet(spillWorkList, WorkList{v});
    }

    addBySet(coalescedNodes, Nodes{v});
    alias[v] = u;

    addBySet(moveList[u], moveList[v]);

    for (const auto &t : Adjacent(v)) {
        AddEdge(t, u);
        DecrementDegree(t);
    }

    if (degree[u] >= K && freezeWorkList.count(u)) {
        delBySet(freezeWorkList, WorkList{u});
        addBySet(spillWorkList, WorkList{u});
    }
}

void RegisterAllocImpl::Freeze() {

    auto u = *freezeWorkList.begin();

    // auto u = *it;

    delBySet(freezeWorkList, WorkList{u});

    addBySet(simplifyWorkList, WorkList{u});

    FreezeMoves(u);
}

void RegisterAllocImpl::FreezeMoves(const MIROperand_p &u) {
    for (const auto &m : NodeMoves(u)) {

        Err::gassert(isMoveInstruction(m), "try Coalesce a not move inst");
        Err::gassert(getDef(m).size() == 1 && getUse(m).size() == 1, "Coalesce a invalid 'move' inst");

        auto v = (*getDef(m).begin()) == u ? *(getUse(m).begin()) : *(getDef(m).begin());

        if (activeMoves.count(m)) {
            delBySet(activeMoves, Moves{m});
        } else {
            delBySet(worklistMoves, Moves{m});
        }

        addBySet(frozenMoves, Moves{m});

        if (NodeMovesEmpty(v) && degree[v] < K) {
            delBySet(freezeWorkList, WorkList{v});
            addBySet(simplifyWorkList, WorkList{v});
        }
    }
}

void RegisterAllocImpl::SelectSpill() {
    auto m = heuristicSpill();

    delBySet(spillWorkList, WorkList{m});
    addBySet(simplifyWorkList, WorkList{m});

    FreezeMoves(m);
}

void RegisterAllocImpl::AssignColors() {
    while (!selectStack.empty()) {
        auto &n = selectStack.back();
        selectStack.pop_back();

        if (precolored.count(n)) {
            auto &calleesave = mfunc->calleeSaveRegs();
            calleesave |= 1LL << n->reg();
            continue;
        } else if (n->isStack()) {
            continue;
        }

        std::vector<unsigned int> okColors(colors.begin(), colors.end());

        for (const auto &w : adjList[n]) { // choose a color not assigned

            auto w_a = GetAlias(w);

            if (isInUnion<MIROperand_p>(w_a, coloredNodes, precolored)) {

                Err::gassert(w_a->isVRegOrISAReg(), "try assign color for a none virReg op");

                auto reg = w_a->isa();

                auto it =
                    std::find_if(okColors.begin(), okColors.end(), [&](const unsigned &_reg) { return _reg == reg; });

                if (it != okColors.end()) {
                    okColors.erase(it);
                }
            }
        }

        if (okColors.empty()) {
            addBySet(spilledNodes, Nodes{n});
        }
        // else if (precolored.count(n)) {
        //     auto &calleesave = mfunc->calleeSaveRegs();
        //     calleesave |= 1LL << n->reg(); // marked
        // } else if (n->isStack()) {
        //     ;
        // }
        else {

            addBySet(coloredNodes, Nodes{n});

            unsigned int c;
            if (okColors.size()) {

                if (mfunc->Context().isARMv8()) {
                    int calleesave_cnt = 0;
                    auto _ = std::find_if(okColors.begin(), okColors.end(), [&](auto &&elem) {
                        ++calleesave_cnt;
                        return elem > 18;
                    });

                    if (calleesave_cnt < 6) {
                        goto __use_fallback;
                    } else {
                        c = okColors[n->getRecover() % calleesave_cnt]; // prefer caller-saves
                    }

                } else if (mfunc->Context().isRISCV64()) {
                    goto __use_fallback;
                }
            } else {
            __use_fallback:
                c = okColors[n->getRecover() % okColors.size()]; // fallback
            }

            auto &calleesave = mfunc->calleeSaveRegs();
            calleesave |= 1LL << c; // marked

            // if (!n->isPreColored())
            n->assignColor(c);
        }
    }

    for (auto &n : coalescedNodes) {

        auto n_a = GetAlias(n);

        Err::gassert(n->isVRegOrISAReg(), "AssignColors: try assign color for a none virReg op");
        Err::gassert(n_a->isVRegOrISAReg(), "AssignColors: try assign color for a none virReg op");

        if (n_a->isVReg()) {
            continue;
        }

        auto &calleesave = mfunc->calleeSaveRegs();
        calleesave |= 1LL << n_a->reg();

        n->assignColor(n_a->reg());
    }
}

void RegisterAllocImpl::ReWriteProgram() {
    initial.clear();
    for (const auto &n : spilledNodes) {
        auto ops_new = spill(n);

        addBySet(initial, ops_new);
        // Logger::logInfo("ReWriteProgram: old operand: " + std::to_string(n->getRecover()) +
        //                 ", new operand size: " + std::to_string(ops_new.size()));

        addBySet(GeneratedBySpill, ops_new);
    }

    spilledNodes.clear();
    addBySet(initial, coalescedNodes);
    addBySet(initial, coloredNodes);

    coloredNodes.clear();
    coalescedNodes.clear();
}

RegisterAllocImpl::Nodes RegisterAllocImpl::Adjacent(const MIROperand_p &n) {
    return getExclude<MIROperand_p>(adjList[n], std::unordered_set(selectStack.begin(), selectStack.end()),
                                    coalescedNodes);
}

RegisterAllocImpl::Moves RegisterAllocImpl::NodeMoves(const MIROperand_p &n) {
    Err::gassert(n != nullptr, "n is nullptr");

    Moves movs{};

    const auto &moveListOfn = moveList[n];
    for (const auto &p : activeMoves) {
        if (moveListOfn.count(p))
            movs.insert(p);
    }

    for (const auto &p : worklistMoves) {
        if (moveListOfn.count(p))
            movs.insert(p);
    }

    return movs;
}

bool RegisterAllocImpl::NodeMovesEmpty(const MIROperand_p &n) {
    Err::gassert(n != nullptr, "n is nullptr");

    for (const auto &rp : moveList[n]) {
        if (activeMoves.count(rp) || worklistMoves.count(rp)) {
            return false;
        }
    }

    return true;
}

bool RegisterAllocImpl::MoveRelated(const MIROperand_p &n) { return !NodeMovesEmpty(n); }

bool RegisterAllocImpl::OK(const MIROperand_p &t, const MIROperand_p &r) {
    if (degree[t] < K) {
        return true;
    } else if (t->isISA()) {
        return true;
    } else if (adjSet.find(Edge{t, r}) != adjSet.end()) {
        return true;
    } else {
        return false;
    }
}

bool RegisterAllocImpl::Conservative(const Nodes &nodes) {
    unsigned int k = 0;

    for (const auto &n : nodes) {
        if (degree[n] >= K) {
            ++k;
        }
    }

    return k < K;
}

MIROperand_p RegisterAllocImpl::GetAlias(MIROperand_p n) { // NOLINT
    if (coalescedNodes.count(n))
        return GetAlias(alias[n]);

    Err::gassert(n != nullptr, "get a nullptr alias");

    return n;
}

void VectorRegisterAllocImpl::impl(MIRFunction &_mfunc, FAM &fam) {
    mfunc = &_mfunc;
    registerInfo = mfunc->Context().registerInfo;
    frameInfo = mfunc->Context().frameInfo;

    clearall();

    K = registerInfo->getFpOrVecRegisterNum();
    colors = registerInfo->getFpOrVecRegisterAllocationList();

    Main(fam);

    auto &spilled = mfunc->spill();
    spilled += spilltimes;

    Logger::logInfo("VectorRegisterAllocImpl: " + mfunc->getName() + " spilled times: " + std::to_string(spilltimes));
}

void VectorRegisterAllocImpl::Build() {
    ///@note MkInitial
    if (!isInitialized) {

        for (const auto &blk : mfunc->blks()) {
            for (const auto &inst : blk->Insts()) {

                const auto &use = getUse(inst);
                const auto &def = getDef(inst);

                for (const auto &n : getUnion<MIROperand_p, false>(def, use)) {
                    if (n->isISA()) {
                        if (registerInfo->isFpOrVecReg(n->isa())) {
                            precolored.insert(n);
                            degree[n] = -1;
                        }
                    } else if (n->isVReg() && isExt(n)) {
                        initial.insert(n);
                    } else {
                        Err::unreachable("trying to alloc register for a constant");
                    }
                }
            }
        }
    }
    isInitialized = true;

    for (const auto &blk : mfunc->blks()) {

        auto live = liveinfo.liveOut[blk];

        for (auto it = live.begin(); it != live.end();) {
            if (isCore(*it)) {
                it = live.erase(it);
            } else {
                ++it;
            }
        }

        const auto &insts = blk->Insts();

        for (auto inst_it = insts.rbegin(); inst_it != insts.rend(); ++inst_it) {
            const auto &inst = *inst_it;

            const auto &use = getUse(inst);
            const auto &def = getDef(inst);

            if (isMoveInstruction(inst)) {
                delBySet(live, use);

                for (const auto &n : getUnion<MIROperand_p, false>(def, use)) {
                    addBySet(moveList[n], Moves{inst});
                }

                addBySet(worklistMoves, Moves{inst});
            }

            addBySet(live, def);

            for (const auto &d : def) {
                for (const auto &l : live) {
                    AddEdge(l, d);
                }
            }

            delBySet(live, def);
            addBySet(live, use);
        }
    }
}

void VectorRegisterAllocImpl::MkWorkList() {
    for (auto it = initial.begin(); it != initial.end();) {
        const auto n = *it;

        if (degree[n] >= K) {
            addBySet(spillWorkList, WorkList{n});
        } else if (MoveRelated(n)) {
            addBySet(freezeWorkList, WorkList{n});
        } else if (isExt(n)) {
            addBySet(simplifyWorkList, WorkList{n});
        }

        it = std::next(it);
        delBySet(initial, WorkList{n});
    }
}