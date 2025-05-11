#include "ir/instructions/control.hpp"
#include "ir/visitor.hpp"
#include "utils/exception.hpp"

namespace IR {
RETInst::RETInst() : Instruction(OP::RET, "__ret", makeBType(IRBTYPE::UNDEFINED)), ret_type(makeBType(IRBTYPE::VOID)) {}

RETInst::RETInst(pVal ret_val)
    : Instruction(OP::RET, "__ret", makeBType(IRBTYPE::UNDEFINED)), ret_type(ret_val->getType()->as<BType>()) {
    addOperand(ret_val);
}

bool RETInst::isVoid() const { return ret_type->as<BType>()->getInner() == IRBTYPE::VOID; }

pVal RETInst::getRetVal() const {
    Err::gassert(!isVoid(), "RETInst::getRetVal: RETInst is void.");
    return getOperand(0)->getValue();
}

IRBTYPE RETInst::getRetBType() const { return toBType(ret_type)->getInner(); }

pBType RETInst::getRetType() const { return ret_type; }

// BRInst operands:
// Conditional
// cond | true_dest | false_dest | true_args | false_args
//  0         1            2           3           4
// Unconditional
// dest | dest_args
//   0        1

BRInst::BRInst(const pBlock &_dest) : Instruction(OP::BR, "__br", makeBType(IRBTYPE::UNDEFINED)), conditional(false) {
    addOperand(_dest);
}

BRInst::BRInst(const pVal &cond, const pBlock &_true_dest, const pBlock &_false_dest)
    : Instruction(OP::BR, "__br", makeBType(IRBTYPE::UNDEFINED)), conditional(true) {
    addOperand(cond);
    addOperand(_true_dest);
    addOperand(_false_dest);
}

bool BRInst::isConditional() const { return conditional; }

pVal BRInst::getCond() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    return getOperand(0)->getValue();
}
pBlock BRInst::getDest() const {
    Err::gassert(!conditional, "BRInst is conditional.");
    return getOperand(0)->getValue()->as<BasicBlock>();
}
pBlock BRInst::getTrueDest() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    return getOperand(1)->getValue()->as<BasicBlock>();
}

pBlock BRInst::getFalseDest() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    return getOperand(2)->getValue()->as<BasicBlock>();
}

void BRInst::setBBArgs(const std::vector<pVal> &args) {
    Err::gassert(!conditional, "BRInst is conditional.");
    addOperand(std::make_shared<BBArgList>(getDest(), args));
    set_args = true;
}

void BRInst::setBBArgs(const std::vector<pVal> &t_args, const std::vector<pVal> &f_args) {
    Err::gassert(conditional, "BRInst is not conditional.");
    addOperand(std::make_shared<BBArgList>(getTrueDest(), t_args));
    addOperand(std::make_shared<BBArgList>(getFalseDest(), f_args));
    set_args = true;
}

std::vector<pVal> BRInst::getBBArgs() const {
    Err::gassert(!conditional, "BRInst is conditional.");
    Err::gassert(set_args, "BRInst is not set args.");
    return getOperand(1)->getValue()->as<BBArgList>()->_getArgs();
}

std::vector<pVal> BRInst::getTrueBBArgs() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    Err::gassert(set_args, "BRInst is not set args.");
    return getOperand(3)->getValue()->as<BBArgList>()->_getArgs();
}

std::vector<pVal> BRInst::getFalseBBArgs() const {
    Err::gassert(conditional, "BRInst is not conditional.");
    Err::gassert(set_args, "BRInst is not set args.");
    return getOperand(4)->getValue()->as<BBArgList>()->_getArgs();
}

void BRInst::dropFalseDest() {
    Err::gassert(conditional, "BRInst is not conditional.");
    conditional = false;
    if (set_args)
        delOperand(4);
    delOperand(2);
    delOperand(0);
}

void BRInst::dropTrueDest() {
    Err::gassert(conditional, "BRInst is not conditional.");
    conditional = false;
    if (set_args)
        delOperand(3);
    delOperand(1);
    delOperand(0);
}

void BRInst::dropOneDest(const pBlock &bb) {
    if (bb == getTrueDest())
        dropTrueDest();
    else if (bb == getFalseDest())
        dropFalseDest();
    else
        Err::unreachable("BRInst::dropOneDest: Not a dest.");
}

CALLInst::CALLInst(const pFuncDecl &func, const std::vector<pVal> &args)
    : Instruction(OP::CALL, "__call", makeBType(IRBTYPE::VOID)) {
#ifndef GNALC_EXTENSION_GGC
    Err::gassert(func->getType()->as<FunctionType>()->getRet()->as<BType>()->getInner() == IRBTYPE::VOID);
#endif
    addOperand(func);
    for (const auto &valptr : args)
        addOperand(valptr);
}

CALLInst::CALLInst(NameRef name, const pFuncDecl &func, const std::vector<pVal> &args)
    : Instruction(OP::CALL, name, func->getType()->as<FunctionType>()->getRet()) {
    addOperand(func);
    for (const auto &valptr : args)
        addOperand(valptr);
}

bool CALLInst::isVoid() const { return toBType(getType())->getInner() == IRBTYPE::VOID; }

std::string CALLInst::getFuncName() const { return getFunc()->getName(); }

pFuncDecl CALLInst::getFunc() const { return getOperand(0)->getValue()->as<FunctionDecl>(); }

std::vector<pVal> CALLInst::getArgs() const {
    std::vector<pVal> ret;
    for (auto it = operand_begin() + 1; it != operand_end(); ++it)
        ret.emplace_back(*it);
    return ret;
}

void CALLInst::setTailCall(bool is_tail_call_) { is_tail_call = is_tail_call_; }

bool CALLInst::isTailCall() const { return is_tail_call; }

SELECTInst::SELECTInst(NameRef name, const pVal &cond, const pVal &true_val, const pVal &false_val)
: Instruction(OP::SELECT, name, true_val->getType()) {
    Err::gassert(isSameType(true_val->getType(), false_val->getType()));
    addOperand(cond);
    addOperand(true_val);
    addOperand(false_val);
}
pVal SELECTInst::getCond() const {
    return getOperand(0)->getValue();
}
pVal SELECTInst::getTrueVal() const {
    return getOperand(1)->getValue();
}
pVal SELECTInst::getFalseVal() const {
    return getOperand(2)->getValue();
}


void RETInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void BRInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void CALLInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

void SELECTInst::accept(IRVisitor &visitor) { visitor.visit(*this); }

BRInst::BBArgList::BBArgList(const pBlock &block, const std::vector<pVal> &args)
    : User("__bb_arg_list", makeBType(IRBTYPE::UNDEFINED), ValueTrait::BB_ARG_LIST), block(block) {
    for (const auto &arg : args)
        addOperand(arg);
}

pBr BRInst::BBArgList::getBr() const { return (*operand_begin())->as<BRInst>(); }

std::vector<pVal> BRInst::BBArgList::_getArgs() const {
    std::vector<pVal> ret;
    for (const auto &operand : getOperands())
        ret.emplace_back(operand->getValue());
    return ret;
}
} // namespace IR
