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
    std::shared_ptr<BType> ret_type; // 此处直接使用BType
public:
    RETInst(); // for void
    RETInst(std::shared_ptr<Value> ret_val);

    bool isVoid() const;
    std::shared_ptr<Value> getRetVal() const;
    IRBTYPE getRetBType() const;
    std::shared_ptr<BType> getRetType() const;

    void accept(IRVisitor& visitor) override;
};

// br i1 <cond>, label <iftrue>, label <iffalse>
// br label <dest>          ; Unconditional branch
// br i1 <cond> label %if.then1(%a, %b), label %if.end1(%c, %d)
class BRInst : public Instruction {
public:
    // arg的user是BBArgList
    class BBArgList : public User {
        std::shared_ptr<BasicBlock> block; // operands只存args
    public:
        BBArgList() = delete;
        BBArgList(const std::shared_ptr<BasicBlock> &block, const std::vector<std::shared_ptr<Value>>& args);

        std::shared_ptr<BRInst> getBr() const;
        std::vector<std::shared_ptr<Value>> _getArgs() const;
        void accept(IRVisitor& visitor) override { Err::not_implemented("BBArgList::visit"); }
    };
private:
    bool conditional;
    bool set_args = false;
public:
    explicit BRInst(std::shared_ptr<BasicBlock> _dest);
    BRInst(std::shared_ptr<Value> cond, std::shared_ptr<BasicBlock> _true_dest, std::shared_ptr<BasicBlock> _false_dest);

    bool isConditional() const;
    std::shared_ptr<Value> getCond() const;
    std::shared_ptr<BasicBlock> getDest() const;
    std::shared_ptr<BasicBlock> getTrueDest() const;
    std::shared_ptr<BasicBlock> getFalseDest() const;

    void setBBArgs(const std::vector<std::shared_ptr<Value>>& args); // just for uncond
    void setBBArgs(const std::vector<std::shared_ptr<Value>>& t_args, const std::vector<std::shared_ptr<Value>>& f_args); // just for cond
    std::vector<std::shared_ptr<Value>> getBBArgs() const;
    std::vector<std::shared_ptr<Value>> getTrueBBArgs() const;
    std::vector<std::shared_ptr<Value>> getFalseBBArgs() const;

    void accept(IRVisitor& visitor) override;
};

//<result> = [tail | musttail | notail ] call [fast-math flags] [cconv] [ret attrs] [addrspace(<num>)]
//            <ty>|<fnty> <fnptrval>(<function args>) [fn attrs] [ operand bundles ]
// 
// %retval = call i32 @test(i32 %argc)
class CALLInst : public Instruction {
private:
    // std::shared_ptr<WeakUse> func;
public:
    // func储存到func, args储存到operands中
    CALLInst(std::shared_ptr<FunctionDecl> func, const std::vector<std::shared_ptr<Value>>& args); // for void
    CALLInst(NameRef name, std::shared_ptr<FunctionDecl> func, const std::vector<std::shared_ptr<Value>>& args);

    bool isVoid() const;
    // bool isNoName();
    std::string getFuncName() const;
    std::shared_ptr<FunctionDecl> getFunc() const; // WeakValue转换为SharedFunction
    std::vector<std::shared_ptr<Value>> getArgs() const;

    void accept(IRVisitor& visitor) override;
};

}

#endif