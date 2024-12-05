/**
 * @brief Terminator instructions and call
 * @brief ret. br, call
 */

#pragma once
#ifndef IR_INSTRUCTIONS_CONTROL_HPP
#define IR_INSTRUCTIONS_CONTROL_HPP

#include "../instruction.hpp"
#include "../function.hpp"
#include <vector>

namespace IR {

// ret <type> <value>       ; Return a value from a non-void function
// ret void                 ; Return from void function
class RETInst : public Instruction {
public:
    RETInst(); // for void
    RETInst(IRTYPE ty, Value* ret_val);

    bool isVoid();
    Value* getRetVal();
};


// br i1 <cond>, label <iftrue>, label <iffalse>
// br label <dest>          ; Unconditional branch
class BRInst : public Instruction {
private:
    // 全部存到oprands中
    // BasicBlock* true_dest; // or dest
    // BasicBlock* false_dest;
    bool conditional;

    // 目前先不搞
    // std::vector<Value*> bbparams; // 基本块参数

public:
    BRInst(BasicBlock* _dest);
    BRInst(Value* cond, BasicBlock* _true_dest, BasicBlock* _false_dest);

    bool isConditional();
    Value* getCond();
    BasicBlock* getDest();
    BasicBlock* getTrueDest();
    BasicBlock* getFalseDest();

    // void setBBParams(std::initializer_list<Value*> _bbparams);
    // void setBBparams(std::vector<Value*>& _bbparams);
    // std::vector<Value*>& getBBParams();
};

//<result> = [tail | musttail | notail ] call [fast-math flags] [cconv] [ret attrs] [addrspace(<num>)]
//            <ty>|<fnty> <fnptrval>(<function args>) [fn attrs] [ operand bundles ]
// 
// %retval = call i32 @test(i32 %argc)
class CALLInst : public Instruction {
    bool isvoid = false;
public:
    // func, args储存到operands中
    CALLInst(IRTYPE ty, Function* func, std::initializer_list<Value*> args); // for void (或不保存返回值？不知道LLVM IR支持不支持)
    CALLInst(NameRef name, IRTYPE ty, Function* func, std::initializer_list<Value*> args);

    bool isVoid();
    // bool isNoName();
    std::string getFuncName();
    Function* getFunc(); // Value*转换为Function*
    std::vector<Value*>& getArgs();
};

}

#endif