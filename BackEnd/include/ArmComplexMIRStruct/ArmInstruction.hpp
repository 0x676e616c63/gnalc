#pragma once
#include <list>
#include <vector>
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/tools/ArmTools.hpp"

class ArmStruct::Instruction{
    public:
        Instruction();
        ~Instruction()=default;
        virtual void toString();
        std::vector<ArmStruct::Operand*> OperandList;
        std::list<ArmStruct::Operand*> LiveIn;
};
namespace ArmStruct{
    class BinaryInst: public ArmStruct::Instruction{
        public:
            BinaryInst();
            ~BinaryInst()=default;
            void toString();
            enum ArmBinaryType{
            ADD,
            SUB,
            CMP,
            CMN,
            TEQ,
            TST,
            RSB, // 反向减法
            MUL,
            SDIV,
            SREM,
            ORR,
            AND,
            ASR, // 算数右移
            LSL, // 逻辑左移(就是左移)
            LSR, // 逻辑右移
            ROR, // 循环右移
            RRX,  // 扩展循环右移
            EOR,
            VADD, // V = vector
            VSUB,
            VMUL,
            VDIV,
            };
        private:
            ArmBinaryType Operator;
    };
    class UnaryInst: public ArmStruct::Instruction{
        public:
            UnaryInst();
            ~UnaryInst()=default;
            void toString();
            enum ArmUnaryType{
                NEG,
            };
        private:
            ArmUnaryType Operator;
    };
    class MemInst: public ArmStruct::Instruction{
        /// @todo load, store, getelementptr
        public:
            MemInst();
            ~MemInst()=default;
            virtual void toString();
            enum ArmMemType{
                STR,
                LDR,
            };
        private:
            ArmMemType Operator;
    };
    class BranchInst: public ArmStruct::Instruction{
        /// @todo icmp/fcmp <> + branch
        public:
            BranchInst();
            ~BranchInst()=default;
            void toString();
            enum ArmBranchType{
                B,
                BEQ,
                BNE,
                BGT,
                BLT,
                BGE,
                BLE,
                BL, 
                BX,
                BLX, // 可能用不到
            };
        private:
            /// @todo 在遍历Instruction时, 留意icmp指令, 将结果传至这里
            ArmStruct::VirtualRegOperand Cond;
            ArmStruct::GlobalOperand Label;
    };
    class RetInst: public ArmStruct::Instruction{};
    class CallInst: public ArmStruct::Instruction{};
    // class VectorInst: public ArmStruct::Instruction{};
};