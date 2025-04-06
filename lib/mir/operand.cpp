#include "../../include/mir/operand.hpp"
#include "../../include/mirtools/enum_name.hpp"
#include "../../include/mirtools/tool.hpp"
#include "../../include/utils/exception.hpp"

using namespace MIR;

Operand::Operand(OperandTrait _otrait) : Value(ValueTrait::Operand), otrait(_otrait) {}
Operand::Operand(OperandTrait _otrait, std::string _name)
    : Value(ValueTrait::Operand, std::move(_name)), otrait(_otrait) {}
OperandTrait Operand::getOperandTrait() const { return otrait; }

PreColedOP::PreColedOP(CoreRegister _color) : BindOnVirOP(_color) {}
PreColedOP::PreColedOP(FPURegister _color) : BindOnVirOP(_color) {}

std::string PreColedOP::toString() const {
    variant_reg_toString visitor;

    std::string str = "$" + std::visit(visitor, color);

    return str;
}

BindOnVirOP::BindOnVirOP(RegisterBank _bank) : Operand(OperandTrait::BindOnVirRegister), bank(_bank) {}
BindOnVirOP::BindOnVirOP(RegisterBank _bank, std::string _name)
    : Operand(OperandTrait::BindOnVirRegister, std::move(_name)), bank(_bank) {
    if (bank == RegisterBank::gpr) {
        color = CoreRegister::none;
    } else if (bank == RegisterBank::spr) {
        color = FPURegister::none;
    }
    ///@todo dpr, qpr
}

BindOnVirOP::BindOnVirOP(CoreRegister _color)
    : Operand(OperandTrait::PreColored), bank(RegisterBank::gpr), color(_color) {}
BindOnVirOP::BindOnVirOP(FPURegister _color)
    : Operand(OperandTrait::PreColored), bank(RegisterBank::spr), color(_color) {} // for PreColored

BindOnVirOP::BindOnVirOP(std::string _name)
    : Operand(OperandTrait::BaseAddress, std::move(_name)), bank(RegisterBank::gpr), color(CoreRegister::none) {
} // for BaseADROP

const std::variant<CoreRegister, FPURegister> &BindOnVirOP::getColor() { return color; };

RegisterBank BindOnVirOP::getRegisterBank() { return bank; }

RegisterBank BindOnVirOP::getBank() const { return bank; }

std::string BindOnVirOP::toString() const {
    std::string str = getName();

    if (bank == RegisterBank::gpr && std::get<CoreRegister>(color) != CoreRegister::none) {
        str += ":$" + enum_name(std::get<CoreRegister>(color));
    } else if (bank == RegisterBank::spr && std::get<FPURegister>(color) != FPURegister::none) {
        str += ":$" + enum_name(std::get<FPURegister>(color));
    } else {
        str += ':' + enum_name(bank);
    }

    ///@todo dpr, qpr...

    return str;
}

BaseADROP::BaseADROP(BaseAddressTrait _btrait, std::string _name, int _constOffset,
                     const std::shared_ptr<BindOnVirOP> &_varOffset)
    : BindOnVirOP(std::move(_name)), btrait(_btrait), constOffset(_constOffset), varOffset(_varOffset) {}

int BaseADROP::getConstOffset() const { return constOffset; }
void BaseADROP::setConstOffset(int newOffset) { constOffset = newOffset; }

BaseAddressTrait BaseADROP::getTrait() { return btrait; }

void BaseADROP::setBase(const std::shared_ptr<BindOnVirOP> &_varOffset) { varOffset = _varOffset; }

std::shared_ptr<BindOnVirOP> BaseADROP::getBase() const {
    if (!varOffset.expired()) {
        return varOffset.lock();
    } else {
        return nullptr;
    }
}

std::string BaseADROP::toString() const {
    /// %1:gpr(#Runtime + [varOffset] + 16)
    std::string str = getName() + ':' + enum_name(bank);

    str += "(#Rt";

    if (!varOffset.expired() && varOffset.lock().get() == this) {
        auto base = varOffset.lock(); // self

        if (std::get<CoreRegister>(base->getColor()) != CoreRegister::none) // 一定是gpr
            str += ": $" + enum_name(std::get<CoreRegister>(base->getColor()));

        if (constOffset)
            str += " + " + std::to_string(constOffset);

        str += ')';
        return str;
    }

    if (!varOffset.expired())
        str += ": " + varOffset.lock()->toString();

    if (constOffset)
        str += " + " + std::to_string(constOffset);

    str += ")";

    return str;
}

GlobalADROP::GlobalADROP(std::string _global_name, std::string _name, int _offset,
                         const std::shared_ptr<BindOnVirOP> &_varOffset)
    : BaseADROP(BaseAddressTrait::Global, std::move(_name), _offset, _varOffset),
      global_name(std::move(_global_name)){};

std::string GlobalADROP::getGloName() const { return global_name; }

std::string GlobalADROP::toString() const {
    /// %1:gpr(#Global.aaa + [varOffset] + 16)

    std::string str = getName() + ':' + enum_name(bank);

    str += "(#Glo." + global_name;

    // 元始天尊
    if (!varOffset.expired() && varOffset.lock().get() == this) {
        auto base = varOffset.lock(); // self

        if (std::get<CoreRegister>(base->getColor()) != CoreRegister::none) // 一定是gpr
            str += ": $" + enum_name(std::get<CoreRegister>(base->getColor()));

        if (constOffset)
            str += " + " + std::to_string(constOffset);

        str += ')';
        return str;
    }

    if (!varOffset.expired()) {
        auto varPtr = varOffset.lock();

        if (std::get<CoreRegister>(varPtr->getColor()) != CoreRegister::none)
            str += ": $" + enum_name(std::get<CoreRegister>(varPtr->getColor()));
        else
            str += ": " + varPtr->getName();
    }

    if (constOffset)
        str += " + " + std::to_string(constOffset);

    str += ")";

    return str;
}

StackADROP::StackADROP(std::shared_ptr<FrameObj> _obj, std::string _name, int _offset,
                       const std::shared_ptr<BindOnVirOP> &_varOffset)
    : BaseADROP(BaseAddressTrait::Local, std::move(_name), _offset, _varOffset), obj(std::move(_obj)) {}

std::shared_ptr<FrameObj> StackADROP::getObj() { return obj; }

std::string StackADROP::toString() const {
    /// %1:gpr(#Stack.bbb + [varOffset] + 16)
    std::string str = getName() + ':' + enum_name(bank);

    str += "(#Stk." + std::to_string(obj->getId());

    if (!varOffset.expired() && varOffset.lock().get() == this) {
        auto base = varOffset.lock(); // self

        if (std::get<CoreRegister>(base->getColor()) != CoreRegister::none) // 一定是gpr
            str += " + $" + enum_name(std::get<CoreRegister>(base->getColor()));

        if (constOffset)
            str += " + " + std::to_string(constOffset);

        str += ')';
        return str;
    }

    if (!varOffset.expired()) {
        // could be sp/r7
        auto varPtr = getBase();

        if (std::get<CoreRegister>(varPtr->getColor()) != CoreRegister::none)
            str += " + $" + enum_name(std::get<CoreRegister>(varPtr->getColor()));
        else
            str += "+ " + varPtr->getName();
    }
    if (constOffset)
        str += " + " + std::to_string(constOffset);

    str += ")";

    return str;
}

ShiftOP::ShiftOP(unsigned _imme, ShiftOP::inlineShift _shiftCode)
    : imme(_imme), shiftCode(_shiftCode), Operand(OperandTrait::ShiftImme) {}

unsigned ShiftOP::getShiftImme() const { return imme; }

std::string ShiftOP::toString() const {
    std::string str;
    str += "%inlineshift-";
    str += enum_name(shiftCode);
    str += ':' + std::to_string(imme);

    return str;
}

ConstantIDX::ConstantIDX(const std::shared_ptr<ConstObj> &_constant)
    : Operand(OperandTrait::ConstantPoolValue), constant(_constant) {}

const std::shared_ptr<ConstObj> &ConstantIDX::getConst() const { return constant; }

std::string ConstantIDX::toString() const {
    std::string str = "%const." + std::to_string(constant->getId());
    return str;
}

UnknownConstant::UnknownConstant(const std::shared_ptr<FrameObj> &_stkobj)
    : Operand(OperandTrait::UnknonConstant), stkobj(_stkobj), offset(0) {}

UnknownConstant::UnknownConstant(const std::shared_ptr<FrameObj> &_stkobj, int _offset)
    : Operand(OperandTrait::UnknonConstant), stkobj(_stkobj), offset(_offset) {}

const std::shared_ptr<FrameObj> &UnknownConstant::getStkObj() const { return stkobj; }

size_t UnknownConstant::getFinalOffset() const { return stkobj->getOffset(); }

std::string UnknownConstant::toString() const {
    std::string str = "offset-of-#Stk." + std::to_string(stkobj->getId());
    return str;
}