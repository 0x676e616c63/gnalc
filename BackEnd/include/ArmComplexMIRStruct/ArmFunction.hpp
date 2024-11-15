#pragma once
#include <vector>
#include <string>
#include <map>
#include "../Arm.hpp"
#include "../tools/ArmRegisterAlloc.hpp"

class ArmStruct::Function{
    /// @todo 维护填色图, 插入函数调用上下文保存指令(恢复寄存器 + 栈空间分配)
    public:
        // Function(IR::Function);
        ~Function()=default;
        void AddInst(ArmStruct::Instruction);
        void toString();
        std::vector<ArmStruct::Instruction&> InstList;
    private:
        std::string Indentifier;
};