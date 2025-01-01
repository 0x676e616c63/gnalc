#include <list>
#include <cassert>
#include <map>
#include <vector>
#include <unordered_set>
#include <algorithm>
#include <typeinfo>
#include <type_traits>
#include <numeric>
#include "../../Arm.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/tools/ArmRegisterAlloc.hpp"

using OperRefHashPtr = std::unique_ptr<std::unordered_set<std::reference_wrapper<ArmStruct::Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual>>;
using OperRefHash = std::unordered_set<std::reference_wrapper<ArmStruct::Operand>, ArmTools::HashOperandReferWrap, ArmTools::HashOperandReferWrapEqual>;
using InstRefHashPtr = std::unique_ptr<std::unordered_set<std::reference_wrapper<ArmStruct::Instruction>, ArmTools::HashInstReferWrap, ArmTools::HashInstReferWrapEqual>>;
using InstRefHash = std::unordered_set<std::reference_wrapper<ArmStruct::Instruction>, ArmTools::HashInstReferWrap, ArmTools::HashInstReferWrapEqual>;

using namespace ArmTools;
using namespace ArmStruct;

bool MyUnOrderedSet::find(const Edge &edge){
    return this->set.find(Edge(edge.u, edge.v)) != this->set.end(); 
}
RegisterAlloc::RegisterAlloc(Function &func, OperandType RegType, unsigned int k)
    : curFunc(func), RegType(RegType), availableColors(k), isPreColoredAlready(false), adjSet(), simplifyWorkList(), freezeWorkList(), spilledNodes(), worklistMoves(), activeMoves(), coalescedMoves(), constrainedMoves(), frozenMoves(), coloredNodes(), coalescedNodes(), selectStack(), initial() {
    // this->GraphColoring();
}
bool RegisterAlloc::isMoveInst(Instruction &inst){
    if(inst.opcode > OperCode::Branch_Begin
    && inst.opcode < OperCode::Branch_End) return false;
    else return true;
}

/// @todo 分配算法和其中的数据结构参考Iterated Register Coalescing这篇论文
void RegisterAlloc::GraphColoring(){
    ///@todo 关于寄存器调用规约
    ///@todo 对于callee func, callee有义务保存和恢复这些寄存器
    ///@todo 具体方法是在开头添加一个 mov %tmp rx; 结尾添加一个 mov rx, %tmp; 这样如果程序中间没有使用rx, 这两句指令会被coalesce消除, 有的话才会保留
    ///@todo 对于caller func, caller需要在callinst前后保存和恢复
    ///@todo 具体做法和上面一模一样
    ///@todo 对于代表寄存器的Operand, 需要指定color的值无法更改, 也就是预着色操作
    ///@todo 除此之外, 一些别的寄存器如sp, pc, lr, 这些寄存器实际上是固定死了, 根本不会参与寄存器分配
    ///@todo 在最后的LeglizeFinal()插入BB的首位即可 
    ///@todo 尝试：首先在Lower2MIR时将插入上述保护指令, 设置好Operand.color值为对应的寄存器序号, 然后将这些Operand直接划入coloredNode中

    BuildGraph();
    MkworkList();
    do{
        if(simplifyWorkList.size()) Simplify();
        else if(worklistMoves.size()) Coalesce();
        else if(freezeWorkList.size()) Freeze();
        else if(spilledNodes.size()) SelectSpill();
    }while(!simplifyWorkList.size() && !worklistMoves.size()
        && !freezeWorkList.size() && !spilledNodes.size());
    AssignColors(); // will produces spills
    if(spilledNodes.size()){
        ReWriteProgram(); // RewriteProgram(spilledNodes) alloc mem and insert str/ldr inst
        GraphColoring(); // invoked using
    }
}
void RegisterAlloc::AddEdge(Operand &u, Operand &v){
    std::unique_ptr<Edge> edge = std::make_unique<Edge>(u, v);
    if(&u != &v && !adjSet.find(*edge)){
        ///@note 由于adjSet中存在双向边的检查，所以无需再添加(v, u)
        adjSet.set.insert(*edge);
        if(u.color == -1){ // no precolored
            u.adjList.insert(std::ref(v));
            ++u.adjDegree;
        }
        if(v.color == -1){
            v.adjList.insert(std::ref(u));
            ++v.adjDegree;
        }
    }
}
void RegisterAlloc::BuildGraph(){
        for(auto it = curFunc.BBList.begin(); it != curFunc.BBList.end(); ++it){
        BB& BasicBlock = **it;
        OperRefHash Live;
        /// @todo isPreColored = false时, 在coloredNodes中加入预着色结点
        Live = BasicBlock.LiveOut;
        for(auto it = BasicBlock.InstList.rbegin(); it != BasicBlock.InstList.rend(); ++it){
                Instruction& curInst = static_cast<Instruction&>(**it);
            /// @note 这里是广义的MoveInst
            if(isMoveInst(curInst)){
                /// @note live := live\use(I); forall
                for(Operand& UseOper: curInst.UseOperandList){
                    if(!isPreColoredAlready && UseOper.color != -1){
                        if(UseOper.ValType == RegType) coloredNodes.insert(std::ref(UseOper)); // 预着色
                    }
                    auto iterator = Live.find(std::ref(UseOper));
                    if(iterator != Live.end()) Live.erase(iterator);
                    UseOper.moveList.insert(std::ref(curInst));
                }

                for(Operand& DefOper: curInst.DefOperandList){
                    if(!isPreColoredAlready && DefOper.color != -1){
                        if(DefOper.ValType == RegType) coloredNodes.insert(std::ref(DefOper)); /// 
                    }
                    DefOper.moveList.insert(std::ref(curInst));
                }

                /// @note worklistMoves := worklistMoves U {I}
                worklistMoves.insert(std::ref(curInst));
            }
            /// @note  live := live U def(I); forall d in def(I).....
            for(Operand& DefOper: curInst.DefOperandList){
                if(DefOper.ValType == RegType) Live.insert(std::ref(DefOper));
            }
            for(Operand& DefOper: curInst.DefOperandList){
                for(Operand& Oper: Live) AddEdge(Oper, DefOper);
            }
            /// @note live := use(I) U (live\def(I))
            /// @note step1: live := live \ def(I)
            for(Operand &DefOper: curInst.DefOperandList){
                auto iterator = Live.find(std::ref(DefOper));
                if(iterator != Live.end()) Live.erase(iterator);
            }
            /// @note step2: live := live U use(I)
            for(Operand &UseOper: curInst.UseOperandList){
                if(UseOper.ValType == RegType) Live.insert(std::ref(UseOper));
            }
        }
        /// @note 解释一下为什么在计算完成live之后, live信息不用先前BB传播
        /// @note 首先, 需要将live信息前传的变量一定是活跃区间跨块的变量
        /// @note 这些变量是phi函数处理的对象
        /// @note 在指令选择阶段phi函数被消除, 从而也不存在这种活跃区间跨块的变量
    }
    isPreColoredAlready = true;
}
OperRefHashPtr RegisterAlloc::Adjacent(Operand& n){
    OperRefHashPtr UnorderSet = std::make_unique<OperRefHash>();
    *UnorderSet = n.adjList;
    for(Operand& node: selectStack){
        auto it = (*UnorderSet).find(std::ref(node));
        if(it != (*UnorderSet).end()) (*UnorderSet).erase(it);
    }
    for(Operand& node: coalescedNodes){
        auto it = (*UnorderSet).find(std::ref(node));
        if(it != (*UnorderSet).end()) (*UnorderSet).erase(it);
    }
    return UnorderSet;
}
InstRefHashPtr RegisterAlloc::NodeMoves(Operand& n){
    ///@note 同上
    InstRefHashPtr UnorderSet = std::make_unique<InstRefHash>();
    *UnorderSet = n.moveList;
    /// @note moveList[n] * (activeMoves + worklistMoves) = moveList[n]*activeMoves + moveList[n]*worklistMoves
    for(Instruction& inst: *UnorderSet){
        auto it = activeMoves.find(std::ref(inst));
        if(it != activeMoves.end()) continue;
        else it = worklistMoves.find(std::ref(inst));
        if(it == activeMoves.end()) (*UnorderSet).erase(it);
    }
    return UnorderSet;
}

bool RegisterAlloc::isMoveRelated(Operand& n){
    auto temp = NodeMoves(n);
    bool ans = !(temp->empty()); // when != {}, return true
    return ans;
}

void RegisterAlloc::MkworkList(){
    ///@todo 如果没有经过ReWriteProgram这里的Initial集应该是空的
    for(auto it = initial.begin(); it != initial.end(); ++it){
        Operand& curNode = (*it).get();
        initial.erase(it);
        if(curNode.adjDegree >= availableColors) spillWorkList.insert(std::ref(curNode));
        else if(isMoveRelated(curNode)) freezeWorkList.insert(std::ref(curNode));
        else simplifyWorkList.insert(std::ref(curNode));
    }
}
void RegisterAlloc::Simplify(){
    /// @note 这里论文中第一步没有forall, 一次只能化简一个node
    auto n = *(simplifyWorkList.begin());
    auto it = simplifyWorkList.find(n);
    if(it != simplifyWorkList.end()) simplifyWorkList.erase(it);
    selectStack.push_back(n);
    OperRefHashPtr adj = Adjacent(n);
    for(Operand& m: *adj) DecrementDegree(m);
}
void RegisterAlloc::DecrementDegree(Operand& m){
    --(m.adjDegree);
    if(m.adjDegree == availableColors){
        OperRefHashPtr adj = Adjacent(m);
        (*adj).insert(std::ref(m));
        EnableMoves(*adj);
        /// @note  spillWorkList := spillWorkList \{m}
        auto it = spillWorkList.find(std::ref(m));
        if(it != spillWorkList.end()) spillWorkList.erase(it);
        if(isMoveRelated(m)) freezeWorkList.insert(std::ref(m));
        else simplifyWorkList.insert(std::ref(m));
    }
}
void RegisterAlloc::EnableMoves(OperRefHash& nodes){
    for(Operand& n: nodes){
        InstRefHashPtr move = NodeMoves(n);
        for(Instruction& inst: *move){
            auto it = activeMoves.find(inst);
            if(it == activeMoves.end()) continue;
            activeMoves.erase(it);
            worklistMoves.insert(*it);
        }
    }
}
void RegisterAlloc::Coalesce(){
    ///@note 合并多余的move指令，所以理论上Def(I)和Use(I)都只有一个元素
    ///@note let m(=copy(x, y)) in workListMoves
    ///@note x := y or y := x ??
    Instruction& inst = *(worklistMoves.begin());
    Operand& x = GetAlias(inst.DefOperandList[0]);
    Operand& y = GetAlias(inst.UseOperandList[0]);
    std::unique_ptr<Edge> edge;
    if(y.color != -1) edge = std::make_unique<Edge>(y, x);
    else edge = std::make_unique<Edge>(x, y);
    // Operand& u = *(edge->u);
    // Operand& v = *(edge->v);
    if(&edge->u == &edge->v){
        coalescedMoves.insert(inst);
        AddWorkList(edge->u);
    }
    else if(edge->v.color != -1 || adjSet.find(*edge)){
        constrainedMoves.insert(inst);
        AddWorkList(edge->u);
        AddWorkList(edge->v);
    }
    /// @todo 先这么写吧
    else if(edge->u.color != -1){
        OperRefHashPtr adj = Adjacent(edge->v);
        bool flag = true;
        for(auto t: (*adj)){
            if(!OK(t, edge->u)){
                flag = false;
                break;
            }
        }
        if(flag){
            coalescedMoves.insert(inst);
            Combine(edge->u, edge->v);
            AddWorkList(edge->u);
        }
    }
    else if(edge->u.color == -1){
        auto adj_u = Adjacent(edge->u);
        auto adj_v = Adjacent(edge->v);
        std::vector<std::reference_wrapper<Operand>> combinedVector;
        combinedVector.insert(combinedVector.end(), (*adj_u).begin(), (*adj_u).end());
        combinedVector.insert(combinedVector.end(), (*adj_v).begin(), (*adj_v).end());

        OperRefHash adj(combinedVector.begin(), combinedVector.end());
        if(Conservative(adj)){
            // coalescedMoves := coalescedMoves U {m}
            // Combine(u,v)
            // AddWorkList(u)
            coalescedMoves.insert(inst);
            Combine(edge->u, edge->v);
            AddWorkList(edge->u);
        }
    }
    else{
        activeMoves.insert(inst);
    }
}
void RegisterAlloc::AddWorkList(Operand &u){
    if(u.color == -1 && !isMoveRelated(u) && u.adjDegree < availableColors){
        auto it = freezeWorkList.find(u);
        if(it != freezeWorkList.end()) freezeWorkList.erase(it);
        it = simplifyWorkList.find(u);
        if(it == simplifyWorkList.end()) simplifyWorkList.insert(u);
    }
}
bool RegisterAlloc::OK(Operand& t, Operand& r){
    if(t.adjDegree < availableColors) return true;
    if(t.color != -1) return true;
    std::unique_ptr<Edge> edge = std::make_unique<Edge>(t, r);
    if(adjSet.find(*edge)) return true;
    return false;
}
bool RegisterAlloc::Conservative(OperRefHash& nodes){
    unsigned int k = 0;
    for(Operand& n: nodes){
        if(n.adjDegree >= availableColors) ++k;
    }
    return k < availableColors;
}
Operand& RegisterAlloc::GetAlias(Operand& n){
    auto it = coalescedNodes.find(n);
    if(it == coalescedNodes.end()) return n;
    else return GetAlias(*(n.alias));
}
void RegisterAlloc::Combine(Operand& u, Operand& v){
    auto it = freezeWorkList.find(v);
    if(it != freezeWorkList.end()) freezeWorkList.erase(it);
    else spillWorkList.erase(it);
    coalescedNodes.insert(v);
    v.alias = std::make_unique<Operand>(u); // v.alias -> ptr; u -> ref; Operand::Operand(Operand&);
    ///@note 这里的nodeMoves[u]应该就是moveList[u]
    for(auto inst: v.moveList) u.moveList.insert(inst);
    auto adj = Adjacent(v);
    for(auto t: (*adj)){
        AddEdge(t, u);
        DecrementDegree(t);
    }
    if(u.adjDegree >= availableColors && freezeWorkList.find(u) != freezeWorkList.end()){
        freezeWorkList.erase(u);
        spillWorkList.insert(u);
    }
}
void RegisterAlloc::Freeze(){
    Operand& u = *(freezeWorkList.begin());
    freezeWorkList.erase(freezeWorkList.begin());
    simplifyWorkList.insert(u);
    FreezeMoves(u);
}
void RegisterAlloc::FreezeMoves(Operand& u){
    auto adj = NodeMoves(u);
    ///@note inst(=copy(u, v) or copy(v, u))
    for(Instruction& inst: (*adj)){
        bool flag = true;
        Operand& v = inst.DefOperandList[0].get() == u ? inst.UseOperandList[0]: inst.DefOperandList[0]; 

        if(activeMoves.find(inst) != activeMoves.end()) activeMoves.erase(inst);
        else worklistMoves.erase(inst);
        frozenMoves.insert(inst);
        if(!(v.moveList.size()) && v.adjDegree < availableColors){
            auto it = freezeWorkList.find(v);
            if(it != freezeWorkList.end()) freezeWorkList.erase(it);
            simplifyWorkList.insert(v);
        }
    }
}
void RegisterAlloc::AssignColors(){
    while(selectStack.size()){
        Operand& n = selectStack.back().get();
        selectStack.pop_back();
        std::vector<int> colorSeq(availableColors);
        std::iota(colorSeq.begin(), colorSeq.end(), 0);
        std::unordered_set<int> okColors(colorSeq.begin(), colorSeq.end());
        
        for(Operand& w: n.adjList){
            if(GetAlias(w).color != -1 || coloredNodes.find(GetAlias(w)) != coloredNodes.end()) okColors.erase(GetAlias(w).color);
        }
        
        if(!(okColors.size())) spilledNodes.insert(n);
        else{
            coloredNodes.insert(n);
            n.color = *(okColors.begin());
        }
    }
    for(Operand& n: coalescedNodes){
        n.color = GetAlias(n).color;
    }
}
void RegisterAlloc::ReWriteProgram(){
    // In the program (instructions), insert a store after each
    // definition of a vi, a fetch before each use of a vi.
    // Put all the vi into a set newTemps.

    OperRefHash newTemp;
    for(Operand& v: spilledNodes){
        ///@note 遍历该结点的moveList,
        ///@note 判断在对应的inst中是处于def集还是use集, 对应改写程序
        for(Instruction& inst: v.moveList){
            bool flag = false; // true for a def inst; false for a use inst

            ///@note def集一般比较小, 查找更快
            for(auto it = inst.DefOperandList.begin(); it != inst.DefOperandList.end(); ++it){
                Operand& DefOper = (*it).get();
                if(DefOper == v){
                    flag = true;
                    break;
                }
            }

            /// @note 改写
            BB& BasicBlock = inst.BasicBlock;
            /// @note 因为不能std::referance_wrap<>重载操作符, 所以只能手动查找
            for(auto inst_it = BasicBlock.InstList.begin(); inst_it != BasicBlock.InstList.end(); ++inst_it){
                Instruction& targetInst = **inst_it;
                if(targetInst == inst){
                    if(flag){
                        std::unique_ptr<Instruction> store_inst = std::make_unique<Instruction>(targetInst, OperCode::STR, ++curFunc.InstCnt);
                        BasicBlock.InstList.insert(++inst_it, store_inst.get()); // 
                    }
                    else{
                        std::unique_ptr<Instruction> load_inst = std::make_unique<Instruction>(targetInst, OperCode::LDR, ++curFunc.InstCnt);
                        BasicBlock.InstList.insert(inst_it, load_inst.get()); // 
                    }
                    break;
                }
            }
        }
        newTemp.insert(std::ref(v));
    }
    spilledNodes.clear();
    initial.clear();
    for(auto n: coloredNodes) initial.insert(n);
    for(auto n: coalescedNodes) initial.insert(n);
    for(auto n: newTemp) initial.insert(n);
    coloredNodes.clear();
    coalescedNodes.clear();
}
void RegisterAlloc::SelectSpill(){
    // let m ∈ spillWorklist selected using favorite heuristic
    // Note: avoid choosing nodes that are the tiny live ranges
    // resulting from the fetches of previously spilled registers
    /// @todo 需要设计一个溢出寄存器的启发式算法, 复杂度O(n)
    /// @todo 自由发挥时间, 但是不知道怎么发挥, 直接选第一个其实也可以
    Operand& m = *(spillWorkList.begin());
    spillWorkList.erase(m);
    simplifyWorkList.insert(m);
    FreezeMoves(m);
}
