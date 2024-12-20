#ifndef ARM
#define ARM
#pragma once
#include <iostream>
#include <vector>
#include <map>
#include "../../../include/ir/base.hpp"
#include "../../../include/ir/instructions/memory.hpp"
#include "../../../include/ir/instructions/binary.hpp"
#include "../../../include/ir/instruction.hpp"

namespace ArmStruct{
    class Module;       // 修改自中端传来的Module
    
    class Function;     // 各个Func的信息，包括指令链，开栈，需要维护冲突图
    class SubFrame;
    class FrameObj;
    
    class BB;
    class Terminator; // dddd
    std::map<std::string, BB&> BBLabelMap;

    class Instruction;   // 指令选择
    class MemInstruction; // load / store

    class Operand;      // 操作数，较长立即量的插入
    class Imm;
    class MMptr;
    class Global;       // 全局变量
    class Bss;

    ///@note MIR 子类
    class CallInst;
    class GetElementPtrInst;
    class PhiInst;
    class BrInst;
};

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
    struct HashFrameObj;
    struct HashFrameObjEqual;

    class LabelTable; // 用于查找标签

    /// @note arm指令合法化的一部分

    bool isVLoadStoreOffsetLegal(int offset);

    class RegisterAlloc;    // 寄存器分配

    ///@warning ISO C++ forbids forward references to 'enum' types
    // enum CoreRegisterName;
    // std::map<CoreRegisterName, std::string> CoreRegisterMap;
    // enum ExtensionRegisterName;
    // std::map<ExtensionRegisterName, std::string> ExtensionRegisterMap;
    // enum OpCode;
    // std::map<OpCode, std::string> OpCodeMap;

    // std::map<IR::OP, OperCode>Mid2BackOpC;
    
    /// @note 模式匹配仿函数

    struct MovtwMatch{
        BB& BasicBlock;
        void operator()(float, unsigned long long &temp_virReg) ;
        void operator()(int, unsigned long long &temo_virReg) ;  
        bool isImmCanBeEncodedInText(unsigned long long imme);
        bool isImmCanBeEncodedInText(float imme);
    };

    struct BinaryMatch{
        BB& BlockBlock;

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
        BB& BasicBlock;
        void operator()(InstArgs);
    };

    struct BranchMatch{
        BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    struct AllocaMatch{
        BB& BasicBlock;
        /// 主要工作是添加FrameObj
        void operator()(InstArgs) ;
        
        void staticMemory(IR::ALLOCAInst&);
        void dynamicMemory(IR::ALLOCAInst&);
    };

    struct LoadMatch{
        BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    struct StoreMatch{
        BB& BasicBlock;
        void operator()(InstArgs) const;
    };
    
    struct GepMatch{
        BB& BasicBlock;
        void operator()(InstArgs);
    };
    
    struct FPTOSIMatch{
        BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    struct SITOFPMatch{
        BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    // struct ICMP, FCMP ; in BranchMatch

    struct CallMatch{
        BB& BasicBlock;
        void operator()(InstArgs) const;
    };

    struct PhiMatch{
        BB& BasicBlock;
        void operator()(InstArgs) const;
    };


    // std::map<IR::OP, OperCode>Mid2BackOpC;
    
    /// @note 模式匹配函数
};

namespace ArmOpt{
    class SIMDInstructions; // Noen指令集优化
    class PeepHole;         // 窥孔优化
};

#endif