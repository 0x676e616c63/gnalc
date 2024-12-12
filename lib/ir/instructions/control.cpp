#include "../../../include/ir/instructions/control.hpp"

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
        addOperands(ret_val);
    }

    bool RETInst::isVoid() const
    {
        return ret_type == IRTYPE::VOID;
    }

    Value* RETInst::getRetVal() const
    {
        return getOperands().begin()->getValue();
    }

    BRInst::BRInst(BasicBlock* _dest)
        : Instruction(OP::BR, "__br", IRTYPE::UNDEFINED), conditional(false)
    {
        addOperands(_dest);
    }

    BRInst::BRInst(Value* cond, BasicBlock* _true_dest, BasicBlock* _false_dest)
        : Instruction(OP::BR, "__br", IRTYPE::UNDEFINED), conditional(false)
    {
        addOperands(cond, _true_dest, _false_dest);
    }

    bool BRInst::isConditional() const
    {
        return conditional;
    }

    Value* BRInst::getCond() const
    {
        assert(conditional);
        return operands.begin()->getValue();
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
        addOperands(func);
        for (auto valptr : args)
            operands.emplace_back(valptr, this);
        // Or something like this
        // std::transform(args.begin(), args.end(), std::back_inserter(operands), [this](auto&& vptr){return Use{vptr, this};});
    }

    CALLInst::CALLInst(NameRef name, IRTYPE ty, Function* func, const std::list<Value*>& args)
        : Instruction(OP::CALL, name, ty)
    {
        assert(func->getType() == ty);
        addOperands(func);
        for (auto valptr : args)
            operands.emplace_back(valptr, this);
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
}
