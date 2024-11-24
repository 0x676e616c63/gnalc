#include <vector>
#include <string>
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"

using namespace ArmStruct;

// ::Instruction(){

// }
///@todo 等以后重构吧, 这switch多少沾点sb了
std::string* Instruction::toString(){
    std::string *AsmInst = new std::string;
    std::string &str = *AsmInst;
    switch(this->opcode){
        case ADDS:
            str = "add ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case SUBS:
            str = "sub ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case RSBS:
        /// @brief 被减数和减数调换位置了
            str = "rsb ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case MUL:
            str = "mul ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case MLA:
        ///@brief Def[0] = Use[0]*Use[1] + Use[2]
            str = "mla ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += ", ";
            str += this->UseOperandList[2]->toString();
            str += "\n";
            break;
        case DIV:
            str = "sdiv ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case SREM:
            str = "srem ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case ORR:
            str = "orr ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case AND:
            str = "and ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case LSL:
            str = "lsl ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case LSR:
            str = "lsr ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case ROR:
            str = "ror ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case RRX:
            str = "rrx ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case EOR:
            str = "eor ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case VADD_F32:
            str = "vadd.f32 ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case VADD_S32:
            str = "vadd.s32 ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case VSUB_F32:
            str = "vsub.f32 ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case VSUB_S32:
            str = "vsub.s32 ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case VMUL_F32:
            str = "vmul.f32 ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case VMUL_S32:
            str = "vmul.s32 ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case VDIV_F32:
            str = "vdiv.f32 ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case VDIV_S32:
            str = "vdiv.s32 ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += "\n";
            break;
        case NEG:
        ///@todo 取代NEG的方法不计其数, 如MVN和ASRS
            str = "if you see this, that means something wrong happens\n";
            break;
        case BEQ:
            str = "beq ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case BNQ:
            str = "bnq ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case BGT:
            str = "bgt ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case BLT:
            str = "blt ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case BGE:
            str = "beq ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case BLE:
            str = "ble ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case BX:
            str = "bx ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case BL:
            str = "bx ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case CMP:
            str = "cmp ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case CMN:
            str = "cmn ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case VCMP_F32:
            str = "vcmp.f32 ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case MOV:
            str = "mov ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case VMOV:
            ///@brief 一般拿来类型转换前加载寄存器
            str = "vmov ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case VMOV_F32:
            str = "vmov.f32 ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case VMOV_S32:
            str = "vmov.s32 ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case MOVW:
            str = "movw ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case MOVT:
            str = "movt ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case MVN:
            str = "mvn ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case VCVT_F32_S32:
            str = "vcvt.f32.s32 ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case VCVT_S32_F32:
            str = "vcvt.s32.f32 ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case VSTR_32:
            str = "vstr.32 ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case VLDR_32:
            str = "vldr.32 ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case LDR:
            str = "ldr ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case STR:
            str = "str ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case SMULL:
            str = "smull ";
            str += this->DefOperandList[0]->toString();
            str += ", ";
            str += this->DefOperandList[1]->toString();
            str += ", ";
            str += this->UseOperandList[0]->toString();
            str += ", ";
            str += this->UseOperandList[1]->toString();
            str += '\n';
            break;
        case SWI:
            str = "swi ";
            str += this->UseOperandList[0]->toString();
            str += '\n';
            break;
        case PUSH:
            str = "push ";
            str += '{';
            for(::Operand* UseOper: this->UseOperandList){
                str += UseOper->toString();
                str += ", "; //
            }
            str.resize(str.size() - 2);
            str += "}\n";
            break;
        default:
            str = "implement asm inst type";
    }

    return AsmInst;
}