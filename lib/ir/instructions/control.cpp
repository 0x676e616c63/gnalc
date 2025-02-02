#include "../../../include/ir/instructions/control.hpp"
#include "../../../include/ir/visitor.hpp"
#include "../../../include/utils/exception.hpp"

#include <algorithm>

namespace IR {
RETInst::RETInst()
    : Instruction(OP::RET, "__ret", makeBType(IRBTYPE::UNDEFINED)),
      ret_type(makeBType(IRBTYPE::VOID)) {}

RETInst::RETInst(std::shared_ptr<Value> ret_val)
    : Instruction(OP::RET, "__ret", makeBType(IRBTYPE::UNDEFINED)),
      ret_type(toBType(ret_val->getType())) {
    addOperand(ret_val);
}

bool RETInst::isVoid() const {
    return toBType(ret_type)->getInner() == IRBTYPE::VOID;
}

std::shared_ptr<Value> RETInst::getRetVal() const {
    Err::gassert(!isVoid(), "RETInst::getRetVal: RETInst is void.");
    return (*(getOperands().begin()))->getValue();
}

IRBTYPE RETInst::getRetBType() const { return toBType(ret_type)->getInner(); }

std::shared_ptr<BType> RETInst::getRetType() const { return ret_type; }

BRInst::BRInst(std::shared_ptr<BasicBlock> _dest)
    : Instruction(OP::BR, "__br", makeBType(IRBTYPE::UNDEFINED)),
      conditional(false) {
    addOperand(_dest);
}

BRInst::BRInst(std::shared_ptr<Value> cond,
               std::shared_ptr<BasicBlock> _true_dest,
               std::shared_ptr<BasicBlock> _false_dest)
    : Instruction(OP::BR, "__br", makeBType(IRBTYPE::UNDEFINED)),
      conditional(true) {
    addOperand(cond);
    addOperand(_true_dest);
    addOperand(_false_dest);
}

bool BRInst::isConditional() const { return conditional; }

std::shared_ptr<Value> BRInst::getCond() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    return (*(getOperands().begin()))->getValue();
}
std::shared_ptr<BasicBlock> BRInst::getDest() const {
    Err::gassert(!conditional, "BRInst is conditional.");
    return std::dynamic_pointer_cast<BasicBlock>(
        (*(getOperands().begin()))->getValue());
}
std::shared_ptr<BasicBlock> BRInst::getTrueDest() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    return std::dynamic_pointer_cast<BasicBlock>(
        (*std::next(getOperands().begin()))->getValue());
}

std::shared_ptr<BasicBlock> BRInst::getFalseDest() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    return std::dynamic_pointer_cast<BasicBlock>(
        (*std::next(std::next(getOperands().begin())))->getValue());
}

void BRInst::setBBArgs(const std::vector<std::shared_ptr<Value>> &args) {
    Err::gassert(!conditional, "BRInst is conditional.");
    addOperand(std::make_shared<BBArgList>(getDest(), args));
    set_args = true;
}

void BRInst::setBBArgs(const std::vector<std::shared_ptr<Value>> &t_args,
                       const std::vector<std::shared_ptr<Value>> &f_args) {
    Err::gassert(conditional, "BRInst is not conditional.");
    addOperand(std::make_shared<BBArgList>(getTrueDest(), t_args));
    addOperand(std::make_shared<BBArgList>(getFalseDest(), f_args));
    set_args = true;
}

std::vector<std::shared_ptr<Value>> BRInst::getBBArgs() const {
    Err::gassert(!conditional, "BRInst is conditional.");
    Err::gassert(set_args, "BRInst is not set args.");
    return (std::dynamic_pointer_cast<BBArgList>(
                (*std::next(getOperands().begin()))->getValue())
                ->_getArgs());
}

std::vector<std::shared_ptr<Value>> BRInst::getTrueBBArgs() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    Err::gassert(set_args, "BRInst is not set args.");
    return (std::dynamic_pointer_cast<BBArgList>(
                (*std::next(getOperands().rbegin()))->getValue())
                ->_getArgs());
}

std::vector<std::shared_ptr<Value>> BRInst::getFalseBBArgs() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    Err::gassert(set_args, "BRInst is not set args.");
    return (std::dynamic_pointer_cast<BBArgList>(
                (*(getOperands().rbegin()))->getValue())
                ->_getArgs());
}

CALLInst::CALLInst(std::shared_ptr<FunctionDecl> func,
                   const std::vector<std::shared_ptr<Value>> &args)
    : Instruction(OP::CALL, "__call", makeBType(IRBTYPE::VOID)) {
    Err::gassert(
        toBType(toFunctionType(func->getType())->getRet())->getInner() ==
        IRBTYPE::VOID);
    addOperand(func);
    for (const auto &valptr : args)
        addOperand(valptr);
}

CALLInst::CALLInst(NameRef name, std::shared_ptr<FunctionDecl> func,
                   const std::vector<std::shared_ptr<Value>> &args)
    : Instruction(OP::CALL, name, toFunctionType(func->getType())->getRet()) {
    addOperand(func);
    for (const auto &valptr : args)
        addOperand(valptr);
}

bool CALLInst::isVoid() const {
    return toBType(getType())->getInner() == IRBTYPE::VOID;
}

std::string CALLInst::getFuncName() const {
    return (*(getOperands().begin()))->getValue()->getName();
}

std::shared_ptr<FunctionDecl> CALLInst::getFunc() const {
    return std::dynamic_pointer_cast<FunctionDecl>(
        (*(getOperands().begin()))->getValue());
}

std::vector<std::shared_ptr<Value>> CALLInst::getArgs() const {
    std::vector<std::shared_ptr<Value>> ret;
    for (auto it = std::next(getOperands().begin()); it != getOperands().end();
         ++it)
        ret.emplace_back((*it)->getValue());
    return ret;
}

void RETInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void BRInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void CALLInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

BRInst::BBArgList::BBArgList(const std::shared_ptr<BasicBlock> &block,
                             const std::vector<std::shared_ptr<Value>> &args)
    : User("__bb_arg_list", makeBType(IRBTYPE::UNDEFINED),
           ValueTrait::BB_ARG_LIST),
      block(block) {
    for (const auto &arg : args)
        addOperand(arg);
}

std::shared_ptr<BRInst> BRInst::BBArgList::getBr() const {
    return std::dynamic_pointer_cast<BRInst>(getUseList().front()->getUser());
}

std::vector<std::shared_ptr<Value>> BRInst::BBArgList::_getArgs() const {
    std::vector<std::shared_ptr<Value>> ret;
    for (const auto &operand : getOperands())
        ret.emplace_back(operand->getValue());
    return ret;
}
} // namespace IR
