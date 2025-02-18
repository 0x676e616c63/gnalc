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
    std::string str = getName() + ':' + enum_name(bank);

    return str;
}

std::string BaseADROP::toString() const {
    /// %1:gpr(%Runtime + [varOffset] + 16)
    std::string str = getName() + ':' + enum_name(bank);

    str += "(%Runtime:";
    if (!varOffset.expired())
        str += " + " + varOffset.lock()->toString();

    if (constOffset)
        str += " + " + std::to_string(constOffset);

    str += ")";

    return str;
}

std::string GlobalADROP::toString() const {
    /// %1:gpr(%Global.aaa + [varOffset] + 16)

    std::string str = getName() + ':' + enum_name(bank);

    str += "(%Global." + global_name;
    if (!varOffset.expired()) {
        auto varPtr = varOffset.lock();
        str += ": " + varPtr->getName();
    }

    if (constOffset)
        str += " + " + std::to_string(constOffset);

    str += ")";

    return str;
}

std::string StackADROP::toString() const {
    /// %1:gpr(%Stack.bbb + [varOffset] + 16)
    std::string str = getName() + ':' + enum_name(bank);

    str += "(%Stack." + std::to_string(obj->getId());
    if (!varOffset.expired() && !std::dynamic_pointer_cast<PreColedOP>(getBase())) // !sp/r7
        str += ": " + varOffset.lock()->toString();

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