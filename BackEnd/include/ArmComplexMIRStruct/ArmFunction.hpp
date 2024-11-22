#ifndef ARM_FUNCTION
#define ARM_FUNCTION
#pragma once
#include <vector>
#include <string>
#include <list>
#include "../../Arm.hpp"

class ArmStruct::Function{
    /// @todo 维护填色图, 插入函数调用上下文保存指令(恢复寄存器 + 栈空间分配)
    public:
        Function(); // waiting...
        ~Function()=default;
        void AddBB(BB);
        void AddInst(Instruction);
        void toString();
        std::list<BB*> BBList;
        std::list<Instruction*> InstList;
    private:
        std::string Identifier;
};

#endif