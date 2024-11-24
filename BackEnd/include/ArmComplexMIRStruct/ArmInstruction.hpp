#ifndef ARM_ArmStruct
#define ARM_ArmStruct
#pragma once
#include <list>
#include <vector>
#include <string>
#include "../../include/tools/ArmTools.hpp"
#include "./ArmOperand.hpp"
#include "../../Arm.hpp"

/// @note MIR 即 instruction
/// @note OpCode中不一定所有都会用到，尤其是只有有符号数时
/// @note asm codegen采用宏展开方法, 对每个inst(mir)调用一次lowering实现1对1的map
/// @note 但是对于特殊的inst, 需要生成多条指令

class ArmStruct::Instruction{
    public:
        Instruction();
        ~Instruction()=default;
        enum OpCode{
            // simple binary
            ADDS, SUBS, RSBS, MUL, MLA, DIV, SREM, ORR, AND, ASR, ASRS, LSL, LSR, ROR, RRX, EOR,
            // 
            NEG,
            // branch
            BRANCH_BEGIN,
            BEQ, BNQ, BGT, BLT, BGE, BLE,
            // function related
            BX, BL,
            BRANCH_END,
            // compare
            CMN, CMP, VCMP_F32, // 直接用vcmp比较向量还是太少见了
            // mov instruction, 感觉movs没有必要
            MOV, VMOV, VMOV_F32, VMOV_S32, MOVW, MOVT, MVN,
            // SIMD inst
            VADD_F32, VADD_S32,
            VSUB_F32, VSUB_S32,
            VMUL_S32, VMUL_F32,
            VDIV_F32, VDIV_S32,
            // type convertion
            VCVT_F32_S32, VCVT_S32_F32,
            // SIMD instruction
            VSTR_32, VLDR_32,
            // store load
            LDR, STR,
            // single long multiple
            SMULL,
            // syscall + Imm
            SWI,
            // push
            PUSH,

        }opcode;
        /// @brief Def集一般只有一个元素, 但是不排除SIMD指令, 所以先放个表
        /// @brief Use集可能一个或是两个
        std::vector<Operand*> DefOperandList;
        std::vector<Operand*> UseOperandList;
        /// @brief 用于反向查找
        BB &BasicBlock;
        virtual std::string* toString();
};
#endif