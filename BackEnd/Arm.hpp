#ifndef ARM
#define ARM
#pragma once
#include <iostream>
#include <vector>
#include <map>
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
    bool isImmCanBeEncodedInText(int Imm);
    bool isImmCanBeEncodedInText(float Imm);
    bool isVLoadStoreOffsetLegal(int offset);

    std::string DecToHex(int);
    std::string HexToDec(std::string);  // 理论上这个东西不要也行
    std::string LiteralToIEEE(float);

    std::pair<std::string, std::string> BreakInBit(unsigned long long);
    std::pair<std::string, std::string> BreakInBit(float);

    class RegisterAlloc;    // 寄存器分配

    ///@warning ISO C++ forbids forward references to 'enum' types
    // enum CoreRegisterName;
    // std::map<CoreRegisterName, std::string> CoreRegisterMap;
    // enum ExtensionRegisterName;
    // std::map<ExtensionRegisterName, std::string> ExtensionRegisterMap;
    // enum OpCode;
    // std::map<OpCode, std::string> OpCodeMap;

    // std::map<IR::OP, OperCode>Mid2BackOpC;
    
    /// @note 模式匹配函数

    struct BinaryMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

    struct UnaryMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

    struct BranchMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

    struct AllocaMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

    struct LoadMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

    struct StoreMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };
    
    struct GepMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };
    
    struct FPTOSIMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

    struct SITOFPMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

    // struct ICMP, FCMP ; in BranchMatch

    struct CallMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

    struct PhiMatch{
        void operator()(InstArgs, ArmStruct::BB&) const;
    };

};

namespace ArmOpt{
    class SIMDInstructions; // Noen指令集优化
    class PeepHole;         // 窥孔优化
};

#endif