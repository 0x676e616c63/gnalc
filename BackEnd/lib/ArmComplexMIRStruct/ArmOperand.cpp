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

MMptr::MMptr(FrameObj* space, OperandType type, unsigned long long idx): space(space), ptrType(type), VirReg(idx){
    space->getFather()->insertMMptr(VirReg, this);  // 入表
}

MMptr::MMptr(FrameObj* loc, OperandType type, unsigned long long idx, unsigned int off)
    : space(loc), ptrType(type), VirReg(idx), offset(off){
    space->getFather()->insertMMptr(VirReg, this);  // 入表
};

MMptr::MMptr(std::string spBiase){  // 疑似没用
    ///@brief for spill args
    this->data = spBiase;
}

Operand::Operand(OperandType type, std::string midEnd_VirReg){
    this->ValType = type;
    this->VirReg = std::stoull(midEnd_VirReg.substr(1)); // 去掉 '%'
    this->adjList = {};
    this->moveList = {};
}

Operand::Operand(OperandType type, unsigned int color): ValType(type), color(color){};



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

std::string Operand::toString(){
    // 先这么写
    if(this->ValType == OperandType::INT){
        str += CoreRegisterMap[(CoreRegisterName)this->color];
    }
    else if(this->ValType == OperandType::FLOAT){
        str += ExtensionRegisterMap[(ExtensionRegisterName)this->color];
    }
    return str;
}

std::string Imm::toString(){
    return this->data;
}

std::string MMptr::toString() {
    data += "[";
    
    unsigned int SubFrameOffset = this->getFrameObj()->getFather()->getOffset();
    unsigned int ObjOffset = this->getFrameObj()->getOffset();
    unsigned int PtrOffset = this->getOffset();

    unsigned int AbusoluteOffset = SubFrameOffset + ObjOffset + PtrOffset;
    if(baseVirReg == nullptr){
        data += "sp, #";
        data += std::to_string(AbusoluteOffset); // 这里不考虑imm过大的情况
    }
    else{
        data += baseVirReg->toString() + ", #";
        data += std::to_string(AbusoluteOffset);
    }

    data += "]";
    return data;
}

std::string Global::toString(){
    this->data += '=';
    this->data += GlobalId;
    return data;
}