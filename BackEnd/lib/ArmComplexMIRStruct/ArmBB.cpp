#include <string>
#include <assert.h>
#include "../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../../include/ir/basic_block.hpp"

using namespace ArmStruct;
using namespace ArmTools;

BB::BB(IR::BasicBlock& midEnd_BasicBlock, Function& func): Func(func){
   label = midEnd_BasicBlock.getName();
   ///@todo 遍历midEnd_BasicBlock中的Instruction,  这个过程会填写VIrMap
   const std::list<std::shared_ptr<IR::Instruction>> midEnd_insts = midEnd_BasicBlock.getInsts();
   
   ParseInsts(midEnd_insts);

   ///@todo 获取LiveOut信息,

   MkLiveOut(midEnd_BasicBlock);

   this->label = 'L' + midEnd_BasicBlock.getName();
}

void BB::MkLiveOut(IR::BasicBlock& midEnd_BasicBlock){
   /// @todo 遍历midEnd_BasicBlock的liveout, 按VirReg来查找this->Func.VirMap,
   std::unordered_set<std::shared_ptr<IR::Value>> &midEnd_liveOut = midEnd_BasicBlock.getLiveOut();

   for(auto it = midEnd_liveOut.begin(); it != midEnd_liveOut.end(); ++it){
      auto &midEnd_value = **it;
      unsigned long long idx = std::stoull(midEnd_value.getName().substr(1));

      auto backEnd_value = this->Func.VirRegOperandMap[idx];
      this->LiveOut.insert(std::ref(*backEnd_value));
   }
}

void BB::ParseInsts(const std::list<std::shared_ptr<IR::Instruction>> insts){
   auto Movtw = new MovtwMatch{*this};
   auto Ret = new RetMatch{*this, *Movtw};
   auto Binary = new BinaryMatch{*this, *Movtw};
   auto Unary = new UnaryMatch{*this, *Movtw};
   auto Branch = new BranchMatch{*this};
   auto Alloca = new AllocaMatch{*this};
   auto Load = new LoadMatch{*this, *Movtw};
   auto Store = new StoreMatch{*this, *Movtw};
   auto Gep = new GepMatch{*this, *Movtw};
   auto FPTOSI = new FPTOSIMatch{*this};
   auto SITOFP = new SITOFPMatch{*this};
   auto Call = new CallMatch{*this};
   // auto Phi = new PhiMatch{*this};

   auto it = insts.begin();
   
   while(it != insts.end()){
      auto &midEnd_inst = **it;

      switch(midEnd_inst.getOpcode()){
         // case IR::OP::AND: case IR::OP::OR: // 还没写
         // case IR::OP::PHI: // 同上

         case IR::OP::RET:
            (*Ret)({midEnd_inst});
            ++it;
            break;
         case IR::OP::FNEG:
            (*Unary)({midEnd_inst});
            ++it;
            break;
         case IR::OP::ADD: case IR::OP::FADD: case IR::OP::SUB: case IR::OP::FSUB:
         case IR::OP::MUL: case IR::OP::FMUL: case IR::OP::DIV: case IR::OP::FDIV:
         case IR::OP::REM: case IR::OP::FREM:
            (*Binary)({midEnd_inst});
            ++it;
            break;
         case IR::OP::ALLOCA:
            (*Alloca)({midEnd_inst});
            ++it;
            break;
         case IR::OP::LOAD:
            (*Load)({midEnd_inst});
            ++it;
            break;
         case IR::OP::STORE:
            (*Store)({midEnd_inst});
            ++it;
            break;
         case IR::OP::GEP:
            (*Gep)({midEnd_inst});
            ++it;
            break;
         case IR::OP::FPTOSI: 
            (*FPTOSI)({midEnd_inst});
            ++it;
            break;
         case IR::OP::SITOFP:
            (*SITOFP)({midEnd_inst});
            ++it;
            break;
         case IR::OP::ICMP: case IR::OP::FCMP:
            // (*Branch)({midEnd_cmp, midEnd_br});
            (*Branch)({midEnd_inst, **(++it)});
            ++it;
            break;
         case IR::OP::BR:  // 没有cmp的branch指令
            (*Branch)({midEnd_inst});
            ++it;
            break;
         case IR::OP::CALL:
            (*Call)({midEnd_inst});
            ++it;
            break;
         default:
            assert(false);
      }
   }
   delete Movtw; delete Ret; delete Binary; delete Unary; delete Branch; delete Alloca; delete Load; delete Store; delete Gep; delete FPTOSI; delete SITOFP; delete Call;
}

BB::~BB(){
   for(auto instPtr : this->InstList) delete instPtr;
}

std::string BB::toString(){
   return label;
}