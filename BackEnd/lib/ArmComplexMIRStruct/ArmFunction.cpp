#include <memory>
#include <cassert>
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmGlobal.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"

using namespace ArmStruct;
using namespace ArmTools;

///@todo 差构造函数

SubFrame& SubFrame::operator=(SubFrame& other){
        if (this!= &other) {
            // 对基本类型成员进行赋值
            this->offset = other.offset;
            this->sizeTotal = other.sizeTotal;
            this->sizeRemain = other.sizeRemain;

            // 先清空当前对象的ObjList
            this->ObjList.clear();

            // 对ObjList中的元素进行赋值，需要深拷贝每个FrameObj对象
            for (const auto& uniquePtrObj : other.ObjList) {
                this->ObjList.push_back(std::make_unique<FrameObj>(*uniquePtrObj));
            }
        }

        return *this;
}

void Function::MkFrame(){
    ///@todo 遍历instruction序列, 找到alloca spill 等特殊的opcode
    ///@todo 现在的问题在于只有类似alloc()的指令, 没有free()指令标识FrameObj的空闲
    BB* BBptr = this->BBListHead;

    while(BBptr){
        BB& BasicBlock = *BBptr;
        BBptr = BBptr->nextBB;
        for(Instruction& inst: BasicBlock.InstList){
            if(!isStackInst(inst)) continue;
            switch(inst.opcode){
                case OperCode::alloca:

                    break;
                case OperCode::spill:

                    break;
                case OperCode::fetch:

                    break;
                case OperCode::push_args:
                
                    break;
                case OperCode::fetch_args:

                    break;
                default:
                    assert("you got me mad now!");
            }
        }
    }
}

void Function::TerminatorPredict(){
    ///@todo 假设由中端传来的BB组织为一张复杂图
    ///@todo 一个结点的入度和出度最大为2
    ///@todo 需要将这个图转换为普通链表
}

BB* Function::getTail(){
    BB* tail = this->BBListHead;
    while(tail){
        tail = tail->nextBB;
    }
    return tail;
}
std::string& Function::toString(){
    std::unique_ptr<std::string> func = std::make_unique<std::string>();
    std::string& str = *func;
    
    for(auto GlobalVal: this->GlobalList){
        ///@todo 在Global内部做好缩进和换行, 以及伪指令
        str += GlobalVal.get().toString();
    }

    BB* BasicBlock = this->BBListHead;
    while(BasicBlock){
        str += BasicBlock->toString() + ':' + '\n'; // BB的label
        for(auto it_inst: BasicBlock->InstList){
            Instruction& inst = it_inst.get();
            str += "    "; // 缩进
            str += inst.toString() + '\n';
        }
    }
    
    return str;
}