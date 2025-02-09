/**
 * @attention update: 使用 `Use` 类来管理操作数
 * @attention NO NULL WARNING
 */
#include <algorithm>

#include "../../include/ir/base.hpp"
#include "../../include/utils/exception.hpp"

#include <functional>

namespace IR {

Value::Value(std::string _name, std::shared_ptr<Type> _vtype,
             ValueTrait _vtrait)
    : NameC(std::move(_name)), vtype(std::move(_vtype)), trait(_vtrait) {}

std::shared_ptr<Type> Value::getType() const { return vtype; }

void Value::addUse(const std::weak_ptr<Use> &use) {
    Err::gassert(!use.expired());
    use_list.emplace_back(use);
}

std::list<std::shared_ptr<Use>> Value::getUseList() const {
    std::list<std::shared_ptr<Use>> shared_use_list;
    for (const auto &weak_use : use_list) {
        auto shared_use = weak_use.lock();
        Err::gassert(shared_use != nullptr,
                     "Expired use should be deleted in User::delOperand");
        if (shared_use)
            shared_use_list.push_back(shared_use);
    }
    return shared_use_list;
}

std::list<std::weak_ptr<Use>> &Value::getRUseList() { return use_list; }

void Value::replaceSelf(const std::shared_ptr<Value> &new_value) const {
    auto shared_use_list = getUseList();
    for (const auto &use : shared_use_list)
        use->getUser()->replaceUse(use->getValue(), new_value);
}

Value::~Value() = default;

bool Value::delUse(User* user) {
    bool found = false;
    for (auto it = use_list.begin(); it != use_list.end();) {
        if (it->lock()->getRawUser() == user) {
            it = use_list.erase(it);
            found = true;
        } else
            ++it;
    }
    return found;
}

User::~User() {
    std::set<Value*> deleted;
    for (const auto& curr : operands) {
        auto curr_val = curr->getValue();
        // Because one's operands may be destroyed before itself and we can't prevent this happen.
        // It's hard to always delete a value before its user.
        if (!curr_val) continue;
        if (deleted.find(curr_val.get()) == deleted.end()) {
            deleted.insert(curr_val.get());
            auto ok = curr_val->delUse(this);
            Err::gassert(ok);
        }
    }
}

User::User(std::string _name, std::shared_ptr<Type> _vtype, ValueTrait _vtrait)
    : Value(std::move(_name), std::move(_vtype), _vtrait) {}

void User::addOperand(const std::shared_ptr<Value> &v) {
    std::shared_ptr<Use> use{new Use(v, this)};
    use->init();
    operands.emplace_back(std::move(use));
}

const std::vector<std::shared_ptr<Use>> &User::getOperands() const {
    return operands;
}
const std::shared_ptr<Use> &User::getOperand(size_t index) const {
    return operands[index];
}

bool User::delOperand(const std::shared_ptr<Value> &v) {
    return delOperandIf([&v](auto &&value) { return value == v; });
}

bool User::delOperand(NameRef name) {
    return delOperandIf(
        [&name](auto &&value) { return value->isName(name); });
}

bool User::delOperand(size_t index) {
    Err::gassert(index < operands.size());
    if (index >= operands.size())
        return false;
    auto use = operands[index];
    auto ok = use->getValue()->delUse(use->getUser().get());
    Err::gassert(ok);
    operands.erase(
        operands.begin() +
        static_cast<decltype(operands)::iterator::difference_type>(index));
    return true;
}

bool User::replaceUse(const std::shared_ptr<Value> &old_val,
                      const std::shared_ptr<Value> &new_val) {
    bool found = false;
    for (auto &use : operands) {
        if (use->getValue() == old_val) {
            auto ok = old_val->delUse(use->getUser().get());
            Err::gassert(ok);
            use = std::shared_ptr<Use>{new Use(new_val, use->getUser().get())};
            use->init();
            found = true;
        }
    }
    Err::gassert(found, "User::replaceUse(): old_val notfound.");
    return found;
}

Use::Use(std::weak_ptr<Value> v, User *u) : val(std::move(v)), user(u) {}

void Use::init() { val.lock()->addUse(weak_from_this()); }

User *Use::getRawUser() const {
    return user;
}

std::shared_ptr<Value> Use::getValue() const { return val.lock(); }

std::shared_ptr<User> Use::getUser() const { return user->shared_from_this(); }
} // namespace IR