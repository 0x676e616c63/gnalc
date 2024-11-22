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
#include "../../include/tools/ArmRegisterAlloc.hpp"
using namespace ArmTools;
using namespace ArmStruct;

bool ::MyUnOrderedSet::find(::Edge *edge){
    return this->set.find(edge) != this->set.end(); 
}
::RegisterAlloc::RegisterAlloc(::Function &func, unsigned int k){
   this->curFunc = func;
   this->availableColors = k;
   this->GraphColoring();
//    if(ifUseS) AvailableNum = ???;
}
/// @todo 分配算法和其中的数据结构参考Iterated Register Coalescing这篇论文
/// @note 原论文中会递归调用该函数
void ::RegisterAlloc::GraphColoring(){
    /// @todo step0: 筛选需要分配寄存器的指令, 后续可能需要重写这些指令
    /// @todo 包括所有需要调用寄存器的指令
    
    // LivenessAnalysis(); // 这里在之前Lowering做过了
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
void ::RegisterAlloc::AddEdge(::Operand *u, ::Operand *v){
    ::Edge *edge = new ::Edge(u, v);
    if(u != v && !adjSet.find(edge)){
        adjSet.set.insert(edge);
        ::Edge edge2 = *(new ::Edge(v, u));
        if(u->color == -1){ // no precolored
            u->adjList.insert(v);
            ++u->adjDegree;
        }
        if(v->color == -1){
            v->adjList.insert(u);
            ++v->adjDegree;
        }
    }
}
void ::RegisterAlloc::BuildGraph(){
    ///@note 原论文这里顺便计算了活跃性，这里由于这个方法在重写程序之后多次使用
    ///@note 所以这里在此实现一边Live的计算
    ///@todo 原论文中，def(I)为一个集合，但是在项目中def(I)应该只有一个元素，即目的操作数
    for(::BB* BasicBlock: curFunc.BBList){
        std::unordered_set<::Operand*, std::hash<::Operand*>> Live;
        /// @todo 这里的Live仅仅用来填图, 而不用于更新活跃信息?
        Live = BasicBlock->LiveOut;
        for(auto it = BasicBlock->InstList.rbegin(); it != BasicBlock->InstList.rend(); ++it){
                ::Instruction* curInst = static_cast<::Instruction*>(*it);
            /// @note 这里是广义的MoveInst
            if(isMoveInst(curInst)){
                /// @note live := live\use(I); forall
                for(::Operand* UseOper: curInst->UseOperandList){
                    auto iterator = Live.find(UseOper);
                    if(iterator != Live.end()) Live.erase(iterator);
                    UseOper->moveList.insert(curInst);
                }
                for(::Operand* DefOper: curInst->DefOperandList)DefOper->moveList.insert(curInst);
                /// @note worklistMoves := worklistMoves U {I}
                worklistMoves.insert(curInst);
            }
            /// @note  live := live U def(I); forall d in def(I).....
            for(::Operand* DefOper: curInst->DefOperandList) Live.insert(DefOper);
            for(::Operand* DefOper: curInst->DefOperandList){
                for(::Operand* Oper: Live) AddEdge(Oper, DefOper);
            }
            /// @note live := use(I) U (live\def(I))
            /// @note step1: live := live \ def(I)
            for(::Operand *DefOper: curInst->DefOperandList){
                auto iterator = Live.find(DefOper);
                if(iterator != Live.end()) Live.erase(iterator);
            }
            /// @note step2: live := live U use(I)
            for(::Operand *UseOper: curInst->UseOperandList){
                Live.insert(UseOper);
            }
        }
    }
}
std::unordered_set<::Operand*>* ::RegisterAlloc::Adjacent(::Operand* n){
    ///@note 使用完了之后记得delete
    std::unordered_set<::Operand*>* UnorderSet = new std::unordered_set<::Operand*>;
    *UnorderSet = n->adjList;
    for(::Operand* node: selectStack){
        auto it = (*UnorderSet).find(node);
        if(it != (*UnorderSet).end()) (*UnorderSet).erase(it);
    }
    for(::Operand* node: coalescedNodes){
        auto it = (*UnorderSet).find(node);
        if(it != (*UnorderSet).end()) (*UnorderSet).erase(it);
    }
    return UnorderSet;
}
std::unordered_set<::Instruction*>* ::RegisterAlloc::NodeMoves(::Operand* n){
    ///@note 同上
    std::unordered_set<::Instruction*>* UnorderSet = new std::unordered_set<::Instruction*>;
    *UnorderSet = n->moveList;
    /// @note moveList[n] * (activeMoves + worklistMoves) = moveList[n]*activeMoves + moveList[n]*worklistMoves
    for(::Instruction* inst: *UnorderSet){
        auto it = activeMoves.find(inst);
        if(it != activeMoves.end()) continue;
        else it = worklistMoves.find(inst);
        if(it == activeMoves.end()) (*UnorderSet).erase(it);
    }
    return UnorderSet;
}
bool ::RegisterAlloc::isMoveRelated(::Operand* n){
    auto temp = NodeMoves(n);
    bool ans = !(temp->empty()); // when != {}, return true
    delete temp;
    return ans;
}
void ::RegisterAlloc::MkworkList(){
    ///@todo 这里可能需要一个生成initial的代码
    for(auto it = initial.begin(); it != initial.end(); ++it){
        ::Operand* curNode = *it;
        initial.erase(it);
        if(curNode->adjDegree >= availableColors) spillWorkList.insert(curNode);
        else if(isMoveRelated(curNode)) freezeWorkList.insert(curNode);
        else simplifyWorkList.insert(curNode);
    }
}
void ::RegisterAlloc::Simplify(){
    /// @note 这里论文中第一步没有forall, 一次只能化简一个node
    auto n = *(simplifyWorkList.begin());
    auto it = simplifyWorkList.find(n);
    if(it != simplifyWorkList.end()) simplifyWorkList.erase(it);
    selectStack.push_back(n);
    std::unordered_set<::Operand*>* adj = Adjacent(n);
    for(::Operand* m: *adj) DecrementDegree(m);
    delete adj;
}
void ::RegisterAlloc::DecrementDegree(::Operand* m){
    --(m->adjDegree);
    if(m->adjDegree == availableColors){
        std::unordered_set<::Operand*>* adj = Adjacent(m);
        (*adj).insert(m);
        EnableMoves(*adj);
        /// @note  spillWorkList := spillWorkList \{m}
        auto it = spillWorkList.find(m);
        if(it != spillWorkList.end()) spillWorkList.erase(it);
        if(isMoveRelated(m)) freezeWorkList.insert(m);
        else simplifyWorkList.insert(m);
        
        delete adj;
    }
}
void ::RegisterAlloc::EnableMoves(std::unordered_set<::Operand*>& nodes){
    for(::Operand* n: nodes){
        std::unordered_set<::Instruction*>* move = NodeMoves(n);
        for(::Instruction* inst: *move){
            auto it = activeMoves.find(inst);
            if(it == activeMoves.end()) continue;
            activeMoves.erase(it);
            worklistMoves.insert(*it);
        }
        delete move;
    }
}
void ::RegisterAlloc::Coalesce(){
    ///@note 合并多余的move指令，所以理论上Def(I)和Use(I)都只有一个元素
    ///@note let m(=copy(x, y)) in workListMoves
    ///@note x := y or y := x ??
    ::Instruction* inst = *(worklistMoves.begin());
    ::Operand* x = GetAlias(inst->DefOperandList[0]);
    ::Operand* y = GetAlias(inst->UseOperandList[0]);
    ::Edge* edge;
    if(y->color != -1) edge = new ::Edge(y, x);
    else edge = new ::Edge(x, y);
    // ::Operand& u = *(edge->u);
    // ::Operand& v = *(edge->v);
    if(edge->u == edge->v){
        coalescedMoves.insert(inst);
        AddWorkList(edge->u);
    }
    else if(edge->v->color != -1 || adjSet.find(edge)){
        constrainedMoves.insert(inst);
        AddWorkList(edge->u);
        AddWorkList(edge->v);
    }
    /// @todo 先这么写吧
    else if(edge->u->color != -1){
        std::unordered_set<::Operand*>* adj = Adjacent(edge->v);
        bool flag = true;
        for(auto t: (*adj)){
            if(!OK(t, edge->u)){
                flag = false;
                break;
            }
        }
        delete adj;
        if(flag){
            coalescedMoves.insert(inst);
            Combine(edge->u, edge->v);
            AddWorkList(edge->u);
        }
    }
    else if(edge->u->color == -1){
        auto adj_u = Adjacent(edge->u);
        auto adj_v = Adjacent(edge->v);
        std::vector<::Operand*> combinedVector;
        combinedVector.insert(combinedVector.end(), (*adj_u).begin(), (*adj_u).end());
        combinedVector.insert(combinedVector.end(), (*adj_v).begin(), (*adj_v).end());
        std::unordered_set<::Operand*> adj(combinedVector.begin(), combinedVector.end());
        delete adj_u;
        delete adj_v;

        if(Conservative(adj)){
            coalescedMoves.insert(inst);
            Combine(edge->u, edge->v);
            AddWorkList(edge->u);
        }
    }
    else{
        activeMoves.insert(inst);
    }
}
void ::RegisterAlloc::AddWorkList(::Operand *u){
    if(u->color == -1 && !isMoveRelated(u) && u->adjDegree < availableColors){
        auto it = freezeWorkList.find(u);
        if(it != freezeWorkList.end()) freezeWorkList.erase(it);
        it = simplifyWorkList.find(u);
        if(it == simplifyWorkList.end()) simplifyWorkList.insert(u);
    }
}
bool ::RegisterAlloc::OK(::Operand* t, ::Operand* r){
    if(t->adjDegree < availableColors) return true;
    if(t->color != -1) return true;
    ::Edge* edge = new ::Edge(t, r);
    if(adjSet.find(edge)){
        delete edge;
        return true;
    }
    delete edge;
    return false;
}
bool ::RegisterAlloc::Conservative(std::unordered_set<::Operand*>& nodes){
    unsigned int k = 0;
    for(::Operand* n: nodes){
        if(n->adjDegree >= availableColors) ++k;
    }
    return k < availableColors;
}
::Operand* ::RegisterAlloc::GetAlias(::Operand* n){
    auto it = coalescedNodes.find(n);
    if(it == coalescedNodes.end()) return n;
    else return GetAlias(n->alias);
}
void ::RegisterAlloc::Combine(::Operand* u, ::Operand* v){
    auto it = freezeWorkList.find(v);
    if(it != freezeWorkList.end()) freezeWorkList.erase(it);
    else spillWorkList.erase(it);
    coalescedNodes.insert(v);
    v->alias = u;
    ///@note 这里的nodeMoves[u]应该就是moveList[u]
    for(auto inst: v->moveList) u->moveList.insert(inst);
    auto adj = Adjacent(v);
    for(auto t: (*adj)){
        AddEdge(t, u);
        DecrementDegree(t);
    }
    delete adj;
    if(u->adjDegree >= availableColors && freezeWorkList.find(u) != freezeWorkList.end()){
        freezeWorkList.erase(u);
        spillWorkList.insert(u);
    }
}
void ::RegisterAlloc::Freeze(){
    ::Operand* u = *(freezeWorkList.begin());
    freezeWorkList.erase(freezeWorkList.begin());
    simplifyWorkList.insert(u);
    FreezeMoves(u);
}
void ::RegisterAlloc::FreezeMoves(::Operand* u){
    auto adj = NodeMoves(u);
    ///@note inst(=copy(u, v) or copy(v, u))
    for(::Instruction* inst: (*adj)){
        ::Operand* v;
        if(inst->DefOperandList[0] == u) v = inst->UseOperandList[0];
        else v = inst->DefOperandList[0];
        if(activeMoves.find(inst) != activeMoves.end()) activeMoves.erase(inst);
        else worklistMoves.erase(inst);
        frozenMoves.insert(inst);
        if(!(v->moveList.size()) && v->adjDegree < availableColors){
            auto it = freezeWorkList.find(v);
            if(it != freezeWorkList.end()) freezeWorkList.erase(it);
            simplifyWorkList.insert(v);
        }
    }
    delete adj;
}
void ::RegisterAlloc::AssignColors(){
    while(selectStack.size()){
        ::Operand* n = selectStack.back();
        selectStack.pop_back();
        std::vector<int> colorSeq(availableColors);
        std::iota(colorSeq.begin(), colorSeq.end(), 0);
        std::unordered_set<int> okColors(colorSeq.begin(), colorSeq.end());
        
        for(::Operand* w: n->adjList){
            if(GetAlias(w)->color != -1 || coloredNodes.find(GetAlias(w)) != coloredNodes.end()) okColors.erase(GetAlias(w)->color);
        }
        
        if(!(okColors.size())) spilledNodes.insert(n);
        else{
            coloredNodes.insert(n);
            n->color = *(okColors.begin());
        }
    }
    for(::Operand* n: coalescedNodes){
        n->color = GetAlias(n)->color;
    }
}
void ::RegisterAlloc::ReWriteProgram(){
    // In the program (instructions), insert a store after each
    // definition of a vi, a fetch before each use of a vi.
    // Put all the vi into a set newTemps.
    /// @todo
    std::unordered_set<::Operand*> newTemp;
    for(::Operand* v: spilledNodes){
        ///@note 遍历该结点的moveList,
        ///@note 判断在对应的inst中是处于def集还是use集, 对应改写程序
        for(::Instruction* inst: v->moveList){
            bool flag = true; // true for a def inst; false for a use inst
            auto it = std::find(inst->DefOperandList.begin(), inst->DefOperandList.end(), v);
            if(it == inst->DefOperandList.end()) flag = false;
            /// @note 改写
            ::BB BasicBlock = inst->BasicBlock;
            auto inst_it = std::find(BasicBlock.InstList.begin(), BasicBlock.InstList.end(), inst);
            /// @todo 这里可以加一个assert
            if(flag){
                /// @todo 需要完善Instruction的构造函数
                ::Instruction* store_inst = new ::Instruction();
                BasicBlock.InstList.insert(++inst_it, store_inst);
            }
            else{
                ::Instruction* load_inst = new ::Instruction();
                BasicBlock.InstList.insert(--inst_it, load_inst);
            }
        }
        newTemp.insert(v);
    }
    spilledNodes.clear();
    initial.clear();
    for(auto n: coloredNodes) initial.insert(n);
    for(auto n: coalescedNodes) initial.insert(n);
    for(auto n: newTemp) initial.insert(n);
    coloredNodes.clear();
    coalescedNodes.clear();
}
void ::RegisterAlloc::SelectSpill(){
    // let m ∈ spillWorklist selected using favorite heuristic
    // Note: avoid choosing nodes that are the tiny live ranges
    // resulting from the fetches of previously spilled registers
    /// @todo 需要设计一个溢出寄存器的启发式算法, 复杂度O(n)
    /// @todo 自由发挥时间, 但是不知道怎么发挥, 直接选第一个其实也可以
    ::Operand* m = *(spillWorkList.begin());
    spillWorkList.erase(m);
    simplifyWorkList.insert(m);
    FreezeMoves(m);
}
