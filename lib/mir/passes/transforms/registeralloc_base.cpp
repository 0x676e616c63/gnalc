#include "../../../../include/mir/passes/transforms/registeralloc.hpp"
#include "../../../../include/mir/passes/transforms/uselessMovEli.hpp"
#include <algorithm>
#include <numeric>
#include <random>
#include <utility>

using namespace MIR;

bool RAPass::Edge::operator==(const Edge &another) const {
    return (another.u == u && another.v == v) || (another.u == v && another.v == u);
}

std::size_t RAPass::EdgeHash::operator()(const Edge &_edge) const {
    return std::hash<std::size_t>()((size_t)(_edge.v.get()) ^ (size_t)(_edge.u.get()));
    // 这么写可能合理, 但这么写合理不太可能
}

PM::PreservedAnalyses RAPass::run(Function &bkd_function, FAM &fam) {
    Func = &bkd_function;                                          ///@bug
    availableSRegisters = &(Func->editInfo().availableSRegisters); ///@bug
    varpool = &(Func->editInfo().varpool);
    liveinfo = fam.getResult<LiveAnalysis>(bkd_function);

    spilltimes = 0;
    isInitialed = false;

    Func->editInfo().regdit_s.insert({
        0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 15,
        16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
    });

    Main();

    ///@bug
    // Func->editInfo().regdit_s.erase(availableSRegisters->begin(), availableSRegisters->end());

    for (auto item : *availableSRegisters) {
        Func->editInfo().regdit_s.erase(item);
    }

    Func->editInfo().spilltimes += spilltimes;
    /// debug用
    Func->editInfo().liveinfo = liveinfo; // copy

    return PM::PreservedAnalyses::all();
}

void RAPass::Main() {
    Build();
    MkWorkList();

    while (!simplifyWorkList.empty() || !worklistMoves.empty() || !freezeWorkList.empty() || !spillWorkList.empty()) {
        if (!simplifyWorkList.empty())
            Simplify();
        else if (!worklistMoves.empty())
            Coalesce();
        else if (!freezeWorkList.empty())
            Freeze();
        else if (!spillWorkList.empty())
            SelectSpill();
    }

    AssignColors();

    if (!spilledNodes.empty()) {
        ReWriteProgram();

        Main();
    }
}

void RAPass::AddEdge(const OperP &u, const OperP &v) {
    Edge edge{u, v};

    if (u != v && adjSet.find(edge) == adjSet.end()) {
        adjSet.insert(std::move(edge));

        if (precolored.find(u) == precolored.end()) { // not precolored
            adjList[u].insert(v);
            ++degree[u];
        }

        if (precolored.find(v) == precolored.end()) {
            adjList[v].insert(u);
            ++degree[v];
        }
    }
}

void RAPass::Build() {
    ///@note MkInitial
    if (!isInitialed) {

        ///@note 在原算法基础上, 顺便填写initial 和 precolored
        ///@note 只有第一次才这么做
        for (const auto &blk : Func->getBlocks()) {
            for (const auto &inst : blk->getInsts()) {

                const auto &use = getUse(inst);
                const auto &def = getDef(inst);

                for (const auto &n : getUnion<OperP>(def, use)) {
                    if (std::dynamic_pointer_cast<PreColedOP>(n)) {
                        precolored.insert(n);
                        degree[n] = -1; // 可能多次赋值
                    } else if (auto addr = std::dynamic_pointer_cast<BaseADROP>(n)) {
                        if (!std::dynamic_pointer_cast<PreColedOP>(addr->getBase())) {
                            ///@warning 如果寻址范围大于4096字节, 可能需要再加一个pass
                            ///@warning 或者更改指令选择
                            initial.insert(addr->getBase());
                        }
                    } else if (std::dynamic_pointer_cast<BindOnVirOP>(n))
                        initial.insert(n);
                    else
                        Err::unreachable("trying to alloc register for a constant");
                }
            }
        }
    }
    isInitialed = true;

    for (const auto &blk : Func->getBlocks()) {

        auto live = liveinfo.liveOut[blk];
        const auto &insts = blk->getInsts();

        for (auto inst_it = insts.rbegin(); inst_it != insts.rend(); ++inst_it) {
            const auto &inst = *inst_it;

            // if (uselessMovEli::isUseless(inst))
            //     continue;

            const auto &use = getUse(inst);
            const auto &def = getDef(inst);

            if (isMoveInstruction(inst)) {
                delBySet(live, use);

                for (const auto &n : getUnion<OperP>(def, use)) {
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

void RAPass::MkWorkList() {
    for (auto it = initial.begin(); it != initial.end();) {
        const auto n = *it;

        Err::gassert(n != nullptr, "n is nullptr");
        Err::gassert(std::dynamic_pointer_cast<PreColedOP>(n) == nullptr, "try put a precolored op into initial");

        if (degree[n] >= K) {
            addBySet(spillWorkList, WorkList{n});
        } else if (MoveRelated(n)) {
            addBySet(freezeWorkList, WorkList{n});
        } else {
            addBySet(simplifyWorkList, WorkList{n});
        }

        it = std::next(it);
        delBySet(initial, WorkList{n}); ///@bug
    }
}

void RAPass::Simplify() {
    ///@note 理论上论文这里也是一种启发式算法: 从simplifyWorkList随便取出一个

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<std::size_t> dist(0, simplifyWorkList.size() - 1);
    std::size_t randomIdx = dist(gen);

    auto it = simplifyWorkList.begin();

    std::advance(it, randomIdx);

    const auto n = *it;

    Err::gassert(n != nullptr, "n is nullptr");

    simplifyWorkList.erase(it); ///@bug

    selectStack.emplace_back(n);

    for (const auto &m : Adjacent(n)) {
        DecrementDegree(m);
    }
}

void RAPass::DecrementDegree(const OperP &m) {
    Err::gassert(m != nullptr, "m is nullptr");

    auto d = degree[m];

    ///@bug
    // if (!std::dynamic_pointer_cast<PreColedOP>(m))
    //     --degree[m];

    --degree[m];

    if (d == K) {
        EnableMoves(getUnion<OperP>(Nodes{m}, Adjacent(m)));
        delBySet(spillWorkList, WorkList{m});

        if (MoveRelated(m)) {
            addBySet(freezeWorkList, WorkList{m});
        } else {
            addBySet(simplifyWorkList, WorkList{m});
        }
    }
}

void RAPass::EnableMoves(const Nodes &nodes) {
    for (const auto &n : nodes) {
        for (const auto &m : NodeMoves(n)) {
            if (activeMoves.find(m) != activeMoves.end()) {
                delBySet(activeMoves, Moves{m});
                addBySet(worklistMoves, Moves{m});
            }
        }
    }
}

void RAPass::Coalesce() {
    ///@note 依然是启发式地随便弄一个
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<std::size_t> dist(0, worklistMoves.size() - 1);
    std::size_t randomIdx = dist(gen);

    auto it = worklistMoves.begin();

    std::advance(it, randomIdx);
    auto m = *it;
    worklistMoves.erase(m);

    Err::gassert(isMoveInstruction(m), "try Coalesce a not move inst");
    Err::gassert(getDef(m).size() == 1 && getUse(m).size() == 1, "Coalesce a invalid 'move' inst");

    auto x = *(getDef(m).begin());
    auto y = *(getUse(m).begin());

    auto x_a = GetAlias(x);
    auto y_a = GetAlias(y);

    Edge edge{nullptr, nullptr};
    if (precolored.find(y_a) != precolored.end())
        edge.u = y_a, edge.v = x_a;
    else
        edge.u = x_a, edge.v = y_a;

    auto &u = edge.u;
    auto &v = edge.v;
    if (u == v) {
        addBySet(coalescedMoves, Moves{m});
        AddWorkList(u);
    } else if (precolored.find(v) != precolored.end() || adjSet.find(edge) != adjSet.end()) {
        addBySet(constrainedMoves, Moves{m});
        AddWorkList(u);
        AddWorkList(v);
    }
    ///@note 将论文的一个if-else拆成了两个
    else if (precolored.find(u) != precolored.end()) {
        ///@note George check

        bool flag = true;
        for (const auto &t : Adjacent(v)) {
            if (!OK(t, u)) {
                flag = false;
                break;
            }
        }

        if (flag)
            goto __Combine_try;
        else
            goto __Combine_giveup;

    } else if (precolored.find(u) == precolored.end() && Conservative(getUnion<OperP>(Adjacent(u), Adjacent(v)))) {
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

void RAPass::AddWorkList(const OperP &u) {
    if (precolored.find(u) == precolored.end() && !MoveRelated(u) && degree[u] < K) {
        delBySet(freezeWorkList, WorkList{u});
        addBySet(simplifyWorkList, WorkList{u});
    }
}

void RAPass::Combine(const OperP &u, const OperP &v) {
    if (freezeWorkList.find(v) != freezeWorkList.end())
        delBySet(freezeWorkList, WorkList{v});
    else
        delBySet(spillWorkList, WorkList{v});

    addBySet(coalescedNodes, Nodes{v});
    alias[v] = u;

    ///@note nodeMoves[u] := nodeMoves[u] ∪ nodeMoves[v]
    ///@note 有充分的理由认为论文写错了, 因为根本没有声明nodeMoves
    ///@note 应该是moveList
    addBySet(moveList[u], moveList[v]);

    for (const auto &t : Adjacent(v)) {
        AddEdge(t, u);
        DecrementDegree(t);
    }

    if (degree[u] >= K && freezeWorkList.find(u) != freezeWorkList.end()) {
        delBySet(freezeWorkList, WorkList{u});
        addBySet(spillWorkList, WorkList{u});
    }
}

void RAPass::Freeze() {
    ///@note 启发式随便找 x 3
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<std::size_t> dist(0, freezeWorkList.size() - 1);
    std::size_t randomIdx = dist(gen);

    auto it = freezeWorkList.begin();

    std::advance(it, randomIdx);

    auto u = *it;

    delBySet(freezeWorkList, WorkList{u});

    addBySet(simplifyWorkList, WorkList{u});

    FreezeMoves(u);
}

void RAPass::FreezeMoves(const OperP &u) {
    for (const auto &m : NodeMoves(u)) {

        Err::gassert(isMoveInstruction(m), "try Coalesce a not move inst");
        Err::gassert(getDef(m).size() == 1 && getUse(m).size() == 1, "Coalesce a invalid 'move' inst");

        auto u = *(getUse(m).begin());
        auto v = *(getDef(m).begin());

        if (activeMoves.find(m) != activeMoves.end())
            delBySet(activeMoves, Moves{m});
        else
            delBySet(worklistMoves, Moves{m});

        addBySet(frozenMoves, Moves{m});

        if (NodeMoves(v).empty() && degree[v] < K) {
            delBySet(freezeWorkList, WorkList{v});
            addBySet(simplifyWorkList, WorkList{v});
        }
    }
}

void RAPass::SelectSpill() {
    ///@note 启发式算法, 但是自己设计
    auto m = heuristicSpill(); ///@bug

    delBySet(spillWorkList, WorkList{m});
    addBySet(simplifyWorkList, WorkList{m});

    FreezeMoves(m);
}

void RAPass::AssignColors() {
    while (!selectStack.empty()) {
        auto n = selectStack.back();
        selectStack.pop_back();
        std::vector<unsigned int> okColors(K);

        std::iota(okColors.begin(), okColors.end(), 0);

        if (Func->getInfo().maxAlignment == 16) {
            ///@brief 此时需要一个栈底寄存器: r7
            auto it = std::find_if(okColors.begin(), okColors.end(), [&](const auto &num) { return num == 7; }); // r7
            if (it != okColors.end())
                okColors.erase(it);
            Func->editInfo().regdit.insert(7); // r7
        }

        for (const auto &w : adjList[n]) {
            if (getUnion<OperP>(coloredNodes, precolored).count(GetAlias(w))) {
                auto w_a = GetAlias(w);
                auto w_a_reg = std::dynamic_pointer_cast<BindOnVirOP>(w_a);

                Err::gassert(w_a_reg != nullptr, "try assign color for a none virReg op");

                ///@note maybe none
                auto rm_idx = static_cast<unsigned int>(std::get<CoreRegister>(w_a_reg->getColor()));

                auto it = std::find_if(okColors.begin(), okColors.end(),
                                       [&rm_idx](const auto &num) { return num == rm_idx; });
                if (it != okColors.end())
                    okColors.erase(it);
            }

            Err::gassert(okColors.size() <= K, "vector okColors corrupted.");
        }

        if (okColors.empty()) {
            addBySet(spilledNodes, Nodes{n});
        } else if (auto precolored = std::dynamic_pointer_cast<PreColedOP>(n)) {
            /// Iterated Register Coalescing会将预着色寄存器一起放入图中, 所以这里不再处理
            Func->editInfo().regdit.insert(static_cast<unsigned int>(std::get<CoreRegister>(precolored->getColor())));
        } else {
            addBySet(coloredNodes, Nodes{n});
            auto c = *(okColors.begin()); // 多用caller saved
            Func->editInfo().regdit.insert(c);

            auto n_reg = std::dynamic_pointer_cast<BindOnVirOP>(n);

            Err::gassert(n_reg != nullptr, "try assign color for a none virReg op");
            Err::gassert(std::dynamic_pointer_cast<PreColedOP>(n_reg) == nullptr,
                         "try assign color for a precolored op");

            n_reg->setColor(static_cast<CoreRegister>(c));
        }
    }

    for (const auto &n : coalescedNodes) {
        ///@note 有没有可能重复assign color?
        auto n_reg = std::dynamic_pointer_cast<BindOnVirOP>(n);
        auto n_a = GetAlias(n_reg);
        auto n_a_reg = std::dynamic_pointer_cast<BindOnVirOP>(n_a);
        Err::gassert(n_reg != nullptr, "try assign color for a none virReg op");
        Err::gassert(n_a_reg != nullptr, "try assign color for a none virReg op");

        n_reg->setColor(std::get<CoreRegister>(n_a_reg->getColor()));
    }
}

void RAPass::ReWriteProgram() {
    initial.clear();

    for (const auto &n : spilledNodes) {
        addBySet(initial, spill_tryOpt(n));
    }

    spilledNodes.clear();
    addBySet(initial, coalescedNodes);
    addBySet(initial, coloredNodes);

    coloredNodes.clear();
    coalescedNodes.clear();
}

RAPass::Nodes RAPass::Adjacent(const OperP &n) {
    return getExclude<OperP>(adjList[n], Nodes(selectStack.begin(), selectStack.end()), coalescedNodes);
}

RAPass::Moves RAPass::NodeMoves(const OperP &n) {
    Err::gassert(n != nullptr, "n is nullptr");

    auto set = getUnion<InstP>(activeMoves, worklistMoves);

    Moves movs{};

    for (const auto &p : set) {
        if (moveList[n].find(p) != moveList[n].end())
            movs.insert(p);
    }

    return movs;
}

bool RAPass::MoveRelated(const OperP &n) { return !NodeMoves(n).empty(); }

bool RAPass::OK(const OperP &t, const OperP &r) {
    if (degree[t] < K)
        return true;
    else if (precolored.find(t) != precolored.end())
        return true;
    else if (adjSet.find(Edge{t, r}) != adjSet.end())
        return true;
    else
        return false;
}

bool RAPass::Conservative(const Nodes &nodes) {
    unsigned int k = 0;

    for (const auto &n : nodes) {
        if (degree[n] >= K)
            ++k;
    }

    return k < K;
}

OperP RAPass::GetAlias(OperP n) {
    if (coalescedNodes.find(n) != coloredNodes.end())
        return GetAlias(alias[n]);

    Err::gassert(n != nullptr, "get a nullptr alias");

    return n;
}

PM::PreservedAnalyses NeonRAPass::run(Function &bkd_function, FAM &fam) {
    Func = &bkd_function;
    varpool = &(Func->editInfo().varpool);
    liveinfo = fam.getResult<LiveAnalysis>(bkd_function);

    isInitialed = false;

    for (int i = 0; i < 32; ++i)
        availableSRegisters.insert(i);

    Main();

    // 吓我一跳我释放忍术 --- 耦合!
    Func->editInfo().availableSRegisters = availableSRegisters;
    Func->editInfo().spilltimes += spilltimes;

    return PM::PreservedAnalyses::all();
}

void NeonRAPass::AssignColors() {
    while (!selectStack.empty()) {
        auto n = selectStack.back();
        selectStack.pop_back();
        std::vector<unsigned int> okColors(K);

        std::iota(okColors.begin(), okColors.end(), 0);

        for (const auto &w : adjList[n]) {
            if (getUnion<OperP>(coloredNodes, precolored).count(GetAlias(w))) {
                auto w_a = GetAlias(w);
                auto w_a_reg = std::dynamic_pointer_cast<BindOnVirOP>(w_a);

                Err::gassert(w_a_reg != nullptr, "try assign color for a none virReg op");

                auto rm_idx = static_cast<unsigned int>(std::get<FPURegister>(w_a_reg->getColor()));

                auto it = std::find_if(okColors.begin(), okColors.end(),
                                       [&rm_idx](const auto &num) { return num == rm_idx; });
                if (it != okColors.end())
                    okColors.erase(it);
            }
        }

        if (okColors.empty()) {
            addBySet(spilledNodes, Nodes{n});
        } else if (std::dynamic_pointer_cast<PreColedOP>(n) != nullptr) {
            /// Iterated Register Coalescing会将预着色寄存器一起放入图中
        } else {
            addBySet(coloredNodes, Nodes{n});
            auto c = *(okColors.begin());
            // auto c = okColors.back();

            auto n_reg = std::dynamic_pointer_cast<BindOnVirOP>(n);
            Err::gassert(n_reg != nullptr, "try assign color for a none virReg op");

            n_reg->setColor(static_cast<CoreRegister>(c));

            ///@note 排除available
            auto it = std::find_if(availableSRegisters.begin(), availableSRegisters.end(),
                                   [&c](const auto &item) { return item == c; });

            availableSRegisters.erase(it);
        }
    }

    for (const auto &n : coalescedNodes) {
        auto n_reg = std::dynamic_pointer_cast<BindOnVirOP>(n);
        auto n_a = GetAlias(n_reg);
        auto n_a_reg = std::dynamic_pointer_cast<BindOnVirOP>(n_a);
        Err::gassert(n_reg != nullptr, "try assign color for a none virReg op");
        Err::gassert(n_a_reg != nullptr, "try assign color for a none virReg op");

        ///@todo dpr, qpr
        n_reg->setColor(n_a_reg->getColor());
    }
}