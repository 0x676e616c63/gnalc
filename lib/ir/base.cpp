/**
 * @attention update: 使用 `Use` 类来管理操作数
 * @attention NO NULL WARNING
 */
#include <algorithm>

#include "../../include/ir/base.hpp"
#include "../../include/utils/exception.hpp"

namespace IR {

Value::Value(std::string _name, std::shared_ptr<Type> _vtype, ValueTrait _vtrait)
    : NameC(std::move(_name)), vtype(std::move(_vtype)), trait(_vtrait) {}

std::shared_ptr<Type> Value::getType() const {
    return vtype;
}

void Value::addUse(const std::weak_ptr<Use>& use) {
    Err::gassert(!use.expired());
    use_list.emplace_back(use);
}

std::list<std::shared_ptr<Use>> Value::getUseList() const {
    std::list<std::shared_ptr<Use>> shared_use_list;
    for (const auto& weak_use : use_list) {
        auto shared_use = weak_use.lock();
        Err::gassert(shared_use != nullptr,
            "Expired use should be deleted in User::delOperand");
        if (shared_use) shared_use_list.push_back(shared_use);
    }
    return shared_use_list;
}

std::list<std::weak_ptr<Use>>& Value::getRUseList() {
    return use_list; }

void Value::replaceSelf(const std::shared_ptr<Value> &new_value) const {
    auto shared_use_list = getUseList();
    for (const auto& use : shared_use_list)
        use->getUser()->replaceUse(use->getValue(), new_value);
}

Value::~Value() = default;

bool Value::delUse(const std::shared_ptr<User> &user) {
    bool found = false;
    for (auto it = use_list.begin(); it != use_list.end();) {
        if (it->lock()->getUser() == user) {
            it = use_list.erase(it);
            found = true;
        }
        else
            ++it;
    }
    return found;
}

User::User(std::string _name, std::shared_ptr<Type> _vtype, ValueTrait _vtrait)
    : Value(std::move(_name), std::move(_vtype), _vtrait) {}

void User::addOperand(const std::shared_ptr<Value>& v) {
    std::shared_ptr<Use> use{new Use(v, this)};
    use->init();
    operands.emplace_back(std::move(use));
}

std::list<std::shared_ptr<Use>>& User::getOperands() {
    return operands;
}

const std::list<std::shared_ptr<Use>>& User::getOperands() const {
    return operands;
}

bool User::delOperand(const std::shared_ptr<Value>& v) {
    return delOperandIf(
        [&v](auto&& op) { return op->getValue() == v; });
}

bool User::delOperand(NameRef name) {
    return delOperandIf(
        [&name](auto&& op) { return op->getValue()->isName(name); });
}

bool User::replaceUse(const std::shared_ptr<Value>& old_val, const std::shared_ptr<Value>& new_val) {
    bool found = false;
    for (auto& use : operands) {
        if (use->getValue() == old_val) {
            auto ok = old_val->delUse(use->getUser());
            Err::gassert(ok);
            use = std::shared_ptr<Use>{new Use(new_val, use->getUser().get())};
            use->init();
            found = true;
        }
    }
    Err::gassert(found, "User::replaceUse(): old_val notfound.");
    return found;
}

Use::Use(std::weak_ptr<Value> v, User* u)
    : val(std::move(v)), user(u) {
}

void Use::init() {
    val.lock()->addUse(weak_from_this());
}


std::shared_ptr<Value> Use::getValue() const {
    return val.lock();
}

std::shared_ptr<User> Use::getUser() const {
    return user->shared_from_this();
}
}