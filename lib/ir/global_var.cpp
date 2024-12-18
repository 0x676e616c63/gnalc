#include "../../include/ir/global_var.hpp"
#include "../../include/ir/visitor.hpp"

#if ENABLE_GVINITER_TOSTRING
#include "../../include/irvisitors/irprinter.hpp"
#endif

namespace IR {

GVIniter::GVIniter(IRTYPE _ty)
    : initer_type(_ty), is_zero(true), is_array(false) {}

GVIniter::GVIniter(IRTYPE _ty, Value* _con)
    : initer_type(_ty), is_zero(false), is_array(false), constval(_con) {}

GVIniter::GVIniter(IRTYPE _ty, std::vector<int> _array_size)
    : initer_type(_ty), is_zero(true), is_array(true), array_size(_array_size) {}

GVIniter::GVIniter(IRTYPE _ty, std::vector<int> _array_size, std::vector<GVIniter> _inner_initer)
    : initer_type(_ty), is_zero(false), is_array(true), array_size(_array_size), inner_initer(_inner_initer) {}

IRTYPE GVIniter::getIniterType() const {
    return initer_type;
}

bool GVIniter::isZero() const {
    return is_zero;
}

bool GVIniter::isArray() const {
    return is_array;
}

std::vector<int> GVIniter::getArraySize() const {
    return array_size;
}

Value* GVIniter::getConstVal() {
    return constval;
}

std::vector<GVIniter>& GVIniter::getInnerIniter() {
    return inner_initer;
}

GVIniter::~GVIniter() {}


GlobalVariable::GlobalVariable(STOCLASS _sc, IRTYPE _ty, std::string _name, GVIniter _initer, int _align)
    : storage_class(_sc), vtype(_ty), is_array(false), Value(_name, IRTYPE::PTR), initer(_initer), align(_align) {}

GlobalVariable::GlobalVariable(STOCLASS _sc, IRTYPE _ty, std::string _name, std::vector<int> _array_size, GVIniter _initer, int _align)
    : storage_class(_sc), vtype(_ty), is_array(true), Value(_name, IRTYPE::PTR), initer(_initer), align(_align), array_size(_array_size) {}

STOCLASS GlobalVariable::getStorageClass() const {
    return storage_class;
}

IRTYPE GlobalVariable::getVarType() const {
    return vtype;
}

bool GlobalVariable::isArray() const {
    return is_array;
}

std::vector<int> GlobalVariable::getArraySize() const {
    return array_size;
}

GVIniter& GlobalVariable::getIniter() {
    return initer;
}

int GlobalVariable::getAlign() const {
    return align;
}

GlobalVariable::~GlobalVariable() {}

std::string GVIniter::toString() {
    std::string ret;

    #if ENABLE_GVINITER_TOSTRING
    if (isArray()) {
        for (int size : getArraySize()) {
            ret += "[" + std::to_string(size) + " x ";
        }
        ret += IRFormatter::formatIRTYPE(getIniterType());
        for (int i = 0; i < getArraySize().size(); i++) {
            ret += "]";
        }

        if (isZero()) {
            ret += " zeroinitializer";
        } else {
            ret += "[";
            for (auto it = getInnerIniter().begin(); it != getInnerIniter().end(); it++) {
                ret += it->toString();
                if (std::next(it) != getInnerIniter().end()) {
                    ret += ", ";
                }
            }
            ret += "]";
        }
    } else {
        if (isZero()) {
            ret += IRFormatter::formatIRTYPE(getIniterType()) + " ";
            ret += "0";
        } else {
            ret += IRFormatter::formatValue(*getConstVal());
        }
    }
    #endif

    return ret;
}

void GlobalVariable::accept(IRVisitor& visitor) {
    visitor.visit(*this);
}
}