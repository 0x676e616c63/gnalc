#ifndef ARM
#define ARM
#pragma once
#include <iostream>
#include <vector>
#include <map>
#include "../include/ir/base.hpp"
#include "../include/ir/instructions/memory.hpp"
#include "../include/ir/instructions/binary.hpp"
#include "../include/ir/instruction.hpp"

namespace ArmStruct{
    class Module;       // 修改自中端传来的Module
    
    class Function;     // 各个Func的信息，包括指令链，开栈，需要维护冲突图
    class SubFrame;
    class FrameObj;
    class ArrayObj;

    class BB;
    class Terminator; // dddd

    class Instruction;   // 指令选择
    class MemInstruction; // load / store

    class Operand;      // 操作数，较长立即量的插入
    class Imm;
    class MMptr;
    class Global;       // 全局变量

    class GlobalIniter; // 相较于中端更细节的Initer

    ///@note MIR 子类
    class CallInst;
    class GetElementPtrInst;
    class PhiInst;
    class BrInst;
};

/// @brief 常量池, 在ArmStruct::Module内释放 
extern std::vector<ArmStruct::Operand*> RegisterPool;
extern std::vector<ArmStruct::Imm*> ConstPool;
extern std::vector<ArmStruct::Operand*> FPURegisterPool;

typedef std::initializer_list<std::reference_wrapper<IR::Instruction>> InstArgs;


typedef std::initializer_list<std::reference_wrapper<IR::Instruction>> InstArgs;


namespace ArmTools{
    class MyUnOrderedSet;

    class Edge;
    struct HashEdge;
    struct EdgeEdgeEqual;

    /// @brief hash映射 + 比较方法
    struct HashOperandReferWrap;
    struct HashOperandReferWrapEqual;
    struct HashInstReferWrap;
    struct HashInstReferWrapEqual;

    class LabelTable; // 用于查找标签

    /// @note arm指令合法化的一部分

    bool isVLoadStoreOffsetLegal(int offset);

    class RegisterAlloc;    // 寄存器分配工具

    enum OperCode{
        NEG, VNEG_F32,
        Unary_End,

        Binary_Begin,   // 比较广义的Binary?
            ADD, ADDS, SUB, SUBS, RSBS, MUL, MULS, MLA, DIV, SDIV, ORR, AND, ASR, ASRS, LSL, LSLS,LSR, ROR, RRX, EOR,
            // SIMD
            VADD_F32, VADD_S32,
            VSUB_F32, VSUB_S32,
            VMUL_S32, VMUL_F32,
            VDIV_F32, VDIV_S32,
        Binary_End,
                
        Branch_Begin,
            BEQ, BNQ, BGT, BLT, BGE, BLE,
            BX, BL, B, BCOND, // branch泛型
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
            // push, pop
            PUSH, POP,
        /// @brief 并非Arm指令
        Addition_Oper_Begin,
            /// @brief 一个栈上的值, 必定要先分配再使用, 为创建Frame提供了便利
            alloca, // local分配栈空间, 操作数为分配栈空间的大小(一个Imm Operand)
            free, // free栈上空间, 由中端插入
            spill,  // spill到temp上, 操作数为溢出的变量(use集)
            fetch, // 从栈上取, 操作数同上(def集)
            push_args, // 参数压栈, 操作数为虚拟寄存器(use集), 注意顺序, IR->MIR时生成
            fetch_args, // callee向栈上固定偏移的位置取值(args), 并放置到操作数(def) 
        Addition_Oper_End,
    };
    
    struct MovtwMatch{
        ArmStruct::BB& BasicBlock;
        void operator()(std::string, unsigned long long &temp_VirReg); // GlobalVal
        void operator()(float, unsigned long long &temp_virReg) ;
        void operator()(int, unsigned long long &temo_virReg) ;  
        bool isImmCanBeEncodedInText(unsigned long long imme);
        bool isImmCanBeEncodedInText(float imme);
    };

    struct RetMatch{
        ArmStruct::BB& BasicBlock;
        MovtwMatch immeMatch;
        void operator()(InstArgs);
    };

    struct BinaryMatch{
        ArmStruct::BB& BasicBlock;

        MovtwMatch immeMatch;

        void operator()(InstArgs);
        
        void IntOrdinaryMatch(IR::BinaryInst&, OperCode);
        
        void SMulMatch(IR::BinaryInst&);
        void SDivMatch(IR::BinaryInst&);

        void FloatOrdinaryMatch(IR::BinaryInst&, OperCode);
        
        void RegMatch(IR::BinaryInst&);
        void FRegMatch(IR::BinaryInst&);

        void immeIntercept(float, float, OperCode);
        void immeIntercept(int, int, OperCode);
    };

    struct UnaryMatch{
        ArmStruct::BB& BasicBlock;
        MovtwMatch immeMatch;
        void operator()(InstArgs);
    };

    struct BranchMatch{
        ArmStruct::BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    struct AllocaMatch{
        ArmStruct::BB& BasicBlock;
        /// 主要工作是添加FrameObj
        void operator()(InstArgs) ;
        
        void staticMemory(IR::ALLOCAInst&);
        void dynamicMemory(IR::ALLOCAInst&);
    };

    struct LoadMatch{
        ArmStruct::BB& BasicBlock;
        MovtwMatch GlobalMatch;
        void operator()(InstArgs);
    };

    struct StoreMatch{
        ArmStruct::BB& BasicBlock;
        MovtwMatch GlobalMatch;
        void operator()(InstArgs);
    };
    
    struct GepMatch{
        ArmStruct::BB& BasicBlock;
        MovtwMatch GlobalMatch;
        void operator()(InstArgs);
        void StaticBaseConstOffset(ArmStruct::MMptr*, IR::GEPInst&);
        void StaticBaseVarOffset(ArmStruct::MMptr*, IR::GEPInst&);
        void DynamicBaseConstOffset(ArmStruct::MMptr*, IR::GEPInst&);
        void DynamicBaseVarOffset(ArmStruct::MMptr*, IR::GEPInst&);

        unsigned int getPreElemSize(std::shared_ptr<IR::Type> ElemType);
    };
    
    struct FPTOSIMatch{
        ArmStruct::BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    struct SITOFPMatch{
        ArmStruct::BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    // struct ICMP, FCMP ; in BranchMatch

    struct CallMatch{
        ArmStruct::BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    struct PhiMatch{
        ArmStruct::BB& BasicBlock;
        void operator()(InstArgs) const;
    };

};

namespace ArmOpt{
    class SIMDInstructions; // Noen指令集优化
    class PeepHole;         // 窥孔优化
};

#endif