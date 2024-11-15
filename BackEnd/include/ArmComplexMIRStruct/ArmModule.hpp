#pragma once
#include <string>
#include <vector>
#include "../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"

class ArmStruct::Module{
    public:
        std::string ModuleName;
        bool ifNoen = false; // 是否启用Noen指令集
        // Module(IR::Module optedIR);
        ~Module() = default;
        void AddFunction(ArmStruct::Function);
        void AddGlobalDataVar(ArmStruct::Global);
        void AddGlobalBssVar(ArmStruct::Global);
        void toString();
    private:
        std::vector<ArmStruct::Function> FunctionList;
        std::vector<ArmStruct::GlobalOperand> GlobalDataVarList;
        std::vector<ArmStruct::GlobalOperand> GlobalBssVarList;
        std::string Asm;
};