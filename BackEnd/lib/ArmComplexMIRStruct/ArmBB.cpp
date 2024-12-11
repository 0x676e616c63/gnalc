#include <string>
#include "../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"

using namespace ArmStruct;
using namespace ArmTools;

BB::BB(IR::BasicBlock& midEnd_BasicBlock, Function& func): Func(Func){
   label = midEnd_BasicBlock.getName();
   ///@todo 遍历midEnd_BasicBlock中的Instruction,  这个过程会填写VIrMap

   ParseInsts();

   ///@todo 获取LiveOut信息,

   MkLiveOut(midEnd_BasicBlock);
}

void BB::MkLiveOut(IR::BasicBlock& midEnd_BasicBlock){
   /// @todo 遍历midEnd_BasicBlock, 按VirReg来查找this->Func.VirMap, 
}

void BB::ParseInsts(){
   
}

BB::~BB(){
   for(auto instPtr : this->InstList) delete instPtr;
}

std::string& BB::toString(){
   return label;
}