#ifndef ARMTOOLS
#define ARMTOOLS
#pragma once
#include <map>
#include <list>
#include "../../Arm.hpp"

namespace ArmTools{
class Edge{
    public:
        Edge(ArmStruct::Operand& u, ArmStruct::Operand& v):u(u), v(v){};
        ~Edge()=default;
        ArmStruct::Operand& u;
        ArmStruct::Operand& v;
};
struct HashEdge{
    size_t operator()(const Edge& edge) const;
};
struct HashEdgeEqual{
    bool operator()(const ArmTools::Edge& a, const ArmTools::Edge& b) const;
};
struct HashOperandReferWrap{
    size_t operator()(const std::reference_wrapper<ArmStruct::Operand>& ref) const;
};
struct HashOperandReferWrapEqual{
    bool operator()(const std::reference_wrapper<ArmStruct::Operand>& a, const std::reference_wrapper<ArmStruct::Operand>& b) const ;
};
struct HashInstReferWrap{
    size_t operator()(const std::reference_wrapper<ArmStruct::Instruction>& ref) const;
};
struct HashInstReferWrapEqual{
    bool operator()(const std::reference_wrapper<ArmStruct::Instruction>& a, const std::reference_wrapper<ArmStruct::Instruction>& b) const; 
};

enum CoreRegisterName{
    vir = -1,
    r0, r1, r2, r3, // 由调用者保存
    r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, // 由被调者恢复
    sp = r13,
    lr = r14,
    pc = r15
};
std::map<CoreRegisterName, std::string> CoreRegisterMap = {
    {CoreRegisterName::vir, "error_vir_reg"},{CoreRegisterName::r0, "r0"},{CoreRegisterName::r1, "r1"},{CoreRegisterName::r2, "r2"},{CoreRegisterName::r3, "r3"},
    {CoreRegisterName::r4, "r4"},{CoreRegisterName::r5, "r5"},{CoreRegisterName::r6, "r6"},{CoreRegisterName::r7, "r7"},{CoreRegisterName::r8, "r8"},
    {CoreRegisterName::r9, "r9"},{CoreRegisterName::r10, "r10"},{CoreRegisterName::r11, "r11"},{CoreRegisterName::r12, "r12"},
    {CoreRegisterName::r13, "sp"}, // r13-r15 为保留寄存器, 不参与寄存器分配
    {CoreRegisterName::r14, "lr"},
    {CoreRegisterName::r15, "pc"},
};
enum ExtensionRegisterName{
    Exvir = -1,
    s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, // 调用者保存 
    s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31 // 被调者恢复
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
/// @warning 如果需要添加指令, 记得在OperCodeMap中添加对应的键值对
enum OperCode{
    Binary_Begin,
        ADD, ADDS, SUB, SUBS, RSBS, MUL, MULS, MLA, DIV, DIVS,SREM, ORR, AND, ASR, ASRS, LSL, LSR, ROR, RRX, EOR,
        // SIMD
        VADD_F32, VADD_S32,
        VSUB_F32, VSUB_S32,
        VMUL_S32, VMUL_F32,
        VDIV_F32, VDIV_S32,
    Binary_End,
            // NEG, 使用别的指令取代
    Branch_Begin,
        BEQ, BNQ, BGT, BLT, BGE, BLE,
        BX, BL,
    Branch_End,

    FlagInst_Begin,
        CMN, CMP, VCMP_F32,
    FlagInst_End,

    Mov_Begin,
        MOV, VMOV, VMOV_F32, VMOV_S32, MOVW, MOVT, MVN,
    Mov_End,

    Type_Convert_Begin,
        VCVT_F32_S32, VCVT_S32_F32,
    Type_Convert_End,

    LDR_Begin,
        VLDR_32, LDR,
    LDR_End,
    
    STR_Begin,
        STR, VSTR_32,
    STR_End,
        // single long multiple
        SMULL,
        // syscall + Imm
        SWI,
        // push
        PUSH,
    /// @brief 并非Arm指令
    Addition_Oper_Begin,
        /// @brief 一个栈上的值, 必定要先分配再使用, 为创建Frame提供了便利
        alloca, // local分配栈空间, 无操作数
        spill,  // spill到temp上, 操作数为溢出的变量(use集)
        fetch, // 从栈上取, 操作数同上(def集)
        push_args, // 参数压栈, 操作数为虚拟寄存器(use集), 注意顺序, IR->MIR时生成
        fetch_args, // callee向栈上固定偏移的位置取值(args), 并放置到操作数(def) 
    Addition_Oper_End,

};
std::map<OperCode, std::string> OperCodeMap = {
    {OperCode::ADD, "add"}, {OperCode::SUB, "sub"},
    {OperCode::ADDS, "adds"},{OperCode::SUBS, "subs"},{OperCode::RSBS, "rsbs"},{OperCode::MUL, "mul"},{OperCode::MLA, "mla"},
    {OperCode::MULS, "muls"}, {OperCode::DIVS, "divs"},
    {OperCode::DIV, "div"},{OperCode::SREM, "srem"},{OperCode::ORR, "orr"},{OperCode::AND, "and"},{OperCode::ASR, "asr"},
    {OperCode::ASRS, "asrs"},{OperCode::LSL, "lsl"},{OperCode::LSR, "lsr"},{OperCode::ROR, "ror"},{OperCode::RRX, "rrx"},
    {OperCode::EOR, "eor"},{OperCode::VADD_F32, "vadd_f32"},{OperCode::VADD_S32, "vadd_s32"},{OperCode::VSUB_F32, "vsub_f32"},
    {OperCode::VSUB_S32, "vsub_s32"},{OperCode::VMUL_S32, "vmul_s32"},{OperCode::VMUL_F32, "vmul_f32"},{OperCode::VDIV_F32, "vdif_f32"},
    {OperCode::VDIV_S32, "vdif_s32"},{OperCode::BEQ, "beq"},{OperCode::BNQ, "bnq"},{OperCode::BGT, "bgt"},{OperCode::BLT, "blt"},{OperCode::BGE, "bge"},{OperCode::BLE, "ble"},{OperCode::BX, "bx"},{OperCode::BL, "bl"},{OperCode::CMN, "cmn"},{OperCode::CMP, "cmp"},
    {OperCode::VCMP_F32, "vcmp_f32"},{OperCode::MOV, "mov"},{OperCode::VMOV, "vmov"},{OperCode::VMOV_F32, "vmov_f32"},
    {OperCode::VMOV_S32, "vmov_s32"},{OperCode::MOVW, "movw"},{OperCode::MOVT, "movt"},{OperCode::MVN, "mvn"},
    {OperCode::VCVT_F32_S32, "vcvt_f32_s32"},{OperCode::VCVT_S32_F32, "vcvt_s32_f32"},{OperCode::VSTR_32, "vstr_32"},{OperCode::VLDR_32, "vldr_32"},
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
bool isImmCanBeEncodedInText(int imme);
bool isImmCanBeEncodedInText(float imme);
bool isVLoadStoreOffsetLegal(int offset);
};
#endif