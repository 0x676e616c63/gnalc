#include <memory>
#include <cassert>
#include "../../Arm.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmGlobal.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"

using namespace ArmStruct;
using namespace ArmTools;
using FrameObjRefHash = std::unordered_set<std::reference_wrapper<ArmStruct::FrameObj>&, ArmTools::HashFrameObj, ArmTools::HashFrameObjEqual>;
using FrameObjRefHashPtr = std::unique_ptr<std::unordered_set<std::reference_wrapper<ArmStruct::FrameObj>&, ArmTools::HashFrameObj, ArmTools::HashFrameObjEqual>>;
///@todo 差构造函数

FrameObj::FrameObj(Operand& oper, Imm& Imm): vitualReg(oper.VirReg){
    // oper : defed ptr
    // Imm : size
    if(oper.ValType == OperandType::INTPTR){
        val_size = 4;
        valType = OperandType::INT;
    }
    else if(oper.ValType == OperandType::FLOATPTR){
        val_size = 4;
        valType = OperandType::FLOAT;
    }
    else{
        ///@note 等待拓展
        assert("ArmFunction.cpp FrameObj::FrameObj()");
    }
}

SubFrame& SubFrame::operator=(SubFrame& other){
        if (this!= &other) {
            // 对基本类型成员进行赋值
            this->offset = other.offset;
            this->sizeTotal = other.sizeTotal;

            // 先清空当前对象的ObjList
            this->ObjList.clear();

            // 对ObjList中的元素进行赋值，需要深拷贝每个FrameObj对象
            for (const auto& uniquePtrObj : other.ObjList) {
                this->ObjList.push_back(std::make_unique<FrameObj>(*uniquePtrObj));
            }
        }

        return *this;
}

bool Function::isStackInst(Instruction& inst){
    return inst.opcode > OperCode::Addition_Oper_Begin;
}

void SubFrame::addFrameObj(Operand& oper, ArmStruct::Imm& imm){
    std::unique_ptr<FrameObj> newLocal = std::make_unique<FrameObj>(oper, imm);
    ObjList.push_back(newLocal);
    newLocal->offset = this->offset;
    sizeTotal += newLocal->val_size;
}

void Function::MkFrameInit(){
    /// @brief 寄存器分配前做, 只做开头的一个BasicBlock, 到alloca指令结束为止
    /// @brief 目的是获取local区的大小
    BB& BasicBlock = *BBList.begin();
    for(auto it = BasicBlock.InstList.begin(); it != BasicBlock.InstList.end(); ++it){
        auto &inst = it->get(); // 这里还必须指出推导的类型为引用, 但下边的又不用, 抽象
        if(inst.opcode != OperCode::alloca) break;
        local.addFrameObj(inst.DefOperandList[0], *(inst.attach));
    }

    /// @brief 获取MemInstruction的Def或者Use, 通过虚拟寄存器, 找到FrameObj
    /// @brief 将MMptr 与 找到的frameobj 绑定
    for(auto it_BB = BBList.begin(); it_BB != BBList.end(); ++it_BB){
        
        auto BB = it_BB->get();
        
        for(auto it = BB.InstList.begin(); it != BB.InstList.end(); ++it){
            
            auto& inst = (*it).get();
            
            if(!(inst.opcode > LDR_Begin && inst.opcode < STR_End)) continue;

            auto& mem_inst = dynamic_cast<MemInstruction&>(inst);
            
            for(auto it_fobj = local.ObjList.begin(); it_fobj != local.ObjList.end(); ++it_fobj){
                
                auto frameObj = **it_fobj;
                
                if(frameObj.vitualReg != mem_inst.MMptr->VirReg) continue;
                mem_inst.MMptr->space = frameObj; // bindon
            }
        }
    }
}

void Function::MkFrameFinal(){
    /// @brief 寄存器分配后做

}

void Function::TerminatorPredict(){
    ///@todo 假设由中端传来的BB组织为一张复杂图
    ///@todo 一个结点的入度和出度最大为2
    ///@todo 需要将这个图转换为普通链表
}

std::string& Function::toString(){
    std::unique_ptr<std::string> func = std::make_unique<std::string>();
    std::string& str = *func;
    
    for(auto it = BBList.begin(); it != BBList.end(); ++it){
        auto BasicBlock = it->get();
        str += BasicBlock.toString() + ':' + '\n'; // BB的label
        for(auto it_inst: BasicBlock.InstList){
            Instruction& inst = it_inst.get();
            str += "    "; // 缩进
            str += inst.toString() + '\n';
        }
    }
    return str;
}