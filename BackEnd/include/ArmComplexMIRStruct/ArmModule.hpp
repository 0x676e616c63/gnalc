#pragma once
#include <string>
#include <vector>
#include "../../Arm.hpp"
#include "./ArmOperand.hpp"


class ArmStruct::Module{
    public:
        std::string ModuleName;
        bool ifNoen = false; // 是否启用Noen指令集
        // Module(IR::Module optedIR);
        ~Module() = default;
        void AddFunction(std::unique_ptr<Function>);
        void AddGlobalDataVar(Global);
        void AddGlobalBssVar(Global);
        void toString();
    private:
        std::vector<std::unique_ptr<Function>> FunctionList;
        // std::vector<GlobalOperand> GlobalDataVarList;
        // std::vector<GlobalOperand> GlobalBssVarList;
        std::string Asm;
};