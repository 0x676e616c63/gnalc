/**
 * @attention update: 使用 `Use` 类来管理操作数
 * @attention NO NULL WARNING
 */
#include <algorithm>

#include "../../include/ir/base.hpp"

#include "../../include/ir/instructions/phi.hpp"
#include "../../include/utils/exception.hpp"

#include <functional>

namespace IR {

Value::Value(std::string _name, std::shared_ptr<Type> _vtype, ValueTrait _vtrait)
    : NameC(std::move(_name)), vtype(std::move(_vtype)), trait(_vtrait) {}

std::shared_ptr<Type> Value::getType() const { return vtype; }

size_t Value::getUseCount() const {
    // Expired use should be deleted by User.
    // So just get the size.
    return use_list.size();
}

void Value::addUse(const std::weak_ptr<Use> &use) {
    Err::gassert(!use.expired());
    use_list.emplace_back(use);
}

std::list<std::shared_ptr<Use>> Value::getUseList() const {
    std::list<std::shared_ptr<Use>> shared_use_list;
    for (const auto &weak_use : use_list) {
        auto shared_use = weak_use.lock();
        Err::gassert(shared_use != nullptr, "Expired use should be deleted by User.");
        if (shared_use)
            shared_use_list.push_back(shared_use);
    }
    return shared_use_list;
}

std::list<std::weak_ptr<Use>> &Value::getRUseList() { return use_list; }

void Value::replaceSelf(const std::shared_ptr<Value> &new_value) const {
    Err::gassert(this != new_value.get(), "Replace with an identical value doesn't make sense.");
    auto shared_use_list = getUseList();
    for (const auto &use : shared_use_list) {
        bool ok = use->getUser()->replaceUse(use, new_value);
        Err::gassert(ok);
    }
}

Value::~Value() = default;

bool Value::delUse(const std::shared_ptr<Use>& target) {
    for (auto it = use_list.begin(); it != use_list.end(); ++it) {
        Err::gassert(!it->expired(), "Expired use should be deleted by User.");
        if (!it->expired() && it->lock() == target) {
            use_list.erase(it);
            return true;
        }
    }
    return false;
}

User::~User() {
    for (const auto& curr : operands) {
        auto curr_val = curr->getValue();
        // Because one's operands may be destroyed before itself and we can't prevent this happen.
        // It's hard to always delete a value before its user.
        // For example, when the whole compiling is done, and Module's destructor runs,
        // all instructions will be deleted, but not in the def-use relationship.
        if (!curr_val) continue;
        auto ok = curr_val->delUse(curr);
        Err::gassert(ok);
    }
}

bool User::replaceOperand(const std::shared_ptr<Value> &before, const std::shared_ptr<Value> &after){
    bool found = false;
    for (const auto& use : operands) {
        if (use->getValue() == before) {
            replaceUse(use, after);
            found = true;
        }
    }
    return found;
}

bool User::replaceUse(const std::shared_ptr<Use> &old_use,
                      const std::shared_ptr<Value> &new_value) {
    Err::gassert(old_use->getValue() != new_value,
        "Replace with an identical value doesn't make sense.");
    for (auto &use : operands) {
        if (use == old_use) {
            auto ok = use->getValue()->delUse(use);
            Err::gassert(ok, "The use has been released unexpectedly.");
            // Don't `make_shared` because the constructor is private.
            use = std::shared_ptr<Use>(new Use(new_value, use->getUser().get()));
            use->init();
            return true;
        }
    }
    Err::unreachable("User::replaceOneUse(): old_val notfound.");
    return false;
}

User::User(std::string _name, std::shared_ptr<Type> _vtype, ValueTrait _vtrait)
    : Value(std::move(_name), std::move(_vtype), _vtrait) {}

size_t User::getNumOperands() const {
    return operands.size();
}

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

void User::setOperand(size_t index, const std::shared_ptr<Value> &val) {
    Err::gassert(index < operands.size(), "index out of range");
    auto old_use = operands[index];
    auto ok = old_use->getValue()->delUse(old_use);
    Err::gassert(ok);
    std::shared_ptr<Use> new_use{new Use(val, this)};
    new_use->init();
    operands[index] = std::move(new_use);
}

void User::swapOperand(size_t a, size_t b) {
    Err::gassert(a < operands.size() && b < operands.size(), "index out of range");
    std::swap(operands[a], operands[b]);
}

bool User::delOperand(const std::shared_ptr<Value> &v) {
    return delOperandIf([&v](const auto& value) { return value == v; });
}

bool User::delOperand(NameRef name) {
    return delOperandIf(
        [&name](const auto& value) { return value->isName(name); });
}

bool User::delOperand(size_t index) {
    Err::gassert(index < operands.size(), "index out of range");
    if (index >= operands.size())
        return false;
    auto use = operands[index];
    auto ok = use->getValue()->delUse(use);
    Err::gassert(ok);
    operands.erase(
        operands.begin() +
        static_cast<decltype(operands)::iterator::difference_type>(index));
    return true;
}

Use::Use(std::weak_ptr<Value> v, User *u) : val(std::move(v)), user(u) {}

void Use::init() { val.lock()->addUse(weak_from_this()); }

User *Use::getRawUser() const {
    return user;
}

std::shared_ptr<Value> Use::getValue() const { return val.lock(); }

std::shared_ptr<User> Use::getUser() const { return user->shared_from_this(); }
} // namespace IR