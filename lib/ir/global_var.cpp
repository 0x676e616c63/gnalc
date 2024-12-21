#include "../../include/ir/global_var.hpp"
#include "../../include/ir/visitor.hpp"

#if ENABLE_GVINITER_TOSTRING
#include "../../include/irvisitors/irprinter.hpp"
#endif

namespace IR
{
    GVIniter::GVIniter(std::shared_ptr<Type> _ty)
        : initer_type(std::move(_ty)), is_zero(true) {}

    GVIniter::GVIniter(std::shared_ptr<Type> _ty, std::shared_ptr<Value> _con)
        : initer_type(std::move(_ty)), is_zero(false), constval(_con) {}

    GVIniter::GVIniter(std::shared_ptr<Type> _ty, std::vector<GVIniter> _inner_initer)
        : initer_type(std::move(_ty)), is_zero(false), inner_initer(_inner_initer) {}

    const auto& GVIniter::getIniterType() const {
        return initer_type;
    }

    bool GVIniter::isZero() const {
        return is_zero;
    }

    bool GVIniter::isArray() const {
        return initer_type->getTrait() == IRCTYPE::ARRAY;
    }

    auto& GVIniter::getConstVal() {
        return constval;
    }

    std::vector<GVIniter>& GVIniter::getInnerIniter() {
        return inner_initer;
    }

    GVIniter::~GVIniter() {}


    GlobalVariable::GlobalVariable(STOCLASS _sc, std::shared_ptr<Type> _ty, std::string _name, GVIniter _initer, int _align)
        : storage_class(_sc), vtype(std::move(_ty)), Value(std::move(_name), makePtrType(_ty)), initer(_initer), align(_align) {}

    STOCLASS GlobalVariable::getStorageClass() const {
        return storage_class;
    }

    const std::shared_ptr<Type>& GlobalVariable::getVarType() const {
        return vtype;
    }

    bool GlobalVariable::isArray() const {
        return vtype->getTrait() == IRCTYPE::ARRAY;
    }

    GVIniter& GlobalVariable::getIniter() {
        return initer;
    }

    int GlobalVariable::getAlign() const {
        return align;
    }

    // void GlobalVariable::accept(IRVisitor& visitor) override { visitor.visit(*this); }

std::string GVIniter::toString() {
    std::string ret;

    #if ENABLE_GVINITER_TOSTRING
    if (isArray()) {
        ret += initer_type->toString();
        if (isZero()) {
            ret += " zeroinitializer";
        } else {
            ret += " [";
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
            ret += initer_type->toString() + " ";
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

IR::GlobalVariable::~GlobalVariable() {}

}