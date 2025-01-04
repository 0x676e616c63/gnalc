#include <memory>
#include <algorithm>
#include <cassert>
#include <cmath>
#include "../../Arm.hpp"
#include "../../../include/ir/function.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"

using namespace ArmStruct;
using namespace ArmTools;

extern std::vector<ArmStruct::Operand*> RegisterPool;
extern std::vector<ArmStruct::Operand*> FPURegisterPool;
extern std::vector<ArmStruct::Imm*> ConstPool;

///@todo 差构造函数

FrameObj::FrameObj(SubFrame *Father, OperandType type, unsigned int size, unsigned long long idx):
    father(Father), type(type), ObjSize(size), VirPtr(idx) {
        
        father->insertObj(VirPtr, this);
        // idx不只是FrameObj的编号, 也是MMptr的编号
        MMptr *ptr = new MMptr(this, type, idx);
        father->insertMMptr(idx, ptr);
}

ArrayObj::ArrayObj(SubFrame* father, OperandType elementType, unsigned long long VirPtr, std::vector<unsigned long long> dims):
    FrameObj(father, elementType, 0, VirPtr){
        unsigned int singleElemSize = 4; // to be continued...

        unsigned int totalObjSize = 0;
        for(unsigned int size : dims){
            arrayDims.push_back(size);
            totalObjSize += size * singleElemSize;
        }
        setSize(totalObjSize);
        
        MMptr *ArrayPtr = new MMptr(this, elementType, VirPtr);
        father->insertMMptr(VirPtr, ArrayPtr);
}

Function::Function(IR::Function& midEnd_function){
    
    local = new SubFrame();
    temp = new SubFrame();
        
    this->Identifier = midEnd_function.getName().substr(1); // 去掉@
    this->VRegNum = midEnd_function.getVRegNum();

    ///@brief fill VirMap and link instructions
    std::vector<std::shared_ptr<IR::BasicBlock>> bbs = midEnd_function.getBlocks();

    for(auto bb_it = bbs.begin(); bb_it != bbs.end(); ++bb_it){
        auto &midEnd_BB = **bb_it;
        
        BB *backEnd_BB = new BB(midEnd_BB, *this);

        this->BBList.push_back(backEnd_BB);
        
        backEnd_BB->MkLiveOut(midEnd_BB); // 查表 IR::Value 到 Arm::Operand的转换

    }
    
    if(this->Identifier != "main"){
        std::vector<unsigned long long> backEnd_temp_VReg;
        /// @note 在首位BasicBlock插入mov %temp {r4,r5...r11}
        auto &backEnd_BB_head = **BBList.begin();
        for(int i = 4; i < 12; ++i){
            
            Operand *Def = new Operand(OperandType::INT, "%" + std::to_string(backEnd_BB_head.Func.VRegNum));
            backEnd_temp_VReg.push_back(backEnd_BB_head.Func.VRegNum);
            backEnd_BB_head.Func.VirRegOperandMap[backEnd_BB_head.Func.VRegNum++] = Def; 
            
            Operand *Use = RegisterPool[i]; // CoreRegisterName::ri

            if(i == CoreRegisterName::r7) continue;
            
            Instruction *backEnd_callee_rx = new Instruction(
                OperCode::MOV, nullptr, backEnd_BB_head, {std::ref(*Def)}, {std::ref(*Use)}
            );
            backEnd_BB_head.InstList.push_front(backEnd_callee_rx);
        }

        /// @note 在最后BasicBlock插入mov {r4,r5...r11} %temp
        auto &backEnd_BB_tail = *BBList.back();    
        for(int i = 0; i < 8; ++i){
            ///@brief mov rx, %temp
            if(i + 4 == CoreRegisterName::r7) continue;
            Operand *Def = RegisterPool[i + 4];
            Operand *Use = backEnd_BB_tail.Func.VirRegOperandMap[backEnd_temp_VReg[i]];

            Instruction *backEnd_callee_rx = new Instruction(
                OperCode::MOV, nullptr, backEnd_BB_tail, {std::ref(*Def)}, {std::ref(*Use)}
            );

            backEnd_BB_tail.InstList.push_back(backEnd_callee_rx);
        }
    }

    /// @note 现在是保存了SSA形式的MIR, 在这里插入一些OPT

    /// @note phi函数消除, 待做
    // for(auto backEnd_BB : this->BBList){
    //     backEnd_BB->PhiEliminate();
    // }
    
    /// @note 现在没有SSA了, 只能做窥孔优化
}

void Function::MkFrameFinal(){
    StackSize += local->getSize();
    StackSize += temp->getSize();
    temp->setOffset(0);
    local->setOffset(temp->getSize());

    temp->assignOffset();
    local->assignOffset();
}

// void Function::TerminatorPredict();

Function::~Function(){
    for(auto bbptr : BBList) delete bbptr;
    for(auto operptr : VirRegOperandMap) delete operptr.second;
    delete local;
    delete temp;
}

std::string Function::toString(){
    for(auto it = BBList.begin(); it != BBList.end(); ++it){
        auto BasicBlock = **it;
        str += BasicBlock.toString() + ':' + '\n'; // BB的label
        for(auto it_inst = BasicBlock.InstList.begin(); it_inst != BasicBlock.InstList.end(); ++it_inst){
            Instruction& inst = **it_inst;
            str += "    "; // 缩进
            str += inst.toString(); // \n 不要写多了
        }
    }
    return str;
}

unsigned int SubFrame::getSize(){
    unsigned int totalSize = 0;
    for(auto it = VirPtrFrameObjMap.begin(); it != VirPtrFrameObjMap.end(); ++it){
        totalSize += (*it).second->getSize();
    }
    return totalSize;
}

SubFrame::~SubFrame(){
    for(auto operptr : VirPtrFrameObjMap) delete operptr.second;
    for(auto frameptr : VirPtrOffsetMap) delete frameptr.second;
}

void SubFrame::assignOffset(){
    unsigned long long totalOff = 0;
    for(auto iter : VirPtrFrameObjMap){
        auto &obj = *iter.second;
        obj.setOffset(totalOff);
        totalOff += obj.getSize();
    }
}