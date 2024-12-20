#ifndef ARM_FUNCTION
#define ARM_FUNCTION
#pragma once
#include <vector>
#include <string>
#include <list>
#include <memory>
#include "../../../include/ir/function.hpp"
#include "../tools/ArmTools.hpp"
#include "./ArmOperand.hpp"
#include "../../Arm.hpp"

/// @brief Frame系列数据结构用于管理溢出变量在栈上的内存分配
/// @brief FrameObj用来存放栈中的一个或者多个(向量化)的字长内存, 便于合法化ldr, str之类的指令
/// @brief 对应的一组(或者几组)ldr/str, 分配一个FrameObj

class ArmStruct::FrameObj{
    public:
        FrameObj(SubFrame*, OperandType, unsigned int, unsigned long long); // 自动调用insert
        ~FrameObj()=default;
        OperandType getType(){return type;};
    
        SubFrame* getFather(){return father;};
        
        unsigned int getSize(){return ObjSize;};
    private:
        OperandType type;
        SubFrame* father; // 指的是所属的SubFrame
        unsigned int ObjSize;
        unsigned long long VirPtr; // 编号
};

class ArmStruct::SubFrame{
    public:
        SubFrame();
        ~SubFrame()=default;

        ///@warning will ret nulls
        void insertObj(unsigned long long idx, FrameObj* Obj){VirPtrFrameObjMap[idx] = Obj;}

        void insertMMptr(unsigned long long idx, MMptr* ptr){VirPtrOffsetMap[idx] =  ptr;};

        FrameObj* findObj(unsigned long long idx){return VirPtrFrameObjMap[idx];}

        MMptr* findMMptr(unsigned long long idx){return VirPtrOffsetMap[idx];}
        unsigned int getSize();

    private:
        std::map<unsigned long long, MMptr*>VirPtrOffsetMap; // 做一个对象池
        std::map<unsigned long long, FrameObj*>VirPtrFrameObjMap; // 
};


class ArmStruct::Function{
    public:
        Function(IR::Function&); // waiting...
        ~Function();
        bool isStackInst(Instruction&); // stack分配相关的指令
        
        ///@note 在寄存器分配之后, 多出来了一些用于管理temp区的load/store指令
        ///@note汇总之后, 分配栈空间
        void MkFrameFinal();

        /// @brief 插入push bx等语句
        void LegalizeFinal();

        void TerminatorPredict();

        std::string& toString();
        
        std::list<BB*> BBList;
        
        std::map<unsigned long long, Operand*> VirRegOperandMap;
        unsigned long long VRegNum;

        unsigned int InstCnt = 0;
        std::string Identifier;

        SubFrame* getLocal(){return local;}
        SubFrame* getTemp(){return temp;}
        unsigned int getParamSize(){return params_size;}
        void setParamSize(unsigned int size){params_size = size;}

    private:
        SubFrame *local;
        SubFrame *temp;
        unsigned int params_size = 0;
        std::string str;

};

#endif