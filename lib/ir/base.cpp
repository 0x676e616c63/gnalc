/**
 * @attention update: 使用 `Use` 类来管理操作数
 * @todo 使用智能指针优化
 * @todo 错误处理
 */

#include "../../include/ir/base.hpp"


namespace IR {

Value::Value(std::string _name, IRTYPE _type)
    : NameC(std::move(_name)), TypeC(_type) {}

void Value::addUse(Use* use) {
    use_list.emplace_back(use);
}

std::list<Use*>& Value::getUseList() {
    return use_list;
}

/**
 * @todo null, not found process
 * @attention repeat delete
 */
void Value::delUseByUse(Use* use) {
    if (use == nullptr) {
        return;
    }
    use_list.remove(use);
}

void Value::delUseByUser(User* user) {
    for (auto iter = use_list.begin(); iter != use_list.end(); iter++) {
        if ((*iter)->getUser() == user) {
            use_list.erase(iter);
            return;
        }
    }
}

void Value::delUseByName(NameRef name) {
    for (auto iter = use_list.begin(); iter != use_list.end(); iter++) {
        if ((*iter)->getUser()->isName(name)) {
            use_list.erase(iter);
            return;
        }
    }
}

void Value::replaceUseByUse(Use* old_use, Use* new_use) {
    for (auto iter = use_list.begin(); iter != use_list.end(); iter++) {
        if (*iter == old_use) {
            *iter = new_use;
            return;
        }
    }
}

Value::~Value() {
    // todo
}


User::User(std::string _name, IRTYPE _type) : Value(std::move(_name), _type) {}

void User::addOperand(Value* ope)
{
    operands.emplace_back(ope, this);
}

std::list<Use>& User::getOperands() {
    return operands;
}

const std::list<Use>& User::getOperands() const {
    return operands;
}

void User::delOperandByValue(Value *v) {
    for (auto iter = operands.begin(); iter != operands.end(); iter++) {
        if (iter->getValue() == v) {
            operands.erase(iter);
            return;
        }
    }
}

void User::delOperandByName(NameRef name) {
    for (auto iter = operands.begin(); iter != operands.end(); iter++) {
        if (iter->getUser()->isName(name)) {
            operands.erase(iter);
            return;
        }
    }
}

User::~User() {
    // todo
}


Use::Use(Value *v, User *u) : val(v), user(u) {
    val->addUse(this);
}

void Use::setValue(Value *v) {
    val->delUseByUse(this);
    val = v;
    val->addUse(this);
}

void Use::setUser(User *u) {
    user = u;
}

Value* Use::getValue() const {
    return val;
}

User* Use::getUser() const {
    return user;
}

Use::~Use() {
    val->delUseByUse(this);
}
}