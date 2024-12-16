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
using FrameObjRefHash = std::unordered_set<std::reference_wrapper<ArmStruct::FrameObj>&, ArmTools::HashFrameObj, ArmTools::HashFrameObjEqual>;
using FrameObjRefHashPtr = std::unique_ptr<std::unordered_set<std::reference_wrapper<ArmStruct::FrameObj>&, ArmTools::HashFrameObj, ArmTools::HashFrameObjEqual>>;
///@todo 差构造函数

Function::Function(IR::Function& midEnd_function){
    
    this->Identifier = midEnd_function.getName();

    ///@brief fill VirMap and link instructions
    std::vector<IR::BasicBlock*>& bbs = midEnd_function.getBlocks();

    for(auto bb_it = bbs.begin(); bb_it != bbs.end(); ++bb_it){
        auto &midEnd_BB = **bb_it;
        
        BB *backEnd_BB = new BB(midEnd_BB, *this);

        this->BBList.push_back(backEnd_BB);
        
        backEnd_BB->MkLiveOut(midEnd_BB); // 查表 IR::Value 到 Arm::Operand的转换

    }


    /// @note 现在是保存了SSA形式的MIR, 在这里插入一些OPT


    for(auto backEnd_BB : this->BBList){
        backEnd_BB->PhiEliminate();
    }
    
    /// @note 现在没有SSA了, 只能做窥孔优化


    this->MkFrameInit();
}

FrameObj::FrameObj(MMptr& oper): vitualReg(oper.VirReg){
    // oper : defed ptr
    // Imm : size
    if(oper.ptrType == OperandType::INTPTR){
        val_size = 4;
        valType = OperandType::INT;
    }
    else if(oper.ptrType == OperandType::FLOATPTR){
        val_size = 4;
        valType = OperandType::FLOAT;
    }
    else{
        ///@note 等待拓展
        assert("ArmFunction.cpp FrameObj::FrameObj()");
    }
}

bool Function::isStackInst(Instruction& inst){
    return inst.opcode > OperCode::Addition_Oper_Begin;
}

void SubFrame::addFrameObj(MMptr& ptr){
    FrameObj* newLocal = new FrameObj(ptr);
    
    ObjList.push_back(newLocal);
    
    newLocal->offset = this->offset;
    sizeTotal += newLocal->val_size;
    
    ///@note 双向绑定
    newLocal->vitualReg = ptr.VirReg;
    ptr.space = newLocal;
}

bool SubFrame::findFrameObj(MMptr& ptr){
    if(std::find(this->ObjList.begin(), this->ObjList.end(), ptr.space) != this->ObjList.end()) return true;
    else return false;
}

void Function::MkFrameInit(){

    // 仅处理alloc区域
    BB& BasicBlock = **BBList.begin();
    for(auto it = BasicBlock.InstList.begin(); it != BasicBlock.InstList.end(); ++it){
        auto &inst = **it; 
        if(inst.opcode != OperCode::alloca) break;
        auto& mem_inst = dynamic_cast<MemInstruction&>(inst);
        local.addFrameObj(*(mem_inst.MMptr)); // new + 链入localFrame + 加size
    }
}

void Function::MkFrameFinal(){
    temp.offset = local.sizeTotal + local.offset;
    
    /// @brief 寄存器分配后做, 关键是如何与之前local变量相区分
    for(auto bb_it = BBList.begin(); bb_it != BBList.end(); ++bb_it){
        auto &bb = **bb_it;
        for(auto inst_it = bb.InstList.begin(); inst_it != bb.InstList.end(); ++inst_it){
            auto &inst = **inst_it;
            if(!isStackInst(inst) || inst.opcode == OperCode::alloca) continue;
            auto& mem_inst = dynamic_cast<MemInstruction&>(inst);
            
            auto& MMptr = mem_inst.MMptr;
            if(MMptr->space != nullptr && local.findFrameObj(*MMptr)) continue;
            else if(MMptr->space == nullptr){
                /// @note 检查, 发现是local区的     
                
                temp.addFrameObj(*MMptr);
            }
            else continue;
        }
    }
}

void Function::TerminatorPredict(){
    ///@todo 假设由中端传来的BB组织为一张复杂图
    ///@todo 一个结点的入度和出度最大为2
    ///@todo 需要将这个图转换为普通链表

    ///@note 由于前端使用访问者模式划分BB, 并且这个学期还没有针对IR做优化
    ///@note 所以传入的BB, 本身就是链式的, 这个接口可以暂时省略
}

std::string& Function::toString(){
    for(auto it = BBList.begin(); it != BBList.end(); ++it){
        auto BasicBlock = **it;
        str += BasicBlock.toString() + ':' + '\n'; // BB的label
        for(auto it_inst = BasicBlock.InstList.begin(); it_inst != BasicBlock.InstList.end(); ++it_inst){
            Instruction& inst = **it_inst;
            str += "    "; // 缩进
            str += inst.toString() + '\n';
        }
    }
    return str;
}