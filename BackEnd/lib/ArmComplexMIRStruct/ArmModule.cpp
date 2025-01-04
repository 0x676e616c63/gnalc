#include <vector>
#include "../../../include/ir/module.hpp"
#include "../../../include/ir/constant.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmModule.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/tools/ArmRegisterAlloc.hpp"
#include "../../Arm.hpp"

using namespace ArmStruct;
using namespace ArmTools;

std::vector<ArmStruct::Operand*> RegisterPool = {};
std::vector<ArmStruct::Operand*> FPURegisterPool = {};
std::vector<ArmStruct::Imm*> ConstPool = {};

/// @note 符号表完善之后会删除
Module::Module(IR::Module& midEnd_Module){
    this->ModuleName = midEnd_Module.getName(); // pass by val

    ///@todo get .bss and get .data and get .equ
    
    for(auto &midEnd_globalVar : midEnd_Module.getGlobalVars()){
        Global *backEnd_globalVar = new Global(*midEnd_globalVar.get());
        dataSection.push_back(backEnd_globalVar);
    }

    ///@todo needed symbolTable

    /// @brief make RegisterPools
    for(int i = 0; i <= 15; ++i){
        Operand *reg = new Operand(OperandType::INT, i);
        RegisterPool.push_back(reg);
    }
    for(int i = 0; i <= 31; ++i){
        Operand *Freg = new Operand(OperandType::FLOAT, i);
        FPURegisterPool.push_back(Freg);
    }

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
        RegisterAlloc *CoreReg = new RegisterAlloc(func, OperandType::INT, 11); // r0, r1, r2, r3, r4, r5, r6, r8, r9, r10, r11(no r7)
        CoreReg->GraphColoring();
        delete CoreReg;

        RegisterAlloc *FPUReg = new RegisterAlloc(func, OperandType::FLOAT, 32); // s0 - s31
        FPUReg->GraphColoring();
        delete FPUReg;
    }
}

Module::~Module(){
    for(auto bssPtr : this->bssSection) delete bssPtr;
    for(auto dataPtr : this->dataSection) delete dataPtr;
    for(auto equPtr : this->equSection) delete equPtr;
    for(auto funcPtr : this->FunctionList) delete funcPtr;
    
    // free pools
    for(auto reg : RegisterPool) delete reg;
    for(auto FPUreg : FPURegisterPool) delete FPUreg;
    for(auto cons : ConstPool) delete cons;
}


void Module::Legalize(){

    for(auto func_it = this->FunctionList.begin(); func_it != FunctionList.end(); ++func_it){
        Function& func = **func_it;
        
        func.MkFrameFinal();

        BB& BB_head = **(func.BBList.begin());
        BB& BB_tail = *(func.BBList.back());

        Operand *backEnd_r7 = RegisterPool[CoreRegisterName::r7];
        Operand *backEnd_sp = RegisterPool[CoreRegisterName::sp];
        Operand *backEnd_lr = RegisterPool[CoreRegisterName::lr];
        Operand *backEnd_pc = RegisterPool[CoreRegisterName::pc];
        Imm *backEnd_0 = new Imm(OperandType::INT, "0");
        Imm *backEnd_stackSize = new Imm(OperandType::INT, std::to_string(func.getStackSize()));
        ConstPool.push_back(backEnd_0);
        ConstPool.push_back(backEnd_stackSize);

        // push {r7, lr}; sub sp, sp, #imm; add r7, sp, #0;
        Instruction *backEnd_add_1 = new Instruction(
            OperCode::ADD, backEnd_0, BB_head, {std::ref(*backEnd_r7)}, {std::ref(*backEnd_sp)}
        );
        BB_head.InstList.insert(BB_head.InstList.begin(), backEnd_add_1);

        Instruction *backEnd_sub = new Instruction(
            OperCode::SUB, backEnd_stackSize, BB_head, {std::ref(*backEnd_sp)}, {std::ref(*backEnd_sp)}
        );
        BB_head.InstList.insert(BB_head.InstList.begin(), backEnd_sub);
        
        Instruction *backEnd_push = new Instruction(
            OperCode::PUSH, backEnd_stackSize, BB_head, {}, {std::ref(*backEnd_r7), std::ref(*backEnd_lr)}
        );
        BB_head.InstList.insert(BB_head.InstList.begin(), backEnd_push);
        
        // add r7, r7, #imm; mov sp, r7; pop {r7, pc}
        Instruction *backEnd_add_2 = new Instruction(
            OperCode::ADD, backEnd_stackSize
            , BB_tail, {std::ref(*backEnd_r7)}, {std::ref(*backEnd_r7)}
        );
        BB_tail.InstList.insert(BB_tail.InstList.end(), backEnd_add_2);

        Instruction *backEnd_mov = new Instruction(
            OperCode::MOV, nullptr
            , BB_tail, {std::ref(*backEnd_sp)}, {std::ref(*backEnd_r7)}
        );
        BB_tail.InstList.insert(BB_tail.InstList.end(), backEnd_mov);        
        
        Instruction *backEnd_pop = new Instruction(
            OperCode::POP, backEnd_stackSize
            , BB_tail, {}, {std::ref(*backEnd_r7), std::ref(*backEnd_pc)}
        );
        BB_tail.InstList.insert(BB_tail.InstList.end(), backEnd_pop);
    }
    return;
}

void Module::AddFunction(Function* func){
    this->FunctionList.push_back(func);
}

void Module::AddDataVar(Global* data){
    this->dataSection.push_back(data);
}

void Module::AddEquDef(Global* equ){
    this->equSection.push_back(equ);
}

std::string Module::toString(){
    std::unique_ptr<std::string> Asm = std::make_unique<std::string>();
    std::string str = *Asm;
    str += arch;
    /// @note .data
    if(!dataSection.empty()){
        str += ".data\n";
        str += "    .align 4\n";
        for(auto it = dataSection.begin(); it != dataSection.end(); ++it){
            auto data = **it;
            str += "    .global " + data.data + '\n';
            str += "    " + data.data + ":\n";
            str += data.toString();
        }
    }

    ///@note .bss

    ///@note .equ

    ///@note .text
    str += ".text\n.arm\n";
    for(auto it = FunctionList.begin(); it != FunctionList.end(); ++it){
        auto &text = **it;
        str += ".globl " + text.Identifier + '\n';
        str += text.Identifier + ":\n";
        str += text.toString();
    }

    return str;
}