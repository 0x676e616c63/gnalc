#include <vector>
#include <string>
#include <map>
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"

using namespace ArmStruct;
using namespace ArmTools;
///@todo 还差instruction的构造函数
// ::Instruction(){

// }

/// @brief reWrite Programme
Instruction::Instruction(Instruction& inst, OperCode type, unsigned int cnt): BasicBlock(inst.BasicBlock), DefOperandList(), UseOperandList()
{
    this->id = cnt;
    this->opcode = type;
    if(type == OperCode::STR){
        UseOperandList.push_back(inst.DefOperandList[0]);
    }
    else{
        DefOperandList.push_back(inst.UseOperandList[0]);
    }
    /// @note 
    this->attach = new MMptr();
    
}

bool Instruction::operator==(Instruction& inst) const{
    return this->id == inst.id;
};
std::string& Instruction::toString(){
    std::unique_ptr<std::string> AsmInst = std::make_unique<std::string>();
    std::string &str = *AsmInst;
    if(this->opcode < OperCode::Binary_End){
        str += OperCodeMap[this->opcode] + ' ';
        str += this->DefOperandList[0].get().toString() + ", ";
        str += this->UseOperandList[0].get().toString() + ", ";
        str += this->UseOperandList[1].get().toString() + '\n';
    }
    else if(this->opcode < OperCode::Branch_End){
        str += OperCodeMap[this->opcode] + ' ';
        if(UseOperandList.size()) str += this->UseOperandList[0].get().toString() + '\n'; // lr register
        else str += this->attach->toString() + '\n'; // label 
    }
    else if(this->opcode < OperCode::FlagInst_End){
        str += OperCodeMap[this->opcode] + ' ';
        str += this->UseOperandList[0].get().toString() + ", ";
        str += this->UseOperandList[1].get().toString() + '\n';
    }
    else if(this->opcode < OperCode::Mov_End){
        str += OperCodeMap[this->opcode] + ' ';
        str += this->DefOperandList[0].get().toString() + ", ";
        if(UseOperandList.size()) str += this->UseOperandList[0].get().toString() + '\n';
        else str += this->attach->toString() + '\n'; // most likely a Imm
    }
    else if(this->opcode < Type_Convert_End){
        str += OperCodeMap[this->opcode] + ' ';
        str += this->DefOperandList[0].get().toString() + ", ";
        str += this->UseOperandList[0].get().toString() + '\n';
    }
    else if(this->opcode < LDR_End){
        str += OperCodeMap[this->opcode] + ' ';
        str += this->DefOperandList[0].get().toString() + ", ";
        str += this->attach->toString() + '\n'; // an MMptr
    }
    else if(this->opcode < STR_End){
        str += OperCodeMap[this->opcode] + ' ';
        str += this->UseOperandList[0].get().toString() + ", ";
        str += this->attach->toString() + '\n';
    }
    else if(this->opcode == SMULL){
        str += "smull ";
        str += this->DefOperandList[0].get().toString() + ", ";
        str += this->UseOperandList[0].get().toString() + ", ";
        str += this->UseOperandList[1].get().toString() + ", ";
        str += this->UseOperandList[2].get().toString() + '\n';
    }
    else if(this->opcode == SWI){
        str += "swi ";
        str += this->attach->toString() + '\n'; 
    }
    else{ // this->opcode == PUSH
        str += "push {";
        for(auto oper: this->UseOperandList){
            str += oper.get().toString() + ", ";
        }
        str.pop_back(), str.pop_back();
        str += "}\n";
    }
    return str;
}