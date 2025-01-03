#include <assert.h>
#include <string>
#include <cmath>
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/tools/ArmTools.hpp"

namespace ArmTools{

bool isVLoadStoreOffsetLegal(int offset){
    //  适用于一个单位量四字节的向量运算
    if(!(offset % 4) && offset >= 0 && offset < 1024 ) return true;
    return false;
}

///@note hashes

size_t HashEdge::operator()(const Edge& edge) const {
    return std::hash<int>()(edge.u.VirReg ^ edge.v.VirReg);
};

bool HashEdgeEqual::operator()(const ArmTools::Edge& a, const ArmTools::Edge& b) const {
    return (a.u.VirReg == b.u.VirReg && a.v.VirReg == b.v.VirReg) || (a.u.VirReg == b.v.VirReg && a.v.VirReg == b.u.VirReg);
}

size_t HashOperandReferWrap::operator()(const std::reference_wrapper<ArmStruct::Operand>& ref) const {
    return std::hash<int>()(ref.get().VirReg);
}

bool HashOperandReferWrapEqual::operator()(const std::reference_wrapper<ArmStruct::Operand>& a, const std::reference_wrapper<ArmStruct::Operand>& b) const {
    return a.get().VirReg == b.get().VirReg;
}

size_t HashInstReferWrap::operator()(const std::reference_wrapper<ArmStruct::Instruction>& ref) const {
    return std::hash<int>()(ref.get().id);
}

bool HashInstReferWrapEqual::operator()(const std::reference_wrapper<ArmStruct::Instruction>& a, const std::reference_wrapper<ArmStruct::Instruction>& b) const {
    return a.get().id == b.get().id;
}


std::map<CoreRegisterName, std::string> CoreRegisterMap = {
    {CoreRegisterName::vir, "error_vir_reg"},{CoreRegisterName::r0, "r0"},{CoreRegisterName::r1, "r1"},{CoreRegisterName::r2, "r2"},{CoreRegisterName::r3, "r3"},
    {CoreRegisterName::r4, "r4"},{CoreRegisterName::r5, "r5"},{CoreRegisterName::r6, "r6"},{CoreRegisterName::r7, "r7"},{CoreRegisterName::r8, "r8"},
    {CoreRegisterName::r9, "r9"},{CoreRegisterName::r10, "r10"},{CoreRegisterName::r11, "r11"},
    {CoreRegisterName::r12, "ip"},
    {CoreRegisterName::r13, "sp"},
    {CoreRegisterName::r14, "lr"},
    {CoreRegisterName::r15, "pc"},
    {CoreRegisterName::ip, "ip"},
    {CoreRegisterName::sp, "sp"},
    {CoreRegisterName::lr, "lr"},
    {CoreRegisterName::pc, "pc"},
};

std::map<ExtensionRegisterName, std::string> ExtensionRegisterMap = {
    {ExtensionRegisterName::Exvir, "error_Exvir_reg"},{ExtensionRegisterName::s0, "s0"},{ExtensionRegisterName::s1, "s1"},{ExtensionRegisterName::s2, "s2"},
    {ExtensionRegisterName::s3, "s3"},{ExtensionRegisterName::s4, "s4"},{ExtensionRegisterName::s5, "s5"},{ExtensionRegisterName::s6, "s6"},
    {ExtensionRegisterName::s7, "s7"},{ExtensionRegisterName::s8, "s8"},{ExtensionRegisterName::s9, "s9"},{ExtensionRegisterName::s10, "s10"},
    {ExtensionRegisterName::s11, "s11"},{ExtensionRegisterName::s12, "s12"},{ExtensionRegisterName::s13, "s13"},{ExtensionRegisterName::s14, "s14"},
    {ExtensionRegisterName::s15, "s15"},{ExtensionRegisterName::s16, "s16"},{ExtensionRegisterName::s17, "s17"},{ExtensionRegisterName::s18, "s18"},
    {ExtensionRegisterName::s19, "s19"},{ExtensionRegisterName::s20, "s20"},{ExtensionRegisterName::s21, "s21"},{ExtensionRegisterName::s22, "s22"},
    {ExtensionRegisterName::s23, "s23"},{ExtensionRegisterName::s24, "s24"},{ExtensionRegisterName::s25, "s25"},{ExtensionRegisterName::s26, "s26"},
    {ExtensionRegisterName::s27, "s27"},{ExtensionRegisterName::s28, "s28"},{ExtensionRegisterName::s29, "s29"},{ExtensionRegisterName::s30, "s30"},
    {ExtensionRegisterName::s31, "s31"},
};

std::map<OperCode, std::string> OperCodeMap = {
    {OperCode::NEG, "neg"}, {OperCode::VNEG_F32, "vneg.f32"},
    {OperCode::ADD, "add"}, {OperCode::SUB, "sub"},
    {OperCode::ADDS, "adds"},{OperCode::SUBS, "subs"},{OperCode::RSBS, "rsbs"},{OperCode::MUL, "mul"},{OperCode::MLA, "mla"},
    {OperCode::MULS, "muls"}, {OperCode::SDIV, "sdiv"},
    {OperCode::DIV, "div"}, {OperCode::ORR, "orr"},{OperCode::AND, "and"},{OperCode::ASR, "asr"},
    {OperCode::ASRS, "asrs"},{OperCode::LSL, "lsl"},{OperCode::LSR, "lsr"}, {OperCode::LSLS, "lsls"}, {OperCode::ROR, "ror"},{OperCode::RRX, "rrx"},
    {OperCode::EOR, "eor"},{OperCode::VADD_F32, "vadd.f32"},{OperCode::VADD_S32, "vadd.s32"},{OperCode::VSUB_F32, "vsub.f32"},
    {OperCode::VSUB_S32, "vsub.s32"},{OperCode::VMUL_S32, "vmul.s32"},{OperCode::VMUL_F32, "vmul.f32"},{OperCode::VDIV_F32, "vdif.f32"},
    {OperCode::VDIV_S32, "vdif.s32"},{OperCode::VNEG_F32, "vneg.f32"},
    {OperCode::BEQ, "beq"},{OperCode::BNQ, "bnq"},{OperCode::BGT, "bgt"},{OperCode::BLT, "blt"},{OperCode::BGE, "bge"},{OperCode::BLE, "ble"},{OperCode::BX, "bx"},{OperCode::BL, "bl"},{OperCode::CMN, "cmn"},{OperCode::CMP, "cmp"},
    {OperCode::VCMP_F32, "vcmp.f32"},{OperCode::MOV, "mov"},{OperCode::VMOV, "vmov"},{OperCode::VMOV_F32, "vmov.f32"},
    {OperCode::VMOV_S32, "vmov.s32"},{OperCode::MOVW, "movw"},{OperCode::MOVT, "movt"},{OperCode::MVN, "mvn"},
    {OperCode::VCVT_F32_S32, "vcvt.f32.s32"},{OperCode::VCVT_S32_F32, "vcvt.s32.f32"},{OperCode::VSTR_32, "vstr.32"},{OperCode::VLDR_32, "vldr.32"},
    {OperCode::LDR, "ldr"},{OperCode::STR, "str"},{OperCode::SMULL, "smull"},{OperCode::SWI, "swi"},{OperCode::PUSH, "push"},
        // 将特殊缩进的枚举值映射为 "error_inst"
    {OperCode::Binary_Begin, "error_inst"},
    {OperCode::Binary_End, "error_inst"},
    {OperCode::Branch_Begin, "error_inst"},
    {OperCode::Branch_End, "error_inst"},
    {OperCode::FlagInst_Begin, "error_inst"},
    {OperCode::FlagInst_End, "error_inst"},
    {OperCode::Mov_Begin, "error_inst"},
    {OperCode::Mov_End, "error_inst"},
    {OperCode::Type_Convert_Begin, "error_inst"},
    {OperCode::Type_Convert_End, "error_inst"},
    {OperCode::LDR_Begin, "error_inst"},
    {OperCode::LDR_End, "error_inst"},
    {OperCode::STR_Begin, "error_inst"},
    {OperCode::STR_End, "error_inst"},
};
};