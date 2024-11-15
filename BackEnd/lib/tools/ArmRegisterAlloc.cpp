#include <list>
#include <map>
#include <vector>
#include <algorithm>
#include "../../Arm.hpp"
#include "../../include/tools/ArmRegisterAlloc.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"

ArmTools::RegisterAlloc::RegisterAlloc(ArmStruct::Function &func, bool ifUseS){
   this->curFunc = func;
   this->GraphColoring();
//    if(ifUseS) AvailableNum = ???;
}
bool ArmTools::RegisterAlloc::InterferenceSort(ArmStruct::Operand *Oper1, ArmStruct::Operand *Oper2){
    // true不交换，false交换
    // 升序
    return Oper1->neighborNum < Oper2->neighborNum;
}
void ArmTools::RegisterAlloc::GraphColoring(){
    /// @brief 构建InterferenceGraph, 按照邻接数排序
    for(auto &Inst: curFunc.InstList){
        for(ArmStruct::Operand *Oper1: Inst.LiveIn){
            if(std::find(InterferenceGraph.begin(), InterferenceGraph.end(), Oper1) == InterferenceGraph.end()) InterferenceGraph.push_back(Oper1);
            for(ArmStruct::Operand *Oper2: Inst.LiveIn){
                if(Oper1->Indentifier == Oper2->Indentifier) continue;
                Oper1->neighbor.push_back(Oper2);
                Oper1->neighborNum++;
            }
        }
    }
    /// @brief 不断化简直到图为空
    while(GraphSimplize()){
        while(GraphNodeSpill()){}
    }
    ReplaceVirtualReg();
}
bool ArmTools::RegisterAlloc::GraphSimplize(){
    /// @brief 化简图，直到图为空或者是邻接最少的结点也大于可用寄存器数
    std::sort(InterferenceGraph.begin(), InterferenceGraph.end(), InterferenceSort);
    while(InterferenceGraph.size() && (*InterferenceGraph.begin())->neighborNum <= AvailableNum){
        for(auto iterator = InterferenceGraph.begin(); iterator != InterferenceGraph.end() && (*iterator)->neighborNum <= AvailableNum; ){
            /// @todo 小于寄存器数，移出图并使邻接结点-1
            VarStack.push_back(std::pair<ArmStruct::Operand*, bool>(*iterator, false));
            (*iterator)->neighborNum = 0;
            for(ArmStruct::Operand *neighbor: (*iterator)->neighbor){
                --neighbor->neighborNum;
            }
            iterator = InterferenceGraph.erase(iterator);
        }
        std::sort(InterferenceGraph.begin(), InterferenceGraph.end(), InterferenceSort);
    }
    if(InterferenceGraph.size()) return true; // 不为空
    return false;
}
bool ArmTools::RegisterAlloc::GraphNodeSpill(){
    /// @todo 溢出冲突最小的变量
    auto Spilled = InterferenceGraph.begin();
    for(auto iter: (*Spilled)->neighbor) --iter->neighborNum;
    VarStack.push_back(std::pair<ArmStruct::Operand*, bool>(*Spilled, true));
    InterferenceGraph.erase(Spilled);
    if((*InterferenceGraph.begin())->neighborNum >= AvailableNum) return true;
    return false;
}
void ArmTools::RegisterAlloc::ReplaceVirtualReg(){
    if(!this->ifOverflowToFloatReg){
        for(auto iter = VarStack.rbegin(); iter != VarStack.rend(); ++iter){}
    }
    else{
        /// @todo add extension registers to be in use
    }
}
