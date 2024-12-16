#include <memory>
#include <string>
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../Arm.hpp"
#include "../../include/tools/ArmTools.hpp"

using namespace ArmStruct;
using namespace ArmTools;
///@todo 还差三个类的构造函数
Imm::Imm(OperandType type, std::string data): data_type(type), data(data){}

MMptr::MMptr(){
    this->space = nullptr; // 仅仅是一个表示需要溢出的标志, 具体的内存空间在FrameObj过程中指定
    ///@warning space成员如果能重载为FPU寄存器, 结合FPU占用表, 即可实现溢出至FPU寄存器
}

MMptr::MMptr(std::string spBiase){
    ///@brief for spill args
    this->data = spBiase;
}

Operand::Operand(std::string midEnd_VirReg){
    this->VirReg = std::stoull(midEnd_VirReg.substr(1)); // 去掉 '%'
    this->adjList = {};
    this->moveList = {};
}

Operand::Operand(IR::Value *midEnd_oper){} // 好像没用?

Operand::Operand(OperandType type, unsigned int VirReg): ValType(type), VirReg(VirReg){} // 好像没用?

Operand::Operand(Operand& other) :
    ValType(other.ValType),


    // 深拷贝字符串指针指向的内容
    // Indentifier(std::make_unique<std::string>(*other.Indentifier)),
    
    // Indentifier(std::make_unique<std::string>(*other.Indentifier)),
    
    VirReg(other.VirReg),
    color(other.color),
    adjDegree(other.adjDegree),
    alias(nullptr)
{
    if (other.alias) {
        alias = std::make_unique<Operand>(*other.alias);
    }
    for (const auto& refOperand : other.adjList) {
        adjList.insert(refOperand);
    }
    for (const auto& refInstruction : other.moveList) {
        moveList.insert(refInstruction);
    }
}

bool Operand::operator==(Operand& oper){
    return this->VirReg == oper.VirReg;
}

bool Operand::operator!=(Operand& oper){
    return this->VirReg != oper.VirReg;
}

std::string& Operand::toString(){
    // 先这么写
    if(this->ValType == OperandType::INT){
        str += CoreRegisterMap[(CoreRegisterName)this->color];
    }
    else if(this->ValType == OperandType::FLOAT){
        str += ExtensionRegisterMap[(ExtensionRegisterName)this->color];
    }
    return str;
}

std::string& Imm::toString(){
    return this->data;
}

std::string& MMptr::toString() {
    if(!data.empty()) return this->data; 
    
    this->data += '[';
    this->data += CoreRegisterMap[this->space->baseReg] + ", ";
    this->data += "#" + std::to_string(this->space->offset) + "]";
    return this->data;
}

std::string& Global::toString(){
    this->data += '=';
    this->data += GlobalId;
    return data;
}