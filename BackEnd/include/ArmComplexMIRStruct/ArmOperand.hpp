#pragma once
#include <list>
#include <string>
#include <type_traits>
#include "../../Arm.hpp"
#include "../tools/ArmTools.hpp"

enum OperandType{
    INT, FLOAT, VOID
};
class ArmStruct::Operand{
    public:
        Operand(OperandType, std::string*);
        ~Operand()=default;
        virtual void toString();
        void operator==(ArmStruct::Operand);

        std::list<Operand*> neighbor;
        unsigned int neighborNum=0;
        CoreRegisterName rx=vir;
        // ExtensionRegisterName sx=Exvir;
        OperandType ValType;
        std::string *Indentifier = NULL; // 在Imm中, 如果Imm无法直接在.text编码, 那么这个string会是Imm的Label
                                 // 反之, 如果可以直接编码, 为NULL
                                // 或者是作为虚拟寄存器的ID
};
namespace ArmStruct{
    template<typename T, typename=std::enable_if_t<std::is_integral_v<T> || std::is_floating_point_v<T>>>
    class ImmOperand: public Operand{
        /// @todo 在encoding时, 尤其是float, 需要编成IEE754
        public:
            ImmOperand(int);
            ImmOperand(float);
            ~ImmOperand()=default;
            virtual void toString();
            /// @todo 当不能直接编码时, 转化为一个GlobalOperand
        private:
            T value;
            std::string encoding;
    };
    class GlobalOperand: public Operand{
        /// @note 使用label, 包括call指令, 跳转, 使用全局变量
        public:
            GlobalOperand(int);
            GlobalOperand(float);
            ~GlobalOperand()=default;
            /// @todo .text之外进行插入, 构建一个ArmStruct::Global
            void toString();
    };
    // class VirtualRegOperand: public Operand{
    //     public:
    //         VirtualRegOperand();
    //         ~VirtualRegOperand()=default;
    //         void toString();
    // };
    class MemReferenceOperand: public Operand{
        /// @note eg: ptr %0 一般出现在 load/store 中
        /// @todo 虚拟寄存器需要转化为lr或者sp的基址寻址
        public:
            MemReferenceOperand();
            ~MemReferenceOperand()=default;
            void toString();
        private:
            CoreRegisterName baseReg;
            int offset;
    };
    class GlobalReferenceOperand: public Operand{
        /// @note eg: ptr @var_global, 同上
        /// @todo 在toString()方法中, 使用全局变量中的label替换
        public:
            GlobalReferenceOperand();
            ~GlobalReferenceOperand()=default;
            void toString();
    };
    /// @brief 对于函数参数, 不单独设置类, 顺序和压栈由Instruction控制
    // class CallParamOperand: public Operand{};
};