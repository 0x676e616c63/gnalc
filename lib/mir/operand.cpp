#include "../../include/mir/operand.hpp"
#include "../../include/mirtools/magic_enum.hpp"
#include "../../include/mirtools/tool.hpp"
#include <cassert>

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

        assert(static_cast<CoreRegister>(newcolor) != CoreRegister::pc &&
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
    std::string str =
        getName() + ':' + static_cast<std::string>(magic_enum::enum_name(bank));

    return str;
}

std::string GlobalADROP::toString() const {
    std::string str = "%global." + getName();

    return str;
}

std::string StackADROP::toString() const {
    std::string str = "%stack." + std::to_string(idx);

    return str;
}

std::string ShiftOP::toString() const {
    std::string str;
    str += "%inlineshift-";
    str += static_cast<std::string>(magic_enum::enum_name(shiftCode));
    str += ':' + std::to_string(imme);

    return str;
}

std::string ConstantIDX::toString() const {
    std::string str = "%const." + std::to_string(idx);
    return str;
}