#include <vector>
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmModule.hpp"
#include "../../include/ArmComplexMIRStruct/ArmGlobal.hpp"
#include "../../Arm.hpp"

// ArmStruct::Module(IR::Module, optedIR){

// }
void ArmStruct::Module::AddFunction(ArmStruct::Function Func){
    this->FunctionList.push_back(Func);
}
void ArmStruct::Module::AddGlobalDataVar(ArmStruct::Global Data){
    this->GlobalDataVarList.push_back(Data);
}
void ArmStruct::Module::AddGlobalBssVar(ArmStruct::Global Bss){
    this->GlobalBssVarList.push_back(Bss);
}
void ArmStruct::Module::toString(){
    
}