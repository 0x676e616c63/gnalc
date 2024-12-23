#include <string>
#include "../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../../include/ir/basic_block.hpp"

using namespace ArmStruct;
using namespace ArmTools;

BB::BB(IR::BasicBlock& midEnd_BasicBlock, Function& func): Func(Func){
   label = midEnd_BasicBlock.getName();
   ///@todo 遍历midEnd_BasicBlock中的Instruction,  这个过程会填写VIrMap

   ParseInsts();

   ///@todo 获取LiveOut信息,

   MkLiveOut(midEnd_BasicBlock);

   this->label = 'L' + midEnd_BasicBlock.getName();
}

void BB::MkLiveOut(IR::BasicBlock& midEnd_BasicBlock){
   /// @todo 遍历midEnd_BasicBlock的liveout, 按VirReg来查找this->Func.VirMap,
   std::list<std::shared_ptr<IR::Value>> &midEnd_liveOut = midEnd_BasicBlock.getLiveOut();

   for(auto it = midEnd_liveOut.begin(); it != midEnd_liveOut.end(); ++it){
      auto &midEnd_value = **it;
      unsigned long long idx = std::stoull(midEnd_value.getName().substr(1));

      auto backEnd_value = this->Func.VirRegOperandMap[idx];
      this->LiveOut.insert(std::ref(*backEnd_value));
   }
}

void BB::ParseInsts(){
   
}

BB::~BB(){
   for(auto instPtr : this->InstList) delete instPtr;
}

std::string& BB::toString(){
   return label;
}