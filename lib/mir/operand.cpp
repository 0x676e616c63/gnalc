#include "../../include/mir/operand.hpp"
#include "../../include/mirtools/enum_name.hpp"
#include "../../include/mirtools/tool.hpp"
#include "../../include/utils/exception.hpp"

using namespace MIR;

std::string PreColedOP::toString() const {
    variant_visitor visitor;
    ///@bug 注意调试
    std::string str = "$" + std::visit(visitor, color);

    return str;
}

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
        str += " + " + varOffset.lock()->toString();

    if (constOffset)
        str += " + " + std::to_string(constOffset);

    str += ")";

    return str;
}

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

std::string StackADROP::toString() const {
    /// %1:gpr(#Stack.bbb + [varOffset] + 16)
    std::string str = getName() + ':' + enum_name(bank);

    str += "(#Stk." + std::to_string(obj->getId());

    if (!varOffset.expired() && varOffset.lock().get() == this) {
        auto base = varOffset.lock(); // self

        if (std::get<CoreRegister>(base->getColor()) != CoreRegister::none) // 一定是gpr
            str += ": $" + enum_name(std::get<CoreRegister>(base->getColor()));

        if (constOffset)
            str += " + " + std::to_string(constOffset);

        str += ')';
        return str;
    }

    if (!varOffset.expired() && !std::dynamic_pointer_cast<PreColedOP>(getBase())) {
        // not sp/r7
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

std::string ShiftOP::toString() const {
    std::string str;
    str += "%inlineshift-";
    str += enum_name(shiftCode);
    str += ':' + std::to_string(imme);

    return str;
}

std::string ConstantIDX::toString() const {
    std::string str = "%const." + std::to_string(constant->getId());
    return str;
}