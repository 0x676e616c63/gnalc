#include "../../../include/ir/instructions/control.hpp"
#include "../../../include/ir/visitor.hpp"

#include <algorithm>
#include <assert.h>

namespace IR
{
    RETInst::RETInst()
        : Instruction(OP::RET, "__ret", IRTYPE::UNDEFINED),
            ret_type(IRTYPE::VOID) {}

    RETInst::RETInst(Value* ret_val)
        : Instruction(OP::RET, "__ret", IRTYPE::UNDEFINED),
            ret_type(ret_val->getType())
    {
        addOperand(ret_val);
    }

    bool RETInst::isVoid() const
    {
        return ret_type == IRTYPE::VOID;
    }

    Value* RETInst::getRetVal() const
    {
        return getOperands().begin()->getValue();
    }

    IRTYPE RETInst::getRetType() const
    {
        return ret_type;
    }

    BRInst::BRInst(BasicBlock* _dest)
        : Instruction(OP::BR, "__br", IRTYPE::UNDEFINED), conditional(false)
    {
        addOperand(_dest);
    }

    BRInst::BRInst(Value* cond, BasicBlock* _true_dest, BasicBlock* _false_dest)
        : Instruction(OP::BR, "__br", IRTYPE::UNDEFINED), conditional(true)
    {
        addOperand(cond);
        addOperand(_true_dest);
        addOperand(_false_dest);
    }

    bool BRInst::isConditional() const
    {
        return conditional;
    }

    // BasicBlock* BRInst::getDest() const
    // {
    //     assert(!conditional);
    //     return dynamic_cast<BasicBlock*>(operands.begin()->getValue());
    // }

    Value* BRInst::getCond() const
    {
        assert(conditional);
        return getOperands().begin()->getValue();
    }
    BasicBlock* BRInst::getDest() const {
        assert(!conditional);
        return dynamic_cast<BasicBlock *>(getOperands().begin()->getValue());
    }
    BasicBlock* BRInst::getTrueDest() const
    {
        assert(conditional);
        return dynamic_cast<BasicBlock*>(std::next(getOperands().begin())->getValue());
    }

    BasicBlock* BRInst::getFalseDest() const
    {
        assert(conditional);
        return dynamic_cast<BasicBlock*>(std::next(std::next(getOperands().begin()))->getValue());
    }

    CALLInst::CALLInst(Function* func, const std::list<Value*>& args)
        : Instruction(OP::CALL, "__call", IRTYPE::VOID)
    {
        addOperand(func);
        for (auto valptr : args)
            operands.emplace_back(valptr, this);
        // Or something like this
        // std::transform(args.begin(), args.end(), std::back_inserter(operands), [this](auto&& vptr){return Use{vptr, this};});
    }

    CALLInst::CALLInst(NameRef name, IRTYPE ty, Function* func, const std::list<Value*>& args)
        : Instruction(OP::CALL, name, ty)
    {
        assert(func->getType() == ty);
        addOperand(func);
        for (auto valptr : args)
            addOperand(valptr);
    }

    bool CALLInst::isVoid() const
    {
        return ty == IRTYPE::VOID;
    }

    std::string CALLInst::getFuncName() const
    {
        return getOperands().begin()->getValue()->getName();
    }

    Function* CALLInst::getFunc() const
    {
        return dynamic_cast<Function*>(getOperands().begin()->getValue());
    }

    std::vector<Value*> CALLInst::getArgs() const
    {
        std::vector<Value*> ret;
        for (auto it = std::next(getOperands().begin()); it != getOperands().end(); ++it)
            ret.emplace_back(it->getValue());
        return ret;
    }

    void RETInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void BRInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void CALLInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}
