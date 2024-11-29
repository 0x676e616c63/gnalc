#include <memory>
#include <string>
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../Arm.hpp"
#include "../../include/tools/ArmTools.hpp"

using namespace ArmStruct;
using namespace ArmTools;
///@todo 还差三个类的构造函数
Operand::Operand(Operand& other) :
    ValType(other.ValType),
    // 深拷贝字符串指针指向的内容
    Indentifier(std::make_unique<std::string>(*other.Indentifier)),
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
    std::unique_ptr<std::string> reg = std::make_unique<std::string>();
    std::string& str = *reg;
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

std::string& ValOnStack::toString() {
    this->data += '[';
    this->data += CoreRegisterMap[this->space.baseReg] + ", ";
    this->data += "#" + std::to_string(this->space.offset) + "]";
    return this->data;
}