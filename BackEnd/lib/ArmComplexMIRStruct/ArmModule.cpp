#include <vector>
#include "../../../include/ir/module.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmModule.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/tools/ArmRegisterAlloc.hpp"
#include "../../Arm.hpp"

using namespace ArmStruct;
using namespace ArmTools;

Module::Module(IR::Module& midEnd_Module){
    this->ModuleName = midEnd_Module.getName(); // pass by val

    ///@todo get .bss and get .data and get .equ
    ///@todo needed symbolTable

    ///@brief get func
    auto& funcs = midEnd_Module.getFunctions();

    for(auto func_it = funcs.begin(); func_it != funcs.end(); ++func_it){
        auto& func = **func_it;
        Function* newFunc = new Function(func); // IR->MIR, localFrame ...s
        this->AddFunction(newFunc);
    }
}

void Module::AllocRegister(){

    for(auto it = FunctionList.begin(); it != FunctionList.end(); ++it){
        Function &func = **it;
        RegisterAlloc *CoreReg = new RegisterAlloc(func, OperandType::INT, 12); // r0, r1, r2, r3, r4, r5, r6, r8, r9, r10, r11, r12
        CoreReg->GraphColoring();
        RegisterAlloc *FPUReg = new RegisterAlloc(func, OperandType::FLOAT, 32);
        FPUReg->GraphColoring();
    }
}

Module::~Module(){
    for(auto bssPtr : this->bssSection) delete bssPtr;
    for(auto dataPtr : this->dataSection) delete dataPtr;
    for(auto equPtr : this->equSection) delete equPtr;
    for(auto funcPtr : this->FunctionList) delete funcPtr;
}


void Module::Legalize(){

    /// @todo 

    for(auto func_it = this->FunctionList.begin(); func_it != FunctionList.end(); ++func_it){
        auto& func = **func_it;
        

        
    }
}

void Module::AddFunction(Function* func){
    this->FunctionList.push_back(func);
}

void Module::AddDataVar(Global* data){
    this->dataSection.push_back(data);
}

void Module::AddBssVar(Bss* bss){
    this->bssSection.push_back(bss);
}

void Module::AddEquDef(Global* equ){
    this->equSection.push_back(equ);
}

std::string& Module::toString(){
    std::unique_ptr<std::string> Asm = std::make_unique<std::string>();
    std::string& str = *Asm;
    str += arch;
    /// @note .data
    if(!dataSection.empty()){
        str += ".data\n";
        for(auto it = dataSection.begin(); it != dataSection.end(); ++it){
            auto data = **it;
            str += "    .global " + data.GlobalId + "\n";
            str += "        " + data.GlobalId + ":\n";
            if(data.data_type == OperandType::BYTE) str += "            .byte    " + data.data + '\n';
            else str += "           .word    " + data.data + '\n';
        }
    }
    /// @note .bss
    if(!bssSection.empty()){
        str += ".bss\n";
        for(auto it = bssSection.begin(); it != bssSection.end(); ++it){
            auto bss = **it;
            if(bss.isAlign) str += "    .align  4\n";
            str += "    .global " + bss.GlobalId + "\n";
            str += "        " + bss.GlobalId + ":\n";
            str += "            .zero   " + std::to_string(bss.ValSize) + '\n';
        }
    }
    ///@note .equ
    for(auto it = equSection.begin(); it != equSection.end(); ++it){
        auto equ = **it;
        str += "    .equ    " + equ.GlobalId + ", " + equ.data + '\n';
    }
    ///@note .text
    str += ".text\n.arm\n";
    for(auto it = FunctionList.begin(); it != FunctionList.end(); ++it){
        auto text = **it;
        str += ".globl " + text.Identifier + '\n';
        str += text.Identifier + ":\n";
        str += text.toString();
    }

    return str;
}