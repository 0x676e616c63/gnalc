/**
 * @brief Terminator instructions and call
 * @brief ret. br, call
 */

#pragma once
#ifndef GNALC_IR_INSTRUCTIONS_CONTROL_HPP
#define GNALC_IR_INSTRUCTIONS_CONTROL_HPP

#include "ir/function.hpp"
#include "ir/instruction.hpp"
#include "ir/type_alias.hpp"
#include <vector>

namespace IR {

// ret <type> <value>       ; Return a value from a non-void function
// ret void                 ; Return from void function
class RETInst : public Instruction {
private:
    pBType ret_type; // 此处直接使用BType
public:
    RETInst(); // for void
    RETInst(pVal ret_val);

    bool isVoid() const;
    pVal getRetVal() const;
    IRBTYPE getRetBType() const;
    pBType getRetType() const;

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override {
        if (isVoid())
            return std::make_shared<RETInst>();
        return std::make_shared<RETInst>(getRetVal());
    }
};

// br i1 <cond>, label <iftrue>, label <iffalse>
// br label <dest>          ; Unconditional branch
// br i1 <cond> label %if.then1(%a, %b), label %if.end1(%c, %d)
//
// BRInst operands:
// Conditional
// cond | true_dest | false_dest | true_args | false_args
//  0         1            2           3           4
// Unconditional
// dest | dest_args
//   0        1
class BRInst : public Instruction {
public:
    // arg的user是BBArgList
    class BBArgList : public User {
        pBlock block; // operands只存args
    public:
        BBArgList() = delete;
        BBArgList(const pBlock &block, const std::vector<pVal> &args);

        pBr getBr() const;
        std::vector<pVal> _getArgs() const;
        void accept(IRVisitor &visitor) override { Err::not_implemented("BBArgList::visit"); }
    };

private:
    bool conditional;
    bool set_args = false;

public:
    // Make a BRInst
    // Make sure to linkBB to update CFG.
    explicit BRInst(const pBlock &_dest);
    BRInst(const pVal &cond, const pBlock &_true_dest, const pBlock &_false_dest);

    // Make it unconditional.
    // Make sure to unlinkBB to update CFG.
    void dropFalseDest();
    void dropTrueDest();
    void dropOneDest(const pBlock& bb);

    bool hasDest(const pBlock& bb);

    bool isConditional() const;
    pVal getCond() const;
    pBlock getDest() const;
    pBlock getTrueDest() const;
    pBlock getFalseDest() const;

    void setBBArgs(const std::vector<pVal> &args); // just for uncond
    void setBBArgs(const std::vector<pVal> &t_args,
                   const std::vector<pVal> &f_args); // just for cond
    std::vector<pVal> getBBArgs() const;
    std::vector<pVal> getTrueBBArgs() const;
    std::vector<pVal> getFalseBBArgs() const;

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override {
        pBr ret;
        if (isConditional()) {
            ret = std::make_shared<BRInst>(getCond(), getTrueDest(), getFalseDest());
            if (set_args)
                ret->setBBArgs(getTrueBBArgs(), getFalseBBArgs());
        } else {
            ret = std::make_shared<BRInst>(getDest());
            if (set_args)
                ret->setBBArgs(getBBArgs());
        }
        return ret;
    }
};

//<result> = [tail | musttail | notail ] call [fast-math flags] [cconv] [ret
// attrs] [addrspace(<num>)]
//            <ty>|<fnty> <fnptrval>(<function args>) [fn attrs] [ operand
//            bundles ]
//
// %retval = call i32 @test(i32 %argc)
class CALLInst : public Instruction {
private:
    // std::shared_ptr<WeakUse> func;
    bool is_tail_call = false;

public:
    // func储存到func, args储存到operands中
    CALLInst(const pFuncDecl &func,
             const std::vector<pVal> &args); // for void
    CALLInst(NameRef name, const pFuncDecl &func, const std::vector<pVal> &args);

    bool isVoid() const;
    // bool isNoName();
    std::string getFuncName() const;
    pFuncDecl getFunc() const; // WeakValue转换为SharedFunction
    std::vector<pVal> getArgs() const;

    void accept(IRVisitor &visitor) override;

    void setTailCall(bool is_tail_call_);
    bool isTailCall() const;

private:
    pVal cloneImpl() const override {
        if (isVoid()) {
            auto ret = std::make_shared<CALLInst>(getFunc(), getArgs());
            ret->setTailCall(is_tail_call);
            return ret;
        }
        auto ret = std::make_shared<CALLInst>(getFuncName(), getFunc(), getArgs());
        ret->setTailCall(is_tail_call);
        return ret;
    }
};

class SELECTInst: public Instruction {
public:
    SELECTInst(NameRef name, const pVal &cond, const pVal &true_val, const pVal &false_val);

    pVal getCond() const;
    pVal getTrueVal() const;
    pVal getFalseVal() const;

    void accept(IRVisitor &visitor) override;

private:
    pVal cloneImpl() const override {
        return std::make_shared<SELECTInst>(getName(), getCond(), getTrueVal(), getFalseVal());
    }
};
} // namespace IR

#endif