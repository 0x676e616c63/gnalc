#include "../../../include/ir/instructions/control.hpp"
#include "../../../include/ir/visitor.hpp"
#include "../../../include/utils/exception.hpp"

#include <algorithm>

namespace IR
{
    RETInst::RETInst()
        : Instruction(OP::RET, "__ret", makeBType(IRBTYPE::UNDEFINED)),
            ret_type(makeBType(IRBTYPE::VOID)) {}

    RETInst::RETInst(std::shared_ptr<Value> ret_val)
        : Instruction(OP::RET, "__ret", makeBType(IRBTYPE::UNDEFINED)),
            ret_type(toBType(ret_val->getType()))
    {
        addOperand(ret_val);
    }

    bool RETInst::isVoid() const
    {
        return toBType(ret_type)->getInner() == IRBTYPE::VOID;
    }

    std::shared_ptr<Value> RETInst::getRetVal() const
    {
        return (*(getOperands().begin()))->getValue();
    }

    IRBTYPE RETInst::getRetType() const
    {
        return toBType(ret_type)->getInner();
    }

    std::shared_ptr<BType> RETInst::getRetTypePtr() const
    {
        return ret_type;
    }

    BRInst::BRInst(std::shared_ptr<BasicBlock> _dest)
        : Instruction(OP::BR, "__br", makeBType(IRBTYPE::UNDEFINED)), conditional(false)
    {
        addOperand(_dest);
    }

    BRInst::BRInst(std::shared_ptr<Value> cond, std::shared_ptr<BasicBlock> _true_dest, std::shared_ptr<BasicBlock> _false_dest)
        : Instruction(OP::BR, "__br", makeBType(IRBTYPE::UNDEFINED)), conditional(true)
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

    std::shared_ptr<Value> BRInst::getCond() const
    {
        Err::gassert(conditional, "BRInst is not conditional.");
        return (*(getOperands().begin()))->getValue();
    }
    std::shared_ptr<BasicBlock> BRInst::getDest() const {
        Err::gassert(!conditional, "BRInst is conditional.");
        return std::dynamic_pointer_cast<BasicBlock>((*(getOperands().begin()))->getValue());
    }
    std::shared_ptr<BasicBlock> BRInst::getTrueDest() const
    {
        Err::gassert(conditional, "BRInst is not conditional.");
        return std::dynamic_pointer_cast<BasicBlock>((*std::next(getOperands().begin()))->getValue());
    }

    std::shared_ptr<BasicBlock> BRInst::getFalseDest() const
    {
        Err::gassert(conditional, "BRInst is not conditional.");
        return std::dynamic_pointer_cast<BasicBlock>((*std::next(std::next(getOperands().begin())))->getValue());
    }

    CALLInst::CALLInst(std::shared_ptr<FunctionDecl> func,
        const std::vector<std::shared_ptr<Value>>& args)
        : Instruction(OP::CALL, "__call", makeBType(IRBTYPE::VOID))
    {
        Err::gassert(toBType(toFunctionType(func->getType())->getRet())->getInner() == IRBTYPE::VOID);
        addOperand(func);
        for (auto valptr : args)
            addOperand(valptr);
    }

    CALLInst::CALLInst(NameRef name, std::shared_ptr<FunctionDecl> func,
        const std::vector<std::shared_ptr<Value>>& args)
        : Instruction(OP::CALL, name, toFunctionType(func->getType())->getRet())
    {
        addOperand(func);
        for (auto valptr : args)
            addOperand(std::move(valptr));
    }

    bool CALLInst::isVoid() const
    {
        return toBType(getType())->getInner() == IRBTYPE::VOID;
    }

    std::string CALLInst::getFuncName() const
    {
        return (*(getOperands().begin()))->getValue()->getName();
    }

    std::shared_ptr<FunctionDecl> CALLInst::getFunc() const
    {
        return std::dynamic_pointer_cast<FunctionDecl>((*(getOperands().begin()))->getValue());
    }

    std::vector<std::shared_ptr<Value>> CALLInst::getArgs() const
    {
        std::vector<std::shared_ptr<Value>> ret;
        for (auto it = std::next(getOperands().begin()); it != getOperands().end(); ++it)
            ret.emplace_back((*it)->getValue());
        return ret;
    }

    void RETInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void BRInst::accept(IRVisitor& visitor) { visitor.visit(*this); }

    void CALLInst::accept(IRVisitor& visitor) { visitor.visit(*this); }
}
