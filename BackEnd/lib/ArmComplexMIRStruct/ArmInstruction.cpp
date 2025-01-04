#include <vector>
#include <string>
#include <map>
#include <assert.h>
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"

using namespace ArmStruct;
using namespace ArmTools;

/// @note md这里还歧义了
MemInstruction::MemInstruction(OperCode opcode, ArmStruct::MMptr* ptr, BB& BasicBlock, Operand* Def_Use):
    mmptr(ptr), Instruction(opcode, nullptr, BasicBlock, {}, {}){
        if(opcode == VLDR_32 || opcode == LDR) DefOperandList.push_back(std::ref(*Def_Use));
        else UseOperandList.push_back(std::ref(*Def_Use));

        if(mmptr->getBase() != nullptr){
            this->UseOperandList.push_back(std::ref(*mmptr->getBase()));
        }
    }

/// @note to fill VirMap and add InstCnt
Instruction::Instruction(OperCode opcode,Imm* attach, BB& BasicBlock,
    std::initializer_list<std::reference_wrapper<Operand>> Defs, 
    std::initializer_list<std::reference_wrapper<Operand>> Uses):
    opcode(opcode), id(++BasicBlock.Func.InstCnt), attach(attach), BasicBlock(BasicBlock){
        
        for(auto oper_it = Defs.begin(); oper_it != Defs.end(); ++oper_it){
            auto &oper = oper_it->get();
            this->DefOperandList.push_back(std::ref(oper)); 
        }
        
        for(auto oper_it = Uses.begin(); oper_it != Uses.end(); ++oper_it){
            auto &oper = oper_it->get();
            this->UseOperandList.push_back(std::ref(oper));
        }
}

/// @brief reWrite Programme to add overflow vars
Instruction::Instruction(Instruction& inst, OperCode type, unsigned int cnt):
    BasicBlock(inst.BasicBlock){
    /// @todo 这里实际上也可以用MemInstruction的构造, attach成员这个设计确实会造成太多歧义
    this->id = cnt;
    this->opcode = type;
    if(type == OperCode::STR || type == OperCode::VSTR_32){
        UseOperandList.push_back(inst.DefOperandList[0]);
    }
    else{
        DefOperandList.push_back(inst.UseOperandList[0]);
    }
    /// @note MMptr 用于保存栈空间信息
    /// @note 分配临时变量
    Function &func = this->BasicBlock.Func;
    
    OperandType valType;
    if(type == OperCode::VLDR_32 || type == OperCode::VSTR_32) valType = OperandType::FLOAT;
    else valType = OperandType::INT;

    FrameObj *tempObj = new FrameObj(func.getTemp(), OperandType::FLOAT, 4,func.getTemp()->getObjCnt());

    this->attach = func.getTemp()->findMMptr(func.getTemp()->getObjCnt() - 1);
    
}


bool Instruction::operator==(Instruction& inst) const{
    return this->id == inst.id;
};

std::string Instruction::toString(){
    std::unique_ptr<std::string> AsmInst = std::make_unique<std::string>();
    std::string str = *AsmInst;
    if(this->opcode < OperCode::Binary_End){
        str += OperCodeMap[this->opcode] + ' ';
        str += this->DefOperandList[0].get().toString() + ", ";

        switch(UseOperandList.size()){
            case 0:
                assert(false);
                break;
            case 1:
                str += this->UseOperandList[0].get().toString() + ", ";
                str += this->attach->toString() + '\n';
                break;
            case 2:
                str += this->UseOperandList[0].get().toString() + ", ";
                str += this->UseOperandList[1].get().toString() + "\n";
                break;
            default:
                assert(false);
        }
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
    else{ // this->opcode == PUSH, POP
        if(opcode == PUSH) str += "push {";
        else str += "pop {";
        for(auto oper: this->UseOperandList){
            str += oper.get().toString() + ", ";
        }
        str.pop_back(), str.pop_back();
        str += "}\n";
    }
    return str;
}

std::string MemInstruction::toString(){
    std::string str = "";
    if(opcode == LDR || opcode == VLDR_32){
        str += OperCodeMap[opcode] + ' ';
        str += DefOperandList[0].get().toString() + ", ";
        str += mmptr->toString() + '\n';
    }
    else{
        str += OperCodeMap[opcode] + ' ';
        str += UseOperandList[0].get().toString() + ", ";
        str += mmptr->toString() + '\n';
    }
    return str;
}