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

void BindOnVirOP::setColor(unsigned int newcolor) {
    if (bank == RegisterBank::gpr)

        color = static_cast<CoreRegister>(newcolor);

    else if (bank == RegisterBank::gprnopc) {

        Err::gassert(static_cast<CoreRegister>(newcolor) != CoreRegister::pc,
                     "MIR::BindOnVirOP::setColor(unsigned int): color "
                     "assignment conflict!");

        color = static_cast<CoreRegister>(newcolor);

    } else if (bank == RegisterBank::spr)

        color = static_cast<FPURegister>(newcolor);

    else if (bank == RegisterBank::dpr) {
        /// @note to be continued
    }
}

std::string BindOnVirOP::toString() const {
    std::string str = getName() + ':' + enum_name(bank);

    return str;
}

std::string GlobalADROP::toString() const {
    /// %1:gpr(%global.aaa + 16)
    std::string str = getName() + ':' + enum_name(bank);
    str += "(%global." + global_name;
    str += " + " + std::to_string(constOffset) + ')';
    return str;
}

std::string StackADROP::toString() const {
    /// %1:gpr(%stack.bbb + 16)
    std::string str = getName() + ':' + enum_name(bank);
    str += "(%stack." + std::to_string(idx);
    str += " + " + std::to_string(constOffset) + ')';
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