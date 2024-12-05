/**
 * @brief Terminator instructions and call
 * @brief ret. br, call
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_CONTROL_HPP
#define GNALC_IR_INSTRUCTIONS_CONTROL_HPP

#include "../instruction.hpp"
#include "../function.hpp"
#include <vector>

namespace IR {

// ret <type> <value>       ; Return a value from a non-void function
// ret void                 ; Return from void function
class RETInst : public Instruction {
    private:
    IRTYPE ret_type;
public:
    RETInst(); // for void
    RETInst(Value* ret_val);

    bool isVoid() const;
    Value* getRetVal() const;
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
    explicit BRInst(BasicBlock* _dest);
    BRInst(Value* cond, BasicBlock* _true_dest, BasicBlock* _false_dest);

    bool isConditional() const;
    Value* getCond() const;
    BasicBlock* getDest() const;
    BasicBlock* getTrueDest() const;
    BasicBlock* getFalseDest() const;

    // void setBBParams(std::initializer_list<Value*> _bbparams);
    // void setBBparams(std::vector<Value*>& _bbparams);
    // std::vector<Value*>& getBBParams();
};

//<result> = [tail | musttail | notail ] call [fast-math flags] [cconv] [ret attrs] [addrspace(<num>)]
//            <ty>|<fnty> <fnptrval>(<function args>) [fn attrs] [ operand bundles ]
// 
// %retval = call i32 @test(i32 %argc)
class CALLInst : public Instruction {
public:
    // func, args储存到operands中
    CALLInst(Function* func, const std::list<Value*>& args); // for void
    CALLInst(NameRef name, IRTYPE ty, Function* func, const std::list<Value*>& args);

    bool isVoid() const;
    // bool isNoName();
    std::string getFuncName() const;
    Function* getFunc() const; // Value*转换为Function*
    std::vector<Value*> getArgs() const;
};

}

#endif