/**
 * @attention update: 使用 `Use` 类来管理操作数
 * @attention NO NULL WARNING
 */

#include "../../include/ir/base.hpp"
#include "../../include/utils/exception.hpp"


namespace IR {

Value::Value(std::string _name, std::shared_ptr<Type> _vtype)
    : NameC(std::move(_name)), vtype(std::move(_vtype)) {}

IRBTYPE Value::getType() const {
    return getBTy(vtype);
}

std::shared_ptr<Type> Value::getTypePtr() const {
    return vtype;
}

void Value::addUse(const std::shared_ptr<Use>& use) {
    use_list.emplace_back(use);
}

std::list<std::shared_ptr<Use>> Value::getUseList() const {
    std::list<std::shared_ptr<Use>> shared_use_list;
    for (const auto& weak_use : use_list) {
        auto shared_use = weak_use.lock();
        if (shared_use) {
            shared_use_list.push_back(shared_use);
        } else {
            Err::error("Value::getUseList(): use is expired.");
        }
    }
    return shared_use_list;
}

std::list<std::weak_ptr<Use>>& Value::getRUseList() {
    return use_list;
}

bool Value::delUse(const std::shared_ptr<Use>& use) {
    bool found = false;
    for (auto it = use_list.begin(); it != use_list.end();) {
        if (it->lock() == use) {
            it = use_list.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    Err::assert(found, "Value::delUse(): use not found.");
    return found;
}

bool Value::delUse(const std::shared_ptr<User>& user) {
    bool found = false;
    for (auto it = use_list.begin(); it != use_list.end();) {
        if (it->lock()->getUser() == user) {
            it = use_list.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    Err::assert(found, "Value::delUse(): user not found.");
    return found;
}

bool Value::delUse(NameRef name) {
    bool found = false;
    for (auto it = use_list.begin(); it != use_list.end();) {
        if (it->lock()->getUser()->isName(name)) {
            it = use_list.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    Err::assert(found, "Value::delUse(): name not found.");
    return found;
}

bool Value::replaceUse(const std::shared_ptr<Use>& old_use, const std::shared_ptr<Use>& new_use) {
    bool found = false;
    for (auto& use : use_list) {
        if (use.lock() == old_use) {
            use = new_use;
            found = true;
        }
    }
    Err::assert(found, "Value::replaceUse(): old_use not found.");
    return found;
}

Value::~Value() {
    // todo
}


User::User(std::string _name, std::shared_ptr<Type> _vtype)
    : Value(std::move(_name), std::move(_vtype)) {}

void User::addOperand(const std::shared_ptr<Value>& v) {
    operands.emplace_back(std::make_shared<Use>(v, shared_from_this()));
}

std::list<std::shared_ptr<Use>>& User::getOperands() {
    return operands;
}

const std::list<std::shared_ptr<Use>>& User::getOperands() const {
    return operands;
}

bool User::delOperand(const std::shared_ptr<Value>& v) {
    bool found = false;
    for (auto it = operands.begin(); it != operands.end();) {
        if ((*it)->getValue() == v) {
            it = operands.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    Err::assert(found, "User::delOperand(): value not found.");
    return found;
}

bool User::delOperand(NameRef name) {
    bool found = false;
    for (auto it = operands.begin(); it != operands.end();) {
        if ((*it)->getValue()->isName(name)) {
            it = operands.erase(it);
            found = true;
        } else {
            ++it;
        }
    }
    Err::assert(found, "User::delOperand(): name not found.");
    return found;
}

bool User::replaceUse(const std::shared_ptr<Value>& old_val, const std::shared_ptr<Value>& new_val) {
    bool found = false;
    for (auto& use : operands) {
        if (use->getValue() == old_val) {
            use = std::make_shared<Use>(new_val, use->getUser());
            found = true;
        }
    }
    Err::assert(found, "User::replaceUse(): old_val notfound.");
    return found;
}

User::~User() {
    // todo
}


Use::Use(std::shared_ptr<Value> v, std::shared_ptr<User> u) 
    : val(std::move(v)), user(std::move(u)) { v->addUse(shared_from_this()); }

std::shared_ptr<Value> Use::getValue() const {
    return val
    #if ENABLE_WEAKUSE
        .lock()
    #endif
    ;
}

std::shared_ptr<User> Use::getUser() const {
    return user.lock();
}

Use::~Use() {
    val
    #if ENABLE_WEAKUSE
        .lock()
    #endif
    ->delUse(shared_from_this());
}

}