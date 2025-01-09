#include <memory>
#include <string>
#include "../../../include/codegen/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../../include/codegen/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../../include/codegen/Arm.hpp"
#include "../../../include/codegen/tools/ArmTools.hpp"
#include "../../../include/ir/global_var.hpp"
#include "../../../include/ir/constant.hpp"

using namespace ArmStruct;
using namespace ArmTools;
///@todo 还差三个类的构造函数



// MMptr::MMptr(std::string spBiase){  // 疑似没用
//     ///@brief for spill args
//     this->data = spBiase;
// }

Operand::Operand(OperandType type, std::string midEnd_VirReg){
    this->ValType = type;
    this->VirReg = std::stoull(midEnd_VirReg.substr(1)); // 去掉 '%'
    this->adjList = {};
    this->moveList = {};
}

Operand::Operand(OperandType type, unsigned int color): ValType(type){
    this->color.first = true;
    this->color.second = color;
    //
    this->VirReg = -1; // 确保不会和其他未着色的Oper冲突
};


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
    ///@bug 记得清空
    str = "";
    
    if(this->ValType == OperandType::INT){
        str += CoreRegisterMap[(CoreRegisterName)this->color.second];
    }
    else if(this->ValType == OperandType::FLOAT){
        str += ExtensionRegisterMap[(ExtensionRegisterName)this->color.second];
    }
    
    ///debug
    // str += "(" + std::to_string(this->VirReg) + ")";

    return str;
}

Imm::Imm(OperandType type): data_type(type){}

Imm::Imm(OperandType type, std::string data): data_type(type), data(data){}

std::string Imm::toString(){
    if(data_type == LABEL) return data;
    else return "#" + data;
}

MMptr::MMptr(FrameObj* space, OperandType type, unsigned long long idx): Imm(type), space(space), VirReg(idx){
    // space->getFather()->insertMMptr(VirReg, this);  // 在FrameObj内入表
}

MMptr::MMptr(FrameObj* loc, OperandType type, unsigned long long idx, unsigned int off)
    : Imm(type), space(loc), VirReg(idx), offset(off){
    if(loc) space->getFather()->insertMMptr(VirReg, this);  // 入表
    
};

MMptr::MMptr(Operand* base, OperandType type, unsigned long long off)
    : Imm(type), baseVirReg(base), VirReg(-1), offset(off){
    space = nullptr;
}

std::string MMptr::toString() {
    data = "";
    data += "[";
    
    unsigned int AbusoluteOffset = 0;

    if(this->getFrameObj()){
        unsigned int SubFrameOffset = this->getFrameObj()->getFather()->getOffset();
        unsigned int ObjOffset = this->getFrameObj()->getOffset();
 
        AbusoluteOffset += SubFrameOffset + ObjOffset;
    }
    unsigned int PtrOffset = this->getOffset();
    
    AbusoluteOffset += PtrOffset;
    
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


Global::Global(IR::GlobalVariable& midEnd_GlobalVar): Imm(OperandType::LABEL){
    data = midEnd_GlobalVar.getName().substr(1);

    parse(midEnd_GlobalVar.getIniter());

}

Global::~Global(){
    for(auto initerptr : GlobalIniterList) delete initerptr;
}

void Global::parse(const IR::GVIniter& midEnd_initer){
    
    if(midEnd_initer.isZero()){
        auto &initer_type = midEnd_initer.getIniterType();
        unsigned long long size = initer_type.get()->getBytes();

        GlobalIniter *backEnd_initer = new GlobalIniter(size);
        GlobalIniterList.push_back(backEnd_initer);
        return;    
    }
    
    if(!midEnd_initer.isArray()){
        unsigned int encoding;
        auto& initer_type = midEnd_initer.getConstVal();
        IR::Value &constValue = *(initer_type.get());

        if(typeid(constValue) == typeid(IR::ConstantInt&)){
            int temp = dynamic_cast<IR::ConstantInt&>(constValue).getVal();
            encoding = temp;
        }
        else{
            float temp = dynamic_cast<IR::ConstantFloat&>(constValue).getVal();
            encoding = *reinterpret_cast<unsigned int*>(&temp);
        }
        GlobalIniter *backEnd_initer = new GlobalIniter(OperandType::INT, encoding);
        GlobalIniterList.push_back(backEnd_initer);

        return;
    }

    for(auto &inner_initer : midEnd_initer.getInnerIniter()){
        parse(inner_initer);
    }

    return;
}

GlobalIniter::GlobalIniter(OperandType type, unsigned int encondings): valType(type), valEncoding(encondings){
    blockInit = std::make_unique<std::pair<bool, int>>(false, -1);
}; // encodings


GlobalIniter::GlobalIniter(unsigned long long space){
    blockInit = std::make_unique<std::pair<bool, int>>(true, space);
}

std::string Global::toString(){
    ///@warning 默认两个indent
    std::string str;
    for(auto initer : GlobalIniterList){
        str += "        " + initer->toString() + "\n";
    }

    return str;
}

std::string GlobalIniter::toString(){
    std::string str;
    if(blockInit.get()->first == false){
        str += ".word " + std::to_string(valEncoding) + "\n";
    }
    else{
        str += ".zero " + std::to_string(blockInit.get()->second) + "\n";
    }

    return str;
}